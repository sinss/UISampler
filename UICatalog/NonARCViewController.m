//
//  NonARCViewController.m
//  UICatalog
//
//  Created by Leo on 10/30/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "NonARCViewController.h"

@interface NonARCViewController ()

@end

@implementation NonARCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_message release], _message = nil;
    [_button release], _button = nil;
    [_label release], _label = nil;
    [super dealloc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
