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

@end

@implementation CRootViewController{
    UIRefreshControl  *refreshControl;
    NSMutableArray *contactsCollection;
    NSMutableArray *receivedContacts;
    NSIndexPath *indexPathToDelete;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [self pr_initialDataSetup];
    [refreshControl addTarget:self action:@selector(pr_refreshTable) forControlEvents:UIControlEventValueChanged];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CUser *user = [[CLocal defaultLocalDB]fetchCurrentUser:NO];
    if(user){
        [[CServer defaultParser] isCurrentUserAuthenticated:^(BOOL succeed){
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
}

# pragma mark - Private API
- (void)pr_refreshTable {
    if([CSharedContact sharedInstance].sharedContacts){
        receivedContacts = [[NSMutableArray alloc]init];
        [self pr_sharedContactsReceived];
    }
    [self pr_initialDataSetup];
}

- (void)pr_sharedContactsReceived{
    __block  int count = [CSharedContact sharedInstance].sharedContacts.count;
    for(CContact *contact in [CSharedContact sharedInstance].sharedContacts){
        count--;
        [[CLocal defaultLocalDB] saveContact:contact :^(BOOL succeed){
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
    [[CServer defaultParser] isThereAnyUser:^(BOOL succeeded){
    if(succeeded){
        [[CServer defaultParser]currentUserObjectId:^(NSString *userObjectId){
            if(userObjectId){
                [[CLocal defaultLocalDB] flushAllContacts:userObjectId :^(BOOL succeed){
                    if(succeed){
                        [[CServer defaultParser] fetchAllContacts:^(NSMutableArray *contacts, NSError *error){
                            if(contacts.count){
                                __block int count = contacts.count;
                                for(CContact *contact in contacts){
                                    count--;
                                    [[CLocal defaultLocalDB] saveContact:contact :^(BOOL succeeded){
                                        if(succeeded){
                                            for(NSNumber *addressId in contact.addressIdCollection){
                                                [[CServer defaultParser] fetchAddress:[addressId intValue] :^(CAddress *address){
                                                    if(address){
                                                        [[CLocal defaultLocalDB] saveAddress:address :^(BOOL succeed){
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
        if(indexPathToDelete.section==0){
            if(indexPathToDelete.row < [contactsCollection count]){
                CContact *contact = [contactsCollection objectAtIndex:indexPathToDelete.row];
                [[CServer defaultParser] deleteContact:contact.objectId :^(BOOL succeed){
                    if(succeed){
                        __block int count = contact.addressIdCollection.count;
                        for(NSNumber *addressId in contact.addressIdCollection){
                            count--;
                            [[CServer defaultParser] deleteAddress:[addressId intValue] :^(BOOL succeed){
                            }];
                        }
                        if(count==0){
                            [[CLocal defaultLocalDB] deleteContact:contact.objectId :^(BOOL succeed){
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
            [[CServer defaultParser] currentUserObjectId:^(NSString *userObjectId){
                if(userObjectId){
                    if([contact.userObjectId isEqualToString:userObjectId]){
                        [[CLocal defaultLocalDB] deleteContact:contact.objectId :^(BOOL succeed){
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
}


- (IBAction)addContactBtn:(id)sender {
    [[CServer defaultParser] isThereAnyUser:^(BOOL succeeded){
        if(succeeded){
            CEditViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditVC"];
            [self presentViewController:editVC animated:YES completion:nil];
        }
        else{
            UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"No User"
                                                                message:@"You must go with Anonymous || Existing User || Create a New User"
                                                               delegate:self
                                                      cancelButtonTitle:@"ok"
                                                      otherButtonTitles:nil];
            [errorAlert show];
        }
    }];
}
@end
