//
//  CPostLoginAppNavigation.m
//  Contacts
//
//  Created by ranjith on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CPostLoginAppNavigation.h"
#import "CPeopleTableViewController.h"
#import "CProfileViewController.h"


@interface CPostLoginAppNavigation ()<UITabBarControllerDelegate>

@property (nonatomic) UITabBarController* tabBarController;
@property (nonatomic) UIWindow* window;

@end

@implementation CPostLoginAppNavigation

+ (instancetype)sharedInstance {
    static dispatch_once_t token;
    static CPostLoginAppNavigation* instance;
    dispatch_once(&token, ^{
        instance = [[CPostLoginAppNavigation alloc] init];
    });
    return instance;
}

- (void)reset {
    
}

- (void)presentRootViewControllerInWindow:(UIWindow*)window {
    if(!self.tabBarController) {
        self.tabBarController = [UITabBarController new];
        [self prepareTabBarController];
        self.tabBarController.delegate = self;
    }
    
    self.tabBarController.selectedIndex = 0;
    window.rootViewController = self.tabBarController;
    self.window = window;
    [window makeKeyAndVisible];
}

- (void)prepareTabBarController {
    CPeopleTableViewController *peopleTVC = [CPeopleTableViewController new];
    UINavigationController *navigationControllerForPeople = [[UINavigationController alloc]initWithRootViewController:peopleTVC];
    peopleTVC.title = @"People";
    
    CProfileViewController *userViewController = [CProfileViewController new];
    UINavigationController *navigationControllerForProfile = [[UINavigationController alloc]initWithRootViewController:userViewController];
    userViewController.title = @"My Profile";
    NSArray *tabControllers = [NSArray arrayWithObjects:navigationControllerForPeople,navigationControllerForProfile, nil];
    self.tabBarController.viewControllers = tabControllers;

    // This should be done as app level thememing
    // Generate a black tab bar
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    [self.tabBarController.view setBackgroundColor:[UIColor whiteColor]];
    
    // Set the selected icons and text tint color
    self.tabBarController.tabBar.tintColor = [UIColor blueColor];
}

@end
