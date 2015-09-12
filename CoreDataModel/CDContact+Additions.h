//
//  CDContact+Additions.h
//  Contacts
//
//  Created by ranjith on 12/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CDContact.h"

@interface CDContact (Additions)

- (void)safeAddForKey:(NSString *)key value:(id)value;

@end
