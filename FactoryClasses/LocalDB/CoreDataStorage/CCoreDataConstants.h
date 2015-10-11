//
//  CCoreDataConstants.h
//  Contacts
//
//  Created by ranjith on 09/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark Entities
extern NSString* const kCoreDataEntityNameUser;
extern NSString* const kCoreDataEntityNameContact;

#pragma mark User
extern NSString* const kCoreDataUserObjectId;
extern NSString* const kCoreDataUserName;
extern NSString* const kCoreDataUserPassword;
extern NSString* const kCoreDataUserEmail;

#pragma mark Contact
extern NSString* const kCoreDataContactName;
extern NSString* const kCoreDataContactEmail;
extern NSString* const kCoreDataContactPhone;
extern NSString* const kCoreDataContactStreet;
extern NSString* const kCoreDataContactDistrict;
extern NSString* const kCoreDataContactObjectId;
extern NSString* const kCoreDataContactUserObjectId;

@interface CCoreDataConstants : NSObject

@end
