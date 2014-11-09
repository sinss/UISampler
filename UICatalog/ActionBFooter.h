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
    FooterA,
    FooterB,
    FooterC,
    FooterD,
};

@protocol ActionFooterDelegate;

@interface ActionBFooter : UITableViewHeaderFooterView

@property (nonatomic, weak) id <ActionFooterDelegate> delegate;

- (IBAction)ButtonPressed:(UIButton*)sender;

@end

@protocol ActionFooterDelegate <NSObject>

- (void)footerView:(ActionBFooter*)footer actionForAction:(Footer)action;

@end
