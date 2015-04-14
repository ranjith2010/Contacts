//
//  PUAddress.h
//  ParseUser
//
//  Created by Ranjith on 13/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAddress : NSObject<NSCoding>

@property(nonatomic,strong)NSString *typeOfAddress;
@property(nonatomic,strong)NSString *district;
@property(nonatomic,strong)NSString *street;
@property(nonatomic,strong)NSString *contactObjectId;

@property(nonatomic)int addressId;
@end
