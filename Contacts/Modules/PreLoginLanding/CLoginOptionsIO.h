//
//  CLoginOptionsIO.h
//  Contacts
//
//  Created by ranjith on 11/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CAnonymousUserCreation)(BOOL succeeded,NSError *error);

@protocol CLoginOptionInputLogicProtocol <NSObject>

- (void)createAnonymousUser :(CAnonymousUserCreation)block;

@end
