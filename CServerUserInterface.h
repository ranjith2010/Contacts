//
//  CServerUserInterface.h
//  Contacts
//
//  Created by ranjit on 14/08/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "CUser.h"

typedef void(^loginUserCompletionBlock)(CUser *user,NSError *error);
typedef void(^createUserCompletionBlock)(BOOL succeeded,NSError *error);
typedef void(^anonymousUserCompletionBlock)(CUser *user, NSError *error);
typedef void(^isAnonymousUserCompletionBlock)(BOOL result);
typedef void(^logoutCompletionBlock)(NSError *error);
typedef void(^forgotPasswordCompletioBlock)(BOOL succeeded,NSError *error);

@protocol CServerUserInterface <NSObject>

/*!
 @brief Login with existing user
 @param username this will be a user email
 @param password this will be a user password
 @param completion block
 */
- (void)logInWithExistingUser:(NSString *)userName
                     password:(NSString *)password :(loginUserCompletionBlock)block;

/*!
 @brief Create a New user. Registering a Brand new user
 @param email new user -email
 @param name its shows like a Username,
 @param password new user -password
 @param completion block
 */
- (void)createNewUserWithEmail:(NSString *)email
                          name:(NSString *)name
                      password:(NSString *)password
                              :(createUserCompletionBlock)block;

/*!
 @brief create a Anonymous user. Here parse don't except anything from user
 @param completion block
 */
- (void)createAnonymousUser:(anonymousUserCompletionBlock)block;

/*!
 @brief Logging out current user session
 @param completion block
 */
- (void)logout:(logoutCompletionBlock)block;

/*!
 @brief check the current user is anonymous?
 @param completion block
 */
- (void)isAnonymousUser:(isAnonymousUserCompletionBlock)block;

/*!
 @brief current device having any user : YES ? NO
 @return bool value
 */
- (BOOL)hasCurrentUser;

/*!
 @return current user object id
 */
- (NSString *)userObjectId;

/*!
 @return current user name
 */
- (NSString *)userName;

/*!
 @return current user email
 */
- (NSString *)email;

/*!
 @return user creation date
 */
- (NSDate *)createdAt;

/*!
 @brief sending an email to user for reset the Email link
 @param completion block
 */
- (void)forgotPassword:(NSString *)email :(forgotPasswordCompletioBlock)block;

@end
