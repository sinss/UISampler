//
//  singleton.m
//  UICatalog
//
//  Created by Leo on 10/30/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "singleton.h"

@implementation singleton

+ (singleton*)singletonInstance
{
    static id singletonInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        singletonInstance = [[singleton alloc] init];
    });
    return singletonInstance;
}

@end
