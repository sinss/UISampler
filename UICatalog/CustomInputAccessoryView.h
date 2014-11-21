//
//  CustomInputAccessoryView.h
//  UICatalog
//
//  Created by Leo on 11/22/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomKeyboardDelegate.h"

@interface CustomInputAccessoryView : UIView

@property (nonatomic, weak) id <CustomKeyboardDelegate> delegate;

- (IBAction)close:(id)sender;

@end
