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
#import "ABAddressBookUI.h"
#import "CConstants.h"
#import "UIAlertView+ZPBlockAdditions.h"
#import "NSMutableDictionary+Additions.h"
#import "CRecord.h"
#import "CAddressBookInterface.h"
#import "CAddressBookEngine.h"
#import "ZPContactModel.h"

@interface CRootViewController ()<UIActionSheetDelegate,ABNewPersonViewControllerDelegate,NSCopying>

@property (nonatomic,strong)id<CLocalInterface> localInterfaceTrigger;
@property (nonatomic,strong)id<CServerInterface> serverInterfaceTrigger;

@property (nonatomic)UIRefreshControl *refreshControl;
@property (nonatomic,strong)NSArray *contactsCollection;
@property (nonatomic,strong)NSMutableArray *receivedContacts;
@property (nonatomic)NSIndexPath *indexPathToDelete;
@property (nonatomic)UINavigationController *navigationForNewPerson;

@end

@implementation CRootViewController
@synthesize refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.localInterfaceTrigger = [CLocal defaultLocalDB];
    self.serverInterfaceTrigger = [CServer defaultParser];
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(pr_refreshTable) forControlEvents:UIControlEventValueChanged];
    //[self fetchAllContacts];
    [[CAddressBookEngine sharedInstance]authorization:^(AddressBookAuthorization status) {
        if(status == ABAuthorizationStatusAuthorized) {
            [[CAddressBookEngine sharedInstance]fetchContacts:^(NSArray *ABObjects) {
                self.contactsCollection = nil;
                self.contactsCollection = [NSMutableArray arrayWithArray:ABObjects];
                [self.tableView reloadData];
            }];
        }
    }];

}

# pragma mark - Private API
- (void)pr_refreshTable {
    if([CSharedContact sharedInstance].sharedContacts){
        self.receivedContacts = [[NSMutableArray alloc]init];
//        [self pr_sharedContactsReceived];
    }
//    [self pr_initialDataSetup];
}

//- (void)pr_changesReflectOnUI{
//    [self.localInterfaceTrigger fetchContacts:nil :^(NSMutableArray *arrayOfContacts,NSError *error){
//        if(arrayOfContacts.count){
//            [self.contactsCollection removeAllObjects];
//            self.contactsCollection = arrayOfContacts;
//            [self.tableView reloadData];
//        }
//    }];
//}
//- (void)pr_sharedContactsReceived{
//    __block  NSUInteger count = [CSharedContact sharedInstance].sharedContacts.count;
//    for(CContact *contact in [CSharedContact sharedInstance].sharedContacts){
//        count--;
//        [self.localInterfaceTrigger saveRecord:contact :^(BOOL succeed){
//            if(succeed){
//                [self.receivedContacts addObject:contact];
//            }
//            if(count==0){
//                [self.tableView reloadData];
//            }
//        }];
//    }
//}

- (void)fetchAllContacts {
    NSMutableDictionary *di;
    [di setObject:nil forKey:@"something"];

   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[CServer defaultParser] fetchAllContacts:^(NSArray *contacts, NSError *error) {
        NSMutableArray *array = [NSMutableArray new];
        ABAddressBookRef ab = ABAddressBookCreate();
        for (CRecord *record in contacts) {
            ABRecordRef person = ABAddressBookGetPersonWithRecordID(ab,[record.recordId intValue]);
            [array addObject:(__bridge id)(person)];
        }
        if(!self.contactsCollection) {
            self.contactsCollection = [NSArray new];
        }
        self.contactsCollection = [self.contactsCollection arrayByAddingObjectsFromArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
           // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.tableView reloadData];
        });
    }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if(section==0){
        return [self.contactsCollection count];
//    }
//    else{
//        return self.receivedContacts.count;
//    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if(section==0){
//        return @"Personal";
//    }
//    else{
//        return @"Received";
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ZPContactModel *contactModel = [self.contactsCollection objectAtIndex:indexPath.row];
    cell.textLabel.text = [contactModel getFullName];



//    if(indexPath.section==0){
//        ABRecordRef person = (__bridge ABRecordRef)([self.contactsCollection objectAtIndex:indexPath.row]);
//        CFTypeRef generalCFObject = ABRecordCopyValue(person, kABPersonFirstNameProperty);
//       cell.textLabel.text = (__bridge NSString*)generalCFObject;
//        CFRelease(generalCFObject);
//    }
//    else{
//        CContact *contact = [self.receivedContacts objectAtIndex:indexPath.row];
//        cell.textLabel.text = contact.name;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CDisplayViewController *displayVC = [self.storyboard instantiateViewControllerWithIdentifier:@"diplayVC"];
    if(indexPath.section==0) {
        [displayVC setContact:[self.contactsCollection objectAtIndex:indexPath.row]];
        [displayVC setAllContacts:self.contactsCollection];
    }
    else{
        [displayVC setContact:[self.receivedContacts objectAtIndex:indexPath.row]];
        [displayVC setAllContacts:self.receivedContacts];
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
        self.indexPathToDelete = indexPath;
    }
}

