//
//  CLoginIO.h
//  Contacts
//
//  Created by ranjith on 16/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CLoginCompletionBlock)(BOOL completed,NSError *error);

@protocol CLoginLogicProtocol <NSObject>

- (void)loginWithEmail:(NSString*)email password:(NSString*)password
       completionBlock:(CLoginCompletionBlock)block;


@end
