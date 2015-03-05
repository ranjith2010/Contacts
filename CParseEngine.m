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
#import "CDContact.h"
#import "PFObject+Additions.h"
#import "CUser.h"

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
    return self;
}


#pragma mark - Public API

- (void)fetchAllContacts:(void (^)(NSMutableArray *contacts, NSError *error))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
    [query whereKey:kServerUserObjectIdAttribute equalTo:[[PFUser currentUser] valueForKey:kServerObjectIdAttribute]];
    NSMutableArray *returnArrayOfContacts = [[NSMutableArray alloc]init];
    for(PFObject *pfObject in [query findObjects]){
       [returnArrayOfContacts addObject:[PFObject PFObjectToCContact:pfObject]];
    }
    block(returnArrayOfContacts,nil);
}



- (void)saveArrayOfContacts:(CContact*)contact :(void(^)(BOOL succeeded, NSError *error))block{
    PFObject *pfObject = [PFObject objectWithClassName:kServerContactClassName];
    [pfObject setObject:contact.userObjectId  forKey:kServerUserObjectIdAttribute];
    [pfObject setObject:contact.phone forKey:kServerPhoneAttribute];
    [pfObject setObject:contact.email forKey:kServerEmailAttribute];
    [pfObject setObject:contact.name forKey:kServerNameAttribute];
    [pfObject setObject:contact.addressIdCollection forKey:kServerAddressIdCollection];
    if([pfObject save]){
        block(YES,nil);
    }
    else{
        block(NO,nil);
    }
}




    // Updating the Address info & contact info into Contacts Class!
-(void)updateAddressInfo:(CContact*)contact withAddress:(NSMutableDictionary*)addressInfo
                                                        :(void(^)(BOOL succeeded, NSError *error))block{
    
    NSLog(@"%@",[[PFUser currentUser]valueForKey:kServerObjectIdAttribute]);
    if(![contact.userObjectId isEqualToString:[[PFUser currentUser]valueForKey:kServerObjectIdAttribute]]){
        block(YES,nil);
    }
    else{
        PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
        [query whereKey:kServerNameAttribute equalTo:contact.name];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error && objects.count){
            PFObject *pfObject = [objects firstObject];
        [pfObject setObject:contact.name forKey:kServerNameAttribute];
        [pfObject setObject:contact.email forKey:kServerEmailAttribute];
        [pfObject setObject:contact.phone forKey:kServerPhoneAttribute];
        [pfObject setObject:contact.userObjectId forKey:kServerUserObjectIdAttribute];
        NSMutableArray *arrayOfCollection = [pfObject valueForKey:kServerAddressIdCollection];
            [arrayOfCollection removeObjectAtIndex:0];
            [arrayOfCollection insertObject:addressInfo atIndex:0];
            [pfObject setObject:arrayOfCollection forKey:kServerAddressIdCollection];
        if([pfObject save]){
            NSLog(@"updated successfully");
            block(YES,error);
        }
        else{
            block(NO,error);
        }
        }}];
    }
}


// Add More Address;

-(void)addMoreAddress:(NSMutableDictionary*)addressDictionary withContactName:(NSString*)whom WhichOperation:(NSString*)operation :(void(^)(BOOL succeeded, NSError *error))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
    [query whereKey:kServerNameAttribute equalTo:whom];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error && objects.count){
            PFObject *pfObject = [objects firstObject];
            NSMutableArray *existingAddress = [pfObject valueForKey:kServerAddressIdCollection];
            if([operation isEqualToString:@"Add"]){
                // To add the New address with Existing dictionary;
                [existingAddress addObject:addressDictionary];
            }
            else if([operation isEqualToString:@"Delete"]){
                // To delete the address dict
                // here maybe, you will face some Enumeration Error!..
                // Just create one new instance of NSMutableArray and do operation!!
                NSMutableArray *toDeleteArray = [[NSMutableArray alloc]init];
                for(NSMutableDictionary *addressDict in existingAddress){
                    if([[addressDict valueForKey:kServerAddressId] isEqualToNumber:[addressDictionary valueForKey:kServerAddressId]]){
                        [toDeleteArray addObject:addressDictionary];
                    }
                }
                [existingAddress removeObjectsInArray:toDeleteArray];
            }
            else if([operation isEqualToString:@"Edit"]){
                // Here you have updated address check with and just replace with existing one!!!
                NSMutableArray *toDeleteArray = [[NSMutableArray alloc]init];
                for(NSMutableArray *addressDict in existingAddress){
                        if([[addressDict valueForKey:kServerAddressId] isEqualToNumber:[addressDictionary valueForKey:kServerAddressId]]){
                            [toDeleteArray addObject:addressDict];
                        }
                }
                [existingAddress removeObjectsInArray:toDeleteArray];
                [existingAddress addObject:addressDictionary];
            }
            [pfObject setObject:existingAddress forKey:kServerAddressIdCollection];
            if([pfObject save]){
                block(YES,nil);
            }
            else{
                block(NO,nil);
            }
        }
    }];
}





