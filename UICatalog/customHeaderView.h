//
//  customHeaderView.h
//  UICatalog
//
//  Created by leo.chang on 11/1/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ActionOptions)
{
    ActionOptionsA = 0,
    ActionOptionsB,
    ActionOptionsC,
};

typedef void (^ActionOptionBlock) (ActionOptions option);

@protocol customHeaderViewAction;
@protocol customHeaderViewDataSource;

@interface customHeaderView : UIView

@property (nonatomic, copy) ActionOptionBlock block;
@property (nonatomic, weak) id <customHeaderViewAction> delegate;
@property (nonatomic, weak) id <customHeaderViewDataSource> datasource;


@property (nonatomic, weak) IBOutlet UIButton *buttonA;
@property (nonatomic, weak) IBOutlet UIButton *buttonB;
@property (nonatomic, weak) IBOutlet UIButton *buttonC;

- (IBAction)ActionButtonPress:(id)sender;

/*
 Show / Dismiss
 */
- (void)showInView:(UIView*)view offset:(CGPoint)offset;
- (void)dismiss;

@end

@protocol customHeaderViewAction <NSObject>

@optional

- (void)customHeader:(customHeaderView*)view didSelectAction:(ActionOptions)action;

@end

@protocol customHeaderViewDataSource <NSObject>

@optional
- (NSString*)titleForButtonA;
- (NSString*)titleForButtonB;
- (NSString*)titleForButtonC;

@end