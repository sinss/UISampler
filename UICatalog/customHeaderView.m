//
//  customHeaderView.m
//  UICatalog
//
//  Created by leo.chang on 11/1/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "customHeaderView.h"

@implementation customHeaderView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSString *titleA = [self.datasource titleForButtonA];
    NSString *titleB = [self.datasource titleForButtonB];
    NSString *titleC = [self.datasource titleForButtonC];
    if (titleA)
    {
        [self.buttonA setTitle:titleA forState:UIControlStateNormal];
    }
    if (titleB)
    {
        [self.buttonB setTitle:titleB forState:UIControlStateNormal];
    }
    if (titleC)
    {
        [self.buttonC setTitle:titleC forState:UIControlStateNormal];
    }
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)ActionButtonPress:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(customHeader:didSelectAction:)])
    {
        [self.delegate customHeader:self didSelectAction:sender.tag];
    }
    
    if (self.block)
    {
        self.block(sender.tag);
    }
}

- (void)showInView:(UIView*)view offset:(CGPoint)offset
{
    
}

- (void)dismiss
{
    
}



@end
