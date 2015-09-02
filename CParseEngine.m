//
//  ParseEngine.m
//  ParseUser
//
//  Created by Ranjith on 03/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CParseEngine.h"
#import "CConstants.h"
#import "CContact.h"
#import "NSMutableDictionary+Additions.h"
#import "PFObject+Additions.h"
#import "CUser.h"
#import "CServer.h"
#import "CServerInterface.h"
#import "CServerUserInterface.h"
#import "CServerUser.h"


#pragma mark - Cloud Functions

NSString *storeContactCloudFunction = @"storeContact";

@interface CParseEngine ()
@property (nonatomic)id<CServerUserInterface> serverUser;
@end

@implementation CParseEngine

+ (CParseEngine*)sharedInstance {
    static CParseEngine* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[CParseEngine alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    self.serverUser = [CServerUser defaultUser];
    return self;
}

- (void)initialize {
    [self authentication];
}

- (void)authentication{
    [Parse setApplicationId:kServerApplicationId clientKey:kServerClientKey];
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicWriteAccess:NO];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
}

- (void)storeContact:(CContact *)contact :(storeContactCompletionBlock)block {
  NSMutableDictionary *params = [NSMutableDictionary new];
  params[kServerUserObjectIdAttribute] = [self.serverUser userObjectId];
  [params safeAddForKey:kServerNameAttribute value:contact.name];
  [params safeAddForKey:kServerEmailAttribute value:contact.email];
  [params safeAddForKey:kServerPhoneAttribute value:contact.phone];
  [params safeAddForKey:kServerStreetAttr value:contact.street];
  [params safeAddForKey:kServerDistrictAttr value:contact.district];

  [PFCloud callFunctionInBackground:storeContactCloudFunction
                     withParameters:params
                              block:^(id object, NSError *error) {
                                PFObject *pfObject = object;
                                if (object) {
                                  NSLog(@"%@", pfObject.objectId);
                                  block(YES, nil);
                                } else {
                                  block(NO, error);
                                }
                              }];
}

- (void)readAllContacts:(CFetchContacts)block {
    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
    [query whereKey:kServerUserObjectIdAttribute equalTo:[self.serverUser userObjectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * __nullable objects, NSError * __nullable error) {
        if(objects && objects.count) {
            NSMutableArray *arrayOfContacts = [NSMutableArray new];
            for(PFObject *pfObject in objects) {
                [arrayOfContacts addObject:[pfObject contact]];
            }
            block(arrayOfContacts,nil);
        }
        else {
            block(nil,error);
        }
    }];
}

- (void)deleteContact:(CContact *)contact :(CDeleteContact)block {
    NSError *error;
    PFObject *object = [PFQuery getObjectOfClass:kServerContactClassName objectId:contact.objectId error:&error];
    BOOL result = [object delete:&error];
    block(result,error);
}

- (void)updateContact:(CContact*)contact :(updatContactCompletionBlock)block {
    NSError *error;
    PFObject *object = [PFQuery getObjectOfClass:kServerContactClassName
                                        objectId:contact.objectId error:&error];
    if(object) {
        [object c_safeAddKey:kServerNameAttribute value:contact.name];
        [object setObject:[self.serverUser userObjectId] forKey:kServerUserObjectIdAttribute];
        [object c_safeAddKey:kServerPhoneAttribute value:contact.phone];
        [object c_safeAddKey:kServerEmailAttribute value:contact.email];
        [object c_safeAddKey:kServerStreetAttr value:contact.street];
        [object c_safeAddKey:kServerDistrictAttr value:contact.district];
        [object saveInBackgroundWithBlock:block];
    }
    else {
        block(nil,error);
    }
}



- (void)saveShareContactArray:(NSArray *)rollnumbers :(shareContactCompletionBlock)block {
    PFObject *pfObject = [PFObject objectWithClassName:kServerSharedContactsClassName];
    [pfObject setObject:rollnumbers.firstObject forKey:@"rollnumber"];
    [pfObject setObject:[self.serverUser userObjectId] forKey:kServerUserObjectIdAttribute];
    [pfObject saveInBackgroundWithBlock:block];
}

