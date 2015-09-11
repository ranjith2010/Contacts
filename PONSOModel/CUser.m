//
//  PUUser.m
//  ParseUser
//
//  Created by Ranjith on 28/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CUser.h"
#import "NSMutableDictionary+Additions.h"

NSString * const kUserInternalEmail                 = @"email";
NSString * const kUserInternalUsername              = @"username";
NSString * const kUserInternalPassword              = @"password";
NSString * const kUserInternalObjectId              = @"objectid";

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
    return self.serverDictionary[kUserInternalEmail];
}

- (void)setEmail:(NSString *)email {
    [self.serverDictionary safeAddForKey:kUserInternalEmail value:email];
}

- (NSString*)username {
    return self.serverDictionary[kUserInternalUsername];
}

- (void)setUsername:(NSString *)username {
    [self.serverDictionary safeAddForKey:kUserInternalUsername value:username];
}

- (NSString*)password {
    return self.serverDictionary[kUserInternalPassword];
}

- (void)setPassword:(NSString *)password {
    [self.serverDictionary safeAddForKey:kUserInternalPassword value:password];
}

- (void)setObjectId:(NSString *)objectId {
    [self.serverDictionary setObject:objectId forKey:kUserInternalObjectId];
}

- (NSString *)objectId {
    return self.serverDictionary[kUserInternalObjectId];
}


@end
