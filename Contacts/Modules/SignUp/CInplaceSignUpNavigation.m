//
//  CInplaceSignUpNavigation.m
//  Contacts
//
//  Created by ranjith on 10/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CInplaceSignUpNavigation.h"
#import "CBaseViewController.h"

@implementation CInplaceSignUpNavigation

- (void)didSuccessfullyCompletedSignup:(CBaseViewController *)signupVC {
    // Dismiss this vc
    if (signupVC.presentingViewController) {
        [signupVC dismissViewControllerAnimated:YES completion:nil];
    } else {
        [super didSuccessfullyCompletedSignup:signupVC];
    }
    
    // Do what is required.
}

@end
