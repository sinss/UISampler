//
//  NSMutableDictionary+extend.h
//  UICatalog
//
//  Created by leo.chang on 11/22/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (extend)

- (NSInteger)integerValueForKey:(NSString*)key;
- (void)setIntegerValue:(NSInteger)value forKey:(NSString*)key;

@end
