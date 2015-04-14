//
//  PUAddress.m
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CAddress.h"
#import "CConstants.h"

@implementation CAddress

-(instancetype)init {
    self = [super init];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.street forKey:kServerStreetAttribute];
    [aCoder encodeObject:self.typeOfAddress forKey:kServerTypeAttribute];
    [aCoder encodeObject:self.district forKey:kServerDistrictAttribute];
    [aCoder encodeObject:[NSNumber numberWithInt:self.addressId] forKey:kServerAddressId];
    [aCoder encodeObject:self.contactObjectId forKey:kServerContactObjectId];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.street = [aDecoder decodeObjectForKey:kServerStreetAttribute];
        self.typeOfAddress = [aDecoder decodeObjectForKey:kServerTypeAttribute];
        self.district = [aDecoder decodeObjectForKey:kServerDistrictAttribute];
        NSNumber *rowNumber = [aDecoder decodeObjectForKey:kServerAddressId];
        self.addressId = [rowNumber intValue];
        self.contactObjectId= [aDecoder decodeObjectForKey:kServerContactObjectId];
    }
    return self;
}

@end
