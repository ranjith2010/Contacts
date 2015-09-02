//
//  PUContactsInfo.h
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CContact : NSObject

@property (nonatomic,strong) NSString *userObjectId;

@property (nonatomic,strong) NSString *objectId;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *phone;

@property (nonatomic,strong) NSString *email;

@property (nonatomic,strong) NSString *street;

@property (nonatomic,strong) NSString *district;

/*!
 It mainly used for handling the contact First Name
 */
@property (nonatomic,strong)NSString *firstname;

/*!
 It mainly used for handling the contact Last Name
 **/
@property (nonatomic,strong)NSString *lastname;


/*!
 Initializes with Server dictionary
 */
- (id)initWithServerDictionary:(NSDictionary*)dictionary;

/*!
 Returns dictionary that can be safely updated to Server.
 This dictionary contains server keys.
 */
- (NSDictionary*)dictionary;

/*!
 Returns the firstname and lastname
 */
- (NSString*)getFullName;


@end
