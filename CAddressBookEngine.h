//
//  CAddressBookEngine.h
//  Contacts
//
//  Created by ranjit on 10/08/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAddressBookInterface.h"

@interface CAddressBookEngine : NSObject<CAddressBookInterface>

+ (CAddressBookEngine*)sharedInstance;

@end
