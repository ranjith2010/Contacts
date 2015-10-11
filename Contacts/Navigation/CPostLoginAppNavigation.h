//
//  CPostLoginAppNavigation.h
//  Contacts
//
//  Created by ranjith on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPostLoginAppNavigation : NSObject

+ (instancetype)sharedInstance;

- (void)reset;

- (void)presentRootViewControllerInWindow:(UIWindow*)window;

- (void)setMainNavigationController;


@end
