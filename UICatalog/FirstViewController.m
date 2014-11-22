//
//  FirstViewController.m
//  UICatalog
//
//  Created by Leo on 10/24/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "FirstViewController.h"
#import "Sample.h"

@interface FirstViewController ()

@property (nonatomic, strong) NSDictionary *searchDict;
@property (nonatomic, strong) NSArray *searchArray;
@property (nonatomic, strong) NSArray *sampleArray;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSampleData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSampleData
{
    NSMutableArray *items = [NSMutableArray array];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0 ; i < 200; i++)
    {
        //使用完立刻會加上 (release) 指令
        @autoreleasepool
        {
            Sample *item = [[Sample alloc] init];
            /*
             0 ~ 7
             */
            item.number = [NSNumber numberWithInteger:i % 7];
            /*
             0 ~ 9
             */
            item.string = [NSString stringWithFormat:@"%i", i % 9];
            [items addObject:item];
        }
        
        //Dictionary
        [dict setObject:[NSNumber numberWithInteger:i % 7] forKey:@"number"];
        [dict setObject:[NSString stringWithFormat:@"%i", i % 9] forKey:@"string"];
        
        //Array
        [array addObject:[NSNumber numberWithInteger:i % 7]];
    }
    
    self.sampleArray = [NSArray arrayWithArray:items];
    self.searchArray = [NSArray arrayWithArray:array];
    self.searchDict = [NSDictionary dictionaryWithDictionary:dict];
}

@end
