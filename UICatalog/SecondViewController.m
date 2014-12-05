//
//  SecondViewController.m
//  UICatalog
//
//  Created by Leo on 10/24/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "SecondViewController.h"
#import <GoogleMapsM4B/GoogleMaps.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:6];
    self.view = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