//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex==0) {
//        if(self.indexPathToDelete.section==0){
//            if(self.indexPathToDelete.row < [self.contactsCollection count]){
//                CContact *contact = [self.contactsCollection objectAtIndex:self.indexPathToDelete.row];
//                [self.serverInterfaceTrigger deleteContact:contact.objectId :^(BOOL succeed){
//                    if(succeed){
//                      //  __block NSUInteger count = contact.addressIdCollection.count;
//                        //for(NSNumber *addressId in contact.addressIdCollection){
////                            count--;
////                            [self.serverInterfaceTrigger deleteAddress:[addressId intValue] :^(BOOL succeed){
////                            }];
//                        }
//                        if(count==0){
//                            [self.localInterfaceTrigger deleteContact:contact.objectId :^(BOOL succeed){
//                                if(succeed){
//                                    [self.contactsCollection removeObjectAtIndex:self.indexPathToDelete.row];
//                                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.indexPathToDelete]
//                                                          withRowAnimation:UITableViewRowAnimationFade];
//                                }
//                            }];
//                        }
//                    }
//                }];
//            }
//        }
//        else if (self.indexPathToDelete.row < [self.receivedContacts count] && (self.indexPathToDelete.section==1)){
//            CContact *contact = [self.receivedContacts objectAtIndex:self.indexPathToDelete.row];
//            [self.serverInterfaceTrigger currentUserObjectId:^(NSString *userObjectId){
//                if(userObjectId){
//                    if([contact.userObjectId isEqualToString:userObjectId]){
//                        [self.localInterfaceTrigger deleteContact:contact.objectId :^(BOOL succeed){
//                            if(succeed){
//                                NSLog(@"shared Contact is Deleted");
//                            }
//                        }];
//                    }
//                    else{
//                        
//                    }
//                }
//            }];
//        }
//    }
//    else if(buttonIndex ==1){
//        [self.tableView reloadData];
//    }
//}

- (IBAction)addContactBtn:(id)sender {
    ABAddressBook *addressBook = [ABAddressBook sharedAddressBook];
    ABNewPersonViewController *newPersonController = [addressBook viewControllerForNewPerson];
    if(!self.navigationForNewPerson) {
        self.navigationForNewPerson = [[UINavigationController alloc]initWithRootViewController:newPersonController];
           }
        [newPersonController setNewPersonViewDelegate:self];
        [self presentViewController:self.navigationForNewPerson animated:YES completion:nil];
}

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView
       didCompleteWithNewPerson:(ABRecordRef)person {
    if(person!=nil) {
        //clicked done btn
//        NSMutableDictionary *dictionary = [self dictionaryRepresentationForABPerson:person];
//        NSArray *temp = [[NSArray alloc] init];
//        NSMapTable *mapTable = [NSMapTable new];
////        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//        temp = [dictionary allKeys];
//        NSEnumerator *e = [temp objectEnumerator];
//        id object;
//        while (object = [e nextObject]) {
//            [mapTable setObject:object forKey:[dictionary objectForKey:object]];
////            [mapTable safeAddForKey:[dictionary objectForKey:object] value:object];
////            [dict setValue:[dictionary objectForKey:object] forKey:object];
//        }
        NSNumber *recordId = [NSNumber numberWithInteger:ABRecordGetRecordID(person)];
        NSLog(@"record id is %@",recordId);
        //ABAddressBookRef ab = ABAddressBookCreate();
        //ABRecordRef person = ABAddressBookGetPersonWithRecordID(ab,recordId.integerValue);

        CRecord *record = [CRecord new];
        [record setRecordId:[NSString stringWithFormat:@"%@",recordId]];
        [record setUserObjectId:[[CServer defaultParser] currentUserObjectId]];

     //   [MBProgressHUD showHUDAddedTo:newPersonView.view animated:YES];
        [[CServer defaultParser] saveRecord:record :^(BOOL succeedeed, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
       //         [MBProgressHUD hideHUDForView:newPersonView.view animated:YES];
            });
            if(succeedeed) {
                [self.navigationForNewPerson dismissViewControllerAnimated:YES completion:nil];
            }
            else if(!error){
                [UIAlertView zp_alertViewWithTitle:@"Parse Error" message:error.localizedDescription];
            }
        }];
    }
    else {
        [self.navigationForNewPerson dismissViewControllerAnimated:YES completion:nil];
    }
}


