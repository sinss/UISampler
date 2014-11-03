//
//  ActivityTableSource.h
//  UICatalog
//
//  Created by leo.chang on 11/1/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ActivityScrollDelegate;

@interface ActivityTableSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <ActivityScrollDelegate> delegate;

@end

/*
 將ScrollViewDelegate的包裝起來成為自已的Delegate
 ．這邊使用@option的關鍵字，是只是表示他是可選擇性的，不一定需要被實作。
 但我們在使用以就需要使用ResponseToSelector:來判斷是否可呼叫，避免造成閃退。
 */
@protocol ActivityScrollDelegate <NSObject>

@optional

- (void)ActivityCcrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
