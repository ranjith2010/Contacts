//
//  CDisplayViewController.m
//  Contacts
//
//  Created by ranjit on 27/08/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CDisplayViewController.h"
#import "CEditViewController.h"
#import "CActivityViewController.h"
#import "CServerInterface.h"
#import "CServer.h"

#import "CCreateContactNavigationProtocol.h"
#import "CCreateContactNavigation.h"

@interface CDisplayViewController ()

@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *emailLabel;
@property (nonatomic) UILabel *mobileLabel;
@property (nonatomic) UILabel *streetLabel;
@property (nonatomic) UILabel *districtLabel;
@property (nonatomic) UIButton *shareBtn;

@property (nonatomic)UINavigationController *navigation;

@property (nonatomic)id<CServerInterface>server;

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *containerView;

@property (nonatomic,strong)id<CCreateContactNavigationProtocol> createEditNavigation;

@end

@interface CDisplayViewController()<pop>

@end

@implementation CDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.server = [CServer defaultParser];
    [self.view removeConstraints:self.view.constraints];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    [self addConstraints];
}

#pragma mark - Private methods

- (void)edit {
    self.createEditNavigation = [CCreateContactNavigation new];
    [self.createEditNavigation presentEditContactFlow:self withContact:self.contact];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:self.navigation completion:nil];
}

- (void)addConstraints {

    self.scrollView = [UIScrollView new];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:self.scrollView];

    self.containerView = [UIView new];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView addSubview:self.containerView];

    self.nameLabel = [UILabel new];
    self.nameLabel.text = self.contact.name;
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.nameLabel.layer.borderColor = [UIColor darkTextColor].CGColor;
    self.nameLabel.layer.borderWidth = 2.0;
    [self.nameLabel.layer setCornerRadius:2];
    [self.nameLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.nameLabel];

    self.emailLabel = [UILabel new];
    self.emailLabel.text = self.contact.email;
    [self.emailLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.emailLabel.layer.borderColor = [UIColor darkTextColor].CGColor;
    self.emailLabel.layer.borderWidth = 2.0;
    [self.emailLabel.layer setCornerRadius:2];
    [self.emailLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.emailLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.emailLabel];

    self.mobileLabel = [UILabel new];
    self.mobileLabel.text = self.contact.phone;
    [self.mobileLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.mobileLabel.layer.borderColor = [UIColor darkTextColor].CGColor;
    self.mobileLabel.layer.borderWidth = 2.0;
    [self.mobileLabel.layer setCornerRadius:2];
    [self.mobileLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.mobileLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.mobileLabel];

    self.streetLabel = [UILabel new];
    self.streetLabel.text = self.contact.street;
    [self.streetLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.streetLabel.layer.borderColor = [UIColor darkTextColor].CGColor;
    self.streetLabel.layer.borderWidth = 2.0;
    [self.streetLabel.layer setCornerRadius:2];
    [self.streetLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.streetLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.streetLabel];

    self.districtLabel = [UILabel new];
    self.districtLabel.text = self.contact.district;
    [self.districtLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.districtLabel.layer.borderColor = [UIColor darkTextColor].CGColor;
    self.districtLabel.layer.borderWidth = 2.0;
    [self.districtLabel.layer setCornerRadius:2];
    [self.districtLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
    self.districtLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.districtLabel];

    self.shareBtn = [UIButton new];
    [self.shareBtn setTitle:@"Share" forState:UIControlStateNormal];
    [self.shareBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    UIColor* backgroundColor = [UIColor colorWithRed:0.175f green:0.458f blue:0.831f alpha:1.0f];
    [self.shareBtn setBackgroundColor:backgroundColor];
    [self.shareBtn.layer setCornerRadius:2];
    [self.shareBtn.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    [self.shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.shareBtn];

    NSDictionary *views = NSDictionaryOfVariableBindings(_scrollView,
                                                         _containerView,
                                                         _nameLabel,
                                                         _emailLabel,
                                                         _mobileLabel,
                                                         _streetLabel,
                                                         _districtLabel,
                                                         _shareBtn);

    NSArray *constraints = [NSArray array];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_scrollView]-0-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scrollView]-0-|" options:0 metrics:nil views:views]];

    NSString *verticalConsForContainerView = [NSString stringWithFormat:@"V:|-0-[_containerView]-0-|"];
    NSString *horizontalConsForContainerView = [NSString stringWithFormat:@"H:|-0-[_containerView]-0-|"];

    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConsForContainerView options:0 metrics:nil views:views]];
    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalConsForContainerView options:0 metrics:nil views:views]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];

    [self.containerView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_nameLabel(50)]-40-[_emailLabel(50)]-40-[_mobileLabel(50)]-40-[_streetLabel(50)]-40-[_districtLabel(50)]-40-[_shareBtn(50)]" options:0 metrics:nil views:views]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_nameLabel]-|" options:0 metrics:nil views:views]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailLabel]-|" options:0 metrics:nil views:views]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_mobileLabel]-|" options:0 metrics:nil views:views]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_streetLabel]-|" options:0 metrics:nil views:views]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_districtLabel]-|" options:0 metrics:nil views:views]];

    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_shareBtn]-|" options:0 metrics:nil views:views]];

    [self.view addConstraints:constraints];
}

- (void)popout {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)share {
#warning deeplinking Share URL is not look like a URL in iOS9
    [self.server storeShareArray:@[self.contact.objectId] :^(NSString *objectId, NSError *error) {
    NSString *finalString = [@"Contacts:" stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"//multipleContacts/",objectId]];
//        NSString *finalString = @"Yelp://12345";
    NSURL *customURL = [[NSURL alloc] initWithString:finalString];
    CActivityViewController *activityVC = [[CActivityViewController alloc] initWithURL:customURL];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[activityVC] applicationActivities:nil];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //iPhone, present activity view controller as is
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
    }];
}

// @override this method for hiding Tabbar when this viewcontroller
-(BOOL)hidesBottomBarWhenPushed {
    return YES;
}

@end
