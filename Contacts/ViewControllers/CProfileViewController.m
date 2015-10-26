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
#import "CSplashViewController.h"
#import "CChangePasswordViewController.h"
#import "CRootWindow.h"

@interface CProfileViewController ()

@property (nonatomic)id<CServerUserInterface>serverUser;

@property (nonatomic) UILabel *userNameLabel;
@property (nonatomic) UILabel *emailLabel;
@property (nonatomic) UILabel *emailHeader;
@property (nonatomic) UILabel *createdAt;
@property (nonatomic) UILabel *createdAtHeader;

@property (nonatomic) UIButton *changePasswordBtn;
@property (nonatomic) UIButton *editBtn;
@property (nonatomic) UIButton *logoutBtn;

@end

@implementation CProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serverUser = [CServerUser defaultUser];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view removeConstraints:self.view.constraints];
    self.navigationController.title = @"Profile";
    [self addConstraints];
}

#pragma mark - Constraints
- (void)addConstraints {
    self.userNameLabel = [UILabel new];
    self.userNameLabel.text = [self.serverUser userName];
    [self.userNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.userNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [self.view addSubview:self.userNameLabel];

    self.emailHeader = [UILabel new];
    self.emailHeader.text = @"Email Address";
    [self.emailHeader setTextColor:[UIColor brownColor]];
    [self.emailHeader setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.emailHeader setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [self.view addSubview:self.emailHeader];

    self.emailLabel = [UILabel new];
    self.emailLabel.text = [self.serverUser email];
    [self.emailLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.emailLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [self.view addSubview:self.emailLabel];

    self.createdAtHeader = [UILabel new];
    self.createdAtHeader.text = @"Created At";
    [self.createdAtHeader setTextColor:[UIColor brownColor]];
    [self.createdAtHeader setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.createdAtHeader setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [self.view addSubview:self.createdAtHeader];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    self.createdAt = [UILabel new];
    self.createdAt.text = [dateFormatter stringFromDate:[self.serverUser createdAt]];
    [self.createdAt setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.createdAt];
    
    self.changePasswordBtn = [UIButton new];
    [self.changePasswordBtn setTitle:@"Change Password" forState:UIControlStateNormal];
    [self.changePasswordBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.changePasswordBtn.layer setCornerRadius:2];
    [self.changePasswordBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    [self.changePasswordBtn setBackgroundColor:[UIColor brownColor]];
    [self.changePasswordBtn addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    [self.changePasswordBtn sizeToFit];
    [self.view addSubview:self.changePasswordBtn];
    
    self.editBtn = [UIButton new];
    [self.editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    [self.editBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.editBtn.layer setCornerRadius:2];
    [self.editBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    [self.editBtn setBackgroundColor:[UIColor brownColor]];
    [self.editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editBtn];
    
  
    self.logoutBtn = [UIButton new];
    [self.logoutBtn setTitle:@"Logout" forState:UIControlStateNormal];
    [self.logoutBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.logoutBtn setBackgroundColor:[UIColor redColor]];
    [self.logoutBtn.layer setCornerRadius:2];
    [self.logoutBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [self.logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutBtn];

    NSDictionary *views = NSDictionaryOfVariableBindings(_userNameLabel,
                                                         _emailHeader,
                                                         _emailLabel,
                                                         _createdAtHeader,
                                                         _createdAt,
                                                         _changePasswordBtn,
                                                         _editBtn,
                                                         _logoutBtn);

    NSArray *constraints = [NSArray array];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_userNameLabel(50)]-[_emailHeader(20)]-0-[_emailLabel(50)]-[_createdAtHeader(20)]-0-[_createdAt(50)]-50-[_changePasswordBtn(50)]-[_logoutBtn(50)]" options:0 metrics:nil views:views]];
    
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_userNameLabel]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailHeader]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailLabel]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_createdAtHeader]-|" options:0 metrics:nil views:views]];
    
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_createdAt]-50-[_editBtn(50)]" options:0 metrics:nil views:views]];
    
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_createdAt]-|" options:0 metrics:nil views:views]];
    
    
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_changePasswordBtn(_editBtn)]-[_editBtn]-|" options:0 metrics:nil views:views]];
    
    
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_logoutBtn]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:constraints];
}

- (void)logout {
    [self.serverUser logout:^(NSError *error) {
        if(!error) {
            NSLog(@"logout success");
            [[CRootWindow sharedInstance] presentPrelogin];

            
//            CSplashViewController *splashVC = [CSplashViewController new];
//             UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:splashVC];
//            [self presentViewController:navigationController animated:NO completion:nil];
        }
        else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

- (void)changePassword {
    CChangePasswordViewController *changePasswordVC = [CChangePasswordViewController new];
    [self.navigationController pushViewController:changePasswordVC animated:YES];
}

- (void)edit {
    
}

@end
