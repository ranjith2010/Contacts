//
//  PUContactsInfo.m
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CContact.h"
#import "NSMutableDictionary+Additions.h"

// The following keys are helping with Internal system ie.CoreData
// So, here nothing relationship with server.

NSString * const kContactInternalname                  = @"name";
NSString * const kContactInternalEmail                 = @"email";
NSString * const kContactInternalPhone                 = @"phone";
NSString * const kContactInternalStreet                = @"street";
NSString * const kContactInternalDistrict              = @"district";
NSString * const kContactInternalUserObjectId          = @"userObjectId";
NSString * const kContactInternalObjectId              = @"objectId";


//TODO:: i am doubt with following two variables.
NSString * const kZPContactFirstName            = @"firstname";
NSString * const kZPContactLastName             = @"lastname";


@interface CContact()
// The backing dictionary
@property (strong, readwrite, nonatomic) NSMutableDictionary* serverDictionary;
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

- (void)setObjectId:(NSString *)objectId {
    [self.serverDictionary setObject:objectId forKey:kContactInternalObjectId];
}

- (NSString *)objectId {
    return self.serverDictionary[kContactInternalObjectId];
}

- (void)setName:(NSString *)name {
    [self.serverDictionary safeAddForKey:kContactInternalname value:name];
}

- (NSString *)name {
   return self.serverDictionary[kContactInternalname];
}

- (void)setPhone:(NSString *)phone {
    [self.serverDictionary safeAddForKey:kContactInternalPhone value:phone];
}

- (NSString *)phone {
    return self.serverDictionary[kContactInternalPhone];
}

- (void)setEmail:(NSString *)email{
    [self.serverDictionary safeAddForKey:kContactInternalEmail value:email];
}

- (NSString *)email {
    return self.serverDictionary[kContactInternalEmail];
}

- (void)setStreet:(NSString *)street {
    [self.serverDictionary safeAddForKey:kContactInternalStreet value:street];
}

- (NSString *)street {
    return self.serverDictionary[kContactInternalStreet];
}

- (void)setDistrict:(NSString *)district {
    [self.serverDictionary safeAddForKey:kContactInternalDistrict value:district];
}

- (NSString *)district {
    return self.serverDictionary[kContactInternalDistrict];
}

- (void)setFirstname:(NSString *)firstname {
    [self.serverDictionary safeAddForKey:kZPContactFirstName value:firstname];
}

- (void)setUserObjectId:(NSString *)userObjectId {
    [self.serverDictionary safeAddForKey:kContactInternalUserObjectId value:userObjectId];
}

- (NSString *)userObjectId {
    return self.serverDictionary[kContactInternalUserObjectId];
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
