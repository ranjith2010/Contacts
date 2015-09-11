//
//  UIAlertView+ZPBlockAdditions.h
//  Zipper Beta 2
//
//  Created by Ashish on 09/10/13.
//  Copyright (c) 2013 Ashish. All rights reserved.
//

/*
 File: UIAlertView+ZPBlockAdditions.h
 Abstract: This is a category of UIAlertView that adds easy to use blocks methods, so instead of using delegate pattern of UIAlertView, with this class block based APIs can be used.
 */


#import <UIKit/UIKit.h>
#import "ZPBlockAdditions.h"
//#import "ZPLongTaskViewProtocol.h"

@interface UIAlertView (ZPBlockAdditions)

// TODO: Remove old api. Use new api below.
+ (UIAlertView*) zp_alertViewWithTitle:(NSString*) title
                            message:(NSString*) message;

+ (UIAlertView*) zp_alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle;

+ (UIAlertView*) zp_alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(ZPAlertIndexedActionBlock) dismissed
                           onCancel:(CancelBlock) cancelled;

@property (nonatomic, copy) ZPAlertIndexedActionBlock dismissBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;
// old api

#pragma mark New API

+ (UIAlertView*)showError:(NSError*)error
                withTitle:(NSString*)title
            positiveTitle:(NSString*)positiveTitle
            negativeTitle:(NSString*)negativeTitle
            positiveBlock:(ZPAlertActionBlock)positiveBlock
            negativeBlock:(ZPAlertActionBlock)negativeBlock;

+ (UIAlertView*)showInformationWithTitle:(NSString*)title
                                 message:(NSString*)message
                            dismissTitle:(NSString*)dismissTitle;
+ (UIAlertView*)showMessage:(NSString*)message
                  withTitle:(NSString*)title
             positiveTitles:(NSArray*)positiveTitles
              negativeTitle:(NSString*)negativeTitle
              positiveBlock:(ZPAlertIndexedActionBlock)dismissBlock
              negativeBlock:(CancelBlock)cancelBlock;

@end
