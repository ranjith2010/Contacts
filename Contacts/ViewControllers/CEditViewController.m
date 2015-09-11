//
//  CEditViewController.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CEditViewController.h"

#import "CLocal.h"
#import "CLocalInterface.h"

#import "CServer.h"
#import "CServerInterface.h"
#import "NSString+Additions.h"
#import "NSString+Additions.h"
#import "MBProgressHUD.h"

#import "CLocalInterface.h"
#import "CLocal.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface CEditViewController ()<UITextFieldDelegate> {
    CGFloat animatedDistance;
}

@property (nonatomic) UITextField *nameTextField;
@property (nonatomic) UITextField *mobileTextField;
@property (nonatomic) UITextField *emailTextField;
@property (nonatomic) UITextField *streetTextField;
@property (nonatomic) UITextField *districtTextField;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *containerView;
@property (nonatomic) UIButton *deleteBtn;

@property (nonatomic) id<CServerInterface> server;
@property (nonatomic) id<CLocalInterface> local;

@end

@implementation CEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.server = [CServer defaultParser];
    self.local = [CLocal defaultLocalDB];
    [self.view removeConstraints:self.view.constraints];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initialDataSetup];
}

#pragma mark - Private API

- (void)initialDataSetup {
    UIBarButtonItem *rightBarbuttonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(storeContact)];
    self.navigationItem.rightBarButtonItem = rightBarbuttonItem;
    [self addConstraints];
}

- (void)addConstraints {
    self.scrollView = [UIScrollView new];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
//    [self.scrollView setBackgroundColor:[UIColor brownColor]];
    [self.view addSubview:self.scrollView];

    self.containerView = [UIView new];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.scrollView setBackgroundColor:[UIColor yellowColor]];
    [self.scrollView addSubview:self.containerView];

    self.nameTextField = [UITextField new];
    [self.nameTextField setPlaceholder:@"name"];
    self.nameTextField.text = self.contact.name;
    [self.nameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.nameTextField addTarget:self
                               action:@selector(methodToFire)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    self.nameTextField.delegate = self;
    [self.containerView addSubview:self.nameTextField];

    self.mobileTextField = [UITextField new];
    [self.mobileTextField setPlaceholder:@"mobile"];
    self.mobileTextField.text = self.contact.phone;
    [self.mobileTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mobileTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.mobileTextField addTarget:self
                               action:@selector(methodToFire)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    self.mobileTextField.delegate = self;
    [self.containerView addSubview:self.mobileTextField];

    self.emailTextField = [UITextField new];
    [self.emailTextField setPlaceholder:@"email"];
    self.emailTextField.text = self.contact.email;
    [self.emailTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.emailTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.emailTextField addTarget:self
                               action:@selector(methodToFire)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    self.emailTextField.delegate = self;
    [self.containerView addSubview:self.emailTextField];

    self.streetTextField = [UITextField new];
    [self.streetTextField setPlaceholder:@"street"];
    self.streetTextField.text = self.contact.street;
    [self.streetTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.streetTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.streetTextField addTarget:self
                               action:@selector(methodToFire)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    self.streetTextField.delegate = self;
    [self.containerView addSubview:self.streetTextField];

    self.districtTextField = [UITextField new];
    [self.districtTextField setPlaceholder:@"district"];
    self.districtTextField.text = self.contact.district;
    [self.districtTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.districtTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.districtTextField addTarget:self
                    action:@selector(methodToFire)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    self.districtTextField.delegate = self;
    [self.containerView addSubview:self.districtTextField];


    NSDictionary *views;

    if(self.contact) {
    self.deleteBtn = [UIButton new];
    [self.deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundColor:[UIColor redColor]];
    [self.deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.deleteBtn.layer setCornerRadius:2];
    [self.deleteBtn.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
    [self.containerView addSubview:self.deleteBtn];
        
    views = NSDictionaryOfVariableBindings(_scrollView,
                                               _containerView,
                                               _nameTextField,
                                               _mobileTextField,
                                               _emailTextField,
                                               _streetTextField,
                                               _districtTextField,
                                               _deleteBtn
                                               );
    }
    else {
    views = NSDictionaryOfVariableBindings(_scrollView,
                                            _containerView,
                                            _nameTextField,
                                            _mobileTextField,
                                            _emailTextField,
                                            _streetTextField,
                                            _districtTextField
                                                         );
    }

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


    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_nameTextField(50)]-[_mobileTextField(50)]-[_emailTextField(50)]-[_streetTextField(50)]-[_districtTextField(50)]" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_nameTextField]-|" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_mobileTextField]-|" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailTextField]-|" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_streetTextField]-|" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_districtTextField]-|" options:0 metrics:nil views:views]];

    if(self.contact) {
        [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_districtTextField]-30-[_deleteBtn(50)]" options:0 metrics:nil views:views]];
        [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_deleteBtn]-|" options:0 metrics:nil views:views]];
    }

    [self.view addConstraints:constraints];
}

- (void)storeContact {
    CContact *contact = [CContact new];
    if(([self.nameTextField.text c_isEmpty]) && ([self.mobileTextField.text c_isEmpty]) && ([self.mobileTextField.text c_isEmpty]) && ([self.emailTextField.text c_isEmpty]) && ([self.streetTextField.text c_isEmpty]) && ([self.districtTextField.text c_isEmpty])) {
        contact.name = @"NO NAME";
    }
    else {
        contact.name = _nameTextField.text;
        contact.phone = _mobileTextField.text;
        contact.email = _emailTextField.text;
        contact.street = _streetTextField.text;
        contact.district = _districtTextField.text;
    }
    // if it has some displayInstance. So the user wants to update some value
    // So, its updated scenario
    if(self.delegate) {
        contact.objectId = self.contact.objectId;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.server updateContact:contact :^(BOOL result, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(!error){
                [self.local updateContact:contact :^(BOOL result, NSError *error) {
                    if(!error) {
                        NSLog(@"update contact successfully");
                        [self dismissViewControllerAnimated:NO completion:nil];
                        [self.delegate popout];
                    }
                    else {
                        NSLog(@"%@",error.localizedDescription);
                    }
                }];
            }
            else {
                NSLog(@"%@",error.localizedDescription);
            }
        }];
    }
    else {
        // Its came fresh look
        // New Contact
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.server storeContact:contact :^(CContact *contact, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(!error) {
                [self.local storeContact:contact :^(BOOL result, NSError *error) {
                    if(!error) {
                        NSLog(@"contact stored successfully");
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else {
                        NSLog(@"%@",error.localizedDescription);
                    }
                }];
            }
            else {
                NSLog(@"%@",error.localizedDescription);
            }
        }];
    }
}

- (void)delete {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.server deleteContact:self.contact :^(BOOL result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error) {
            NSLog(@"contact deleted successfully");
            [self dismissViewControllerAnimated:NO completion:nil];
            [self.delegate popout];
        }
        else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

// dummy selector @note: There is no use for this selector
- (void)methodToFire {}


#pragma mark - TextField Delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];

    [self.view setFrame:viewFrame];

    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];

    [self.view setFrame:viewFrame];

    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
