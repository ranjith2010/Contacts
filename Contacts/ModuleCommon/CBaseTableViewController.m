//
//  CBaseTableViewController.m
//  Contacts
//
//  Created by Srikanth on 08/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CBaseTableViewController.h"

@implementation UITableView(emptyCell)

- (void)reloadDataWithHideEmptyCell {
    [self reloadData];
    [self pr_hideEmptySeparators];
}


- (void)pr_hideEmptySeparators {
    UIView *emptyView_ = [[UIView alloc] initWithFrame:CGRectZero];
    emptyView_.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:emptyView_];
}
@end


@interface CBaseTableViewController ()
@property (nonatomic, readwrite) CLongTaskViewHelper* viewHelper;
@end

@implementation CBaseTableViewController

- (void)viewDidLoad {
    self.viewHelper = [[CLongTaskViewHelper alloc] initWithContainerViewController:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self addScreenNameToGoogleAnalytics:NSStringFromClass([self class])];
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

@end
