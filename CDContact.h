//
//  CDContact.h
//  Contacts
//
//  Created by Ranjith on 18/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDAddress, CDUser;

@interface CDContact : NSManagedObject

@property (nonatomic, retain) NSData * addressIdCollection;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * userObjectId;
@property (nonatomic, retain) NSSet *cdaddress;
@property (nonatomic, retain) CDUser *cduser;
@end

@interface CDContact (CoreDataGeneratedAccessors)

- (void)addCdaddressObject:(CDAddress *)value;
- (void)removeCdaddressObject:(CDAddress *)value;
- (void)addCdaddress:(NSSet *)values;
- (void)removeCdaddress:(NSSet *)values;

@end
