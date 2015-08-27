//
//  CForgotViewController.m
//  Contacts
//
//  Created by ranjit on 26/08/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "CForgotViewController.h"
#import "NSString+Additions.h"
#import "CServerUser.h"
#import "CServerUserInterface.h"

@interface CForgotViewController ()

@property (nonatomic) UITextField *emailTextField;
@property (nonatomic) UIButton *resetBtn;

@property (nonatomic)id<CServerUserInterface>serverUser;

@end

@implementation CForgotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"Forgot Password";
    self.serverUser = [CServerUser defaultUser];
    [self pr_initalDataSetup];
}


- (void)pr_initalDataSetup {

    self.emailTextField = [UITextField new];
    [self.emailTextField setPlaceholder:@"Email"];
    [self.emailTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.emailTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.emailTextField];

    self.resetBtn = [UIButton new];
    [self.resetBtn setBackgroundColor:[UIColor blackColor]];
    [self.resetBtn setTitle:@"Reset" forState:UIControlStateNormal];
    [self.resetBtn addTarget:self action:@selector(resetEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.resetBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.resetBtn.layer setCornerRadius:10];
    [self.view addSubview:self.resetBtn];

    [self addConstraints];
}


- (void)addConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_emailTextField,_resetBtn);
    NSArray *constraints = [NSArray array];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[_emailTextField(50)]-[_resetBtn(50)]" options:0 metrics:nil views:views]];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_emailTextField]-|" options:0 metrics:nil views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_resetBtn(100)]-20-|" options:0 metrics:nil views:views]];

    [self.view addConstraints:constraints];

}


- (void)resetEmail {
    if([self.emailTextField.text c_isEmpty]) {
        NSLog(@"email is empty");
    }
    else if(![self.emailTextField.text c_validateEmail]){
        NSLog(@"invalid email");
    }
    else {
        [self.serverUser forgotPassword:self.emailTextField.text :^(BOOL succeeded, NSError *error) {
            if(!error){
                NSLog(@"reset email sent");
            }
            else {
                NSLog(@"%@",error.localizedDescription);
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
