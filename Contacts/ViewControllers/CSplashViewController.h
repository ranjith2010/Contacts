//
//  CSplashViewController.h
//  Contacts
//
//  Created by ranjit on 26/08/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBaseViewController.h"
#import "CLoginOptionsPresenter.h"

@interface CSplashViewController : CBaseViewController<CLoginOptionsViewProtocol>

@property (nonatomic,strong)id<CLoginOptionsPresenterProtocol> presenter;

@end