#pragma mark - Public API

//- (void)saveContact:(CContact *)contact completionBlock:(CContactCreation)block {
//    PFObject *pfObject = [PFObject objectWithClassName:kServerContactClassName];
//    [pfObject setObject:[[CServer defaultParser] userObjectId] forKey:kServerUserObjectIdAttribute];
//    [pfObject c_safeAddKey:kServerPhoneAttribute value:contact.phone];
//    [pfObject c_safeAddKey:kServerEmailAttribute value:contact.email];
//    [pfObject c_safeAddKey:kServerFirstNameAttribute value:contact.firstname];
//    [pfObject c_safeAddKey:kServerLastNameAttribute value:contact.lastname];
//    [pfObject setValue:contact.objectId forKey:@"contactid"];
//    [pfObject saveInBackgroundWithBlock:block];
//}

//- (void)fetchCurrentUserContacts:(CFetchContacts)block {
//    }

//- (void)syncABAddressBookObjectsToParse:(void(^)(NSArray *contacts,NSError *error))block {
//    [[CAddressBook defaultParser]authorization:^(AddressBookAuthorization status) {
//        if(status == ABAuthorizationStatusAuthorized) {
//            [[CAddressBook defaultParser]fetchContacts:^(NSArray *contacts) {
//                [self storeBunchOfContacts:contacts];
//                block(contacts,nil);
//            }];
//        }
//    }];
//}

//- (BOOL)storeBunchOfContacts:(NSArray *)bunch {
//    BOOL result = false;
//    for(CContact *contact in bunch) {
//        PFObject *pfObject = [PFObject objectWithClassName:kServerContactClassName];
//        [pfObject setObject:[[CServer defaultParser] userObjectId] forKey:kServerUserObjectIdAttribute];
//        [pfObject c_safeAddKey:kServerPhoneAttribute value:contact.phone];
//        [pfObject c_safeAddKey:kServerEmailAttribute value:contact.email];
//        [pfObject c_safeAddKey:kServerFirstNameAttribute value:contact.firstname];
//        [pfObject c_safeAddKey:kServerLastNameAttribute value:contact.lastname];
//       result = [pfObject save];
//    }
//    return result;
//}



//                    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
//                    [query whereKey:kServerUserObjectIdAttribute equalTo:[[CServer defaultParser] userObjectId]];
//                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                        if (objects && objects.count) {
//                            NSMutableArray *arrayOfContacts = [NSMutableArray new];
//                            for(PFObject *pfObject in objects) {
//                                [arrayOfContacts addObject:[pfObject contact]];
//                            }
//                            block(arrayOfContacts,error);
//                        }
//                        else {
//                            block(objects,error);
//                        }
//                    }];



//- (void)saveArrayOfContacts:(CContact*)contact :(void(^)(BOOL succeeded, NSError *error))block{
//    PFObject *pfObject = [PFObject objectWithClassName:kServerContactClassName];
//    [pfObject setObject:contact.userObjectId  forKey:kServerUserObjectIdAttribute];
//   // [pfObject setObject:contact.phone forKey:kServerPhoneAttribute];
//    //[pfObject setObject:contact.email forKey:kServerEmailAttribute];
//    [pfObject setObject:contact.name forKey:kServerNameAttribute];
//    //[pfObject setObject:contact.addressIdCollection forKey:kServerAddressIdCollection];
//    if([pfObject save]){
//        block(YES,nil);
//    }
//    else{
//        block(NO,nil);
//    }
//}




    // Updating the Address info & contact info into Contacts Class!
