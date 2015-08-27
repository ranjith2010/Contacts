//
//  PUUser.h
//  ParseUser
//
//  Created by Ranjith on 28/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CUser : NSObject

/*!
 Initializes with Server dictionary
 */
- (id)initWithServerDictionary:(NSDictionary*)dictionary;

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;

@end
