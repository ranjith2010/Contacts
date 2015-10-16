//
//  CForgotPasswordLogic.m
//  Contacts
//
//  Created by ranjith on 16/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CForgotPasswordLogic.h"
#import "CServerUserInterface.h"
#import "CServerUser.h"

@implementation CForgotPasswordLogic

- (void)resetPasswordwithEmail:(NSString *)email :(CForgotPasswordCompletionBlock)block {
    [[CServerUser defaultUser] forgotPassword:email :block];
}

@end
