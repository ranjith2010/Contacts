//
//  CSignUpPresenter.m
//  Contacts
//
//  Created by ranjith on 10/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CSignUpPresenter.h"
#import "CBaseViewController.h"

@implementation CSignUpPresenter

- (void)signUpWithNewUserInfo:(CUser *)userInfo {
    [self.view showBusyIndicatorWithMessage:nil andImage:nil];
    [self.logic signupWithNewUserInfo:userInfo completionBlock:^(BOOL completed, NSError *error) {
        [self.view dismissBusyIndicator];
        if(completed) {
            [self.navigation didSuccessfullyCompletedSignup:[self viewController]];
        }
        
        
        
    }];
    
}


- (CBaseViewController*)viewController {
    return (CBaseViewController*)self.view;
}


@end
