//
//  CPreloginLogicProvider.m
//  Contacts
//
//  Created by ranjith on 10/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CPreloginLogicProvider.h"
#import "CSignUpLogicIO.h"
#import "CSignUpLogic.h"

@implementation CPreloginLogicProvider

+ (id<CSignupLogicProtocol>)signupLogic {
    return [CSignUpLogic new];
}

@end
