//
//  NSString+extend.m
//  UICatalog
//
//  Created by leo.chang on 11/22/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "NSString+extend.h"

@implementation NSString (extend)

- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
}


@end
