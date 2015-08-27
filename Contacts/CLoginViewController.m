//
//  CLoginViewController.m
//  Contacts
//
//  Created by ranjit on 20/07/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CLoginViewController.h"
#import "CServerUser.h"
#import "CServerUserInterface.h"
#import "NSString+Additions.h"
#import "CSignUpViewController.h"
#import "CForgotViewController.h"
#import "CPeopleTableViewController.h"
#import "CProfileViewController.h"
#import "MBProgressHUD.h"

@interface CLoginViewController ()

@property (nonatomic) UITextField *emailTextField;
@property (nonatomic) UITextField *passwordTextField;
@property (nonatomic) UIButton *loginBtn;
@property (nonatomic) UILabel *dontHaveAccountLabel;
@property (nonatomic) UIButton *signUpBtn;
@property (nonatomic) UIButton *forgotPasswordBtn;

@property (nonatomic)id<CServerUserInterface> serverUser;

@end

@implementation CLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.serverUser = [CServerUser defaultUser];
    [self.view removeConstraints:self.view.constraints];
    [self addConstraints];
}


- (void)addConstraints {

    _emailTextField = [UITextField new];
    _emailTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    [_emailTextField addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
    _emailTextField.placeholder = @"email";
    [self.view addSubview:_emailTextField];

    _passwordTextField = [UITextField new];
    _passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [_passwordTextField addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
    _passwordTextField.placeholder = @"password";
    [self.view addSubview:_passwordTextField];

    _loginBtn = [UIButton new];
    [_loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    _loginBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_loginBtn setBackgroundColor:[UIColor blackColor]];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn.layer setCornerRadius:10];
    [self.view addSubview:_loginBtn];

    _dontHaveAccountLabel = [UILabel new];
    _dontHaveAccountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _dontHaveAccountLabel.text = @"Don't have an account?";
    [self.view addSubview:_dontHaveAccountLabel];

    _signUpBtn = [UIButton new];
    [_signUpBtn setTitle:@"Signup" forState:UIControlStateNormal];
    [_signUpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _signUpBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_signUpBtn addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpBtn.layer setCornerRadius:10];
    [self.view addSubview:_signUpBtn];

    _forgotPasswordBtn = [UIButton new];
    [_forgotPasswordBtn setTitle:@"Forgot password" forState:UIControlStateNormal];
    [_forgotPasswordBtn setBackgroundColor:[UIColor blackColor]];
    _forgotPasswordBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_forgotPasswordBtn addTarget:self action:@selector(forgotpassword) forControlEvents:UIControlEventTouchUpInside];
    [self.forgotPasswordBtn.layer setCornerRadius:10];
    [self.view addSubview:_forgotPasswordBtn];

    NSDictionary *views = NSDictionaryOfVariableBindings(_emailTextField,
                                                         _passwordTextField,
                                                         _loginBtn,
                                                         _dontHaveAccountLabel,
                                                         _signUpBtn,
                                                         _forgotPasswordBtn);

    NSArray *constraints = [NSArray array];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[_emailTextField(40)]-[_passwordTextField(40)]-[_loginBtn(50)]-[_dontHaveAccountLabel(50)]-[_forgotPasswordBtn(50)]" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailTextField]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_passwordTextField]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_loginBtn]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_loginBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_passwordTextField attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_dontHaveAccountLabel]-0-[_signUpBtn]" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_loginBtn]-[_signUpBtn(50)]" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_forgotPasswordBtn]-|" options:0 metrics:nil views:views]];

    [self.view addConstraints:constraints];
}

- (void)dismissKeyboard {
}


- (void)login {
    NSString *errorMsg;
    if([self.emailTextField.text c_isEmpty]) {
       errorMsg =  @"Email is Empty";
    }
    else if(![self.emailTextField.text c_validateEmail]) {
        errorMsg = @"Invalid Email";
    }
    else if ([self.passwordTextField.text c_isEmpty]) {
        errorMsg = @"Password is Empty";
    }

    if(errorMsg.length) {
        NSLog(@"%@",errorMsg);
        return;
    }
  //  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.serverUser logInWithExistingUser:self.emailTextField.text
                                  password:self.passwordTextField.text
                                          :^(CUser *user, NSError *error) {
       // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if(!error){
            NSLog(@"user logged in successful");
            [self launchTabBarVC];
        }
        else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

- (void)signup {
    CSignUpViewController *signup = [CSignUpViewController new];
    [self.navigationController pushViewController:signup animated:YES];
}

- (void)forgotpassword {
    CForgotViewController *forgotVC = [CForgotViewController new];
    [self.navigationController pushViewController:forgotVC animated:YES];
}

#pragma mark - Helpers

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

@end
