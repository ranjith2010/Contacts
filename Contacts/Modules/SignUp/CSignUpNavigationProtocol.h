//
//  CSignUpNavigationProtocol.h
//  Contacts
//
//  Created by ranjith on 09/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBaseViewController;

@protocol CSignUpNavigationProtocol <NSObject>

/*!
 Called after user is signed up successfully.
 @param signupVC The signup view controller.
 */
- (void)didSuccessfullyCompletedSignup:(CBaseViewController*)signupVC;

@end
