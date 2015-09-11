//
//  CDContact+Additions.h
//  Contacts
//
//  Created by ranjit on 04/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CDContact.h"
#import "CContact.h"

@interface CDContact (Additions)

- (void)safeAddForKey:(NSString *)key value:(id)value;

@end
