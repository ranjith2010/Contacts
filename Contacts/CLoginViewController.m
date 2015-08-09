//
//  CLoginViewController.m
//  Contacts
//
//  Created by ranjit on 20/07/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CLoginViewController.h"

@interface CLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextFieldProperty;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFieldProperty;
@property (weak, nonatomic) IBOutlet UIButton *loginBtnProperty;
@property (weak, nonatomic) IBOutlet UILabel *dontHaveAccountLabelProperty;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtnProperty;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordBtnProeprty;

@end

@implementation CLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view removeConstraints:self.view.constraints];
    [self addConstraints];
}

- (void)addConstraints {
    
    _emailTextFieldProperty.translatesAutoresizingMaskIntoConstraints = NO;
    _passwordTextFieldProperty.translatesAutoresizingMaskIntoConstraints = NO;
    _loginBtnProperty.translatesAutoresizingMaskIntoConstraints = NO;
    _dontHaveAccountLabelProperty.translatesAutoresizingMaskIntoConstraints = NO;
    _signUpBtnProperty.translatesAutoresizingMaskIntoConstraints = NO;
    _forgotPasswordBtnProeprty.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *views = NSDictionaryOfVariableBindings(_emailTextFieldProperty,
                                                         _passwordTextFieldProperty,
                                                         _loginBtnProperty,
                                                         _dontHaveAccountLabelProperty,
                                                         _signUpBtnProperty,
                                                         _forgotPasswordBtnProeprty);

    NSArray *constraints = [NSArray array];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[_emailTextFieldProperty(40)]-[_passwordTextFieldProperty(40)]-[_loginBtnProperty(50)]-[_dontHaveAccountLabelProperty(50)]-150-[_forgotPasswordBtnProeprty(50)]" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailTextFieldProperty]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_passwordTextFieldProperty]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_loginBtnProperty(100)]" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_loginBtnProperty attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_passwordTextFieldProperty attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_dontHaveAccountLabelProperty(170)]-0-[_signUpBtnProperty]-100-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_loginBtnProperty]-[_signUpBtnProperty(50)]" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_forgotPasswordBtnProeprty(200)]" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_forgotPasswordBtnProeprty attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraints:constraints];
}


- (IBAction)CancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
