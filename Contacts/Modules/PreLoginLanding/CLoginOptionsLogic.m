//
//  CLoginOptionsLogic.m
//  Contacts
//
//  Created by ranjith on 11/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CLoginOptionsLogic.h"
#import "CServerUserInterface.h"
#import "CServerUser.h"

@implementation CLoginOptionsLogic

- (void)createAnonymousUser:(CAnonymousUserCreation)block {
    [[CServerUser defaultUser] createAnonymousUser:^(CUser *user, NSError *error) {
        if(!error){
            block(YES,error);
        }
        else {
            block(NO,error);
        }
    }];
}

@end
