//
//  ViewController.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CRootViewController.h"
#import "CServer.h"
#import "CServerInterface.h"
#import "CLocal.h"
#import "CLocalInterface.h"
#import "CEditViewController.h"
#import "CDisplayViewController.h"
#import "CSharedContact.h"
@interface CRootViewController ()

@property (nonatomic,strong)id<CLocalInterface> localInterfaceTrigger;
@property (nonatomic,strong)id<CServerInterface> serverInterfaceTrigger;

@end

@implementation CRootViewController{
    UIRefreshControl  *refreshControl;
    NSMutableArray *contactsCollection;
    NSMutableArray *receivedContacts;
    NSIndexPath *indexPathToDelete;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.localInterfaceTrigger = [CLocal defaultLocalDB];
    self.serverInterfaceTrigger = [CServer defaultParser];
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [self pr_initialDataSetup];
    [refreshControl addTarget:self action:@selector(pr_refreshTable) forControlEvents:UIControlEventValueChanged];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CUser *user = [self.localInterfaceTrigger fetchCurrentUser:NO];
    if(user){
        [self.serverInterfaceTrigger isCurrentUserAuthenticated:^(BOOL succeed){
            if(succeed){
                _loginOrSignUpBtnProperty.title = user.username;
            }
            else{
                _loginOrSignUpBtnProperty.title = @"Login/SignUp";
            }
        }];
    }
    else{
        _loginOrSignUpBtnProperty.title = @"Login/SignUp";
    }
    [self pr_changesReflectOnUI];
}



# pragma mark - Private API
- (void)pr_refreshTable {
    if([CSharedContact sharedInstance].sharedContacts){
        receivedContacts = [[NSMutableArray alloc]init];
        [self pr_sharedContactsReceived];
    }
    [self pr_initialDataSetup];
}

- (void)pr_changesReflectOnUI{
    [self.localInterfaceTrigger fetchContacts:nil :^(NSMutableArray *arrayOfContacts,NSError *error){
        if(arrayOfContacts.count){
            [contactsCollection removeAllObjects];
            contactsCollection = arrayOfContacts;
            [self.tableView reloadData];
        }
    }];
}
- (void)pr_sharedContactsReceived{
    __block  NSUInteger count = [CSharedContact sharedInstance].sharedContacts.count;
    for(CContact *contact in [CSharedContact sharedInstance].sharedContacts){
        count--;
        [self.localInterfaceTrigger saveContact:contact :^(BOOL succeed){
            if(succeed){
                [receivedContacts addObject:contact];
            }
            if(count==0){
                [self.tableView reloadData];
            }
        }];
    }
}

