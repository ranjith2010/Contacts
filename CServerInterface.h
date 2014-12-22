//
//  ContactsFetcher.h
//  ParseUser
//
//  Created by Ranjith on 03/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#import "CContact.h"
#import "CDContact.h"
#import "CAddress.h"
#import "CUser.h"

@protocol CServerInterface <NSObject>

#pragma mark - CONTACTS Operations

- (void)fetchAllContacts:(void (^)(NSMutableArray *contacts, NSError *error))block;
- (void)updateAddressInfo:(CContact*)contact withAddress:(NSMutableDictionary*)addressInfo :(void(^)(BOOL succeeded, NSError *error))block;

- (void)saveArrayOfContacts:(CContact*)contact :(void(^)(BOOL succeeded, NSError *error))block;

-(void)addMoreAddress:(NSMutableDictionary*)addressDictionary withContactName:(NSString*)whom WhichOperation:(NSString*)operation :(void(^)(BOOL succeeded, NSError *error))block;


#pragma mark - SHARED CONTACTS

-(void)findPFObjectwithObjectId:(NSString*)objectId :(void (^)(NSString *sharedClassObjectId, NSError *error))block;

- (void)saveSharedContacts:(NSMutableArray*)sharedContactsArray :(void (^)(BOOL succedeed))block;

#pragma mark - USER Operations



#pragma mark - Well Written code
- (void)logIn:(CUser*)user :(void(^)(CUser *user))block;
- (void)createNewUser:(CUser*)newUser :(void(^)(BOOL succedeed))block;
- (void)createAnonymousUser:(void(^)(CUser *user, NSError *error))block;
- (void)currentUserObjectId:(void(^)(NSString *objectId))block;
- (NSNumber*)randomIdFromNSUserDefault;

- (void)saveContact:(CContact*)contact :(void(^)(BOOL succedeed))block;
- (void)updateContact:(CContact*)contact :(void(^)(CContact *contact))block;
- (void)saveAddress:(CAddress*)address :(void(^)(BOOL succedeed))block;

- (void)editContact:(CContact*)contact :(void(^)(BOOL succeed))block;
- (void)editAddress:(CAddress*)address :(void(^)(BOOL succeed))block;

- (void)deleteAddress:(int)addressId :(void(^)(BOOL succeed))block;
- (void)deleteContact:(NSString*)contactObjectId :(void(^)(BOOL succeeded))block;

- (void)removeAddressIdinContact:(NSString*)contactObjectId withAddressId:(int)addressId :(void (^)(BOOL succeed))block;

- (void)affectAddressIdinContact:(NSString*)contactObjectId withAddressId:(int)addressId :(void (^)(BOOL succeed))block;
- (void)isThereAnyUser:(void (^)(BOOL succeeded))block;
- (void)logout:(void (^)(BOOL succeeded))block;
- (void)isAnonymousUser:(void (^)(BOOL succeeded))block;
- (void)fetchAddress:(int)addressId :(void(^)(CAddress *address))block;
- (void)fetchSharedContacts:(NSURL*)url  :(void (^)(NSMutableArray *arrayOfContacts))block;

- (void)isCurrentUserAuthenticated:(void (^)(BOOL succedeed))block;




#pragma mark - Parse Authentication, during App Launch
- (void)parseAuthentication;

@end
