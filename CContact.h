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

// Here you can able to put all following properties into .m file also,
// But anyway the Dictionary is giving you all the properties.
// some cases we need to access properties directly, then simply we can use it.

@property(nonatomic,strong)NSString *objectId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *userObjectId;
@property(nonatomic,strong)NSMutableArray *addressIdCollection;

@end
