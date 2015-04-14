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
        if([dictionary valueForKey:kServerTypeAttribute]){
            [returnAddress setTypeOfAddress:[dictionary valueForKey:kServerTypeAttribute]];
        }
        if([dictionary valueForKey:kServerStreetAttribute]){
            [returnAddress setStreet:[dictionary valueForKey:kServerStreetAttribute]];
        }
        if([dictionary valueForKey:kServerDistrictAttribute]){
            [returnAddress setDistrict:[dictionary valueForKey:kServerDistrictAttribute]];
        }
        if([[dictionary valueForKey:kServerAddressId] intValue]){
            [returnAddress setAddressId:[[dictionary valueForKey:kServerAddressId] intValue]];
        }
    }
    return returnAddress;
}

@end