//-(void)updateAddressInfo:(CContact*)contact withAddress:(NSMutableDictionary*)addressInfo
//                                                        :(void(^)(BOOL succeeded, NSError *error))block{
//    
//    NSLog(@"%@",[[PFUser currentUser]valueForKey:kServerObjectIdAttribute]);
//    if(![contact.userObjectId isEqualToString:[[PFUser currentUser]valueForKey:kServerObjectIdAttribute]]){
//        block(YES,nil);
//    }
//    else{
//        PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
//        [query whereKey:kServerNameAttribute equalTo:contact.name];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if(!error && objects.count){
//            PFObject *pfObject = [objects firstObject];
//        [pfObject setObject:contact.name forKey:kServerNameAttribute];
////        [pfObject setObject:contact.email forKey:kServerEmailAttribute];
////        [pfObject setObject:contact.phone forKey:kServerPhoneAttribute];
//        [pfObject setObject:contact.userObjectId forKey:kServerUserObjectIdAttribute];
//        NSMutableArray *arrayOfCollection = [pfObject valueForKey:kServerAddressIdCollection];
//            [arrayOfCollection removeObjectAtIndex:0];
//            [arrayOfCollection insertObject:addressInfo atIndex:0];
//            [pfObject setObject:arrayOfCollection forKey:kServerAddressIdCollection];
//        if([pfObject save]){
//            NSLog(@"updated successfully");
//            block(YES,error);
//        }
//        else{
//            block(NO,error);
//        }
//        }}];
//    }
//}
//
//
//// Add More Address;
//
//-(void)addMoreAddress:(NSMutableDictionary*)addressDictionary withContactName:(NSString*)whom WhichOperation:(NSString*)operation :(void(^)(BOOL succeeded, NSError *error))block{
//    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
//    [query whereKey:kServerNameAttribute equalTo:whom];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if(!error && objects.count){
//            PFObject *pfObject = [objects firstObject];
//            NSMutableArray *existingAddress = [pfObject valueForKey:kServerAddressIdCollection];
//            if([operation isEqualToString:@"Add"]){
//                // To add the New address with Existing dictionary;
//                [existingAddress addObject:addressDictionary];
//            }
//            else if([operation isEqualToString:@"Delete"]){
//                // To delete the address dict
//                // here maybe, you will face some Enumeration Error!..
//                // Just create one new instance of NSMutableArray and do operation!!
//                NSMutableArray *toDeleteArray = [[NSMutableArray alloc]init];
//                for(NSMutableDictionary *addressDict in existingAddress){
//                    if([[addressDict valueForKey:kServerAddressId] isEqualToNumber:[addressDictionary valueForKey:kServerAddressId]]){
//                        [toDeleteArray addObject:addressDictionary];
//                    }
//                }
//                [existingAddress removeObjectsInArray:toDeleteArray];
//            }
//            else if([operation isEqualToString:@"Edit"]){
//                // Here you have updated address check with and just replace with existing one!!!
//                NSMutableArray *toDeleteArray = [[NSMutableArray alloc]init];
//                for(NSMutableArray *addressDict in existingAddress){
//                        if([[addressDict valueForKey:kServerAddressId] isEqualToNumber:[addressDictionary valueForKey:kServerAddressId]]){
//                            [toDeleteArray addObject:addressDict];
//                        }
//                }
//                [existingAddress removeObjectsInArray:toDeleteArray];
//                [existingAddress addObject:addressDictionary];
//            }
//            [pfObject setObject:existingAddress forKey:kServerAddressIdCollection];
//            if([pfObject save]){
//                block(YES,nil);
//            }
//            else{
//                block(NO,nil);
//            }
//        }
//    }];
//}


- (void)findSharedContactObjectId:(NSString *)rollNumber :(findSharedContactCompletionBlock)block {
    PFQuery *query = [PFQuery queryWithClassName:kServerSharedContactsClassName];
    query.limit = 1;
    [query whereKey:@"rollnumber" equalTo:rollNumber];
    [query whereKey:kServerUserObjectIdAttribute equalTo:[self.serverUser userObjectId]];
    NSArray *pfObjects=[query findObjects];
    if(pfObjects.count){
        block([[pfObjects firstObject] valueForKey:kServerObjectIdAttribute],nil);
    }
    else{
        block(nil,nil);
    }
}



- (void)isCurrentUserAuthenticated:(void (^)(BOOL succedeed))block{
    if([PFUser currentUser].isAuthenticated){
        block(YES);
    }
    else{
        block(NO);
    }
}


