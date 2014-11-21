//
//  customHeaderView.m
//  UICatalog
//
//  Created by leo.chang on 11/1/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "customHeaderView.h"

@implementation customHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
