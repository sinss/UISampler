//
//  CustomCell.m
//  UICatalog
//
//  Created by leo.chang on 2014/10/25.
//  Copyright (c) 2014年 Perfectidea. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
    [self setupUIAttribute];
}

- (void)setupUIAttribute
{
    self.headerContainer.layer.cornerRadius = 5;
    [self.headerContainer setClipsToBounds:YES];
    
    self.contentContainer.layer.cornerRadius = 5;
    [self.contentContainer setClipsToBounds:YES];
    
    self.imageContainer.layer.cornerRadius = 5;
    
    self.actionA.layer.cornerRadius = 10;
    [self.actionA setClipsToBounds:YES];
    
    self.actionB.layer.cornerRadius = 20;
    [self.actionB setClipsToBounds:YES];
    
    self.actionC.layer.cornerRadius = 30;
    [self.actionC setClipsToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
