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

@interface CAppDelegate (){
//    CSharedContact *sharedZippr;
}
@property (nonatomic)id<CServerUserInterface> serverUser;
@end

@implementation CAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blueColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    [[CServer defaultParser] authentication];
    [self pr_initalSetup];

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


- (void)pr_initalSetup {
    if(!self.window) {
        self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    self.serverUser = [CServerUser defaultUser];
    if(![self.serverUser hasCurrentUser]) {
        CSplashViewController *splashVC = [CSplashViewController new];
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:splashVC];
        self.window.rootViewController = navigationController;
    }
    else {
        UITabBarController *tabBarController = [UITabBarController new];
        CPeopleTableViewController *peopleTVC = [CPeopleTableViewController new];
        UINavigationController *navigationControllerForPeople = [[UINavigationController alloc]initWithRootViewController:peopleTVC];
        navigationControllerForPeople.title = @"People";

        CProfileViewController *userViewController = [CProfileViewController new];
        UINavigationController *navigationControllerForProfile = [[UINavigationController alloc]initWithRootViewController:userViewController];
        userViewController.title = @"Profile";
        NSArray *tabControllers = [NSArray arrayWithObjects:navigationControllerForPeople,navigationControllerForProfile, nil];
        tabBarController.viewControllers = tabControllers;
        self.window.rootViewController = tabBarController;
    }
    [self.window makeKeyAndVisible];
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

#pragma mark - Private API

//- (void)pr_isItFirstLaunch{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if(![defaults objectForKey:kServerAddressId]){
//        [defaults setObject:[NSNumber numberWithInt:0] forKey:kServerAddressId];
//        [defaults synchronize];
//    }
//}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    if(url){
//        sharedZippr = [CSharedContact sharedInstance];
//        sharedZippr.sharedContacts = [[NSMutableArray alloc]init];
////        [self pr_sharedContactsUsingDeepLinking:url];
//    }
//    return YES;
//}

//-(void)pr_sharedContactsUsingDeepLinking:(NSURL*)url{
//    [[CServer defaultParser] fetchSharedContacts:(NSURL*)url  :^(NSMutableArray *arrayOfContacts){
//        [sharedZippr.sharedContacts addObjectsFromArray:arrayOfContacts];
//    }];
//}

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
