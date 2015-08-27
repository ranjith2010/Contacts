//
//  PULocalDBInterface.h
//  ParseUser
//
//  Created by Ran on 05/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CUser.h"
#import "CContact.h"

@protocol CLocalInterface <NSObject>
// User : Clear & Store


// Contacts : Store

    // Doubt : Why block returning the CDContactModel???
//-(void)storeContactInfo:(CContact*)contactInfo :(void (^)(CDContact *contactInfoCDModel, NSError *error))block;


-(void)fetchContacts : (NSString*)objectId :(void (^)(NSMutableArray *PUcontacts, NSError *error))block;


- (void)updateAddressInfo:(CContact*)contact withAddress:(NSMutableDictionary *)addressInfo :(void (^)(BOOL, NSError *))block;

-(void)addMoreAddress:(NSMutableDictionary*)addressDictionary withContactName:(NSString*)whom WhichOperation:(NSString*)operation :(void(^)(BOOL succeeded, NSError *error))block;


#pragma mark - Well Written Functions

//- (void)createNewUser:(CUser*)newUser :(void (^)(BOOL succedeed))block;

- (BOOL)createNewUser:(CUser *)user;

//- (void)fetchAddress:(int)addressId :(void (^)(CAddress *address))block;

- (BOOL)saveContact:(CContact*)contact error:(NSError **)error;
- (void)fetchCurrentUserContacts:(NSString*)userObjectId :(void(^)(NSArray *contacts))block;


//- (void)saveRecord:(CRecord *)record
//                  :(void(^)(BOOL succeedeed,NSError *error))block;


//- (void)saveAddress:(CAddress*)address :(CDContact*)cdcontact :(void (^)(BOOL succeed))block;

- (void)editContact:(CContact*)contact :(void(^)(BOOL succeed))block;
//- (void)editAddress:(CAddress*)address :(void(^)(BOOL succeed))block;

- (void)affectAddressIdinContact:(NSString*)contactObjectId withAddressId:(int)addressId :(void (^)(BOOL succeed))block;

//- (void)saveAddress:(CAddress*)address :(void (^)(BOOL succeed))block;

- (void)deleteAddress:(int)addressId :(void(^)(BOOL succeed))block;
- (void)deleteContact:(NSString*)contactObjectId :(void (^)(BOOL succedeed))block;
- (void)removeAddressIdinContact:(NSString*)contactObjectId withAddressId:(int)addressId :(void (^)(BOOL succeed))block;


- (id)fetchCurrentUser:(BOOL)CDUserNeeded;

- (void)logout:(void (^)(BOOL succedeed))block;
- (void)flushAllContacts:(NSString*)userObjectId :(void (^)(BOOL succedeed))block;



@end
