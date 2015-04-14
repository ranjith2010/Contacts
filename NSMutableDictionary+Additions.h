//
//  NSMutableDictionary+Additions.h
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Additions)

- (void)safeAddForKey:(NSString *)key value:(id)value;

@end
