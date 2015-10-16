//
//  CLoginOptionsPresenter.m
//  Contacts
//
//  Created by ranjith on 11/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CLoginOptionsPresenter.h"

@implementation CLoginOptionsPresenter

- (void)onSignupSelected {
    [self.navigation navigateToSignup];
}

- (void)onLoginSelected {
    [self.navigation navigateToLogin];
}

- (void)onSkipSelected {
    [self.view showBusyIndicatorWithMessage:nil andImage:nil];
    [self.logic createAnonymousUser:^(BOOL succeeded, NSError *error) {
        [self.view dismissBusyIndicator];
        if(!error){
            NSLog(@"Anonymous user Created");
            [self.navigation navigateToPostLogin];
        }
        else {
            [self.view showError:error withTitle:@"Error" positiveButtonTitle:nil negativeButtonTitle:@"OK" positiveBlock:nil negativeBlock:nil];
        }
    }];
}

@end
