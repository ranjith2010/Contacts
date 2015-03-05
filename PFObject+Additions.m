//
//  PFObject+Additions.m
//  ParseUser
//
//  Created by Ranjith on 05/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "PFObject+Additions.h"

@implementation PFObject (Additions)

+ (CContact*)PFObjectToCContact:(PFObject*)pfObject{
    CContact *returnContact;
    if(pfObject){
         returnContact = [[CContact alloc]init];
        [returnContact setName:[pfObject valueForKey:kServerNameAttribute]];
        [returnContact setEmail:[pfObject valueForKey:kServerEmailAttribute]];
        [returnContact setPhone:[pfObject valueForKey:kServerPhoneAttribute]];
        [returnContact setObjectId:[pfObject valueForKey:kServerObjectIdAttribute]];
        [returnContact setAddressIdCollection:[pfObject valueForKey:kServerAddressIdCollection]];
        [returnContact setUserObjectId:[pfObject valueForKey:kServerUserObjectIdAttribute]];
        return returnContact;
    }
    else{
        return returnContact;
    }
}
@end
