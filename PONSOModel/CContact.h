//
//  PUContactsInfo.h
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CContact : NSObject

@property (nonatomic,copy) NSString *userObjectId;
@property (nonatomic,copy) NSString *objectId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *street;
@property (nonatomic,copy) NSString *district;

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
