//
//  CSignUpPresenter.h
//  Contacts
//
//  Created by ranjith on 10/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSignUpPresenterProtocol.h"
#import "CSignUpViewProtocol.h"
#import "CSignUpNavigationProtocol.h"
#import "CSignUpLogicIO.h"
#import "CPreLoginAppNavigation.h"

@interface CSignUpPresenter : NSObject<CSignUpPresenterProtocol>

@property (nonatomic,strong) id<CSignupLogicProtocol> logic;
@property (nonatomic,weak) id<CSignUpViewProtocol> view;
@property (nonatomic,strong) id<CSignUpNavigationProtocol> navigation;

@end
