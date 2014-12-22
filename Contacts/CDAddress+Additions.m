//
//  CDAddress+Additions.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CDAddress+Additions.h"

@implementation CDAddress (Additions)
// TODO:: Move this into Category! #PLS

+ (CAddress*)CDAddressToCAddress:(CDAddress*)cdAddress{
    CAddress *returnCAddress = [[CAddress alloc]init];
    [returnCAddress setTypeOfAddress:cdAddress.type];
    [returnCAddress setStreet:cdAddress.street];
    [returnCAddress setDistrict:cdAddress.district];
    [returnCAddress setAddressId:[cdAddress.addressId intValue]];
    return returnCAddress;
}
@end
