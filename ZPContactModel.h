//
//  ZPContactModel.h
//  contactsIntegration
//
//  Created by Ranjith on 20/03/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPContactModel : NSObject


/*!
 It mainly used for handling the contact First Name
 **/
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
 **/
@property (nonatomic,strong)NSArray *email;


/*!
 Initializes with Server dictionary
 **/
- (id)initWithServerDictionary:(NSDictionary*)dictionary;

/*!
 Returns dictionary that can be safely updated to Server.
 This dictionary contains server keys.
 **/
- (NSDictionary*)dictionary;

/*!
 Returns the firstname and lastname
 **/
- (NSString*)getFullName;

@end
