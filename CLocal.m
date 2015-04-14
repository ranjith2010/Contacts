//
//  PULocalDB.m
//  ParseUser
//
//  Created by Ran on 05/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CLocal.h"
#import "CCoreDataEngine.h"

@implementation CLocal

+ (id)defaultLocalDB{
    return [CLocal withCoreData:@"CoreData"];
}

+ (id)withCoreData:(NSString*)type{
    if([type isEqual:@"CoreData"])
        return [CCoreDataEngine sharedInstance];
    else
        return nil;
}

@end
