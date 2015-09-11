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


// here the email & username are same only. because in Parse SDK they are me to handle with username.
// So users don't rememeber with UserName. This is Poor.
// Thats why we are handling the email as username.
// and we have to show the username -> name. So that we are handling name property
@property (nonatomic) NSString * email;
@property (nonatomic) NSString * password;
@property (nonatomic) NSString * username;
@property (nonatomic) NSString * objectId;

@end
