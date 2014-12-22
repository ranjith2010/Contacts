//
//  CAddress+Additions.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CAddress+Additions.h"
#import "CConstants.h"

@implementation CAddress (Additions)
+ (CAddress*)dictionaryToCAddress:(NSMutableDictionary*)dictionary{
    CAddress *returnAddress;
    returnAddress = [[CAddress alloc]init];
    if(dictionary.count!=0){
        if([dictionary valueForKey:kParseTypeAttribute]){
            [returnAddress setTypeOfAddress:[dictionary valueForKey:kParseTypeAttribute]];
        }
        if([dictionary valueForKey:kParseStreetAttribute]){
            [returnAddress setStreet:[dictionary valueForKey:kParseStreetAttribute]];
        }
        if([dictionary valueForKey:kParseDistrictAttribute]){
            [returnAddress setDistrict:[dictionary valueForKey:kParseDistrictAttribute]];
        }
        if([[dictionary valueForKey:kParseAddressId] intValue]){
            [returnAddress setAddressId:[[dictionary valueForKey:kParseAddressId] intValue]];
        }
    }
    return returnAddress;
}

@end
