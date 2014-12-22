//
//  CDAddress.h
//  Contacts
//
//  Created by Ranjith on 18/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDContact;

@interface CDAddress : NSManagedObject

@property (nonatomic, retain) NSNumber * addressId;
@property (nonatomic, retain) NSString * district;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * contactObjectId;
@property (nonatomic, retain) CDContact *cdcontact;

@end
