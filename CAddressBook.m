//
//  CAddressBook.m
//  Contacts
//
//  Created by ranjit on 10/08/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CAddressBook.h"
#import "CAddressBookEngine.h"

@implementation CAddressBook

+(id) defaultParser{
    return [CAddressBook withParser:@"AddressBook"];
}

+(id) withParser:(NSString*)type{
    if([type isEqual:@"AddressBook"])
        return [CAddressBookEngine sharedInstance];
    else
        return nil;
}

@end
