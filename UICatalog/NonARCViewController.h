//
//  NonARCViewController.h
//  UICatalog
//
//  Created by Leo on 10/30/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NonARCViewController : UIViewController

@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIButton *button;

@end
