//
//  CUserViewController.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CProfileViewController.h"

#import "CServer.h"
#import "CServerInterface.h"
#import "CLocalInterface.h"
#import "CLocal.h"
#import "UIAlertView+ZPBlockAdditions.h"
#import "CServerUserInterface.h"
#import "CServerUser.h"
#import "MBProgressHUD.h"
#import "CSplashViewController.h"

@interface CProfileViewController ()

@property (nonatomic)id<CServerUserInterface>serverUser;

@property (nonatomic) UILabel *userNameLabel;
@property (nonatomic) UILabel *emailLabel;
@property (nonatomic) UILabel *emailHeader;
@property (nonatomic) UILabel *createdAt;
@property (nonatomic) UILabel *createdAtHeader;
@property (nonatomic) UIButton *logoutBtn;

@end

@implementation CProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serverUser = [CServerUser defaultUser];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view removeConstraints:self.view.constraints];
    [self addConstraints];
}

#pragma mark - Constraints
- (void)addConstraints {
    self.userNameLabel = [UILabel new];
    self.userNameLabel.text = [self.serverUser userName];
    [self.userNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.userNameLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:25]];
    [self.view addSubview:self.userNameLabel];

    self.emailHeader = [UILabel new];
    self.emailHeader.text = @"Email Address";
    [self.emailHeader setTextColor:[UIColor brownColor]];
    [self.emailHeader setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.emailHeader];

    self.emailLabel = [UILabel new];
    self.emailLabel.text = [self.serverUser email];
    [self.emailLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.emailLabel];

    self.createdAtHeader = [UILabel new];
    self.createdAtHeader.text = @"Created At";
    [self.createdAtHeader setTextColor:[UIColor brownColor]];
    [self.createdAtHeader setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.createdAtHeader];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    self.createdAt = [UILabel new];
    self.createdAt.text = [dateFormatter stringFromDate:[self.serverUser createdAt]];
    [self.createdAt setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.createdAt];

    self.logoutBtn = [UIButton new];
    [self.logoutBtn setTitle:@"Logout" forState:UIControlStateNormal];
    [self.logoutBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.logoutBtn setBackgroundColor:[UIColor redColor]];
    [self.logoutBtn.layer setCornerRadius:6];
    [self.logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutBtn];

    NSDictionary *views = NSDictionaryOfVariableBindings(_userNameLabel,
                                                         _emailHeader,
                                                         _emailLabel,
                                                         _createdAtHeader,
                                                         _createdAt,
                                                         _logoutBtn);

    NSArray *constraints = [NSArray array];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_userNameLabel(50)]-[_emailHeader(20)]-0-[_emailLabel(50)]-[_createdAtHeader(20)]-0-[_createdAt(50)]-50-[_logoutBtn(40)]" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_userNameLabel]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailHeader]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailLabel]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_createdAtHeader]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_createdAt]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_logoutBtn]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:constraints];
}

- (void)logout {
    [self.serverUser logout:^(NSError *error) {
        if(!error) {
            NSLog(@"logout success");
            CSplashViewController *splashVC = [CSplashViewController new];
             UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:splashVC];
            [self presentViewController:navigationController animated:NO completion:nil];
        }
        else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

@end
