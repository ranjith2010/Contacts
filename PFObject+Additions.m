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
        NSArray *temp = [[NSArray alloc] init];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

        temp = [pfObject allKeys];

        NSEnumerator *e = [temp objectEnumerator];
        id object;
        while (object = [e nextObject]) {
            [dict setValue:[pfObject objectForKey:object] forKey:object];
        }
        returnContact = [[CContact alloc]initWithServerDictionary:dict];

        //Check the results NSLog(@"PFObject Info: %@", PFObject); NSLog(@"dict Info: %@", dict);.
//        [returnContact setName:[pfObject valueForKey:kServerNameAttribute]];
//        [returnContact setEmail:[pfObject valueForKey:kServerEmailAttribute]];
//        [returnContact setPhone:[pfObject valueForKey:kServerPhoneAttribute]];
//        [returnContact setObjectId:[pfObject valueForKey:kServerObjectIdAttribute]];
        //[returnContact setAddressIdCollection:[pfObject valueForKey:kServerAddressIdCollection]];
//        [returnContact setUserObjectId:[pfObject valueForKey:kServerUserObjectIdAttribute]];
        return returnContact;
    }
    else{
        return returnContact;
    }
}
@end
