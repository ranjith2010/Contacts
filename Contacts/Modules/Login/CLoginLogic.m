//
//  CLoginLogic.m
//  Contacts
//
//  Created by ranjith on 16/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CLoginLogic.h"
#import "CServerUser.h"
#import "CServerUserInterface.h"

@implementation CLoginLogic

- (void)loginWithEmail:(NSString *)email password:(NSString *)password
       completionBlock:(CLoginCompletionBlock)block {
    [[CServerUser defaultUser]logInWithExistingUser:email password:password :^(CUser *user, NSError *error) {
        if(user){
            block(YES,error);
        }
        else {
            block(NO,error);
        }
    }];
}

@end
