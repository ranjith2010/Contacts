//
//  shareZipprClass.h
//  ParseUser
//
//  Created by Ranjith on 10/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSharedContact : NSObject

+ (CSharedContact*)sharedInstance;

@property(nonatomic,strong)NSMutableArray *sharedContacts;

@end
