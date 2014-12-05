//
//  AppDelegate.h
//  UICatalog
//
//  Created by Leo on 10/24/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

/*
 Google API key
 AIzaSyCd-1nBUCJWJ0PSWCeq8Y9F8kbqTj1pwq4
 */

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

/*
 此裝置的Location
 */
@property (strong, readonly) CLLocationManager *locmanager;

- (void)stopUpdatingLocation;
- (void)startUpdatingLocation;

- (CLLocation*)getCurrentLocation;

@end

