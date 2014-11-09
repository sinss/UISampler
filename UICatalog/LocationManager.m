//
//  LocationManager.m
//  UICatalog
//
//  Created by Leo on 11/8/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

+ (LocationManager*)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[LocationManager alloc] init];
    });
    
    return instance;
}

- (id)initwithSometype:(NSInteger)type
{
//    self = [self init];
//    if (self)
//    {
//        
//    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        [self createLocationManager];
    }
    return self;
}

- (void)createLocationManager
{
    self.locmanager = [[CLLocationManager alloc] init];
    
    //[self startUpdatingLocation];
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
    /*
     iOS8 以上
     */
    if ([self.locmanager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        //[self.locmanager requestWhenInUseAuthorization];
        [self.locmanager requestAlwaysAuthorization];
    }
    [_locmanager setDelegate:self];
    //設定人在移動多遠時才會定位的距離
    [_locmanager setDistanceFilter:1.0f];
    //degree -->手機在轉動時
    [_locmanager setHeadingFilter:kCLHeadingFilterNone];
    
    //精準度，愈精準愈耗電。
    [_locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    //開始定位
    [_locmanager startUpdatingLocation];
    
    NSLog(@"(1) lat : %f, long : %f", _locmanager.location.coordinate.latitude, _locmanager.location.coordinate.longitude);
    
    [_locmanager startUpdatingHeading];
    
    NSLog(@"(2) lat : %f, long : %f", _locmanager.location.coordinate.latitude, _locmanager.location.coordinate.longitude);
}

- (CLLocation*)getCurrentLocation
{
    return _locmanager.location;
}

- (BOOL)locationServicesEnabled
{
    NSLog(@"locationService is %@", [CLLocationManager locationServicesEnabled] ? @"YES" : @"NO");
    if([CLLocationManager locationServicesEnabled])
    {
        
        NSLog(@"Location Services Enabled");
        
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)
        {
            return NO;
        }
    }
    return YES;
}


#pragma mark - LocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"(old) lat : %f, long : %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"(new) lat : %f, long : %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

@end
