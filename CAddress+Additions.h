//
//  CAddress+Additions.h
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CAddress.h"

@interface CAddress (Additions)

+ (CAddress*)dictionaryToCAddress:(NSMutableDictionary*)dictionary;

@end
