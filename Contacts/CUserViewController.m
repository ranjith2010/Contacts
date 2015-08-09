//
//  CUserViewController.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CUserViewController.h"
#import "CCredentialsViewController.h"

#import "CServer.h"
#import "CServerInterface.h"
#import "CLocalInterface.h"
#import "CLocal.h"
#import "UIAlertView+ZPBlockAdditions.h"

@interface CUserViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtnProperty;
@property (weak, nonatomic) IBOutlet UIButton *skipBtnProperty;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtnProperty;

@end

@implementation CUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view removeConstraints:self.view.constraints];
    [self addConstraints];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CUser *user = [[CLocal defaultLocalDB]fetchCurrentUser:NO];
    if(user){
        [[CServer defaultParser] isAnonymousUser:^(BOOL succeed){
            if(!succeed){
                [_loginBtnProperty setTitle:@"Logout" forState:UIControlStateNormal];
            }
            else{
                [_loginBtnProperty setTitle:@"Login" forState:UIControlStateNormal];
            }
        }];
    }
}

#pragma mark - constraints

- (void)addConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_loginBtnProperty,
                                                         _skipBtnProperty,
                                                         _signUpBtnProperty);
    [_loginBtnProperty setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_skipBtnProperty setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_signUpBtnProperty setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSArray *constraints = [NSArray array];

    // center X & Y
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_signUpBtnProperty attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
    constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_signUpBtnProperty attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];

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

- (IBAction)skipBtn:(id)sender {
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[CServer defaultParser]createAnonymousUser:^(CUser *user, NSError *error){
      //  [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error){
            NSLog(@"Anonymous #User Created Successfully");
        }
        else {
            [UIAlertView zp_alertViewWithTitle:@"Parse Error" message:error.localizedDescription];
        }
    }];
}


- (IBAction)loginBtn:(id)sender {
    if([_loginBtnProperty.titleLabel.text isEqualToString:@"Login"]){
    CCredentialsViewController *credentialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CredenVC"];
    [credentialVC setIsUserChoosenLogin:YES];
        [self presentViewController:credentialVC animated:YES completion:nil];
    }
    else{
        [[CServer defaultParser]logout:^(BOOL succeed){
            if(succeed){
                [[CLocal defaultLocalDB]logout:^(BOOL succeed){
                    if(succeed){
                        [_loginBtnProperty setTitle:@"Login" forState:UIControlStateNormal];
                     }
                }];
            }
        }];
    }
}
- (IBAction)dismissBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