- (void)isAnonymousUser:(void (^)(BOOL succeeded))block{
    if([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        block(YES);
    }
    else{
        block(NO);
    }
}


-(void)findPFObjectwithObjectId:(NSString*)objectId :(void (^)(NSString *sharedClassObjectId, NSError *error))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerSharedContactsClassName];
    [query whereKey:kServerUserObjectIdAttribute equalTo:[[PFUser currentUser] valueForKey:kServerObjectIdAttribute]];
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

- (void)logIn:(CUser*)user :(void (^)(CUser *user))block{
    [PFUser logInWithUsernameInBackground:user.username password:user.password block:^(PFUser *pfUser,NSError *error){
        if(user){
            CUser *Cuser = [[CUser alloc]init];
            [Cuser setUsername:[pfUser valueForKey:@"username"]];
            [Cuser setPassword:[pfUser valueForKey:@"password"]];
            [Cuser setEmail:[pfUser valueForKey:@"email"]];
            block(Cuser);
        }
        else{
            block(nil);
        }
    }];
}

- (void)createAnonymousUser:(void (^)(CUser *user,NSError *error))block{
    [PFAnonymousUtils logInWithBlock:^(PFUser *user,NSError *error){
        if(!error){
            [self pr_AnonymousUserToCUser:user :^(CUser *user){
                if(user){
                    block(user,nil);
                }
            }];
        }
        else{
            block(nil,error);
        }}];
}


- (void)pr_AnonymousUserToCUser:(PFUser*)pfUser :(void (^)(CUser *user))block{
    CUser *user = [[CUser alloc]init];
    [user setUsername:[pfUser valueForKey:@"username"]];
    [user setEmail:[pfUser valueForKey:@"email"]];
    [user setPassword:[pfUser valueForKey:@"password"]];
    block(user);
}

- (void)createNewUser:(CUser*)newUser :(void (^)(BOOL succedeed))block{
    PFUser *user = [PFUser user];
    user.username = newUser.username;
    user.password = newUser.password;
    user.email = newUser.email;
    if([user signUp]){
        // Hooray! Let them use the app now.
        block(YES);
    }
    else{
        block(NO);
    }
}

- (void)parseAuthentication{
    [Parse setApplicationId:kServerApplicationId clientKey:kServerClientKey];
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicWriteAccess:NO];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
}

-(void)currentUserObjectId:(void (^)(NSString *objectId))block{
    block([[PFUser currentUser] valueForKey:kServerObjectIdAttribute]);
}

- (NSNumber*)randomIdFromNSUserDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *numb = [defaults objectForKey:kServerAddressId];
    int integerValue = [numb intValue];
    integerValue = integerValue+1;
    [defaults setObject:[NSNumber numberWithInt:integerValue] forKey:kServerAddressId];
    [defaults synchronize];
    return [NSNumber numberWithInt:integerValue];
}

- (void)saveContact:(CContact*)contact :(void (^)(BOOL succedeed))block{
    PFObject *pfObject = [PFObject objectWithClassName:kServerContactClassName];
    [pfObject setObject:contact.userObjectId forKey:kServerUserObjectIdAttribute];
    [pfObject setObject:contact.phone forKey:kServerPhoneAttribute];
    [pfObject setObject:contact.email forKey:kServerEmailAttribute];
    [pfObject setObject:contact.name forKey:kServerNameAttribute];
    if([pfObject save]){
        block(YES);
    }
    else{
        block(NO);
    }
}

- (void)saveAddress:(CAddress*)address :(void (^)(BOOL succedeed))block{
    PFObject *pfObject = [PFObject objectWithClassName:kServerAddressClassName];
    [pfObject setObject:address.typeOfAddress forKey:kServerTypeAttribute];
    [pfObject setObject:address.street forKey:kServerStreetAttribute];
    [pfObject setObject:address.district forKey:kServerDistrictAttribute];
    [pfObject setObject:[NSNumber numberWithInt:address.addressId] forKey:kServerAddressId];
    [pfObject setObject:address.contactObjectId forKey:kServerContactObjectId];
    if([pfObject save]){
            block(YES);
        }
        else{
            block(NO);
        }
}


- (void)updateContact:(CContact*)contact :(void (^)(CContact *contact))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
    [query whereKey:kServerNameAttribute equalTo:contact.name];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error && objects.count){
            PFObject *pfObject = [objects firstObject];
            [pfObject setObject:contact.addressIdCollection forKey:kServerAddressIdCollection];
            contact.objectId = [pfObject valueForKey:kServerObjectIdAttribute];
            if([pfObject save]){
                    block(contact);
                }
                else{
                    block(nil);
                }
        }
    }];
}


