//
//  PUConstants.m
//  ParseUser
//
//  Created by Ranjith on 12/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CConstants.h"

@implementation CConstants

NSString * const kServerClientKey                           = @"N4qTlR1d3yi6qanVrwvLVlfuszkMuYmjPU0SgAfo";
NSString * const kServerApplicationId                       = @"ZJdmZlD0SXuhlyjvuGomQwlC2YhvM7fk2F09qWWS";

// Parse : User class Name & Attributes

NSString * const kServerUserName                            = @"username";
NSString * const kServerPassword                            = @"password";

// Parse : Contact class Name & Attributes

NSString * const kServerContactClassName                     = @"contact";
NSString * const kServerUserObjectIdAttribute                = @"userobjectid";
NSString * const kServerObjectIdAttribute                    = @"objectId";
NSString * const kServerPhoneAttribute                       = @"phone";
NSString * const kServerEmailAttribute                       = @"email";
NSString * const kServerNameAttribute                        = @"name";
NSString * const kServerStreetAttr                           = @"street";
NSString * const kServerDistrictAttr                         = @"district";


NSString * const kServerAddressIdCollection                  = @"addressIdCollection";
NSString * const kServerContactRollNumber                    = @"rollnumber";

// Parse : Address class Names & Attributes

NSString * const kServerAddressClassName                     = @"Address";
NSString * const kServerStreetAttribute                      = @"street";
NSString * const kServerDistrictAttribute                    = @"district";
NSString * const kServerTypeAttribute                        = @"type";
NSString * const kServerAddressId                            = @"addressId";

// Parse : SharedContacts Names & Attributes

NSString * const kServerSharedContactsClassName              = @"share";
NSString * const kServerContactsArray                        = @"contacts";

// Errors

NSString* const ZPErrorDomainInvalidInput                   =   @"com.zippr.errordomain.InvalidInput";
@end
