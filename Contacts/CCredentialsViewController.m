//
//  CCredentialsViewController.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CCredentialsViewController.h"
#import "CServer.h"
#import "CServerInterface.h"
#import "CLocal.h"
#import "CLocalInterface.h"
#import "CUser.h"

@interface CCredentialsViewController (){
    CUser *user;
}
@end

@implementation CCredentialsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.containerView
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];
    
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTrailing relatedBy:0 toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:rightConstraint];
    [self initialDataSetup];
}


#pragma mark - Private Api

- (void)initialDataSetup{
    if(_isUserChoosenLogin){
        _createBtnProperty.title = @"Login";
    }
}

#pragma mark - Button Actions

- (IBAction)dismissBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissKeyboard:(id)sender {
}

//- (IBAction)createBtn:(id)sender {
//    user = [[CUser alloc]init];
//    [user setUsername:_userNameTextField.text];
//    [user setEmail:_emailTextField.text];
//    [user setPassword:_passwordTextField.text];
//    if([_createBtnProperty.title isEqualToString:@"Login"]){
//        [[CServer defaultParser] logIn:user :^(CUser *Cuser){
//            if(Cuser){
//                [[CLocal defaultLocalDB] createNewUser:Cuser :^(BOOL succeed){
//                    if(succeed){
//                    NSLog(@"Existing User Logged in successfully");
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                }
//                 else{
//                     NSLog(@"Failure #Existing user Log in");
//                 }
//                }];
//            }
//        }];
//    }
//    else{
//        [[CServer defaultParser] createNewUser:user : ^(BOOL succedeed){
//            if(succedeed){
//                [[CLocal defaultLocalDB]createNewUser:user :^(BOOL succedeed){
//                    if(succedeed){
//                        NSLog(@"New User Successfully Created.!");
//                        [self dismissViewControllerAnimated:YES completion:nil];
//                    }
//                    else{
//                        NSLog(@"Failure #New user Creation");
//                    }
//                }];
//            }
//        }];
//    }
//}
@end
