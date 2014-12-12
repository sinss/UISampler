//
//  LocationManager.h
//  UICatalog
//
//  Created by Leo on 11/8/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <UIKit/UIKit.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

/*
 此裝置的Location
 */
@property (strong, nonatomic) CLLocationManager *locmanager;

+ (LocationManager*)sharedInstance;

- (id)initwithSometype:(NSInteger)type;

- (void)stopUpdatingLocation;
- (void)startUpdatingLocation;

- (BOOL)locationServicesEnabled;
- (BOOL)CanDeviceSupportAppBackgroundRefresh;

//取得經緯度
- (CLLocation*)getCurrentLocation;

@end
