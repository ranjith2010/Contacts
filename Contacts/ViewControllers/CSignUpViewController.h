//
//  CSignUpViewController.h
//  Contacts
//
//  Created by ranjit on 20/07/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBaseViewController.h"
#import "CSignUpPresenterProtocol.h"
#import "CSignUpPresenter.h"

@interface CSignUpViewController : CBaseViewController<CSignUpViewProtocol>

@property (nonatomic,strong)id<CSignUpPresenterProtocol> presenter;

@end
