//
//  PUContactsInfo.h
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CContact : NSObject

/*!
 Initializes with Server dictionary
 **/
- (id)initWithServerDictionary:(NSDictionary*)dictionary;

/*!
 Returns dictionary that can be safely updated to Server.
 This dictionary contains server keys.
 **/
- (NSDictionary*)dictionary;

@property(nonatomic,readonly)NSString *objectId;
@property(nonatomic,readonly)NSString *name;
//@property(nonatomic,readonly)NSString *phone;
//@property(nonatomic,readonly)NSString *email;
@property(nonatomic,strong,readwrite)NSString *userObjectId;
//@property(nonatomic,strong)NSMutableArray *addressIdCollection;

@end