#pragma mark - Good Written Fucntions

//-(void)currentUserObjectId:(void (^)(NSString *objectId))block{
//    block([[PFUser currentUser] valueForKey:kServerObjectIdAttribute]);
//}

- (NSString *)userObjectId {
    return [[PFUser currentUser] valueForKey:kServerObjectIdAttribute];
}

- (NSString *)makeRollNumber {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *numb = [defaults objectForKey:@"rollNumber"];
    int integerValue = [numb intValue];
    integerValue = integerValue+1;
    [defaults setObject:[NSNumber numberWithInt:integerValue] forKey:@"rollNumber"];
    [defaults synchronize];
    return [NSString stringWithFormat:@"%d",integerValue];
}

//- (void)saveContact:(CContact*)contact :(void (^)(BOOL succedeed))block{
//    PFObject *pfObject = [PFObject objectWithClassName:kServerContactClassName];
//    [pfObject setObject:contact.userObjectId forKey:kServerUserObjectIdAttribute];
//    [pfObject setObject:contact.phone forKey:kServerPhoneAttribute];
//    [pfObject setObject:contact.email forKey:kServerEmailAttribute];
//    [pfObject setObject:contact.name forKey:kServerNameAttribute];
//    if([pfObject save]){
//        block(YES);
//    }
//    else{
//        block(NO);
//    }
//}
//

//- (void)saveRecord:(CRecord *)record :(void(^)(BOOL succeedeed,NSError *error))block {
//    PFObject *pfObject = [PFObject objectWithClassName:@"contacts"];
//    [pfObject setObject:record.userObjectId forKey:kServerUserObjectIdAttribute];
//    [pfObject setObject:record.recordId forKey:@"recordId"];
//    [pfObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        block(succeeded,error);
//    }];
//
//}


//- (void)saveContact:(CContact *)contact :(void(^)(BOOL succeedeed,NSError *error))block {
//    PFObject *pfObject = [PFObject objectWithClassName:kServerContactClassName];
//    [pfObject setObject:contact.userObjectId forKey:kServerUserObjectIdAttribute];
//    [pfObject setObject:contact.name forKey:kServerNameAttribute];
//    [pfObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        block(succeeded,error);
//    }];
//}



// helper functions

//- (NSString *)name:(ABPerson *)person {
//    NSMutableString *mutableString = [NSMutableString new];
//    if(person.firstName) {
//        [mutableString appendString:person.firstName];
//    }
//    if(person.lastName) {
//        [mutableString appendString:person.lastName];
//    }
//    return mutableString;
//}



//- (void)saveAddress:(CAddress*)address :(void (^)(BOOL succedeed))block{
//    PFObject *pfObject = [PFObject objectWithClassName:kServerAddressClassName];
//    [pfObject setObject:address.typeOfAddress forKey:kServerTypeAttribute];
//    [pfObject setObject:address.street forKey:kServerStreetAttribute];
//    [pfObject setObject:address.district forKey:kServerDistrictAttribute];
//    [pfObject setObject:[NSNumber numberWithInt:address.addressId] forKey:kServerAddressId];
//    [pfObject setObject:address.contactObjectId forKey:kServerContactObjectId];
//    if([pfObject save]){
//            block(YES);
//        }
//        else{
//            block(NO);
//        }
//}


//- (void)updateContact:(CContact*)contact :(void (^)(CContact *contact))block{
//    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
//    [query whereKey:kServerNameAttribute equalTo:contact.name];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if(!error && objects.count){
//            PFObject *pfObject = [objects firstObject];
////            [pfObject setObject:contact.addressIdCollection forKey:kServerAddressIdCollection];
//          //  contact.objectId = [pfObject valueForKey:kServerObjectIdAttribute];
//            if([pfObject save]){
//                    block(contact);
//                }
//                else{
//                    block(nil);
//                }
//        }
//    }];
//}


