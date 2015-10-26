//
//  CCreateContactLogic.m
//  Contacts
//
//  Created by ranjith on 25/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CCreateContactLogic.h"
#import "CServer.h"
#import "CServerInterface.h"

#import "CLocalInterface.h"
#import "CLocal.h"

@implementation CCreateContactLogic

- (void)createContactWithBlob:(CContact*)contact {
    [self.view showBusyIndicatorWithMessage:nil andImage:nil];
    [[CServer defaultParser] storeContact:contact :^(CContact *contact, NSError *error) {
        [[CLocal defaultLocalDB] storeContact:contact
                                             :^(BOOL result, NSError *error) {
                                                 [self.view dismissBusyIndicator];
                                                 NSLog(@"contact stored successfully");
                                                 [self.navigation navigateBackWithAnimation:YES];
                                             }];
    }];
}


- (void)updateContactWithBlob:(CContact*)contact {
    [self.view showBusyIndicatorWithMessage:nil andImage:nil];
    [[CServer defaultParser] updateContact:contact
                                          :^(BOOL result, NSError *error) {
                                              [[CLocal defaultLocalDB] updateContact:contact :^(BOOL result, NSError *error) {
                                                  NSLog(@"contact updated successfully");
                                                  [self.view dismissBusyIndicator];
                                                  [self.navigation navigateBackWithAnimation:YES];
                                              }];
                                          }];
    
}

- (void)deleteContact:(CContact*)contact {
    [self.view showBusyIndicatorWithMessage:nil andImage:nil];
    [[CServer defaultParser] deleteContact:contact :^(BOOL result, NSError *error) {
        if(!error) {
            NSLog(@"contact deleted successfully");
            [self.view dismissBusyIndicator];
            [self.navigation navigateBackWithAnimation:NO];
        }
    }];
}

@end
