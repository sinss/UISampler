//
//  ActionBFooter.m
//  UICatalog
//
//  Created by Leo on 11/9/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "ActionBFooter.h"

@implementation ActionBFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)ButtonPressed:(UIButton*)sender
{
    if ([self.actionDelegate respondsToSelector:@selector(footerView:actionForAction:)])
    {
        [self.actionDelegate footerView:self actionForAction:sender.tag];
    }
}

@end
