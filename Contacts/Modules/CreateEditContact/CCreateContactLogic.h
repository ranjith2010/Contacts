//
//  CCreateContactLogic.h
//  Contacts
//
//  Created by ranjith on 25/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCreateContactLogicProtocol.h"
#import "CCreateEditContactViewProtocol.h"
#import "CCreateContactNavigationProtocol.h"

@interface CCreateContactLogic : NSObject<CCreateContactLogicProtocol>

@property (nonatomic,strong)id<CCreateEditContactViewProtocol> view;
@property (nonatomic,strong)id<CCreateContactNavigationProtocol> navigation;

@end
