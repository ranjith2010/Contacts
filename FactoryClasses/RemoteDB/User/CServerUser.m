//
//  CServerUser.m
//  Contacts
//
//  Created by ranjit on 14/08/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CServerUser.h"
#import "CServerUserManager.h"

@implementation CServerUser

+(id) defaultUser {
    return [CServerUser withParser:@"serverUser"];
}

+(id) withParser:(NSString*)type{
    if([type isEqual:@"serverUser"])
        return [CServerUserManager sharedInstance];
    else
        return nil;
}

@end
