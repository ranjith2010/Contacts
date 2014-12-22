//
//  ParseEngine.h
//  ParseUser
//
//  Created by Ranjith on 03/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CServerInterface.h"

@interface CParseEngine : NSObject<CServerInterface>

+ (CParseEngine*)sharedInstance;

@end
