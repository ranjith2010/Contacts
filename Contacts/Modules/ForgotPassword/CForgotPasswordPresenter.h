//
//  CForgotPasswordPresenter.h
//  Contacts
//
//  Created by ranjith on 16/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CForgotPasswordLogic.h"
#import "CForgotPasswordViewProtocol.h"
#import "CForgotPasswordLogicProtocol.h"
#import "CPreLoginAppNavigation.h"
#import "CForgotPasswordPresenterProtocol.h"

@interface CForgotPasswordPresenter : NSObject<CForgotPasswordPresenterProtocol>

@property (nonatomic,strong)id<CForgotPasswordViewProtocol> view;
@property (nonatomic,strong)id<CForgotPasswordLogicProtocol> logic;
@property (nonatomic,weak) CPreLoginAppNavigation *navigation;
@end
