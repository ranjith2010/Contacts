//
//  CPreLoginAppNavigation.m
//  Contacts
//
//  Created by ranjith on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CPreLoginAppNavigation.h"
#import "CSplashViewController.h"
#import "CSignUpViewController.h"

#import "CPreloginLogicProvider.h"
#import "CSignUpLogic.h"
#import "CSignUpPresenter.h"
#import "CRootWindow.h"
#import "CDefaultSignUpNavigation.h"

#import "CLoginOptionsPresenter.h"
#import "CLoginOptionsLogic.h"

#import "CLoginViewController.h"
#import "CLoginPresenter.h"
#import "CLoginLogic.h"

#import "CForgotViewController.h"
#import "CForgotPasswordPresenter.h"
#import "CForgotPasswordLogic.h"

@interface CPreLoginAppNavigation ()
@property (nonatomic,strong) UINavigationController* navController;
@property (nonatomic, readonly) UIStoryboard* storyboard;
@property (nonatomic, readwrite, weak) UIWindow* window;

// Dont use these properties directly. Use the method instead.
@property (nonatomic, strong) CSignUpViewController* signupVC;
@property (nonatomic, strong) CLoginViewController* loginVC;
@property (nonatomic, strong) CForgotViewController* forgotPasswordVC;

@end

@implementation CPreLoginAppNavigation

+ (instancetype)sharedInstance {
    static dispatch_once_t token;
    static CPreLoginAppNavigation* instance;
    dispatch_once(&token, ^{
        instance = [[CPreLoginAppNavigation alloc] initInternal];
    });
    return instance;
}

- (instancetype)initInternal {
    return [super init];
}

- (UIViewController*)topViewController {
    return self.navController.topViewController;
}

- (void)presentRootViewControllerInWindow:(UIWindow*)window {
    self.window = window;
    self.navController = [[UINavigationController alloc]initWithRootViewController:[CSplashViewController new]];
    
//    self.navController = [[CSplashViewController alloc]init];
    CSplashViewController *splashVC = (CSplashViewController*)self.navController.topViewController;
    CLoginOptionsPresenter *presenter = [CLoginOptionsPresenter new];
    presenter.navigation = self;
    splashVC.presenter = presenter;
    presenter.logic = [CLoginOptionsLogic new];
    presenter.view = splashVC;
    window.rootViewController = self.navController;
    [window makeKeyAndVisible];
    [window addObserver:self forKeyPath:@"rootViewController" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    // Legacy code
//    CSplashViewController *splashVC = [CSplashViewController new];
//    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:splashVC];
//    self.window.rootViewController = navigationController;
//    [self.window makeKeyAndVisible];
}

- (void)navigateToSignup {
    CSignUpViewController *vc = [self signupViewController:[CSignUpPresenter new]];
    [self checkAndNavigateToViewController:vc animated:YES];
}

- (void)navigateToLogin {
    CLoginViewController *loginVC = [self loginViewController];
    [self checkAndNavigateToViewController:loginVC animated:YES];
}

- (void)navigateToForgotPassword {
    CForgotViewController *forgotPasswordVC = [self forgotPasswordViewController];
    [self checkAndNavigateToViewController:forgotPasswordVC animated:YES];
}

- (void)navigateToPostLogin {
    [self navigateBack];
    [[CRootWindow sharedInstance] presentPostlogin];
}

- (void)navigateBack {
    if(!self.navController.viewControllers.count)
        return;
    
    UIViewController* vc = self.navController.topViewController;
    if(vc.presentingViewController) {
        [vc dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navController popViewControllerAnimated:YES];
    }
}

#pragma mark Private

// TODO:: Make it as Generic give storyboard name and get back the storyboard
- (UIStoryboard*)storyboard {
    return [UIStoryboard storyboardWithName:@"Login" bundle:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
}

- (void)checkAndNavigateToViewController:(UIViewController*)vc animated:(BOOL)animated {
    if([self.navController.topViewController isEqual:vc])
        return;
    else if([self.navController.viewControllers containsObject:vc])
        [self.navController popToViewController:vc animated:animated];
    else
        [self.navController pushViewController:vc animated:animated];
}

#pragma mark Controller creation

- (CSignUpViewController*)signupViewController:(CSignUpPresenter*)presenter {
    self.signupVC = [CSignUpViewController new];
    presenter.logic = [CPreloginLogicProvider signupLogic];
    presenter.view = self.signupVC;
    presenter.navigation = [CDefaultSignUpNavigation new];
    
    // Set presenter to view controller
    self.signupVC.presenter = presenter;
    return self.signupVC;
}

- (CLoginViewController*)loginViewController {
    if(self.loginVC)
        return self.loginVC;
    self.loginVC = [CLoginViewController new];
    CLoginPresenter *presenter = [CLoginPresenter new];
    presenter.logic = [CLoginLogic new];
    presenter.view = self.loginVC;
    presenter.navigation = self;
    self.loginVC.presenter = presenter;
    return self.loginVC;
}

- (CForgotViewController*)forgotPasswordViewController {
    if(self.forgotPasswordVC)
        return self.forgotPasswordVC;
    self.forgotPasswordVC = [CForgotViewController new];
    CForgotPasswordPresenter *presenter = [CForgotPasswordPresenter new];
    self.forgotPasswordVC.presenter = presenter;
    presenter.view = self.forgotPasswordVC;
    presenter.logic = [CForgotPasswordLogic new];
    presenter.navigation = self;
    return self.forgotPasswordVC;
}

@end
