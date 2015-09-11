//
//  CDContact+Additions.m
//  Contacts
//
//  Created by ranjit on 04/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CDContact+Additions.h"

@implementation CDContact (Additions)

// @Notes: Why it's necessary, because in some cases -  some property has nil vaule.
// Its fully safe side

- (void)safeAddForKey:(NSString *)key value:(id)value {
    if (value && key) {
        [self setValue:value forKey:key];
    }
}

@end
