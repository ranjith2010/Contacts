//
//  CDefaultSignUpNavigation.m
//  Contacts
//
//  Created by ranjith on 10/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CDefaultSignUpNavigation.h"
#import "CRootWindow.h"

@implementation CDefaultSignUpNavigation

- (void)didSuccessfullyCompletedSignup:(CBaseViewController*)signupVC {
    [[CRootWindow sharedInstance].preloginNavigation navigateToPostLogin];
    [[CRootWindow sharedInstance].postLoginNavigation setMainNavigationController];
}


@end
