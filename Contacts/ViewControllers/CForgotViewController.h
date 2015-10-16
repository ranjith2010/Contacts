//
//  CForgotViewController.h
//  Contacts
//
//  Created by ranjit on 26/08/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBaseViewController.h"
#import "CForgotPasswordPresenterProtocol.h"
#import "CForgotPasswordViewProtocol.h"

@interface CForgotViewController : CBaseViewController<CForgotPasswordViewProtocol>

@property (nonatomic,strong)id<CForgotPasswordPresenterProtocol> presenter;

@end
