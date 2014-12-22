//
//  PFObject+Additions.m
//  ParseUser
//
//  Created by Ran on 05/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "PFObject+Additions.h"

@implementation PFObject (Additions)

+ (CContact*)PFObjectToCContact:(PFObject*)pfObject{
    CContact *returnContact;
    if(pfObject){
         returnContact = [[CContact alloc]init];
        [returnContact setName:[pfObject valueForKey:kParseNameAttribute]];
        [returnContact setEmail:[pfObject valueForKey:kParseEmailAttribute]];
        [returnContact setPhone:[pfObject valueForKey:kParsePhoneAttribute]];
        [returnContact setObjectId:[pfObject valueForKey:kParseObjectIdAttribute]];
        [returnContact setAddressIdCollection:[pfObject valueForKey:kParseAddressIdCollection]];
        [returnContact setUserObjectId:[pfObject valueForKey:kParseUserObjectIdAttribute]];
        return returnContact;
    }
    else{
        return returnContact;
    }
}
@end
