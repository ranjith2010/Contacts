//
//  PUConstants.m
//  ParseUser
//
//  Created by Ranjith on 12/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CConstants.h"

@implementation CConstants

NSString *const kServerClientKey                            = @"N4qTlR1d3yi6qanVrwvLVlfuszkMuYmjPU0SgAfo";
NSString *const kServerApplicationId                        = @"ZJdmZlD0SXuhlyjvuGomQwlC2YhvM7fk2F09qWWS";

// Parse : User class Name & Attributes

NSString *const kServerUserName                             = @"username";
NSString *const kServerPassword                             = @"password";

// Parse : Contact class Name & Attributes

NSString *const kServerContactClassName                     = @"contact";
NSString *const kServerUserObjectIdAttr                     = @"userObjectId";
NSString *const kServerObjectIdAttr                         = @"objectId";
NSString *const kServerPhoneAttr                            = @"phone";
NSString *const kServerEmailAttr                            = @"email";
NSString *const kServerNameAttr                             = @"name";
NSString *const kServerStreetAttr                           = @"street";
NSString *const kServerDistrictAttr                         = @"district";

// Parse : SharedContacts Names & Attributes

NSString *const kServerShareCollection                      = @"collection";
NSString *const kServerSharedContactsClassName              = @"share";

// Errors

NSString *const ZPErrorDomainInvalidInput                   = @"com.zippr.errordomain.InvalidInput";
@end
