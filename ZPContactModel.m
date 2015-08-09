//
//  ZPContactModel.m
//  contactsIntegration
//
//  Created by Ranjith on 20/03/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import "ZPContactModel.h"
#import "NSString+Additions.h"
#import "NSMutableDictionary+Additions.h"

@interface ZPContactModel()
// The backing dictionary
@property (strong, readwrite, nonatomic) NSMutableDictionary* serverDictionary;
@end
NSString * const kZPContactFirstName            = @"contact_first_name";
NSString * const kZPContactLastName             = @"contact_last_name";
NSString * const kZPContactEmail                = @"contact_emails";
NSString * const kZPContactPhone                = @"contact_phone_numbers";
@implementation ZPContactModel


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
