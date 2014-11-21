//
//  CustomInputAccessoryView.m
//  UICatalog
//
//  Created by Leo on 11/22/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "CustomInputAccessoryView.h"

@implementation CustomInputAccessoryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)close:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(customKeyboardDoClose:)])
    {
        [self.delegate customKeyboardDoClose:self];
    }
}

@end
