//
//  FirstViewController.m
//  UICatalog
//
//  Created by Leo on 10/24/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "FirstViewController.h"
#import "Sample.h"

#import "NSMutableDictionary+extend.h"
/*
 KVO, KVC
 
 Key Value Path
 NSPredicate
 */
@interface FirstViewController ()

@property (nonatomic, strong) NSDictionary *searchDict;
@property (nonatomic, strong) NSArray *sampleArray;


@property (nonatomic, strong) NSArray *searchArray;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSampleData];
    
    [self sum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sum
{
    NSNumber *result = [self.searchArray valueForKeyPath:@"@sum.integerValue"];
    NSArray *unions = [self.sampleArray valueForKeyPath:@"@distinctUnionOfObjects.number"];
    
    NSString *str = [NSString stringWithFormat:@"number = %@", [NSNumber numberWithInteger:1]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
    
    NSArray *items = [self.sampleArray filteredArrayUsingPredicate:predicate];
    
    NSLog(@"search in sampleArray = %@", items);
    
    NSArray *numbers = [items valueForKeyPath:@"number"];
    
    NSLog(@"numbers = %@", numbers);
    str = [NSString stringWithFormat:@"string = '%@'", @"1"];
    items = [self.sampleArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:str]];
    
    NSString *strings = [items valueForKeyPath:@"string"];
    NSLog(@"strings = %@", strings);
    
    str = [NSString stringWithFormat:@"string = '%@'", @"1"];
    items = [[self.searchDict valueForKey:@"strings"]  filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:str]];
    
    NSSortDescriptor *d1 = [[NSSortDescriptor alloc] initWithKey:@"string" ascending:YES];
    NSSortDescriptor *d2 = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:NO];
    
    items = [self.sampleArray sortedArrayUsingDescriptors:@[d1, d2]];
    
    numbers = [items valueForKeyPath:@"number"];
    strings = [items valueForKeyPath:@"string"];
    for (Sample *item in items)
    {
        NSLog(@"(%@, %@)", item.string, item.number);
    }
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
        [dict setIntegerValue:(i%7) forKey:@"number"];
        
        
        NSInteger i = [dict integerValueForKey:@"number"];
        if (i==NSNotFound)
        {
            
        }
        
        [dict setObject:[NSString stringWithFormat:@"%i", i % 9] forKey:@"string"];
        
        //Array
        [array addObject:[NSNumber numberWithInteger:i % 7]];
    }
    
    self.sampleArray = [NSArray arrayWithArray:items];
    self.searchArray = [NSArray arrayWithArray:array];
    self.searchDict = [NSDictionary dictionaryWithDictionary:dict];
}

@end
