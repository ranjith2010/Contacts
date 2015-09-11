//
//  PFObject+Additions.h
//  ParseUser
//
//  Created by Ranjith on 05/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Parse/Parse.h>
#import "CContact.h"
#import "CConstants.h"

@interface PFObject (Additions)
//
//+ (CContact*)PFObjectToCContact:(PFObject*)pfObject;

- (CContact *)contact;

-(void)c_safeAddKey:(NSString *)key value:(id)value;

@end
