//
//  NSMutableDictionary+extend.m
//  UICatalog
//
//  Created by leo.chang on 11/22/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "NSMutableDictionary+extend.h"

@implementation NSMutableDictionary (extend)

- (NSInteger)integerValueForKey:(NSString*)key
{
    NSNumber *number = [self valueForKey:key];
    if (!number)
    {
        return NSNotFound;
    }
    return [number integerValue];
}

- (void)setIntegerValue:(NSInteger)value forKey:(NSString*)key
{
    [self setObject:[NSNumber numberWithInteger:value] forKey:key];
}

@end
