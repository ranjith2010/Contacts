//
//  CSignUpViewController.m
//  Contacts
//
//  Created by ranjit on 20/07/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CSignUpViewController.h"
#import "CServer.h"
#import "CServerInterface.h"
#import "CLocal.h"
#import "CLocalInterface.h"
#import "NSString+Additions.h"
#import "UIAlertView+ZPBlockAdditions.h"
#import "CUser.h"

#import "CServerUserInterface.h"
#import "CServerUser.h"
#import "MBProgressHUD.h"

#import "CPeopleTableViewController.h"
#import "CProfileViewController.h"

#import "CLocal.h"
#import "CLocalInterface.h"

@interface CSignUpViewController ()

@property (nonatomic) UIButton *loginFaceBookBtn;
@property (nonatomic) UITextField *userNameTextField;
@property (nonatomic) UITextField *emailTextField;
@property (nonatomic) UITextField *passwordTextField;
@property (nonatomic) UIButton *signUpBtn;
@property (nonatomic)id<CServerUserInterface>serverUser;
@property (nonatomic)id<CLocalInterface> local;
@end

@implementation CSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.serverUser = [CServerUser defaultUser];
    self.local = [CLocal defaultLocalDB];
    [self.view removeConstraints:self.view.constraints];
    [self addConstraints];
}

- (void)addConstraints {

    _loginFaceBookBtn = [UIButton new];
    [_loginFaceBookBtn setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    [_loginFaceBookBtn setBackgroundColor:[UIColor blackColor]];
    [_loginFaceBookBtn addTarget:self action:@selector(loginWithFacebookAction) forControlEvents:UIControlEventTouchUpInside];
    _loginFaceBookBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.loginFaceBookBtn.layer setCornerRadius:6];
    [self.view addSubview:_loginFaceBookBtn];

    _userNameTextField = [UITextField new];
    _userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [_userNameTextField addTarget:self action:@selector(didOnExitKeyboardDismissAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_userNameTextField setPlaceholder:@"username"];
    [self.view addSubview:_userNameTextField];

    _emailTextField = [UITextField new];
    _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    _emailTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [_emailTextField addTarget:self action:@selector(didOnExitKeyboardDismissAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_emailTextField setPlaceholder:@"email"];
    [self.view addSubview:_emailTextField];

    _passwordTextField = [UITextField new];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [_passwordTextField addTarget:self action:@selector(didOnExitKeyboardDismissAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    _passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [_passwordTextField setPlaceholder:@"password"];
    [self.view addSubview:_passwordTextField];

    _signUpBtn = [UIButton new];
    [_signUpBtn setTitle:@"Sign up" forState:UIControlStateNormal];
    [_signUpBtn setBackgroundColor:[UIColor blackColor]];
    [_signUpBtn addTarget:self action:@selector(signUpBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _signUpBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.signUpBtn.layer setCornerRadius:6];
    [self.view addSubview:_signUpBtn];

    NSArray *constraints = [NSArray array];
    NSDictionary *views = NSDictionaryOfVariableBindings(_loginFaceBookBtn,
                                                         _userNameTextField,
                                                         _emailTextField,
                                                         _passwordTextField,
                                                         _signUpBtn);
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[_loginFaceBookBtn(50)]-20-[_userNameTextField(40)]-[_emailTextField(40)]-[_passwordTextField(40)]-20-[_signUpBtn(50)]" options:NSLayoutFormatAlignAllCenterX metrics:0 views:views]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_loginFaceBookBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_loginFaceBookBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:300]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_userNameTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:300]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_emailTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:300]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_passwordTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:300]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_signUpBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:300]];

    [self.view addConstraints:constraints];
}

- (void)signUpBtnAction {
  if ([self.userNameTextField.text c_isEmpty]) {
    [UIAlertView zp_alertViewWithTitle:@"Error" message:@"User name is Empty"];
  } else if ([self.emailTextField.text c_isEmpty]) {
    [UIAlertView zp_alertViewWithTitle:@"Error" message:@"Email is Empty"];
  } else if (![self.emailTextField.text c_validateEmail]) {
    [UIAlertView zp_alertViewWithTitle:@"Validation Error"
                               message:@"Incorrect Email"];
  } else if ([self.passwordTextField.text c_isEmpty]) {
    [UIAlertView zp_alertViewWithTitle:@"Error" message:@"Password Empty"];
  } else {
    CUser *newUser = [CUser new];
    [newUser setUsername:self.emailTextField.text];
    [newUser setEmail:self.emailTextField.text];
    [newUser setUsername:self.userNameTextField.text];
    [newUser setPassword:self.passwordTextField.text];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.serverUser
        createNewUserWithCredentials:
                             newUser:^(BOOL succeeded, NSError *error) {
                               [MBProgressHUD hideHUDForView:self.view
                                                    animated:YES];
                               if (!error) {
                                 [self.local
                                     storeUser:
                                       newUser:^(BOOL result, NSError *error) {
                                         if (!error) {
                                           NSLog(@"%@ user created",
                                                 self.userNameTextField.text);
                                           [self.navigationController
                                               popViewControllerAnimated:YES];
                                         } else {
                                           NSLog(@"%@",
                                                 error.localizedDescription);
                                         }
                                       }];

                               } else {
                                 NSLog(@"%@", error.localizedDescription);
                               }
                             }];
  }
}

- (void)launchTabBarVC {
    UITabBarController *tabBarController = [UITabBarController new];
    CPeopleTableViewController *peopleTVC = [CPeopleTableViewController new];
    UINavigationController *navigationControllerForPeople = [[UINavigationController alloc]initWithRootViewController:peopleTVC];
    navigationControllerForPeople.title = @"People";

    CProfileViewController *userViewController = [CProfileViewController new];
    UINavigationController *navigationControllerForProfile = [[UINavigationController alloc]initWithRootViewController:userViewController];
    userViewController.title = @"Profile";
    NSArray *tabControllers = [NSArray arrayWithObjects:navigationControllerForPeople,navigationControllerForProfile, nil];
    tabBarController.viewControllers = tabControllers;
    [self presentViewController:tabBarController animated:NO completion:nil];
}


- (void)loginWithFacebookAction {

}


// TextField - keyboard dissmissing action.
- (void)didOnExitKeyboardDismissAction {

}

@end
