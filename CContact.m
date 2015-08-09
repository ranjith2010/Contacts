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

//Company = Zippr;
//CreationDate = "2015-07-20 12:28:34 +0000";
//Email = "ABMultiValueRef 0x7fde7e044e60 with 1 value(s)\n    0: _$!<Home>!$_ (0x105e94510) - ranmyfriend@icloud.com (0x7fde7e005750)\n";
//First = ranjith;
//FirstSort = "K)C;9O7=QA)K[9GGK\v\t\t\v\t\U00dc\b";
//FirstSortLanguageIndex = 0;
//FirstSortSection = K;
//IsPreferredName = 0;
//Kind = 0;
//Last = kumar;
//LastSort = "=QA)KK)C;9O7[9GGK\t\v\t\t\v\U00dc\b";
//LastSortLanguageIndex = 0;
//LastSortSection = "=";
//ModificationDate = "2015-07-20 12:28:51 +0000";
//NameOnlySearch = <4b29433b 394f3702 3d514129 4b00>;
//PersonLink = "-1";
//Phone = "ABMultiValueRef 0x7fde7e06a0a0 with 1 value(s)\n    0: _$!<Home>!$_ (0x105e94510) - 1\U00a0(234) (0x7fde7bce4b80)\n";
//Ringtone = "ABMultiValueRef 0x7fde7bc9e120 with 0 value(s)\n";
//Search = <4b29433b 394f3702 3d514129 4b025b39 47474b02 5b394747 4b00>;
//StoreID = 0;
//StoreReference = "<CPRecord: 0x7fde7bf473a0 ABStore>";
//SyntheticPropertiesReset = 0;


- (NSString*)name {
    NSMutableString *mutableString = [NSMutableString new];
    if(self.serverDictionary[@"First"]) {
        [mutableString appendString:[self.serverDictionary valueForKey:@"First"]];
        [mutableString appendFormat:@" "];
    }
    if(self.serverDictionary[@"Last"]) {
        [mutableString appendString:[self.serverDictionary valueForKey:@"Last"]];
    }
    if(!mutableString.length) {
        [mutableString appendString:@"No Name"];
    }
    return mutableString;
}

//- (void)setName:(NSString *)name {
//    [self.serverDictionary safeAddForKey:kServerNameAttribute value:name];
//}


- (NSString*)userObjectId {
    return self.serverDictionary[kServerUserObjectIdAttribute];
}

- (void)setUserObjectId:(NSString *)userObjectId {
    [self.serverDictionary safeAddForKey:kServerUserObjectIdAttribute value:userObjectId];
}

//- (NSString*)phone {
//    return self.serverDictionary[kServerPhoneAttribute];
//}
//
//- (void)setPhone:(NSString *)phone {
//    [self.serverDictionary safeAddForKey:kServerPhoneAttribute value:phone];
//}
//
//- (NSString*)objectId {
//    return self.serverDictionary[kServerContactObjectId];
//}
//- (void)setObjectId:(NSString *)objectId {
//    [self.serverDictionary safeAddForKey:kServerContactObjectId value:objectId];
//}

//- (NSString*)email {
//    return self.serverDictionary[kServerEmailAttribute];
//}
//
//- (void)setEmail:(NSString *)email {
//    [self.serverDictionary safeAddForKey:kServerEmailAttribute value:email];
//}

//- (NSArray*)addressIdCollection {
//    return self.serverDictionary[kServerAddressIdCollection];
//}
//
//- (void)setAddressIdCollection:(NSMutableArray *)addressIdCollection {
//    [self.serverDictionary safeAddForKey:kServerAddressIdCollection value:addressIdCollection];
//}

@end
