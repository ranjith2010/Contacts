//
//  CSignUpPresenterProtocol.h
//  Contacts
//
//  Created by ranjith on 10/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CUser.h"

@protocol CSignUpPresenterProtocol <NSObject>

/*!
 @brief: 
 */

- (void)signUpWithNewUserInfo:(CUser*)userInfo;

@end
