//
//  CDUser.h
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDUser : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSSet *cdcontact;
@end

@interface CDUser (CoreDataGeneratedAccessors)

- (void)addCdcontactObject:(NSManagedObject *)value;
- (void)removeCdcontactObject:(NSManagedObject *)value;
- (void)addCdcontact:(NSSet *)values;
- (void)removeCdcontact:(NSSet *)values;

@end
