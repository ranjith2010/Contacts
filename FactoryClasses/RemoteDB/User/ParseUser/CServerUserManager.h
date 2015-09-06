//
//  CServerUserManager.h
//  Contacts
//
//  Created by ranjit on 14/08/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CServerUserInterface.h"

@interface CServerUserManager : NSObject<CServerUserInterface>

+ (CServerUserManager*)sharedInstance;

@end
