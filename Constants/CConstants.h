//
//  PUConstants.h
//  ParseUser
//
//  Created by Ranjith on 12/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CConstants : NSObject


#pragma mark - Custom font Names

#define HEADING_FONT_BOLD               @"OpenSans-Bold"
#define HEADING_FONT_REGULAR            @"OpenSans"
#define HEADING_FONT_SEMIBOLD           @"OpenSans-Semibold"
#define GENERAL_FONT_BOLD               @"SourceSansPro-Bold"
#define GENERAL_FONT_REGULAR            @"SourceSansPro-Regular"
#define GENERAL_FONT_SEMIBOLD           @"SourceSansPro-Semibold"


extern NSString * const kServerApplicationId                            ;
extern NSString * const kServerClientKey                                ;

extern NSString * const kServerContactClassName                         ;
extern NSString * const kServerAddressClassName                         ;

extern NSString * const kServerUserName                                 ;
extern NSString * const kServerPassword                                 ;

extern NSString * const kServerUserObjectIdAttr                         ;
extern NSString * const kServerObjectIdAttr                             ;
extern NSString * const kServerPhoneAttr                                ;
extern NSString * const kServerEmailAttr                                ;
extern NSString * const kServerNameAttr                                 ;
extern NSString * const kServerStreetAttr                               ;
extern NSString * const kServerDistrictAttr                             ;

extern NSString * const kServerShareCollection                          ;
extern NSString * const kServerSharedContactsClassName                  ;

extern NSString* const ZPErrorDomainInvalidInput                        ;

@end
