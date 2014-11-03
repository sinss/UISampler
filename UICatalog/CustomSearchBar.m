//
//  CustomSearchBar.m
//  UICatalog
//
//  Created by leo.chang on 2014/10/25.
//  Copyright (c) 2014年 Perfectidea. All rights reserved.
//

#import "CustomSearchBar.h"

@implementation CustomSearchBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)showInView:(UIView *)view offset:(CGPoint)offset
{
    CGRect frame = self.frame;
    frame.origin.y = -kSearchBarHeight;
    self.frame = frame;
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        //動畫效果
        self.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finish) {
        //動畫完成
        if (finish)
        {
            self.isShowing = YES;
            
            [self.searchBar becomeFirstResponder];
        }
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        //動畫效果
        self.frame = CGRectMake(0, -kSearchBarHeight + 64, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finish) {
        //動畫完成
        if (finish)
        {
            self.isShowing = NO;
            
            if ([self respondsToSelector:@selector(removeFromSuperview)])
            {
                [self removeFromSuperview];
            }
        }
    }];
}

@end
