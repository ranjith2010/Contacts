//
//  CDContact+Additions.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CDContact+Additions.h"

@implementation CDContact (Additions)
+ (CContact*)contactCDModelToCModel:(CDContact*)CDcontact{
    CContact *PUcontact;
    if(CDcontact){
        PUcontact  = [[CContact alloc]init];
        [PUcontact setName:CDcontact.name];
        [PUcontact setEmail:CDcontact.email];
        [PUcontact setPhone:CDcontact.phone];
        [PUcontact setObjectId:CDcontact.objectId];
        [PUcontact setUserObjectId:CDcontact.userObjectId];
        if([NSKeyedUnarchiver unarchiveObjectWithData:CDcontact.addressIdCollection]!=nil){
            [PUcontact setAddressIdCollection:[NSKeyedUnarchiver unarchiveObjectWithData:CDcontact.addressIdCollection]];
        }
        return PUcontact;
    }
    else{
        return PUcontact;
    }
}
@end
