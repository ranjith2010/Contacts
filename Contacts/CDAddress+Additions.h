//
//  CDAddress+Additions.h
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CDAddress.h"
#import "CAddress.h"

@interface CDAddress (Additions)
+ (CAddress*)CDAddressToCAddress:(CDAddress*)cdAddress;
@end
