//
//  CPreLoginAppNavigation.h
//  Contacts
//
//  Created by ranjith on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

/*!
 This class handles app navigation for prelogin flow.
 It knows how to navigate from one viewcontroller to another.
 Only this class should be used for app navigation purpose.
 @warning Always use sharedInstance to get an instance of this class.
 */

#import <Foundation/Foundation.h>

@interface CPreLoginAppNavigation : NSObject
@property (readonly) UIViewController* topViewController;



+ (instancetype)sharedInstance;
- (instancetype)init __attribute__((unavailable("Use sharedInstance")));
- (void)presentRootViewControllerInWindow:(UIWindow*)window;
- (void)navigateToSignup;
- (void)navigateToPostLogin;
- (void)navigateToLogin;
- (void)navigateToForgotPassword;
- (void)navigateBack;

@end
