//
//  ActivityViewController.h
//  UICatalog
//
//  Created by leo.chang on 11/1/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)searchItemPress:(id)sender;

@end
