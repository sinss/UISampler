//
//  SearchMarkCell.m
//  UICatalog
//
//  Created by leo.chang on 11/8/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "SearchMarkCell.h"
#import "LocationManager.h"

@implementation SearchMarkCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLocationServiceEnabled:(BOOL)enable
{
    isEnabled = enable;
    
    if (!isEnabled)
    {
        [self.locationButton setHidden:NO];
        [self.locationButton setTitle:@"開啟地標定位服務" forState:UIControlStateNormal];
    }
}

- (IBAction)turnOnLocationService:(id)sender
{
    //目前Apple是不開放可直接開啟定位服務的，當User自行關閉了定位服務後，只能導引User至設定頁面啟動。
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    
    //[[LocationManager sharedInstance] startUpdatingLocation];
}

@end
