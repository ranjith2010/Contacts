//
//  CBaseViewController.m
//  Contacts
//
//  Created by Srikanth on 08/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CBaseViewController.h"

@interface CBaseViewController ()
@property (nonatomic, readwrite) CLongTaskViewHelper* viewHelper;
@property (nonatomic, assign) BOOL handleKeyboardAutomatically;
@property (nonatomic, weak) UIControl* keyboardResponder;
@end

@implementation CBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewHelper = [[CLongTaskViewHelper alloc] initWithContainerViewController:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self addScreenNameToGoogleAnalytics:NSStringFromClass([self class])];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.handleKeyboardAutomatically) {
        [self deregisterFromKeyboardNotifications:self];
        [self registerForKeyboardNotifications:self
                           selectorForWillShow:@selector(willShowKeyboard:)
                           selectorForWillHide:@selector(willHideKeyboard:)];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(self.handleKeyboardAutomatically) {
        if (self.keyboardResponder) {
            [self.keyboardResponder resignFirstResponder];
        }
        [self deregisterFromKeyboardNotifications:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
- (void)addScreenNameToGoogleAnalytics:(NSString *)screenName {
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:screenName];
    
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

 */
- (void)showBusyIndicatorWithMessage:(NSString*)message andImage:(UIImage*)image {
    [self.viewHelper showBusyIndicatorWithMessage:message andImage:image];
}

- (void)dismissBusyIndicator {
    [self.viewHelper dismissBusyIndicator];
}

- (void)showError:(NSError*)error
        withTitle:(NSString*)title
positiveButtonTitle:(NSString*)positiveTitle
negativeButtonTitle:(NSString*)negativeTitle
    positiveBlock:(CAlertActionBlock)positiveBlock
    negativeBlock:(CAlertActionBlock)negativeBlock {
    [self.viewHelper showError:error withTitle:title positiveButtonTitle:positiveTitle negativeButtonTitle:negativeTitle positiveBlock:positiveBlock negativeBlock:negativeBlock];
}

- (void)showInformationWithTitle:(NSString*)title
                         message:(NSString*)message
              dismissButtonTitle:(NSString*)dismissTitle {
    
    [self.viewHelper showInformationWithTitle:title message:message dismissButtonTitle:dismissTitle];
}

- (void)showConfirmationWithTitle:(NSString*)title
                          message:(NSString*)message
              positiveButtonTitle:(NSString*)positiveTitle
              negativeButtonTitle:(NSString*)negativeTitle
                    positiveBlock:(CAlertActionBlock)positiveBlock
                    negativeBlock:(CAlertActionBlock)negativeBlock {
    
    [self.viewHelper showConfirmationWithTitle:title message:message positiveButtonTitle:positiveTitle negativeButtonTitle:negativeTitle positiveBlock:positiveBlock negativeBlock:negativeBlock];
}

- (void)showMessage:(NSString *)message withTitle:(NSString *)title positiveTitles:(NSArray *)positiveTitles negativeTitle:(NSString *)negativeTitle positiveBlock:(CAlertIndexedActionBlock)dismissBlock negativeBlock:(CAlertActionBlock)cancelBlock {
    [self.viewHelper showMessage:message withTitle:title positiveTitles:positiveTitles negativeTitle:negativeTitle positiveBlock:dismissBlock negativeBlock:cancelBlock];
}

- (void)showToastWithMessage:(NSString *)message {
    [self.viewHelper showToastWithMessage:message];
}

#pragma mark Keyboard
- (void)registerForKeyboardNotifications:(id)target
                     selectorForWillShow:(SEL)willShowSelector
                     selectorForWillHide:(SEL)willHideSelector {
    
    [[NSNotificationCenter defaultCenter] addObserver:target
                                             selector:willShowSelector
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:target
                                             selector:willHideSelector
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications:(id)target {
    
    [[NSNotificationCenter defaultCenter] removeObserver:target
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:target
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)provideAutomaticKeyboardHanlding:(BOOL)provide {
    self.handleKeyboardAutomatically = provide;
}

- (void)provideAutomaticKeyboardHanlding:(BOOL)provide onUIResponder:(UIControl*)responder {
    [self provideAutomaticKeyboardHanlding:provide];
    if (provide) {
        self.keyboardResponder = responder;
        [responder addTarget:responder
                      action:@selector(resignFirstResponder)
            forControlEvents:UIControlEventEditingDidEndOnExit];
    } else {
        self.keyboardResponder = nil;
        [responder removeTarget:responder
                         action:@selector(resignFirstResponder)
               forControlEvents:UIControlEventEditingDidEndOnExit];
    }
}

- (BOOL)isProvidingAutomaticKeyboardHanding {
    return self.handleKeyboardAutomatically;
}

- (void)willShowKeyboard:(NSNotification*)notification {
    if (![self isProvidingAutomaticKeyboardHanding])
        return;
    
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect newVisibleRect = self.view.frame;
    newVisibleRect.origin.y = -(keyboardSize.height);
    
    [UIView animateWithDuration:0.15 animations:^{
        self.view.frame = newVisibleRect;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)willHideKeyboard:(NSNotification*)notification {
    if (![self isProvidingAutomaticKeyboardHanding])
        return;
    
    CGRect newVisibleRect = self.view.frame;
    newVisibleRect.origin.y = 0;
    [UIView animateWithDuration:0.15 animations:^{
        self.view.frame = newVisibleRect;
    } completion:^(BOOL finished) {
    }];
}

@end
