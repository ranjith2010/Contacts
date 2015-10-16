//
//  CServerUserManager.m
//  Contacts
//
//  Created by ranjit on 14/08/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CServerUserManager.h"
#import "CConstants.h"

@implementation CServerUserManager

+ (CServerUserManager*)sharedInstance {
    static CServerUserManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[CServerUserManager alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    return self;
}

- (void)logInWithExistingUser:(NSString *)userName
                     password:(NSString *)password
                             :(loginUserCompletionBlock)block {
    [PFUser
     logInWithUsernameInBackground:userName
     password:password
     block:^(PFUser *pfUser, NSError *error) {
         if (!error) {
             CUser *user = [[CUser alloc] init];
             [user
              setUsername:
              [pfUser valueForKey:kServerUserName]];
             [user
              setPassword:
              [pfUser valueForKey:kServerPassword]];
             [user setEmail:[pfUser valueForKey:
                             kServerEmailAttr]];
             block(user, nil);
         } else {
             block(nil, error);
         }
     }];
}

- (void)createNewUserWithCredentials:(CUser *)userModel :(createUserCompletionBlock)block {
    PFUser *user = [PFUser user];
    user.username = userModel.email;
    user.email = userModel.email;
    user.password = userModel.password;
    [user setValue:userModel.username forKey:kServerNameAttr];
    [user signUpInBackgroundWithBlock:block];
}

- (void)createAnonymousUser:(anonymousUserCompletionBlock)block {
    [PFAnonymousUtils logInWithBlock:^(PFUser *user,NSError *error){
        if(!error && user){
            CUser *user = [CUser new];
            [user setUsername:[user valueForKey:kServerUserName]];
            block(user,nil);
        }
        else{
            block(nil,error);
        }
    }];
}

- (void)logout:(logoutCompletionBlock)block {
    if([PFUser currentUser]) {
        [PFUser logOutInBackgroundWithBlock:block];
    }
}

- (void)isAnonymousUser:(isAnonymousUserCompletionBlock)block{
    block([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]);
}

- (BOOL)hasCurrentUser {
    return [PFUser currentUser]? YES : NO;
}

- (NSString *)userObjectId {
    return [[PFUser currentUser]objectId];
}

- (NSString *)userName {
    return [[PFUser currentUser] valueForKey:kServerNameAttr];
}

- (NSString *)email {
    return [[PFUser currentUser] username];
}

- (NSDate*)createdAt {
    return [[PFUser currentUser] createdAt];
}

- (void)forgotPassword:(NSString *)email :(forgotPasswordCompletioBlock)block {
    [PFUser requestPasswordResetForEmailInBackground:email block:block];
}

- (void)changePasswordForUsername:(NSString *)username
                      oldPassword:(NSString *)oldPassword
                      newPassword:(NSString *)newPassword
              withCompletionBlock:(userTaskCompletionBlock)block {
    // First login with oldPassword
    [PFUser logInWithUsernameInBackground:username password:oldPassword block:^(PFUser *user, NSError *error){
        if (!error) {
            // login successfull, change password
            [user setPassword:newPassword];
            // make a save in background
            [user saveInBackgroundWithBlock:^(BOOL succeded, NSError *error){
                block(succeded, error);
            }];
        } else {
            block(NO, error);
        }
    }];
}

- (void)loginWithFacebook {
//    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissions block:^(PFUser *user, NSError *error) {
//        if (!user) {
//            NSLog(@"Uh oh. The user cancelled the Facebook login.");
//        } else if (user.isNew) {
//            NSLog(@"User signed up and logged in through Facebook!");
//        } else {
//            NSLog(@"User logged in through Facebook!");
//        }
//    }];
}


@end
