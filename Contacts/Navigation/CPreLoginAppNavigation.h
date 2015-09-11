//
//  CPreLoginAppNavigation.h
//  Contacts
//
//  Created by ranjith on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPreLoginAppNavigation : NSObject
+ (instancetype)sharedInstance;
- (instancetype)init __attribute__((unavailable("Use sharedInstance")));

- (void)presentRootViewControllerInWindow:(UIWindow*)window;
@property (readonly) UIViewController* topViewController;

@end
