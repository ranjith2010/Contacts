//
//  NSMutableDictionary+Additions.m
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "NSMutableDictionary+Additions.h"

@implementation NSMutableDictionary (Additions)

- (void)safeAddForKey:(NSString *)key value:(id)value {
    if (value && key) {
        self[key] = value;
    }
}
@end
