//
//  CDUser+CoreDataProperties.h
//  Contacts
//
//  Created by ranjith on 12/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CDUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *objectid;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) CDUser *cdcontact;

@end

NS_ASSUME_NONNULL_END