//- (void)editContact:(CContact*)contact :(void(^)(BOOL succeed))block{
//    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
//    [query getObjectInBackgroundWithId:contact.objectId block:^(PFObject* pfObject,NSError *error){
//        if(!error){
//            pfObject[kServerNameAttribute]=contact.name;
////            pfObject[kServerPhoneAttribute]=contact.phone;
////            pfObject[kServerEmailAttribute]=contact.email;
//           if([pfObject save]){
//               block(YES);
//           }
//            else{
//                    block(NO);
//                }
//        }
//    }];
//}
//
//- (void)editAddress:(CAddress*)address :(void(^)(BOOL succeed))block{
//    PFQuery *query = [PFQuery queryWithClassName:kServerAddressClassName];
//    [query whereKey:kServerAddressId equalTo:[NSNumber numberWithInt:address.addressId]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
//        if(pfObjects.count){
//            PFObject *pfObject = [pfObjects firstObject];
//            pfObject[kServerTypeAttribute]=address.typeOfAddress;
//            pfObject[kServerStreetAttribute]=address.street;
//            pfObject[kServerDistrictAttribute]=address.district;
//            if([pfObject save]){
//                block(YES);
//            }
//            else{
//                block(NO);
//            }
//        }
//    }];
//}
//
//- (void)fetchAddress:(int)addressId :(void(^)(CAddress *address))block{
//    PFQuery *query = [PFQuery queryWithClassName:kServerAddressClassName];
//    [query whereKey:kServerAddressId equalTo:[NSNumber numberWithInt:addressId]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
//        if(pfObjects.count){
//            PFObject *pfObject = [pfObjects firstObject];
//            CAddress *address = [[CAddress alloc]init];
//            [address setTypeOfAddress:[pfObject valueForKey:kServerTypeAttribute]];
//            [address setStreet:[pfObject valueForKey:kServerStreetAttribute]];
//            [address setDistrict:[pfObject valueForKey:kServerDistrictAttribute]];
//            [address setAddressId:[[pfObject valueForKey:kServerAddressId] intValue]];
//            block(address);
//            }
//            else{
//                block(nil);
//            }
//    }];
//}

#pragma mark - PLS Concentrate on Code Quality Here:

- (void)affectAddressIdinContact:(NSString*)contactObjectId withAddressId:(int)addressId :(void (^)(BOOL succeed))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
    [query whereKey:kServerObjectIdAttribute equalTo:contactObjectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
        if(!error && pfObjects.count){
            PFObject *pfObject = [pfObjects firstObject];
            NSMutableArray *arrayOfAddress = [pfObject valueForKey:kServerAddressIdCollection];
            if(!arrayOfAddress){
                arrayOfAddress = [[NSMutableArray alloc]init];
            }
                [arrayOfAddress addObject:[NSNumber numberWithInt:addressId]];
                [pfObject setObject:arrayOfAddress forKey:kServerAddressIdCollection];
                if([pfObject save]){
                        block(YES);
                    }
                    else{
                        block(NO);
                    }
            }
    }];
}

- (void)removeAddressIdinContact:(NSString*)contactObjectId withAddressId:(int)addressId :(void (^)(BOOL succeed))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
    [query whereKey:kServerObjectIdAttribute equalTo:contactObjectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
        if(!error && pfObjects.count){
            PFObject *pfObject = [pfObjects firstObject];
            NSMutableArray *arrayOfAddress = [pfObject valueForKey:kServerAddressIdCollection];
            if(arrayOfAddress.count){
                [arrayOfAddress removeObject:[NSNumber numberWithInt:addressId]];
                [pfObject setObject:arrayOfAddress forKey:kServerAddressIdCollection];
                if([pfObject save]){
                        block(YES);
                    }
                    else{
                        block(NO);
                    }
            }
        }
    }];
}

#pragma mark -

- (void)deleteAddress:(int)addressId :(void(^)(BOOL succeed))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerAddressClassName];
    [query whereKey:kServerAddressId equalTo:[NSNumber numberWithInt:addressId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
        if(pfObjects.count){
            [[pfObjects firstObject] deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                if(succeeded){
                    block(YES);
                    }
                else{
                    block(NO);
                }
            }];
        }
    }];
}


