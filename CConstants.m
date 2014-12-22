//
//  PUConstants.m
//  ParseUser
//
//  Created by Ranjith on 12/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CConstants.h"

@implementation CConstants


// Credentials

NSString * const kClientKey                                 = @"N4qTlR1d3yi6qanVrwvLVlfuszkMuYmjPU0SgAfo";
NSString * const kApplicationId                             = @"ZJdmZlD0SXuhlyjvuGomQwlC2YhvM7fk2F09qWWS";


// Parse : Contact class Name & Attributes

NSString * const kParseContactClassName                     = @"Contacts";
NSString * const kParseUserObjectIdAttribute                = @"userObjectId";
NSString * const kParseObjectIdAttribute                    = @"objectId";
NSString * const kParsePhoneAttribute                       = @"phone";
NSString * const kParseEmailAttribute                       = @"email";
NSString * const kParseNameAttribute                        = @"name";
NSString * const kParseAddressIdCollection                  = @"addressIdCollection";

// Parse : Address class Names & Attributes

NSString * const kParseAddressClassName                     = @"Address";
NSString * const kParseStreetAttribute                      = @"street";
NSString * const kParseDistrictAttribute                    = @"district";
NSString * const kParseTypeAttribute                        = @"type";
NSString * const kParseAddressId                            = @"addressId";
NSString * const kParseContactObjectId                      = @"contactObjectId";

// Parse : SharedContacts Names & Attributes

NSString * const kParseSharedContactsClassName              = @"SharedContacts";
NSString * const kParseContactsArray                        = @"contacts";

// Notification : Names

NSString * const kAppDidReceivedSharedContactsNotification  = @"SharedContactsReceivedSuccessfully";

// Entity : Names

NSString * const kContactEntity                             = @"CDContact";
NSString * const kAddressEntity                             = @"CDAddress";
NSString * const kUserEntity                                = @"CDUser";
@end
