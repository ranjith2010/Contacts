//
//  CCredentialsViewController.h
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CCredentialsViewController : UIViewController{
    IBOutlet UIScrollView *scroller;
}
@property(nonatomic) BOOL isUserChoosenLogin;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *createBtnProperty;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
