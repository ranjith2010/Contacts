//
//  CLoginPresenter.m
//  Contacts
//
//  Created by ranjith on 16/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CLoginPresenter.h"

@implementation CLoginPresenter

- (void)onLoginClickedWithUsername:(NSString *)username password:(NSString *)password {
    [self.view showBusyIndicatorWithMessage:nil andImage:nil];
    [self.logic loginWithEmail:username password:password completionBlock:^(BOOL completed, NSError *error) {
        [self.view dismissBusyIndicator];
        if(!error) {
            [self.navigation navigateToPostLogin];
        }
        else {
            [self.view showError:error withTitle:@"Login Failed" positiveButtonTitle:nil negativeButtonTitle:@"OK" positiveBlock:nil negativeBlock:nil];
        }
    }];
}

- (void)onSignupClicked {
    [self.navigation navigateToSignup];
}

- (void)onForgotPasswordClicked {
    [self.navigation navigateToForgotPassword];
}

@end
