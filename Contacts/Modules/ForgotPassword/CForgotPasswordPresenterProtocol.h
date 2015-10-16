//
//  CForgotPasswordPresenterProtocol.h
//  Contacts
//
//  Created by ranjith on 16/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CForgotPasswordPresenterProtocol <NSObject>

- (void)onResetPasswordWithEmail:(NSString*)email;

@end
