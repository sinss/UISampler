//
//  LocationTableViewController.h
//  UICatalog
//
//  Created by leo.chang on 11/28/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationTableViewDelegate;
@interface LocationTableViewController : UITableViewController

@property (nonatomic, weak) id <LocationTableViewDelegate> delegate;

@end


@protocol LocationTableViewDelegate <NSObject>

@required
- (BOOL)shouldSelectEnable;

@optional
- (void)didSelectItems:(NSArray*)selectedItems;

@end
