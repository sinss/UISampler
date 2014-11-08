//
//  SearchMarkCell.h
//  UICatalog
//
//  Created by leo.chang on 11/8/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchMarkCell : UITableViewCell
{
    BOOL isEnabled;
}

@property (nonatomic, strong) IBOutlet UIButton *locationButton;

- (void)setLocationServiceEnabled:(BOOL)enable;

- (IBAction)turnOnLocationService:(id)sender;

@end
