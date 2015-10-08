//
//  CLongTaskViewHelper.m
//  Contacts
//
//  Created by Srikanth on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CLongTaskViewHelper.h"
#import "MBProgressHUD.h"
#import "UIAlertView+ZPBlockAdditions.h"
#import <objc/runtime.h>

static char ZP_POSITIVE_BLOCK_IDENTIFIER;
static char ZP_NEGATIVE_BLOCK_IDENTIFIER;

static int POSITIVE_INDEX       =   0;

@interface CLongTaskViewHelper ()<UIActionSheetDelegate>

@end

@implementation CLongTaskViewHelper

- (instancetype)initWithContainerViewController:(UIViewController*)vc {
    self = [super init];
    [self setContainerView:vc.view];
    return self;
}

- (void)showBusyIndicatorWithMessage:(NSString*)message andImage:(UIImage*)image {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.containerView animated:YES];
    hud.labelText = message;
    [hud show:YES];
}

- (void)dismissBusyIndicator {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.containerView animated:YES];
    });
}

- (void)showToastWithMessage:(NSString*)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.containerView animated:NO];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
}

- (void)showMessage:(NSString *)message withTitle:(NSString *)title positiveTitles:(NSArray *)positiveTitles negativeTitle:(NSString *)negativeTitle positiveBlock:(ZPAlertIndexedActionBlock)dismissBlock negativeBlock:(ZPAlertActionBlock)cancelBlock {
    [UIAlertView showMessage:message withTitle:title positiveTitles:positiveTitles negativeTitle:negativeTitle positiveBlock:dismissBlock negativeBlock:cancelBlock];
}

- (void)showError:(NSError*)error
        withTitle:(NSString*)title
positiveButtonTitle:(NSString*)positiveTitle
negativeButtonTitle:(NSString*)negativeTitle
    positiveBlock:(ZPAlertActionBlock)positiveBlock
    negativeBlock:(ZPAlertActionBlock)negativeBlock {
    
    [UIAlertView showError:error withTitle:title positiveTitle:positiveTitle negativeTitle:negativeTitle positiveBlock:positiveBlock negativeBlock:negativeBlock];
}

- (void)showConfirmationWithTitle:(NSString*)title
                          message:(NSString*)message
              positiveButtonTitle:(NSString*)positiveTitle
              negativeButtonTitle:(NSString*)negativeTitle
                    positiveBlock:(ZPAlertActionBlock)positiveBlock
                    negativeBlock:(ZPAlertActionBlock)negativeBlock {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:message
                                                             delegate:self
                                                    cancelButtonTitle:negativeTitle
                                               destructiveButtonTitle:positiveTitle
                                                    otherButtonTitles:nil, nil];
    
    objc_setAssociatedObject(actionSheet, &ZP_POSITIVE_BLOCK_IDENTIFIER, positiveBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(actionSheet, &ZP_NEGATIVE_BLOCK_IDENTIFIER, negativeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [actionSheet showInView:self.containerView];
}


- (void)showInformationWithTitle:(NSString*)title
                         message:(NSString*)message
              dismissButtonTitle:(NSString*)dismissTitle {
    [UIAlertView showInformationWithTitle:title message:message dismissTitle:dismissTitle];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    ZPAlertActionBlock positiveBlock = objc_getAssociatedObject(actionSheet, &ZP_POSITIVE_BLOCK_IDENTIFIER);
    ZPAlertActionBlock negativeBlock = objc_getAssociatedObject(actionSheet, &ZP_NEGATIVE_BLOCK_IDENTIFIER);
    if(buttonIndex == POSITIVE_INDEX) {
        if(positiveBlock)
            positiveBlock();
    } else {
        if(negativeBlock)
            negativeBlock();
    }
}

@end
