//
//  CustomCell.h
//  UICatalog
//
//  Created by leo.chang on 2014/10/25.
//  Copyright (c) 2014年 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, customCellAction)
{
    headerAction,   //點擊最右上按鈕
    iconAction,     //點擊姓名
    imageAction,    //點擊照片區域
    actionA,
    actionB,
    actionC,
};

#define cellIdentifier @"cellidentifier"

@protocol CustomCellDelegate;
@interface CustomCell : UITableViewCell

/* 最外層 */
@property (nonatomic, strong) IBOutlet UIView *headerContainer;
@property (nonatomic, strong) IBOutlet UIButton *headerButton;
/* 內容區域 */
@property (nonatomic, strong) IBOutlet UIView *contentContainer;
@property (nonatomic, strong) IBOutlet UIButton *iconButton;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *subtitleLabel;
/* 照片區域 */
@property (nonatomic, strong) IBOutlet UIView *imageContainer;
@property (nonatomic, strong) IBOutlet UIButton *contentImageButton;
@property (nonatomic, strong) IBOutlet UILabel *contentLabel;

/* 下方按鈕區 */
@property (nonatomic, strong) IBOutlet UIButton *actionA;
@property (nonatomic, strong) IBOutlet UIButton *actionB;
@property (nonatomic, strong) IBOutlet UIButton *actionC;

@property (nonatomic, weak) id <CustomCellDelegate> delegate;

@end

@protocol CustomCellDelegate <NSObject>

- (void)CustomCell:(CustomCell*)cell didActionButtonPress:(NSInteger)action;

@end
