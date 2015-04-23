//
//  PUConstants.m
//  ParseUser
//
//  Created by Ranjith on 12/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CConstants.h"

@implementation CConstants

NSString * const kServerClientKey                                 = @"N4qTlR1d3yi6qanVrwvLVlfuszkMuYmjPU0SgAfo";
NSString * const kServerApplicationId                             = @"ZJdmZlD0SXuhlyjvuGomQwlC2YhvM7fk2F09qWWS";

// Parse : User class Name & Attributes

NSString * const kServerUserName                            = @"username";
NSString * const kServerPassword                            = @"password";

// Parse : Contact class Name & Attributes

NSString * const kServerContactClassName                     = @"Contacts";
NSString * const kServerUserObjectIdAttribute                = @"userObjectId";
NSString * const kServerObjectIdAttribute                    = @"objectId";
NSString * const kServerPhoneAttribute                       = @"phone";
NSString * const kServerEmailAttribute                       = @"email";
NSString * const kServerNameAttribute                        = @"name";
NSString * const kServerAddressIdCollection                  = @"addressIdCollection";

// Parse : Address class Names & Attributes

NSString * const kServerAddressClassName                     = @"Address";
NSString * const kServerStreetAttribute                      = @"street";
NSString * const kServerDistrictAttribute                    = @"district";
NSString * const kServerTypeAttribute                        = @"type";
NSString * const kServerAddressId                            = @"addressId";
NSString * const kServerContactObjectId                      = @"contactObjectId";

// Parse : SharedContacts Names & Attributes

NSString * const kServerSharedContactsClassName              = @"SharedContacts";
NSString * const kServerContactsArray                        = @"contacts";
@end
