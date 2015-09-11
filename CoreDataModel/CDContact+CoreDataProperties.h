//
//  CDContact+CoreDataProperties.h
//  Contacts
//
//  Created by ranjith on 09/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDContact.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDContact (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *district;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *street;
@property (nullable, nonatomic, retain) NSString *userObjectId;
@property (nullable, nonatomic, retain) NSString *objectId;
@property (nullable, nonatomic, retain) CDUser *cduser;

@end

NS_ASSUME_NONNULL_END
