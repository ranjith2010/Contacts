
//
//  CPreLoginAppNavigation.m
//  Contacts
//
//  Created by ranjith on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CPreLoginAppNavigation.h"
#import "CSplashViewController.h"

@interface CPreLoginAppNavigation ()
@property (nonatomic) UINavigationController* navController;
@property (nonatomic, readonly) UIStoryboard* storyboard;
@property (nonatomic, readwrite, weak) UIWindow* window;
@end

@implementation CPreLoginAppNavigation

+ (instancetype)sharedInstance {
    static dispatch_once_t token;
    static CPreLoginAppNavigation* instance;
    dispatch_once(&token, ^{
        instance = [[CPreLoginAppNavigation alloc] initInternal];
    });
    return instance;
}

- (instancetype)initInternal {
    return [super init];
}

- (UIViewController*)topViewController {
    return self.navController.topViewController;
}

- (void)presentRootViewControllerInWindow:(UIWindow*)window {
    self.window = window;
    CSplashViewController *splashVC = [CSplashViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:splashVC];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

#pragma mark Private

- (UIStoryboard*)storyboard {
    return [UIStoryboard storyboardWithName:@"Login" bundle:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
}

- (void)checkAndNavigateToViewController:(UIViewController*)vc animated:(BOOL)animated {
    if([self.navController.topViewController isEqual:vc])
        return;
    else if([self.navController.viewControllers containsObject:vc])
        [self.navController popToViewController:vc animated:animated];
    else
        [self.navController pushViewController:vc animated:animated];
}


@end
