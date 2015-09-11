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

typedef void(^storeContactCompletionBlock)(CContact *contact,NSError *error);
typedef void(^updatContactCompletionBlock)(BOOL result,NSError *error);
typedef void(^deleteContactCompletionBlock)(BOOL result,NSError *error);
typedef void(^readAllContactsCompletionBlock)(NSArray *contacts, NSError *error);

typedef void(^storeSharedArray)(NSString *objectId,NSError *error);
typedef void(^fetchSharedContactsCompletionBlock)(BOOL result,NSError *error);

@protocol CServerInterface <NSObject>
/*!
    @brief: here we are setting the client id & parse application id
            So the parse initialization are happening.
 */
- (void)initialize;

/*!
 @brief: storing contact to parse
 @param: contact its our plain object model
 @param: block the completion block
 */
- (void)storeContact:(CContact*)contact :(storeContactCompletionBlock)block;


/*!
 @brief: updating contact in parse
 @param: contact its our plain object model
 @param: block the completion block
 */
- (void)updateContact:(CContact*)contact :(updatContactCompletionBlock)block;

/*!
 @brief: deleting contact in parse
 @param: contact its our plain object model
 @param: block the completion block
 */
- (void)deleteContact:(CContact*)contact :(deleteContactCompletionBlock)block;

/*!
 @brief: read all the contact belongs to current user
 @param: block the completion block
 */
- (void)readAllContacts:(readAllContactsCompletionBlock)block;

/*!
 @brief: user shared contacts to parse
 @param: objectIdCollection Its array of ObjectId
 @param: block the completion block
 */
- (void)storeShareArray:(NSArray *)objectIdCollection :(storeSharedArray)block;

/*!
 @brief: fetch the shared Contact from 'Contacts Pool' using Objectid
 @param: sharedURL it contains the objectId & other resources.
 @param: block the completion block
 */
- (void)fetchSharedContacts:(NSURL *)sharedURL :(fetchSharedContactsCompletionBlock)block;

@end