//- (void)deleteContact:(NSString*)contactObjectId :(void(^)(BOOL succeeded))block{
//    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
//    [query getObjectInBackgroundWithId:contactObjectId block:^(PFObject *object, NSError *error) {
//        if (!object) {
//            NSLog(@"The getFirstObject request failed.");
//        }
//        else{
//            [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
//                if(succeeded){
//                    block(YES);
//                }
//                else{
//                    block(NO);
//                }
//            }];
//        }
//    }];
//}

- (void)isThereAnyUser:(void (^)(BOOL succeeded))block{
    if([PFUser currentUser]){
        block(YES);
    }
    else{
        block(NO);
    }
}

- (void)logout:(void (^)(BOOL succeeded))block{
    [self isThereAnyUser:^(BOOL succeeded){
        if(succeeded){
            [PFUser logOut];
            block(succeeded);
        }
        else{
            block(NO);
        }
    }];
}

- (void)fetchSharedContacts:(NSURL *)sharedURL :(fetchSharedContactsCompletionBlock)block {
    NSMutableArray *fetchedObjects = [NSMutableArray new];
    // This case is individual contacts. like 1 or multiple contacts
    // So we are making an array and sharing to someone
    if (sharedURL){
        NSString *myString = [sharedURL absoluteString];
        NSArray *items = [myString componentsSeparatedByString:@"/"];
        if([items[2] isEqualToString:@"multipleContacts"]){
            PFQuery *query = [PFQuery queryWithClassName:kServerSharedContactsClassName];
            [query whereKey:kServerObjectIdAttribute equalTo:items[3]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
                if(!error && pfObjects.count){
                    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
                    query.limit = 1;
                    [query whereKey:kServerUserObjectIdAttribute equalTo:[self.serverUser userObjectId]];
                    [query whereKey:@"rollnumber" equalTo:[pfObjects.firstObject valueForKey:@"rollnumber"]];
//                    [query whereKey:kServerObjectIdAttribute containedIn:[[pfObjects firstObject] valueForKey:kServerContactsArray]];
                    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
                        __block NSUInteger pass = pfObjects.count;
                        if(!error && pfObjects.count){
                            for(PFObject *object in pfObjects){
                                CContact *contact  =[object contact];
                                if(contact){
                                    pass--;
                                    if(!error && contact){
                                        [fetchedObjects addObject:contact];
                                        [self storeContact:contact :^(BOOL result, NSError *error) {
                                            block(result,error);
                                        }];
                                    }
                                    if(pass==0){
//                                        block(fetchedObjects,error);
                                    }
                                }
                            }
                        }
                    }];
                }
            }];
        }
        else{
            // the following code to share all the contacts
            // So here we sending the userobjectId to someOne
            PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
            if([items[2] isEqualToString:kServerUserObjectIdAttribute]){
                [query whereKey:kServerUserObjectIdAttribute equalTo:items[3]];
            }
            else{
                [query whereKey:kServerObjectIdAttribute equalTo:items[3]];
            }
            [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
                __block NSUInteger pass = pfObjects.count;
                if(!error && pfObjects.count){
                    for(PFObject *object in pfObjects){
                        CContact *contactInfo = [[CContact alloc]init];
//                        [contactInfo setName:[object valueForKey:kServerNameAttribute]];
//                        [contactInfo setPhone:[object valueForKey:kServerPhoneAttribute]];
//                        [contactInfo setEmail:[object valueForKey:kServerEmailAttribute]];
//                        [contactInfo setObjectId:[object valueForKey:kServerObjectIdAttribute]];
                        [contactInfo setUserObjectId:[object valueForKey:kServerUserObjectIdAttribute]];
                       // [contactInfo setAddressIdCollection:[object valueForKey:kServerAddressIdCollection]];
                        pass--;
                        if(!error && contactInfo){
//                            [fetchedObjects addObject:contactInfo];
                        }
                        if(pass==0){
//                            block(fetchedObjects,error);
                        }
                    }
                }
            }];
        }
    }
}

@end
