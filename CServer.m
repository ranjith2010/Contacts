//
//  ContactsProvider.m
//  ParseUser
//
//  Created by Ranjith on 03/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CServer.h"
#import "CParseEngine.h"

@implementation CServer

+(id) defaultParser{
    return [CServer withParser:@"Parse"];
}

+(id) withParser:(NSString*)type{
    if([type isEqual:@"Parse"])
        return [CParseEngine sharedInstance];
    else
        return nil;
}
@end
