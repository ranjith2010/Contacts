//
//  shareZipprClass.m
//  ParseUser
//
//  Created by Ranjith on 10/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CSharedContact.h"

@implementation CSharedContact
@synthesize sharedContacts;

+ (CSharedContact*)sharedInstance {
    static CSharedContact * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[CSharedContact alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    return self;
}
@end
