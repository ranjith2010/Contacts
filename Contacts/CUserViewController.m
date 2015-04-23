//
//  CUserViewController.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CUserViewController.h"
#import "CCredentialsViewController.h"

#import "CServer.h"
#import "CServerInterface.h"
#import "CLocalInterface.h"
#import "CLocal.h"

@interface CUserViewController ()

@end

@implementation CUserViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CUser *user = [[CLocal defaultLocalDB]fetchCurrentUser:NO];
    if(user){
        [[CServer defaultParser] isAnonymousUser:^(BOOL succeed){
            if(!succeed){
                [_loginBtnProperty setTitle:@"Logout" forState:UIControlStateNormal];
            }
            else{
                [_loginBtnProperty setTitle:@"Login" forState:UIControlStateNormal];
            }
        }];
    }

}

#pragma mark - User Selection

- (IBAction)signUpBtn:(id)sender {
    CCredentialsViewController *credentialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CredenVC"];
    [self presentViewController:credentialVC animated:YES completion:nil];
}

- (IBAction)skipBtn:(id)sender {
    __block UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]
                                                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activityView.center=self.view.center;
    [activityView startAnimating];
    [self.view addSubview:activityView];
    [[CServer defaultParser]createAnonymousUser:^(CUser *user, NSError *error){
        if(!error){
            [activityView stopAnimating];
            NSLog(@"Anonymous #User Created Successfully");
        }
    }];
}


- (IBAction)loginBtn:(id)sender {
    if([_loginBtnProperty.titleLabel.text isEqualToString:@"Login"]){
    CCredentialsViewController *credentialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CredenVC"];
    [credentialVC setIsUserChoosenLogin:YES];
        [self presentViewController:credentialVC animated:YES completion:nil];
    }
    else{
        [[CServer defaultParser]logout:^(BOOL succeed){
            if(succeed){
                [[CLocal defaultLocalDB]logout:^(BOOL succeed){
                    if(succeed){
                        [_loginBtnProperty setTitle:@"Login" forState:UIControlStateNormal];
                     }
                }];
            }
        }];
    }
}
- (IBAction)dismissBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