- (void)pr_initialDataSetup{
    [self.serverInterfaceTrigger isThereAnyUser:^(BOOL succeeded){
        if(succeeded){
            [self.serverInterfaceTrigger currentUserObjectId:^(NSString *userObjectId){
                if(userObjectId){
                    [self.localInterfaceTrigger flushAllContacts:userObjectId :^(BOOL succeed){
                        if(succeed){
                            [self.serverInterfaceTrigger fetchAllContacts:^(NSMutableArray *contacts, NSError *error){
                                if(contacts.count){
                                    __block NSUInteger count = contacts.count;
                                    for(CContact *contact in contacts){
                                        count--;
                                        [self.localInterfaceTrigger saveContact:contact :^(BOOL succeeded){
                                            if(succeeded){
                                                for(NSNumber *addressId in contact.addressIdCollection){
                                                    [self.serverInterfaceTrigger fetchAddress:[addressId intValue] :^(CAddress *address){
                                                        if(address){
                                                            [self.localInterfaceTrigger saveAddress:address :^(BOOL succeed){
                                                                if(succeed){
                                                                    NSLog(@"Fetches are #Contacts #Address completed");
                                                                }
                                                            }];
                                                        }
                                                    }];
                                                }
                                            }
                                        }];
                                        if(count==0){
                                            contactsCollection = contacts;
                                            [refreshControl endRefreshing];
                                            [self.tableView reloadData];
                                        }
                                    }
                                }
                            }];
                        }
                    }];
                }
            }];
        }
        else{
            contactsCollection =nil;
            [self.tableView reloadData];
            [refreshControl endRefreshing];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0){
        return [contactsCollection count];
    }
    else{
        return receivedContacts.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0){
        return @"Personal";
    }
    else{
        return @"Received";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if(indexPath.section==0){
        CContact *contact = [contactsCollection objectAtIndex:indexPath.row];
        cell.textLabel.text = contact.name;
    }
    else{
        CContact *contact = [receivedContacts objectAtIndex:indexPath.row];
        cell.textLabel.text = contact.name;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CDisplayViewController *displayVC = [self.storyboard instantiateViewControllerWithIdentifier:@"diplayVC"];
    if(indexPath.section==0){
        [displayVC setContact:[contactsCollection objectAtIndex:indexPath.row]];
        [displayVC setAllContacts:contactsCollection];
    }
    else{
        [displayVC setContact:[receivedContacts objectAtIndex:indexPath.row]];
        [displayVC setAllContacts:receivedContacts];
    }
    [self.navigationController pushViewController:displayVC animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    if ([tableView isEqual:self.tableView]){
        result = UITableViewCellEditingStyleDelete;
    }
    return result;
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Really delete the selected contact?"
                                                                delegate:self
                                                       cancelButtonTitle:@"No, I changed my mind"
                                                  destructiveButtonTitle:@"Delete"
                                                       otherButtonTitles:nil, nil];
        [actionSheet showInView:self.view];
        indexPathToDelete = indexPath;
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0) {
        if(indexPathToDelete.section==0){
            if(indexPathToDelete.row < [contactsCollection count]){
                CContact *contact = [contactsCollection objectAtIndex:indexPathToDelete.row];
                [self.serverInterfaceTrigger deleteContact:contact.objectId :^(BOOL succeed){
                    if(succeed){
                        __block NSUInteger count = contact.addressIdCollection.count;
                        for(NSNumber *addressId in contact.addressIdCollection){
                            count--;
                            [self.serverInterfaceTrigger deleteAddress:[addressId intValue] :^(BOOL succeed){
                            }];
                        }
                        if(count==0){
                            [self.localInterfaceTrigger deleteContact:contact.objectId :^(BOOL succeed){
                                if(succeed){
                                    [contactsCollection removeObjectAtIndex:indexPathToDelete.row];
                                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPathToDelete]
                                                          withRowAnimation:UITableViewRowAnimationFade];
                                }
                            }];
                        }
                    }
                }];
            }
        }
        else if (indexPathToDelete.row < [receivedContacts count] && (indexPathToDelete.section==1)){
            CContact *contact = [receivedContacts objectAtIndex:indexPathToDelete.row];
            [self.serverInterfaceTrigger currentUserObjectId:^(NSString *userObjectId){
                if(userObjectId){
                    if([contact.userObjectId isEqualToString:userObjectId]){
                        [self.localInterfaceTrigger deleteContact:contact.objectId :^(BOOL succeed){
                            if(succeed){
                                NSLog(@"shared Contact is Deleted");
                            }
                        }];
                    }
                    else{
                        
                    }
                }
            }];
        }
    }
    else if(buttonIndex ==1){
        [self.tableView reloadData];
    }
}

- (IBAction)addContactBtn:(id)sender {
    [self.serverInterfaceTrigger isThereAnyUser:^(BOOL succeeded){
        if(succeeded){
            CEditViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditVC"];
            [self presentViewController:editVC animated:YES completion:nil];
        }
        else{
            UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                                message:@"You must go with Anonymous || Existing User || Create a New User"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [errorAlert show];
        }
    }];
}
@end
