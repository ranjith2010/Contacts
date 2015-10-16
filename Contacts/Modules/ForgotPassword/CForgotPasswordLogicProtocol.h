//
//  CForgotPasswordLogicProtocol.h
//  Contacts
//
//  Created by ranjith on 16/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CForgotPasswordCompletionBlock)(BOOL isDone,NSError *error);

@protocol CForgotPasswordLogicProtocol <NSObject>

- (void)resetPasswordwithEmail:(NSString*)email :(CForgotPasswordCompletionBlock)block;

@end
