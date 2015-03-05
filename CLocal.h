//
//  PULocalDB.h
//  ParseUser
//
//  Created by Ran on 05/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLocal : NSObject

+ (id)defaultLocalDB;
+ (id)withCoreData:(NSString*)type;

@end
