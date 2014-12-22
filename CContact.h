//
//  PUContactsInfo.h
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CContact : NSObject

@property(nonatomic,strong)NSString *objectId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *userObjectId;
@property(nonatomic,strong)NSMutableArray *addressIdCollection;

@end