- (void)editContact:(CContact*)contact :(void(^)(BOOL succeed))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
    [query getObjectInBackgroundWithId:contact.objectId block:^(PFObject* pfObject,NSError *error){
        if(!error){
            pfObject[kServerNameAttribute]=contact.name;
            pfObject[kServerPhoneAttribute]=contact.phone;
            pfObject[kServerEmailAttribute]=contact.email;
           if([pfObject save]){
               block(YES);
           }
            else{
                    block(NO);
                }
        }
    }];
}

- (void)editAddress:(CAddress*)address :(void(^)(BOOL succeed))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerAddressClassName];
    [query whereKey:kServerAddressId equalTo:[NSNumber numberWithInt:address.addressId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
        if(pfObjects.count){
            PFObject *pfObject = [pfObjects firstObject];
            pfObject[kServerTypeAttribute]=address.typeOfAddress;
            pfObject[kServerStreetAttribute]=address.street;
            pfObject[kServerDistrictAttribute]=address.district;
            if([pfObject save]){
                block(YES);
            }
            else{
                block(NO);
            }
        }
    }];
}

- (void)fetchAddress:(int)addressId :(void(^)(CAddress *address))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerAddressClassName];
    [query whereKey:kServerAddressId equalTo:[NSNumber numberWithInt:addressId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
        if(pfObjects.count){
            PFObject *pfObject = [pfObjects firstObject];
            CAddress *address = [[CAddress alloc]init];
            [address setTypeOfAddress:[pfObject valueForKey:kServerTypeAttribute]];
            [address setStreet:[pfObject valueForKey:kServerStreetAttribute]];
            [address setDistrict:[pfObject valueForKey:kServerDistrictAttribute]];
            [address setAddressId:[[pfObject valueForKey:kServerAddressId] intValue]];
            block(address);
            }
            else{
                block(nil);
            }
    }];
}

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


- (void)deleteContact:(NSString*)contactObjectId :(void(^)(BOOL succeeded))block{
    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
    [query getObjectInBackgroundWithId:contactObjectId block:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
        }
        else{
            [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
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



- (void)fetchSharedContacts:(NSURL*)url  :(void (^)(NSMutableArray *arrayOfContacts))block{
    NSMutableArray *fetchedObjects = [[NSMutableArray alloc]init];
    if (url){
        NSString *myString = [url absoluteString];
        NSArray *items = [myString componentsSeparatedByString:@"/"];
        if([items[2] isEqualToString:@"multipleContacts"]){
            PFQuery *query = [PFQuery queryWithClassName:kServerSharedContactsClassName];
            [query whereKey:kServerObjectIdAttribute equalTo:items[3]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
                if(!error && pfObjects.count){
                    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
                    [query whereKey:kServerObjectIdAttribute containedIn:[[pfObjects firstObject] valueForKey:kServerContactsArray]];
                    [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
                        __block NSUInteger pass = pfObjects.count;
                        if(!error && pfObjects.count){
                            for(PFObject *object in pfObjects){
                                CContact *contact  =[PFObject PFObjectToCContact:object];
                                if(contact){
                                    pass--;
                                    if(!error && contact){
                                        [fetchedObjects addObject:contact];
                                    }
                                    if(pass==0){
                                        block(fetchedObjects);
                                    }
                                }
                            }
                        }
                    }];
                }
            }];
        }
        else{
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
                        [contactInfo setName:[object valueForKey:kServerNameAttribute]];
                        [contactInfo setPhone:[object valueForKey:kServerPhoneAttribute]];
                        [contactInfo setEmail:[object valueForKey:kServerEmailAttribute]];
                        [contactInfo setObjectId:[object valueForKey:kServerObjectIdAttribute]];
                        [contactInfo setUserObjectId:[object valueForKey:kServerUserObjectIdAttribute]];
                        [contactInfo setAddressIdCollection:[object valueForKey:kServerAddressIdCollection]];
                        pass--;
                        if(!error && contactInfo){
                            [fetchedObjects addObject:contactInfo];
                        }
                        if(pass==0){
                            block(fetchedObjects);
                        }
                    }
                }
            }];
        }
    }
}

- (void)saveSharedContacts:(NSMutableArray*)sharedContactsArray :(void (^)(BOOL succedeed))block{
    PFObject *pfObject = [PFObject objectWithClassName:kServerSharedContactsClassName];
    [pfObject setObject:sharedContactsArray forKey:kServerContactsArray];
    [pfObject setObject:[[PFUser currentUser] valueForKey:kServerObjectIdAttribute]
                                                   forKey:kServerUserObjectIdAttribute];
    if([pfObject save]){
        block(YES);
    }
    else{
        block(NO);
    }
}

@end
