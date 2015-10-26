//
//  CCreateContactLogicProtocol.h
//  Contacts
//
//  Created by ranjith on 25/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CContact;

@protocol CCreateContactLogicProtocol <NSObject>

- (void)createContactWithBlob:(CContact*)contact;

- (void)updateContactWithBlob:(CContact*)contact;

- (void)deleteContact:(CContact*)contact;

@end
