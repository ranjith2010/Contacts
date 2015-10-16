//
//  CLoginPresenterProtocol.h
//  Contacts
//
//  Created by ranjith on 16/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLoginPresenterProtocol <NSObject>

- (void)onSignupClicked;
- (void)onLoginClickedWithUsername:(NSString*)username password:(NSString*)password;
- (void)onForgotPasswordClicked;
@end
