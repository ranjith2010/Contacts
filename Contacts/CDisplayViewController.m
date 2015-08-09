//
//  CDisplayViewController.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CDisplayViewController.h"
#import "CEditViewController.h"
#import "CLocal.h"
#import "CLocalInterface.h"
#import "CServer.h"
#import "CServerInterface.h"

#import "CAddMoreFieldViewController.h"
#import "CSelectionTableViewController.h"

@interface CDisplayViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CDisplayViewController{
    NSMutableArray *addressCollectionDataSource;
    NSIndexPath *indexPathToDelete;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [scroller setScrollEnabled:YES];
//    [scroller setContentSize:CGSizeMake(320, 800)];
    addressCollectionDataSource = [[NSMutableArray alloc]init];
    self.addressTableView.delegate = self;
    self.addressTableView.dataSource = self;
    //[self pr_initialDataSetup];
}

- (void)viewWillAppear:(BOOL)animated{
    if(_contact){
        [[CLocal defaultLocalDB] fetchContacts :_contact.objectId
                                               :^(NSMutableArray *arrayOfContacts,NSError *error){
            if(arrayOfContacts.count){
                for(CContact *contact in arrayOfContacts){
                    if([contact.name isEqualToString:_contact.name]){
                        _contact = contact;
      //                  [self pr_initialDataSetup];
                    }
                }
            }
        }];
    }
}

#pragma mark - Private API

//- (void)pr_initialDataSetup{
//    if(_contact){
//        _nameLabel.text = _contact.name;
//        _mobileLabel.text = _contact.phone;
//        _emailLabel.text = _contact.email;
//        if(_contact.addressIdCollection.count){
//            __block NSUInteger count = _contact.addressIdCollection.count;
//            [addressCollectionDataSource removeAllObjects];
//            for(NSNumber *addressId in _contact.addressIdCollection){
//                count--;
//                [[CLocal defaultLocalDB] fetchAddress:[addressId intValue] :^(CAddress *address){
//                    if(address){
//                        [addressCollectionDataSource addObject:address];
//                    }
//                }];
//                if(count==0){
//                    [self.addressTableView reloadData];
//                }
//            }
//        }
//    }
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [addressCollectionDataSource count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Address";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [self.addressTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    CAddress *address = [addressCollectionDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = address.typeOfAddress;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ , %@",address.street,address.district];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    
    if ([tableView isEqual:self.addressTableView]){
        result = UITableViewCellEditingStyleDelete;
    }
    return result;
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.addressTableView setEditing:editing animated:animated];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Confirmation"
                                                        message:@"Are you sure!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:@"Cancel",nil];
        indexPathToDelete = indexPath;
        [alert show];
        
    }
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        if (indexPathToDelete.row < [addressCollectionDataSource count]){
            CAddress *address = [addressCollectionDataSource objectAtIndex:indexPathToDelete.row];
            [[CServer defaultParser] deleteAddress:address.addressId :^(BOOL succeed){
                if(succeed){
                    [[CLocal defaultLocalDB] deleteAddress:address.addressId :^(BOOL succeed){
                        if(succeed){
                            [[CServer defaultParser] removeAddressIdinContact:_contact.objectId
                                             withAddressId:address.addressId :^(BOOL succeed){
                                                if(succeed){
                                                [[CLocal defaultLocalDB] removeAddressIdinContact:_contact.objectId withAddressId:address.addressId :^(BOOL succeed){
                                                    if(succeed){
                                                    /* First remove this object from the source */
                                                    [addressCollectionDataSource removeObjectAtIndex:indexPathToDelete.row];
                                                    /* Then remove the associated cell from the Table View */
                                                    [self.addressTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPathToDelete]withRowAnimation:UITableViewRowAnimationLeft];
                                                                            }
                                                                        }];
                                                                    }
                                                                }];
                        }
                    }];
                }
            }];
        }
    }
    else{
        [self.addressTableView reloadData];
    }
}


#pragma mark - Button Action

- (IBAction)editBtn:(id)sender {
    CEditViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditVC"];
    [editVC setContact:_contact];
    [self presentViewController:editVC animated:YES completion:nil];
}

- (IBAction)shareBtn:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Sharing option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Share 1 Contact",
                            @"Share Mulitple Contacts",
                            @"Share All Contacts",
                            nil];
    popup.tag = 1;
    popup.accessibilityLabel = _contact.objectId;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

// ActionSheet related Code

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self pr_shareContact:popup.accessibilityLabel withAll:NO];
                    break;
                case 1:{
                    CSelectionTableViewController *selectionTVC=  [self.storyboard instantiateViewControllerWithIdentifier:@"SelectionTVC"];
                    [selectionTVC setContacts:_allContacts];
                    [self presentViewController:selectionTVC animated:YES completion:nil];
                }
                    break;
                case 2:{
//                    [[CServer defaultParser] currentUserObjectId:^(NSString *userObjectId){
//                        if(userObjectId){
                            [self pr_shareContact:[[CServer defaultParser] currentUserObjectId] withAll:YES];
                        }
                   // }];
                //}
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

-(void)pr_shareContact:(NSString*)objectID withAll:(BOOL)allContacts{
    NSString *finalString;
    if(allContacts){
        finalString = [@"Contacts:" stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"//userObjectId/",objectID]];
    }
    else{
        finalString = [@"Contacts:" stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"//contactObjectID/",objectID]];
    }
    NSURL *customURL = [[NSURL alloc] initWithString:finalString];
    self.activityVC = [[CActivityViewController alloc] initWithURL:customURL];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.activityVC] applicationActivities:nil];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
}


- (IBAction)addAddressFieldBtn:(id)sender {
    CAddMoreFieldViewController *addMoreFieldVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddMoreFieldVC"];
    [addMoreFieldVC setContactObjectId:_contact.objectId];
    [self presentViewController:addMoreFieldVC animated:YES completion:nil];
}


@end
