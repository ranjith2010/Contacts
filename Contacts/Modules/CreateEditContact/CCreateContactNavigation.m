//
//  CCreateContactNavigation.m
//  Contacts
//
//  Created by ranjith on 25/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CCreateContactNavigation.h"
#import "CEditViewController.h"
#import "CCreateContactLogic.h"

@class CContact;

@interface CCreateContactNavigation()

@property (nonatomic,strong)UINavigationController *navigationController;

@end

@implementation CCreateContactNavigation

- (void)presentCreateContactFlow:(UINavigationController*)navigationController {
    CEditViewController *editViewController = [CEditViewController new];
    CCreateContactLogic *logic = [CCreateContactLogic new];
    editViewController.logic = logic;
    logic.view = editViewController;
    logic.navigation = self;
    self.navigationController = navigationController;
    [navigationController pushViewController:editViewController animated:YES];
}

- (void)presentEditContactFlow:(id)displayVCInstance withContact:(CContact*)contact {
    CEditViewController *editViewController= [CEditViewController new];
    [editViewController setContact:contact];
    [editViewController setDelegate:displayVCInstance];
    editViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(navigateBackWithAnimation:)];
    CCreateContactLogic *logic = [CCreateContactLogic new];
    editViewController.logic = logic;
    logic.view = editViewController;
    logic.navigation = self;
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:editViewController];
    self.navigationController = navigationController;
    [displayVCInstance presentViewController:self.navigationController animated:NO completion:nil];
}

- (void)navigateBackWithAnimation:(BOOL)hasAnimation {
    if(!self.navigationController.viewControllers.count)
        return;

    UIViewController *viewController = self.navigationController.topViewController;
    if(viewController.presentingViewController) {
        [viewController dismissViewControllerAnimated:hasAnimation completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:hasAnimation];
    }
}
@end
