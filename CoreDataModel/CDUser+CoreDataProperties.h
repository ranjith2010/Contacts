//
//  CDUser+CoreDataProperties.h
//  Contacts
//
//  Created by ranjith on 09/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *objectId;
@property (nullable, nonatomic, retain) NSSet<CDContact *> *cdcontact;

@end

@interface CDUser (CoreDataGeneratedAccessors)

- (void)addCdcontactObject:(CDContact *)value;
- (void)removeCdcontactObject:(CDContact *)value;
- (void)addCdcontact:(NSSet<CDContact *> *)values;
- (void)removeCdcontact:(NSSet<CDContact *> *)values;

@end

NS_ASSUME_NONNULL_END
