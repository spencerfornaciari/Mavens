//
//  SFAppDelegate.m
//  Mavens
//
//  Created by Spencer Fornaciari on 3/18/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import "SFAppDelegate.h"
#import "GAI.h"

@implementation SFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"AhqbrR58bGtypdnIm5uQdqSSlaxiTLsbLWteYpAj"
                  clientKey:@"eCuKDD8VasfycOH8JZaqtYCInR4BlBueEvZgW0lj"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
//    [PFFacebookUtils initializeFacebook];
    [PFTwitterUtils initializeWithConsumerKey:@"sWHgfLqyIiTXDtOwVyQhw"
                               consumerSecret:@"ykWAphdeEuXLZ05DeGjXPur5ckU4zTelkMN7LE"];
    
    
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-6557341-7"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Facebook Login

//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    return [FBAppCall handleOpenURL:url
//                  sourceApplication:sourceApplication
//                        withSession:[PFFacebookUtils session]];
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
//}

@end
