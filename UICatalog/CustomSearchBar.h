//
//  CustomSearchBar.h
//  UICatalog
//
//  Created by leo.chang on 2014/10/25.
//  Copyright (c) 2014年 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSearchBarHeight 44

@interface CustomSearchBar : UIView

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) BOOL isShowing;

- (void)showInView:(UIView*)view offset:(CGPoint)offset;
- (void)dismiss;

@end
