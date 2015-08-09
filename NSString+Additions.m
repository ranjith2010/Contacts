//
//  NSString+Additions.m
//  Zipper Beta 2
//
//  Created by Ashish on 02/12/13.
//  Copyright (c) 2013 Ashish. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (BOOL)c_isEmpty {
    if (!self) {
        return YES;
    }
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (string.length > 0) {
        return NO;
    }
    return YES;
}

- (BOOL)c_validateEmail {
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if (regExMatches == 0) {
        return NO;
    } else
        return YES;
}

- (NSString*)c_removeSymbols {
    NSString *emptySpaceTrim=[self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray* words = [emptySpaceTrim componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* nospaceCharSet = [words componentsJoinedByString:@""];
    NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"-()"];
    NSString *string = [[nospaceCharSet componentsSeparatedByCharactersInSet: trim] componentsJoinedByString: @""];
    NSLog(@"%@", string);
    return string;
}


- (BOOL)c_isChar {
    NSString *regex = @"[A-Z]+";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
}

@end
