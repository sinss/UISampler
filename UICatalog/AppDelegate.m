//
//  AppDelegate.m
//  UICatalog
//
//  Created by Leo on 10/24/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "AppDelegate.h"
#import "LocationManager.h"

#import "DBHelper.h"
#import "OpreationSample.h"
#import <GoogleMapsM4B/GoogleMaps.h>
#import <Parse/Parse.h>

#ifdef DEVELOPMENT

#define parseAppId @"X7DO3SAGlyTTlY7i0Vi5IVJSkiD5woWpVmRjhWvP"
#define parseClientId @"WidStINW0xzh6NaEfAABVZKVg0XtbcVLmnlasy2Q"

#else

#define parseAppId @""
#define parseClientId @""

#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //[self createLocationManager];
    
    [[LocationManager sharedInstance] startUpdatingLocation];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AAAAAAAA" object:@{}];
    
    [GMSServices provideAPIKey:@"AIzaSyC50XBJPHLkYR78RmG9bTC7O-0kBzLM4Bw"];
    
    [Parse setApplicationId:parseAppId clientKey:parseClientId];
    
//    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
//                                                    UIUserNotificationTypeBadge |
//                                                    UIUserNotificationTypeSound);
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
//                                                                             categories:nil];
//    [application registerUserNotificationSettings:settings];
//    [application registerForRemoteNotifications];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
    
    return YES;
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
    NSLog(@"become active");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current Installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    
    currentInstallation[@"userId"] = @1;
    
    
    [currentInstallation saveInBackground];
}


#pragma mark - Private Method
- (void)createLocationManager
{
    _locmanager = [[CLLocationManager alloc] init];
    if ([self.locmanager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locmanager requestAlwaysAuthorization];
    }
    [_locmanager setDelegate:self];
    [_locmanager setDistanceFilter:1.0f];
    [_locmanager setHeadingFilter:kCLHeadingFilterNone];
    
    //精準度，愈精準愈耗電。
    [_locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [self startUpdatingLocation];
    
    [_locmanager startMonitoringForRegion:nil];
    //[_locmanager startMonitoringVisits];
    //[_locmanager startMonitoringSignificantLocationChanges];
    /*
     注意
     NSLocationAlwaysUsageDescription
     NSLocationAlwaysUsageDescription
     在Setting Info.plist裡面一定要加上這兩組Key才可以正常使用(iOS8)
     */
}

- (void)stopUpdatingLocation
{
    [_locmanager stopUpdatingLocation];
    [_locmanager stopUpdatingHeading];
}

- (void)startUpdatingLocation
{
    //開始定位
    [_locmanager startUpdatingLocation];
    
    NSLog(@"(1) lat : %f, long : %f", _locmanager.location.coordinate.latitude, _locmanager.location.coordinate.longitude);
    
    [_locmanager startUpdatingHeading];
    
    NSLog(@"(2) lat : %f, long : %f", _locmanager.location.coordinate.latitude, _locmanager.location.coordinate.longitude);
}

#pragma mark - LocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"(old) lat : %f, long : %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"(new) lat : %f, long : %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

/*
 如果App關閉了通知，收不到此訊息
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    CLRegion *region = notification.region;
    if (region)
    {
        if ([region.identifier isEqualToString:@"XXX"])
        {
            
        }
    }
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"didReceived:%@", userInfo);
    NSLog(@"%@", userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"didReceived:%@");
    NSLog(@"%@", userInfo);
}

@end
