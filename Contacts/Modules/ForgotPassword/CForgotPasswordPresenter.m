//
//  CForgotPasswordPresenter.m
//  Contacts
//
//  Created by ranjith on 16/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CForgotPasswordPresenter.h"

@implementation CForgotPasswordPresenter

- (void)onResetPasswordWithEmail:(NSString *)email {
    [self.view showBusyIndicatorWithMessage:nil andImage:nil];
    [self.logic resetPasswordwithEmail:email :^(BOOL isDone, NSError *error) {
        [self.view dismissBusyIndicator];
        if(!error){
            [self.navigation navigateBack];
        }
        else {
            [self.view showError:error withTitle:@"Errror" positiveButtonTitle:nil negativeButtonTitle:@"OK" positiveBlock:nil negativeBlock:nil];
        }
    }];
}

@end
