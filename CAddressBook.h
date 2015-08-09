//
//  CAddressBook.h
//  Contacts
//
//  Created by ranjit on 10/08/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAddressBook : NSObject

+(id) defaultParser;
+(id) withParser:(NSString*)type;

@end
