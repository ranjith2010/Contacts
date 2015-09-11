//
//  CRootWindow.h
//  Contacts
//
//  Created by ranjith on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPreLoginAppNavigation.h"
#import "CPostLoginAppNavigation.h"
#import "CLongTaskViewProtocol.h"

@interface CRootWindow : NSObject


- (instancetype)init __attribute__((unavailable("Use sharedInstance")));
+ (CRootWindow*)sharedInstance;
- (void)presentAppStartup;
- (void)presentPrelogin;
- (void)presentPostlogin;

@property (nonatomic) UIWindow* window;
@property (nonatomic, readonly) CPreLoginAppNavigation* preloginNavigation;
@property (nonatomic, readonly) CPostLoginAppNavigation* postLoginNavigation;


// Need to show any UI related messages, check with this Property!
@property (nonatomic,readonly)id<CLongTaskViewProtocol> viewHelper;

@end
