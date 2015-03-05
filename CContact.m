//
//  PUContactsInfo.m
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CContact.h"
#import "NSMutableDictionary+Additions.h"
#import "CConstants.h"

@interface CContact()
// The backing Dictionary!
@property (nonatomic,strong)NSMutableDictionary *serverDictionary;
@end
@implementation CContact

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

- (NSDictionary*)dictionary {
    return self.serverDictionary;
}

- (NSString*)name {
    return self.serverDictionary[kServerNameAttribute];
}

- (void)setName:(NSString *)name {
    [self.serverDictionary safeAddForKey:kServerNameAttribute value:name];
}

- (NSString*)phone {
    return self.serverDictionary[kServerPhoneAttribute];
}

- (void)setPhone:(NSString *)phone {
    [self.serverDictionary safeAddForKey:kServerPhoneAttribute value:phone];
}

- (NSString*)objectId {
    return self.serverDictionary[kServerContactObjectId];
}
- (void)setObjectId:(NSString *)objectId {
    [self.serverDictionary safeAddForKey:kServerContactObjectId value:objectId];
}

- (NSString*)email {
    return self.serverDictionary[kServerEmailAttribute];
}

- (void)setEmail:(NSString *)email {
    [self.serverDictionary safeAddForKey:kServerEmailAttribute value:email];
}

- (NSString*)userObjectId {
    return self.serverDictionary[kServerUserObjectIdAttribute];
}

- (void)setUserObjectId:(NSString *)userObjectId {
    [self.serverDictionary safeAddForKey:kServerUserObjectIdAttribute value:userObjectId];
}

- (NSArray*)addressIdCollection {
    return self.serverDictionary[kServerAddressIdCollection];
}

- (void)setAddressIdCollection:(NSMutableArray *)addressIdCollection {
    [self.serverDictionary safeAddForKey:kServerAddressIdCollection value:addressIdCollection];
}

@end
