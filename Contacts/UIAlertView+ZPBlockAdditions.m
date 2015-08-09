//
//  UIAlertView+ZPBlockAdditions.m
//  Zipper Beta 2
//
//  Created by Ashish on 09/10/13.
//  Copyright (c) 2013 Ashish. All rights reserved.
//

#import "UIAlertView+ZPBlockAdditions.h"
#import "CConstants.h"
#import <objc/runtime.h>

static char DISMISS_IDENTIFER;
static char CANCEL_IDENTIFER;

// New api
static char ZP_POSITIVE_BLOCK_IDENTIFIER;
static char ZP_NEGATIVE_BLOCK_IDENTIFIER;

@interface UIAlertView ()
@property (nonatomic, copy) ZPAlertActionBlock positiveBlock;
@property (nonatomic, copy) ZPAlertActionBlock negativeBlock;
@end
// New api

@implementation UIAlertView (ZPBlockAdditions)

@dynamic cancelBlock;
@dynamic dismissBlock;

- (void)setDismissBlock:(ZPAlertIndexedActionBlock)dismissBlock
{
    objc_setAssociatedObject(self, &DISMISS_IDENTIFER, dismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ZPAlertIndexedActionBlock)dismissBlock
{
    return objc_getAssociatedObject(self, &DISMISS_IDENTIFER);
}

- (void)setCancelBlock:(CancelBlock)cancelBlock
{
    objc_setAssociatedObject(self, &CANCEL_IDENTIFER, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CancelBlock)cancelBlock
{
    return objc_getAssociatedObject(self, &CANCEL_IDENTIFER);
}


+ (UIAlertView*) zp_alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(ZPAlertIndexedActionBlock) dismissed
                           onCancel:(CancelBlock) cancelled {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    [alert setDismissBlock:dismissed];
    [alert setCancelBlock:cancelled];
    
    for(NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    return alert;
}

+ (UIAlertView*) zp_alertViewWithTitle:(NSString*) title
                            message:(NSString*) message {
    
    return [UIAlertView zp_alertViewWithTitle:title
                                   message:message
                         cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")];
}

+ (UIAlertView*) zp_alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
    return alert;
}


+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {

    // New api
    if(buttonIndex == [alertView cancelButtonIndex]) {
        if(alertView.negativeBlock)
            alertView.negativeBlock();
    } else {
        if(alertView.positiveBlock)
            alertView.positiveBlock();
    }
    // New api
    
    
	if(buttonIndex == [alertView cancelButtonIndex])
	{
		if (alertView.cancelBlock) {
            alertView.cancelBlock();
        }
	}
    else
    {
        if (alertView.dismissBlock) {
            alertView.dismissBlock(buttonIndex - 1); // cancel button is button 0
        }
    }
}

#pragma mark New UIAlert API

- (void)setPositiveBlock:(ZPAlertActionBlock)block {
    objc_setAssociatedObject(self, &ZP_POSITIVE_BLOCK_IDENTIFIER, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ZPAlertActionBlock)positiveBlock {
    return objc_getAssociatedObject(self, &ZP_POSITIVE_BLOCK_IDENTIFIER);
}

- (void)setNegativeBlock:(ZPAlertActionBlock)block {
    objc_setAssociatedObject(self, &ZP_NEGATIVE_BLOCK_IDENTIFIER, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ZPAlertActionBlock)negativeBlock {
    return objc_getAssociatedObject(self, &ZP_NEGATIVE_BLOCK_IDENTIFIER);
}

+ (UIAlertView*)showMessage:(NSString*)message
                  withTitle:(NSString*)title
            positiveTitles:(NSArray*)positiveTitles
             negativeTitle:(NSString*)negativeTitle
              positiveBlock:(ZPAlertIndexedActionBlock)dismissBlock
              negativeBlock:(CancelBlock)cancelBlock {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:negativeTitle
                                          otherButtonTitles:nil];
    
    [alert setDismissBlock:dismissBlock];
    [alert setNegativeBlock:cancelBlock];
    
    for(NSString *buttonTitle in positiveTitles)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    return alert;
}


+ (UIAlertView*)showError:(NSError*)error
        withTitle:(NSString*)title
    positiveTitle:(NSString*)positiveTitle
    negativeTitle:(NSString*)negativeTitle
    positiveBlock:(ZPAlertActionBlock)positiveBlock
    negativeBlock:(ZPAlertActionBlock)negativeBlock {

#ifdef PRERELEASE
    if(![error.domain hasPrefix:ZP_ERR_DOMAIN]) {
        [NSException raise:@"Should not use non zippr domain errors" format:@"error %@",error];
    }
#endif
    
    if([error.domain isEqualToString:ZPErrorDomainInvalidInput]) {
        NSString* message = error.userInfo[NSLocalizedDescriptionKey];
        return [self showInformationWithTitle:title message:message dismissTitle:@"OK"];
    }
    
    NSString* message = error.localizedDescription;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:negativeTitle
                                          otherButtonTitles:positiveTitle, nil];
    
    alert.positiveBlock = positiveBlock;
    alert.negativeBlock = negativeBlock;
    [alert show];
    return alert;
}

+ (UIAlertView*)showInformationWithTitle:(NSString*)title
                         message:(NSString*)message
                    dismissTitle:(NSString*)dismissTitle {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:nil
                                          otherButtonTitles:dismissTitle, nil];
    [alert show];
    return alert;
}

@end
