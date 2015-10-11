//
//  CRootWindow.m
//  Contacts
//
//  Created by ranjith on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CRootWindow.h"
#import "CLongTaskViewHelper.h"

@interface CRootWindow ()

@property (nonatomic, readwrite) CPreLoginAppNavigation* preloginNavigation;
@property (nonatomic, readwrite) CPostLoginAppNavigation* postLoginNavigation;
@property (nonatomic,readwrite) id<CLongTaskViewProtocol> viewHelper;

@end

@implementation CRootWindow

+ (CRootWindow*)sharedInstance {
    static dispatch_once_t token;
    static CRootWindow* instance;
    dispatch_once(&token, ^{
        instance = [[CRootWindow alloc] initInternal];
    });
    return instance;
}

- (instancetype)initInternal {
    self = [super init];
    [self setPostLoginNavigation:[CPostLoginAppNavigation sharedInstance]];
    [self setPreloginNavigation:[CPreLoginAppNavigation sharedInstance]];
    return self;
}

- (void)presentAppStartup {
    //MARK:: inFuture i will add.
    //ZHSplashVC *splashVC = [[ZHSplashVC alloc] initWithNibName:@"ZHSplashVC" bundle:nil];
//    self.window.rootViewController = splashVC;
//    [self.window makeKeyAndVisible];
}

- (void)presentPrelogin {
    if (self.postLoginNavigation)
        [self.postLoginNavigation reset];
    [self.preloginNavigation presentRootViewControllerInWindow:self.window];
    self.viewHelper = [[CLongTaskViewHelper alloc]initWithContainerViewController:self.window.rootViewController];
}

- (void)presentPostlogin {
    [self.postLoginNavigation presentRootViewControllerInWindow:self.window];
    //    [self.postLoginNavigation setMainNavigationController];
    self.viewHelper = [[CLongTaskViewHelper alloc] initWithContainerViewController:self.window.rootViewController];
}

@end
