//
//  CSplashViewController.m
//  Contacts
//
//  Created by ranjit on 26/08/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CSplashViewController.h"
#import "CSignUpViewController.h"
#import "CLoginViewController.h"
#import "CPeopleTableViewController.h"
#import "CProfileViewController.h"

@interface CSplashViewController ()
@property (nonatomic) UIButton *loginBtnProperty;
@property (nonatomic) UIButton *skipBtnProperty;
@property (nonatomic) UIButton *signUpBtnProperty;
@property (nonatomic) UILabel *userStatus;
@end

@implementation CSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view removeConstraints:self.view.constraints];
    [self addConstraints];
}

#warning removed
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    if([self.serverUser hasCurrentUser]) {
//        [self launchTabBarVC];
//    }
//}

- (void)addConstraints {

    self.loginBtnProperty = [UIButton new];
    [self.loginBtnProperty setBackgroundColor:[UIColor blackColor]];
    [self.loginBtnProperty setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.loginBtnProperty addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtnProperty setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginBtnProperty.layer setCornerRadius:6];
    [self.view addSubview:self.loginBtnProperty];

    self.skipBtnProperty = [UIButton new];
    [self.skipBtnProperty setBackgroundColor:[UIColor blackColor]];
    [self.skipBtnProperty setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.skipBtnProperty addTarget:self action:@selector(skipBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.skipBtnProperty setTitle:@"Skip" forState:UIControlStateNormal];
    [self.skipBtnProperty.layer setCornerRadius:6];
    [self.view addSubview:self.skipBtnProperty];

    self.signUpBtnProperty = [UIButton new];
    [self.signUpBtnProperty setBackgroundColor:[UIColor blackColor]];
    [self.signUpBtnProperty setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.signUpBtnProperty addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpBtnProperty setTitle:@"Register" forState:UIControlStateNormal];
    [self.signUpBtnProperty.layer setCornerRadius:6];
    [self.view addSubview:self.signUpBtnProperty];


    NSDictionary *views = NSDictionaryOfVariableBindings(_loginBtnProperty,
                                                         _skipBtnProperty,
                                                         _signUpBtnProperty);

    NSArray *constraints = [NSArray array];

    // center X & Y
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_signUpBtnProperty attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_signUpBtnProperty attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];

    // for -50-[_userStatus(50)]-20-[logoutBtn(50)]
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_loginBtnProperty(50)]-[_skipBtnProperty(50)]-[_signUpBtnProperty(50)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];

    // width
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_signUpBtnProperty attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:200]];

    // _skip
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_skipBtnProperty attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:200]];
    // _login
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_loginBtnProperty attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:200]];

    [self.view addConstraints:constraints];
}

#pragma mark - User Selection

- (void)skipBtn {
    [self.presenter onSkipSelected];
}

- (void)loginBtn {
    [self.presenter onLoginSelected];
}

- (void)signUp {
    [self.presenter onSignupSelected];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
