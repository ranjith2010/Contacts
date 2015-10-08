//
//  CChangePasswordViewController.m
//  Contacts
//
//  Created by ranjith on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CChangePasswordViewController.h"
#import "CServerUserInterface.h"
#import "CServerUser.h"
#import "NSString+Additions.h"
#import "UIAlertView+ZPBlockAdditions.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface CChangePasswordViewController ()<UITextFieldDelegate> {
    CGFloat animatedDistance;
}

@property (nonatomic,strong) UILabel *oldPasswordLabel;
@property (nonatomic,strong) UITextField *oldPasswordTextField;
@property (nonatomic,strong) UILabel *brandNewPasswordLabel;
@property (nonatomic,strong) UITextField *brandNewPasswordTextField;
@property (nonatomic,strong) UITextField *confirmPasswordTextField;

@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *containerView;

@property (nonatomic)id<CServerUserInterface> serverUser;

@end

@implementation CChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"Change Password";
    self.serverUser = [CServerUser defaultUser];
    [self addUIElements];
}

- (void)addUIElements {
    
    self.scrollView = [UIScrollView new];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    //    [self.scrollView setBackgroundColor:[UIColor brownColor]];
    [self.view addSubview:self.scrollView];
    
    self.containerView = [UIView new];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    [self.scrollView setBackgroundColor:[UIColor yellowColor]];
    [self.scrollView addSubview:self.containerView];
    
    self.oldPasswordLabel = [UILabel new];
    [self.oldPasswordLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.oldPasswordLabel setText:@"Old password"];
    [self.oldPasswordLabel setTextColor:[UIColor brownColor]];
    [self.containerView addSubview:self.oldPasswordLabel];
    
    self.oldPasswordTextField = [UITextField new];
    [self.oldPasswordTextField setPlaceholder:@"Old password"];
    [self.oldPasswordTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.oldPasswordTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.oldPasswordTextField addTarget:self
                               action:@selector(methodToFire)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    self.oldPasswordTextField.delegate = self;
    [self.containerView addSubview:self.oldPasswordTextField];
    
    self.brandNewPasswordLabel = [UILabel new];
    [self.brandNewPasswordLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.brandNewPasswordLabel setText:@"New password"];
    [self.brandNewPasswordLabel setTextColor:[UIColor brownColor]];
    [self.containerView addSubview:self.brandNewPasswordLabel];
    
    self.brandNewPasswordTextField = [UITextField new];
    [self.brandNewPasswordTextField setPlaceholder:@"New password"];
    [self.brandNewPasswordTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.brandNewPasswordTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.brandNewPasswordTextField addTarget:self
                                  action:@selector(methodToFire)
                        forControlEvents:UIControlEventEditingDidEndOnExit];
    self.brandNewPasswordTextField.delegate = self;
    [self.containerView addSubview:self.brandNewPasswordTextField];
    
    
    self.confirmPasswordTextField = [UITextField new];
    [self.confirmPasswordTextField setPlaceholder:@"Confirm password"];
    [self.confirmPasswordTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.confirmPasswordTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.confirmPasswordTextField addTarget:self
                                       action:@selector(methodToFire)
                             forControlEvents:UIControlEventEditingDidEndOnExit];
    self.confirmPasswordTextField.delegate = self;
    [self.containerView addSubview:self.confirmPasswordTextField];
    
    self.cancelBtn = [UIButton new];
    [self.cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelBtn setBackgroundColor:[UIColor blueColor]];
    [self.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.cancelBtn.layer setCornerRadius:2];
    [self.cancelBtn.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
    [self.containerView addSubview:self.cancelBtn];

    self.confirmBtn = [UIButton new];
    [self.confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:[UIColor brownColor]];
    [self.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    self.confirmBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.confirmBtn.layer setCornerRadius:2];
    [self.confirmBtn.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
    [self.containerView addSubview:self.confirmBtn];
    
    [self addConstriants];
}


- (void)addConstriants {
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_scrollView,
                                                         _containerView,
                                                         _oldPasswordLabel,
                                                         _oldPasswordTextField,
                                                         _brandNewPasswordLabel,
                                                         _brandNewPasswordTextField,
                                                         _confirmPasswordTextField,
                                                         _cancelBtn,
                                                         _confirmBtn);
    
    NSArray *constraints = [NSArray array];
    
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_scrollView]-0-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scrollView]-0-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:constraints];
    
    NSString *verticalConsForContainerView = [NSString stringWithFormat:@"V:|-0-[_containerView]-0-|"];
    NSString *horizontalConsForContainerView = [NSString stringWithFormat:@"H:|-0-[_containerView]-0-|"];
    
    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConsForContainerView options:0 metrics:nil views:views]];
    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalConsForContainerView options:0 metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    [self.containerView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[_oldPasswordLabel(30)]-[_oldPasswordTextField(50)]-[_brandNewPasswordLabel(30)]-[_brandNewPasswordTextField(50)]-[_confirmPasswordTextField(50)]-40-[_cancelBtn(50)]" options:0 metrics:nil views:views]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_oldPasswordLabel]-|" options:0 metrics:nil views:views]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_oldPasswordTextField]-|" options:0 metrics:nil views:views]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_brandNewPasswordLabel]-|" options:0 metrics:nil views:views]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_brandNewPasswordTextField]-|" options:0 metrics:nil views:views]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_confirmPasswordTextField]-|" options:0 metrics:nil views:views]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_cancelBtn(_confirmBtn)]-[_confirmBtn]-|" options:0 metrics:nil views:views]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_confirmPasswordTextField]-40-[_confirmBtn(50)]" options:0 metrics:nil views:views]];

}


- (void)methodToFire{}


- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)confirm {
    if([self.oldPasswordTextField.text c_isEmpty]){
        [UIAlertView showInformationWithTitle:@"Error" message:@"Old password can't be Empty" dismissTitle:@"OK"];
    }
    else if([self.brandNewPasswordTextField.text c_isEmpty]) {
        [UIAlertView showInformationWithTitle:@"Error" message:@"New password can't be Empty" dismissTitle:@"OK"];
    }
    else if([self.confirmPasswordTextField.text c_isEmpty]) {
        [UIAlertView showInformationWithTitle:@"Error" message:@"Confirm password can't be Empty" dismissTitle:@"OK"];
    }
    else if(![self.brandNewPasswordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        [UIAlertView showInformationWithTitle:@"Error" message:@"New & Confirm password mis-match" dismissTitle:@"OK"];
    }
    else {
        [self showBusyIndicatorWithMessage:nil andImage:nil];
        [self.serverUser changePasswordForUsername:[self.serverUser email] oldPassword:self.oldPasswordTextField.text newPassword:self.oldPasswordTextField.text withCompletionBlock:^(BOOL result, NSError *error) {
            [self dismissBusyIndicator];
            if(error) {
            [UIAlertView showError:error withTitle:nil positiveTitle:nil negativeTitle:@"OK" positiveBlock:nil negativeBlock:nil];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    }
}


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
