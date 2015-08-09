//
//  NSString+Additions.h
//  Zipper Beta 2
//
//  Created by Ashish on 02/12/13.
//  Copyright (c) 2013 Ashish. All rights reserved.
//

/*
 File: NSString+Additions.h
 Abstract: This is a category of NSString that adds methods to check empty string and valid email string.
 */

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (BOOL)c_isEmpty;
- (BOOL)c_validateEmail;
- (NSString*)c_removeSymbols;
- (BOOL)c_isChar;
@end
