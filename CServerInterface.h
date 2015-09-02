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
#import "CUser.h"

typedef void(^storeContactCompletionBlock)(BOOL result,NSError *error);
typedef void(^updatContactCompletionBlock)(BOOL result,NSError *error);
typedef void(^shareContactCompletionBlock)(BOOL result,NSError *error);
typedef void(^findSharedContactCompletionBlock)(NSString *objectId,NSError *error);
typedef void(^fetchSharedContactsCompletionBlock)(BOOL result,NSError *error);

// deprecated
typedef void(^CContactCreation)(BOOL result, NSError *error);
typedef void(^CFetchContacts)(NSArray *contacts, NSError *error);
typedef void(^CDeleteContact)(BOOL result, NSError *error);

@protocol CServerInterface <NSObject>


/*!
    @Notes: In Objective C the Parameters will be,
    name:(NSString*)name email:(NSString*)email -> second params
    but, Why first param is not officially supporting to write like this. because the first param will be comes  with func name.
    like. storePhone:(NSString*)phone withname:(NSString*)name withEmail:(NSString*)email
    #Caution: if you wont follow above format you will face difficulties to find what method and what purpose, what are the params do i need to pass.!
 */

// Basic CRUD Operations
- (void)storeContact:(CContact*)contact :(storeContactCompletionBlock)block;
- (void)updateContact:(CContact*)contact :(updatContactCompletionBlock)block;
- (void)deleteContact:(CContact*)contact :(CDeleteContact)block;
- (void)readAllContacts:(CFetchContacts)block;

- (void)saveShareContactArray:(NSArray *)rollnumbers :(shareContactCompletionBlock)block;
- (void)findSharedContactObjectId:(NSString *)rollNumber :(findSharedContactCompletionBlock)block;
- (void)fetchSharedContacts:(NSURL *)sharedURL :(fetchSharedContactsCompletionBlock)block;


- (void)initialize;

//
//
//
//#pragma mark - CONTACTS Operations
//
//- (void)fetchCurrentUserContacts:(void (^)(NSArray *contacts, NSError *error))block;
//- (void)updateAddressInfo:(CContact*)contact withAddress:(NSMutableDictionary*)addressInfo :(void(^)(BOOL succeeded, NSError *error))block;
//
//- (void)saveArrayOfContacts:(CContact*)contact :(void(^)(BOOL succeeded, NSError *error))block;
//
//-(void)addMoreAddress:(NSMutableDictionary*)addressDictionary withContactName:(NSString*)whom WhichOperation:(NSString*)operation :(void(^)(BOOL succeeded, NSError *error))block;
//
//
//#pragma mark - SHARED CONTACTS
//
//-(void)findPFObjectwithObjectId:(NSString*)objectId :(void (^)(NSString *sharedClassObjectId, NSError *error))block;
//
//- (void)saveSharedContacts:(NSMutableArray*)sharedContactsArray :(void (^)(BOOL succedeed))block;
//
//#pragma mark - Well Written code
//- (NSNumber*)randomIdFromNSUserDefault;
//
//#pragma mark -  updated API's
//
//- (NSString *)userObjectId;
//
//- (void)updateContact:(CContact*)contact :(void(^)(CContact *contact))block;
//- (void)editContact:(CContact*)contact :(void(^)(BOOL succeed))block;
//
//- (void)deleteAddress:(int)addressId :(void(^)(BOOL succeed))block;
//- (void)deleteContact:(NSString*)contactObjectId :(void(^)(BOOL succeeded))block;
//
//- (void)removeAddressIdinContact:(NSString*)contactObjectId withAddressId:(int)addressId :(void (^)(BOOL succeed))block;
//
//- (void)affectAddressIdinContact:(NSString*)contactObjectId withAddressId:(int)addressId :(void (^)(BOOL succeed))block;
//- (void)fetchSharedContacts:(NSURL*)url  :(void (^)(NSMutableArray *arrayOfContacts))block;
//
//- (void)isCurrentUserAuthenticated:(void (^)(BOOL succedeed))block;
//
//
//
//- (void)syncABAddressBookObjectsToParse:(void(^)(NSArray *contacts,NSError *error))block;
//- (void)saveContact:(CContact *)contact completionBlock:(CContactCreation)block;

@end
