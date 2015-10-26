//
//  AppDelegate.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CAppDelegate.h"
#import "CServer.h"
#import "CServerInterface.h"
#import "CConstants.h"

#import "CPeopleTableViewController.h"
#import "CProfileViewController.h"
#import "CServerUser.h"
#import "CServerUserInterface.h"
#import "CSplashViewController.h"

#import "CRootWindow.h"
#import "UIAlertView+ZPBlockAdditions.h"

@interface CAppDelegate ()
@property (nonatomic)id<CServerUserInterface> serverUser;
@property (nonatomic)id<CServerInterface> server;

@property (nonatomic) CRootWindow* rootWindow;

@end

@implementation CAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.server = [CServer defaultParser];
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);

    // style the navigation bar
    UIColor* navColor = [UIColor colorWithRed:0.175f green:0.458f blue:0.831f alpha:1.0f];
    [[UINavigationBar appearance] setBarTintColor:navColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    // make the status bar white
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.server initialize];
    
    [self setRootWindow:[CRootWindow sharedInstance]];
    UIWindow* window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    [self prepareAppInWindow:window];

//    [self pr_isItFirstLaunch];

//    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
//                                                    UIUserNotificationTypeBadge |
//                                                    UIUserNotificationTypeSound);
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
//                                                                             categories:nil];
//    [application registerUserNotificationSettings:settings];
//    [application registerForRemoteNotifications];
    return YES;
}


- (void)prepareAppInWindow:(UIWindow*)window {
    self.rootWindow.window = window;
    [self.rootWindow presentAppStartup];
    __weak CAppDelegate* welf = self;
#warning need to implement
//    [ZHCore initializeWithCompletionBlock:^(NSError *error) {
//        
        [welf coreInitializedWithError:nil window:window];
//
//    }];
}

- (void)coreInitializedWithError:(NSError*)error window:(UIWindow*)window{
    if(error) {
        NSLog(@"Zippr Core Initialization Error: %@", error);
        [UIAlertView zp_alertViewWithTitle:@"Database Error" message:[NSString stringWithFormat:@"%@ Unable to open database, please close the app and restart it",error.localizedDescription]];
    } else {
        //        isInitialized = YES;
        //        if([[ZPUserManager currentUser] isValid]) {
        //            [self.rootWindow presentPostlogin];
        //            [self onPostLoginAppPresentedWithLaunchOptions:self.launchOptions];
        //            // if there is any upload model is there just upload it
        //            [[ZPPictureManager imageUploader]retryFailedImage];
        //
        //        } else {
        //            [self.rootWindow presentPrelogin];
//        [self.rootWindow presentPostlogin];
        
        // Let me go simply check with current user is non Nil value?
        self.serverUser = [CServerUser defaultUser];
        if(![self.serverUser hasCurrentUser]) {
            [self.rootWindow presentPrelogin];
        }
        else {
            [self.rootWindow presentPostlogin];
        }
    }
}


//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    // Store the deviceToken in the current installation and save it to Parse.
//    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//    [currentInstallation setDeviceTokenFromData:deviceToken];
//    currentInstallation.channels = @[ @"global" ];
//    [currentInstallation saveInBackground];
//}
//
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [PFPush handlePush:userInfo];
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if(url){
        [self pr_sharedContactsUsingDeepLinking:url];
    }
    return YES;
}

-(void)pr_sharedContactsUsingDeepLinking:(NSURL*)url{
    [self.server fetchSharedContacts:url :^(BOOL result, NSError *error) {
        if(!error) {
            NSLog(@"shared contact stored into currect user Personal");
        }
        else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
