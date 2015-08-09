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

@interface CSignUpViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginFBBtnProperty;
@property (weak, nonatomic) IBOutlet UITextField *userNameProperty;
@property (weak, nonatomic) IBOutlet UITextField *emailProperty;
@property (weak, nonatomic) IBOutlet UITextField *passwordProperty;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtnProperty;
@end

@implementation CSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view removeConstraints:self.view.constraints];
    [self addConstraints];
}


- (void)addConstraints {
    _loginFBBtnProperty.translatesAutoresizingMaskIntoConstraints = NO;
    _userNameProperty.translatesAutoresizingMaskIntoConstraints = NO;
    _emailProperty.translatesAutoresizingMaskIntoConstraints = NO;
    _passwordProperty.translatesAutoresizingMaskIntoConstraints = NO;
    _signUpBtnProperty.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraints = [NSArray array];
    NSDictionary *views = NSDictionaryOfVariableBindings(_loginFBBtnProperty,
                                                         _userNameProperty,
                                                         _emailProperty,
                                                         _passwordProperty,
                                                         _signUpBtnProperty);
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[_loginFBBtnProperty(50)]-20-[_userNameProperty(40)]-[_emailProperty(40)]-[_passwordProperty(40)]-20-[_signUpBtnProperty(50)]" options:NSLayoutFormatAlignAllCenterX metrics:0 views:views]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_loginFBBtnProperty attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_loginFBBtnProperty attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:300]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_userNameProperty attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:300]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_emailProperty attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:300]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_passwordProperty attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:300]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_signUpBtnProperty attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:300]];

    [self.view addConstraints:constraints];

}

- (IBAction)signUpBtnAction:(id)sender {
    if ([self.userNameProperty.text c_isEmpty]) {
        [UIAlertView zp_alertViewWithTitle:@"Error" message:@"User name is Empty"];
    }
    else if ([self.emailProperty.text c_isEmpty]) {
        [UIAlertView zp_alertViewWithTitle:@"Error" message:@"Email is Empty"];
    }
    else if (![self.emailProperty.text c_validateEmail]) {
        [UIAlertView zp_alertViewWithTitle:@"Validation Error" message:@"Incorrect Email"];
    }
    else if ([self.passwordProperty.text c_isEmpty]) {
        [UIAlertView zp_alertViewWithTitle:@"Error" message:@"Password Empty"];
    }
    else {
        [[CServer defaultParser] createNewUser:self.userNameProperty.text
                                         email:self.emailProperty.text
                                      password:self.passwordProperty.
                                          text:^(BOOL succeeded, NSError* error) {
              if (error) {
                  [UIAlertView zp_alertViewWithTitle:@"Parse Error" message:error.localizedDescription];
              }
              else if (succeeded) {
                  [[CLocal defaultLocalDB] createNewUser:self.userNameProperty.text
                                                   email:self.emailProperty.text
                                                password:self.passwordProperty.
                                                    text:^(BOOL succeeded, NSError* error) {
                                                if (error) {
                                                    [UIAlertView zp_alertViewWithTitle:@"Core Data Error" message:error.localizedDescription];
                                                }
                                                else {
                                                    [UIAlertView zp_alertViewWithTitle:@"Success" message:@"Sign Up successfull"];
                                                }
                                                    }];
                                            }
                                          }];
    }
}


// TextField - keyboard dissmissing action.
- (IBAction)didOnExitKeyboardDismissAction:(id)sender {

}

- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
