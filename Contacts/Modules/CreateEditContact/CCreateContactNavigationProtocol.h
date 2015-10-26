//
//  CCreateContactNavigationProtocol.h
//  Contacts
//
//  Created by ranjith on 25/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CContact;

@protocol CCreateContactNavigationProtocol <NSObject>

- (void)presentCreateContactFlow:(UINavigationController*)navigationController;

- (void)presentEditContactFlow:(id)displayVCInstance withContact:(CContact*)contact;

- (void)navigateBackWithAnimation:(BOOL)hasAnimation;
@end
