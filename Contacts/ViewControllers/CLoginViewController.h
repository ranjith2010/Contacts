//
//  CLoginViewController.h
//  Contacts
//
//  Created by ranjit on 20/07/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBaseViewController.h"
#import "CLoginPresenter.h"

@interface CLoginViewController : CBaseViewController<CLoginViewProtocol>

@property (nonatomic,strong)id<CLoginPresenterProtocol>presenter;

@end
