//
//  CSignUpLogic.m
//  Contacts
//
//  Created by ranjith on 09/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CSignUpLogic.h"
#import "CServerUserInterface.h"
#import "CServerUser.h"

@implementation CSignUpLogic

- (void)signupWithNewUserInfo:(CUser *)newUserInfo
              completionBlock:(CSignupCompletionBlock)block {
    [[CServerUser defaultUser] createNewUserWithCredentials:newUserInfo :block];
}

@end
