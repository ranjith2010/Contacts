//
//  CAddressBookInterface.h
//  Contacts
//
//  Created by ranjit on 10/08/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum  {
    ABAuthorizationStatusAuthorized,
    ABAuthorizationStatusDenied,
    ABAuthorizationStatusNotDetermined
} AddressBookAuthorization;

@protocol CAddressBookInterface <NSObject>

- (void)authorization:(void(^)(AddressBookAuthorization status))block;
- (void)saveContact;
- (void)updateContact;
- (void)deleteContact;
- (void)fetchContacts:(void(^)(NSArray *ABObjects))block;

@end
