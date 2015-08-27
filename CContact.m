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
NSString * const kZPContactEmail                = @"email";
NSString * const kZPContactPhone                = @"phone";
NSString * const kZPContactUserObjectId         = @"userobjectid";
NSString * const kZPContactRollNumber           = @"rollnumber";

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

- (void)setName:(NSString *)name {
    [self.serverDictionary safeAddForKey:@"name" value:name];
}

- (NSString *)name {
   return self.serverDictionary[@"name"];
}

- (void)setMobile:(NSString *)mobile {
    [self.serverDictionary safeAddForKey:@"mobile" value:mobile];
}

- (NSString *)mobile {
    return self.serverDictionary[@"mobile"];
}

- (void)setEmailString:(NSString *)emailString {
    [self.serverDictionary safeAddForKey:@"email" value:emailString];
}

- (NSString *)emailString {
    return self.serverDictionary[@"email"];
}

- (void)setStreet:(NSString *)street {
    [self.serverDictionary safeAddForKey:@"street" value:street];
}

- (NSString *)street {
    return self.serverDictionary[@"street"];
}

- (void)setDistrict:(NSString *)district {
    [self.serverDictionary safeAddForKey:@"district" value:district];
}

- (NSString *)district {
    return self.serverDictionary[@"district"];
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
- (void)setPhone:(NSArray *)phone {
    [self.serverDictionary safeAddForKey:kZPContactPhone value:phone];
}

- (NSArray*)phone {
    return self.serverDictionary[kZPContactPhone];
}

- (void)setEmail:(NSArray *)email {
    [self.serverDictionary safeAddForKey:kZPContactEmail value:email];
}

- (NSArray*)email {
    return self.serverDictionary[kZPContactEmail];
}

- (void)setUserObjectId:(NSString *)userObjectId {
    [self.serverDictionary safeAddForKey:kZPContactUserObjectId value:userObjectId];
}

- (NSString *)userObjectId {
    return self.serverDictionary[kZPContactUserObjectId];
}

- (void)setRollNumber:(NSString *)rollNumber {
    [self.serverDictionary safeAddForKey:kZPContactRollNumber value:rollNumber];
}

- (NSString *)rollNumber {
    return self.serverDictionary[kZPContactRollNumber];
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
    else if(self.phone.count !=0) {
        fullname = self.phone.firstObject;
    }
    else if(self.email.count !=0) {
        fullname =  self.email.firstObject;
    }
    return fullname;
}

@end
