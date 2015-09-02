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

@interface CEditViewController ()

@property (nonatomic) UITextField *nameTextField;
@property (nonatomic) UITextField *mobileTextField;
@property (nonatomic) UITextField *emailTextField;
@property (nonatomic) UITextField *streetTextField;
@property (nonatomic) UITextField *districtTextField;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *containerView;

@property (nonatomic) UIButton *deleteBtn;

@property (nonatomic) id<CServerInterface> server;

@property (nonatomic) UITextField *activeTextField;


@end

@implementation CEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.server = [CServer defaultParser];
    [self.view removeConstraints:self.view.constraints];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initialDataSetup];
    [self registerForKeyboardNotifications];
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
    [self.view addSubview:self.scrollView];

    self.containerView = [UIView new];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView addSubview:self.containerView];

    self.nameTextField = [UITextField new];
    [self.nameTextField setPlaceholder:@"name"];
    self.nameTextField.text = self.contact.name;
    [self.nameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.nameTextField addTarget:self
                               action:@selector(methodToFire)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.containerView addSubview:self.nameTextField];

    self.mobileTextField = [UITextField new];
    [self.mobileTextField setPlaceholder:@"mobile"];
    self.mobileTextField.text = self.contact.phone;
    [self.mobileTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mobileTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.mobileTextField addTarget:self
                               action:@selector(methodToFire)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.containerView addSubview:self.mobileTextField];

    self.emailTextField = [UITextField new];
    [self.emailTextField setPlaceholder:@"email"];
    self.emailTextField.text = self.contact.email;
    [self.emailTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.emailTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.emailTextField addTarget:self
                               action:@selector(methodToFire)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.containerView addSubview:self.emailTextField];

    self.streetTextField = [UITextField new];
    [self.streetTextField setPlaceholder:@"street"];
    self.streetTextField.text = self.contact.street;
    [self.streetTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.streetTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.streetTextField addTarget:self
                               action:@selector(methodToFire)
                     forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.containerView addSubview:self.streetTextField];

    self.districtTextField = [UITextField new];
    [self.districtTextField setPlaceholder:@"district"];
    self.districtTextField.text = self.contact.district;
    [self.districtTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.districtTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.districtTextField addTarget:self
                    action:@selector(methodToFire)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.containerView addSubview:self.districtTextField];

    self.deleteBtn = [UIButton new];
    [self.deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundColor:[UIColor redColor]];
    [self.deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.deleteBtn.layer setCornerRadius:10];
    [self.view addSubview:self.deleteBtn];


    NSDictionary *views = NSDictionaryOfVariableBindings(_scrollView,
                                                         _containerView,
                                                         _nameTextField,
                                                         _mobileTextField,
                                                         _emailTextField,
                                                         _streetTextField,
                                                         _districtTextField,
                                                         _deleteBtn);

    NSArray *constraints = [NSArray array];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_scrollView]-0-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scrollView]-0-|" options:0 metrics:nil views:views]];

    NSString *verticalConsForContainerView = [NSString stringWithFormat:@"V:|-0-[_containerView(%f)]-|",self.view.bounds.size.height];
    NSString *horizontalConsForContainerView = [NSString stringWithFormat:@"H:|-0-[_containerView(%f)]-|",self.view.bounds.size.width];

    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConsForContainerView options:0 metrics:nil views:views]];
    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalConsForContainerView options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameTextField(50)]-[_mobileTextField(50)]-[_emailTextField(50)]-[_streetTextField(50)]-[_districtTextField(50)]" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameTextField(50)]-[_mobileTextField(50)]-[_emailTextField(50)]-[_streetTextField(50)]-[_districtTextField(50)]" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_nameTextField]-|" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_mobileTextField]-|" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailTextField]-|" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_streetTextField]-|" options:0 metrics:nil views:views]];

    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_districtTextField]-|" options:0 metrics:nil views:views]];

    if(self.contact) {
        constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_districtTextField]-30-[_deleteBtn(50)]" options:0 metrics:nil views:views]];
        constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_deleteBtn]-|" options:0 metrics:nil views:views]];
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
        // Its came fresh look
        // New Contact
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.server storeContact:contact :^(BOOL result, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(!error) {
                NSLog(@"contact stored successfully");
                [self.navigationController popViewControllerAnimated:YES];
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

- (void)methodToFire {
}


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;

    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeTextField.frame.origin.y-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


@end
