//
//  CSignUpLogicIO.h
//  Contacts
//
//  Created by ranjith on 09/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CUser;

typedef void(^CFetchUserInfoFromSystemCompletionBlock)(CUser* userInfo, NSError* error);
typedef void(^CSignupCompletionBlock)(BOOL completed, NSError* error);

/*!
 The protocol that signup logic should extend.
 */
@protocol CSignupLogicProtocol <NSObject>

/*!
 Fetches user info from system using social accounts.
 This info will be used to prefill in signup process.
 @param block The completion block
 */
- (void)fetchUserInfoWithCompletionBlock:(CFetchUserInfoFromSystemCompletionBlock)block;

/*!
 Creates new user with supplies info
 @param newUserInfo The info with which new user should be created.
 @param block The signup completion block
 */
- (void)signupWithNewUserInfo:(CUser*)newUserInfo
              completionBlock:(CSignupCompletionBlock)block;

@end

@protocol CSignUpLogicIO <NSObject>

@end
