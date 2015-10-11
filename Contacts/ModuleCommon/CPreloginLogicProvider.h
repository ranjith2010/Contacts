//
//  CPreloginLogicProvider.h
//  Contacts
//
//  Created by ranjith on 10/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSignupLogicIO.h"

/*!
 Provider class to provide logic implementations for prelogin flow.
 */

@interface CPreloginLogicProvider : NSObject

+ (id<CSignupLogicProtocol>)signupLogic;


@end
