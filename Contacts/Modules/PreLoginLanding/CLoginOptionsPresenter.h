//
//  CLoginOptionsPresenter.h
//  Contacts
//
//  Created by ranjith on 11/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLoginOptionsPresenterProtocol.h"
#import "CPreLoginAppNavigation.h"
#import "CLoginOptionsIO.h"
#import "CLoginOptionsViewProtocol.h"
#import "CLoginOptionsIO.h"

@interface CLoginOptionsPresenter : NSObject<CLoginOptionsPresenterProtocol>

@property (nonatomic,weak)CPreLoginAppNavigation* navigation;
@property (nonatomic,weak)id<CLoginOptionsViewProtocol> view;
@property (nonatomic,strong)id<CLoginOptionInputLogicProtocol> logic;

@end
