//
//  PUUser.m
//  ParseUser
//
//  Created by Ranjith on 28/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CUser.h"
#import "CConstants.h"
#import "NSMutableDictionary+Additions.h"

@interface CUser()

// The backing Dictionary!
@property (nonatomic,strong)NSMutableDictionary *serverDictionary;
@end

@implementation CUser

- (id)init {
    self = [super init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [self setServerDictionary:[NSMutableDictionary dictionaryWithDictionary:dict]];
    return self;
}

- (id)initWithServerDictionary:(NSDictionary*)dictionary {
    self = [super init];
    [self setServerDictionary:[NSMutableDictionary dictionaryWithDictionary:dictionary]];
    return self;
}

- (NSString*)email {
    return self.serverDictionary[kServerEmailAttribute];
}

- (void)setEmail:(NSString *)email {
    [self.serverDictionary safeAddForKey:kServerEmailAttribute value:email];
}

- (NSString*)username {
    return self.serverDictionary[kServerUserName];
}

- (void)setUsername:(NSString *)username {
    [self.serverDictionary safeAddForKey:kServerUserName value:username];
}

- (NSString*)password {
    return self.serverDictionary[kServerPassword];
}

- (void)setPassword:(NSString *)password {
    [self.serverDictionary safeAddForKey:kServerPassword value:password];
}

@end
