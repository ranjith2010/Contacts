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

@synthesize street,district,typeOfAddress,addressId,contactObjectId;

-(instancetype)init {
    self = [super init];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.street forKey:kParseStreetAttribute];
    [aCoder encodeObject:self.typeOfAddress forKey:kParseTypeAttribute];
    [aCoder encodeObject:self.district forKey:kParseDistrictAttribute];
    [aCoder encodeObject:[NSNumber numberWithInt:addressId] forKey:kParseAddressId];
    [aCoder encodeObject:self.contactObjectId forKey:kParseContactObjectId];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.street = [aDecoder decodeObjectForKey:kParseStreetAttribute];
        self.typeOfAddress = [aDecoder decodeObjectForKey:kParseTypeAttribute];
        self.district = [aDecoder decodeObjectForKey:kParseDistrictAttribute];
        NSNumber *rowNumber = [aDecoder decodeObjectForKey:kParseAddressId];
        self.addressId = [rowNumber intValue];
        self.contactObjectId= [aDecoder decodeObjectForKey:kParseContactObjectId];
    }
    return self;
}


@end
