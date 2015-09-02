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
// The backing dictionary
@property (strong, readwrite, nonatomic) NSMutableDictionary* serverDictionary;
@end
NSString * const kZPContactFirstName            = @"firstname";
NSString * const kZPContactLastName             = @"lastname";

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

- (void)setObjectId:(NSString *)objectId {
    [self.serverDictionary setObject:objectId forKey:kServerObjectIdAttribute];
}

- (NSString *)objectId {
    return self.serverDictionary[kServerObjectIdAttribute];
}

- (void)setName:(NSString *)name {
    [self.serverDictionary safeAddForKey:kServerNameAttribute value:name];
}

- (NSString *)name {
   return self.serverDictionary[kServerNameAttribute];
}

- (void)setPhone:(NSString *)phone {
    [self.serverDictionary safeAddForKey:kServerPhoneAttribute value:phone];
}

- (NSString *)phone {
    return self.serverDictionary[kServerPhoneAttribute];
}

- (void)setEmail:(NSString *)email{
    [self.serverDictionary safeAddForKey:kServerEmailAttribute value:email];
}

- (NSString *)email {
    return self.serverDictionary[kServerEmailAttribute];
}

- (void)setStreet:(NSString *)street {
    [self.serverDictionary safeAddForKey:kServerStreetAttr value:street];
}

- (NSString *)street {
    return self.serverDictionary[kServerStreetAttr];
}

- (void)setDistrict:(NSString *)district {
    [self.serverDictionary safeAddForKey:kServerDistrictAttr value:district];
}

- (NSString *)district {
    return self.serverDictionary[kServerDistrictAttr];
}

- (void)setFirstname:(NSString *)firstname {
    [self.serverDictionary safeAddForKey:kZPContactFirstName value:firstname];
}

- (NSString*)firstname {
    return self.serverDictionary[kZPContactFirstName];
}
- (void)setLastname:(NSString *)lastname {
    [self.serverDictionary safeAddForKey:kZPContactLastName value:lastname];
}

- (NSString*)lastname {
    return self.serverDictionary[kZPContactLastName];
}

- (void)setUserObjectId:(NSString *)userObjectId {
    [self.serverDictionary safeAddForKey:kServerUserObjectIdAttribute value:userObjectId];
}

- (NSString *)userObjectId {
    return self.serverDictionary[kServerUserObjectIdAttribute];
}

- (NSString*)getFullName {
    NSString *fullname =nil;
    // here i am not cross checking first & last name has null value,
    // becuase in iPhone contact app doesn't allow to create a contact with Null value in Names
    if(self.firstname !=nil && self.lastname !=nil) {
        fullname = [NSString stringWithFormat:@"%@ %@",self.firstname,self.lastname];
    }
    else if(self.firstname!=nil && self.lastname==nil) {
        fullname = self.firstname;
    }
    else if(self.lastname) {
        fullname = self.lastname;
    }
    return fullname;
}

@end
