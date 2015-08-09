//
//  CDRecord.h
//  Contacts
//
//  Created by ranjit on 21/07/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDRecord : NSManagedObject

@property (nonatomic, retain) NSString * userObjectId;
@property (nonatomic, retain) NSString * recordId;

@end
