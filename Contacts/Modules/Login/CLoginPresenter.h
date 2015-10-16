//
//  CLoginPresenter.h
//  Contacts
//
//  Created by ranjith on 16/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLoginViewProtocol.h"
#import "CLoginIO.h"
#import "CPreLoginAppNavigation.h"
#import "CLoginPresenterProtocol.h"

@interface CLoginPresenter : NSObject<CLoginPresenterProtocol>

@property (nonatomic,strong)id<CLoginViewProtocol> view;
@property (nonatomic,strong)id<CLoginLogicProtocol> logic;

@property (nonatomic,weak)CPreLoginAppNavigation *navigation;
@end
