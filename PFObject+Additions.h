//
//  PFObject+Additions.h
//  ParseUser
//
//  Created by Ran on 05/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Parse/Parse.h>
#import "CContact.h"
#import "CConstants.h"

@interface PFObject (Additions)

+ (CContact*)PFObjectToCContact:(PFObject*)pfObject;

@end
