//
//  ActionBCell.h
//  UICatalog
//
//  Created by leo.chang on 11/8/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>
//customize a TextView with placeHolder
#import "UIPlaceHolderTextView.h"
@interface ActionBCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *iconView;
@property (nonatomic, strong) IBOutlet UIPlaceHolderTextView *contentTextView;

@end
