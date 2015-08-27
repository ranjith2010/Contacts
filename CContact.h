//
//  PUContactsInfo.h
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CContact : NSObject


@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *mobile;

@property (nonatomic,strong) NSString *emailString;

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
 It mainly used for handling the contact Phone Numbers,
 It's array of phone numbers, {Mobile and Home and work and etc} mobile numbers included here.
 **/
@property (nonatomic,strong)NSArray *phone;

/*!
 It mainly used for handling the contact Email Id's,
 It's array of Email Ids, {Home and Work and Personal, icloud. etc} Email Ids included here.
 */
@property (nonatomic,strong)NSArray *email;

@property (nonatomic,strong)NSString *userObjectId;

@property (nonatomic,strong)NSString *rollNumber;

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
