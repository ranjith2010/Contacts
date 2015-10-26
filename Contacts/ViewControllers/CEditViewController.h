//
//  CEditViewController.h
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CContact.h"
#import "CBaseViewController.h"
#import "CCreateContactLogicProtocol.h"
#import "CCreateContactLogic.h"
#import "CCreateEditContactViewProtocol.h"

@protocol pop <NSObject>

- (void)popout;

@end

@interface CEditViewController : CBaseViewController<CCreateEditContactViewProtocol>

@property(nonatomic,strong)CContact *contact;

@property (nonatomic)id<pop>delegate;

//@Note:: Why we are using Logic in ViewController, Coz we are limiting the presenter to use further.
@property (nonatomic,strong)id<CCreateContactLogicProtocol> logic;

@end