// Helper function to iterate the key/values of ABRecordRef and put into Dictionary
- (NSDictionary*)dictionaryRepresentationForABPerson:(ABRecordRef) person {
//    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
//    for ( int32_t propertyIndex = kABPersonFirstNameProperty; propertyIndex <= kABPersonSocialProfileProperty; propertyIndex ++ ) {
//        NSString* propertyName = CFBridgingRelease(ABPersonCopyLocalizedPropertyName(propertyIndex));
//        id value = CFBridgingRelease(ABRecordCopyValue(person, propertyIndex));
//
//        if ( value )
//            [dictionary setObject:value forKey:propertyName];
//    }
//    return dictionary;

    // Loop over all properties of this Person

    // taken from Apple's ABPerson reference page on 9.12.13.
    // URL: https://developer.apple.com/library/ios/documentation/AddressBook/Reference/ABPersonRef_iPhoneOS/Reference/reference.html#//apple_ref/c/func/ABPersonGetTypeOfProperty

    // count = 25. All are type ABPropertyID

//    int propertyArray[25] = {
//        kABPersonFirstNameProperty,
//        kABPersonLastNameProperty,
//        kABPersonMiddleNameProperty,
//        kABPersonPrefixProperty,
//        kABPersonSuffixProperty,
//        kABPersonNicknameProperty,
//        kABPersonFirstNamePhoneticProperty,
//        kABPersonLastNamePhoneticProperty,
//        kABPersonMiddleNamePhoneticProperty,
//        kABPersonOrganizationProperty,
//        kABPersonJobTitleProperty,
//        kABPersonDepartmentProperty,
//        kABPersonEmailProperty,
//        kABPersonBirthdayProperty,
//        kABPersonNoteProperty,
//        kABPersonCreationDateProperty,
//        kABPersonModificationDateProperty,
//
//        kABPersonAddressProperty,
//        kABPersonDateProperty,
//        kABPersonKindProperty,
//        kABPersonPhoneProperty,
//        kABPersonInstantMessageProperty,
//        kABPersonSocialProfileProperty,
//        kABPersonURLProperty,
//        kABPersonRelatedNamesProperty
//    };
//    int propertyArraySize = 25;
//
//    NSMutableDictionary *dictionary = [NSMutableDictionary new];
//
//    for ( int propertyIndex = 0; propertyIndex < propertyArraySize; propertyIndex++ ) {
////        NSString* propertyName = CFBridgingRelease(ABPersonCopyLocalizedPropertyName(propertyIndex));
//            id value = CFBridgingRelease(ABRecordCopyValue(person, propertyIndex));
//                if ( value )
//                    NSLog(@"%d",propertyArray[propertyIndex]);
//                    NSLog(@"value: %@",value);
////                    NSString *key = propertyArray[propertyIndex];
//                [dictionary setObject:value forKey:@(propertyArray[propertyIndex)]];
//    }
//    return dictionary;
    return nil;
}

@end
