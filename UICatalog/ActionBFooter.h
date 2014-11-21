//
//  ActionBFooter.h
//  UICatalog
//
//  Created by Leo on 11/9/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Footer)
{
    FooterCamera,
    FooterPeople,
    FooterEmoji,
    FooterLoation,
};

@protocol ActionFooterDelegate;

@interface ActionBFooter : UIView

@property (nonatomic, weak) id <ActionFooterDelegate> actionDelegate;

- (IBAction)ButtonPressed:(UIButton*)sender;

@end

@protocol ActionFooterDelegate <NSObject>

- (void)footerView:(ActionBFooter*)footer actionForAction:(Footer)action;

@end
