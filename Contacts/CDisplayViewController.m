//
//  CDisplayViewController.m
//  Contacts
//
//  Created by ranjit on 27/08/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CDisplayViewController.h"
#import "CEditViewController.h"

@interface CDisplayViewController ()

@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *emailLabel;
@property (nonatomic) UILabel *mobileLabel;
@property (nonatomic) UILabel *streetLabel;
@property (nonatomic) UILabel *districtLabel;

@property (nonatomic)UINavigationController *navigation;

@end

@interface CDisplayViewController()<pop>

@end

@implementation CDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view removeConstraints:self.view.constraints];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    [self addConstraints];
}

#pragma mark - Private methods

- (void)edit {
    CEditViewController *editVC = [CEditViewController new];
    [editVC setContact:self.contact];
    editVC.delegate = self;
    self.navigation = [[UINavigationController alloc]initWithRootViewController:editVC];
    editVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    [self presentViewController:self.navigation animated:NO completion:nil];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:self.navigation completion:nil];
}

- (void)addConstraints {
    self.nameLabel = [UILabel new];
    self.nameLabel.text = self.contact.name;
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.nameLabel.layer.borderColor = [UIColor brownColor].CGColor;
    self.nameLabel.layer.borderWidth = 4.0;
    [self.nameLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nameLabel];

    self.emailLabel = [UILabel new];
    self.emailLabel.text = self.contact.emailString;
    [self.emailLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.emailLabel.layer.borderColor = [UIColor brownColor].CGColor;
    self.emailLabel.layer.borderWidth = 4.0;
    [self.emailLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.emailLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.emailLabel];

    self.mobileLabel = [UILabel new];
    self.mobileLabel.text = self.contact.mobile;
    [self.mobileLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.mobileLabel.layer.borderColor = [UIColor brownColor].CGColor;
    self.mobileLabel.layer.borderWidth = 4.0;
    [self.mobileLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.mobileLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.mobileLabel];

    self.streetLabel = [UILabel new];
    self.streetLabel.text = self.contact.street;
    [self.streetLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.streetLabel.layer.borderColor = [UIColor brownColor].CGColor;
    self.streetLabel.layer.borderWidth = 4.0;
    [self.streetLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.streetLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.streetLabel];

    self.districtLabel = [UILabel new];
    self.districtLabel.text = self.contact.district;
    [self.districtLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.districtLabel.layer.borderColor = [UIColor brownColor].CGColor;
    self.districtLabel.layer.borderWidth = 4.0;
    [self.districtLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.districtLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.districtLabel];

    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel,
                                                         _emailLabel,
                                                         _mobileLabel,
                                                         _streetLabel,
                                                         _districtLabel);

    NSArray *constraints = [NSArray array];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[_nameLabel(50)]-40-[_emailLabel(50)]-40-[_mobileLabel(50)]-40-[_streetLabel(50)]-40-[_districtLabel(50)]" options:0 metrics:nil views:views]];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_nameLabel]-|" options:0 metrics:nil views:views]];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailLabel]-|" options:0 metrics:nil views:views]];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_mobileLabel]-|" options:0 metrics:nil views:views]];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_streetLabel]-|" options:0 metrics:nil views:views]];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_districtLabel]-|" options:0 metrics:nil views:views]];

    [self.view addConstraints:constraints];
}

- (void)popout {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// @override this method for hiding Tabbar when this viewcontroller
-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

@end
