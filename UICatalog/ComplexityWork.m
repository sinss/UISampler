//
//  ComplexityWork.m
//  UICatalog
//
//  Created by leo.chang on 11/29/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "ComplexityWork.h"

@implementation ComplexityWork

- (id)initWithName:(NSString*)name
{
    if (self = [super init])
    {
        self.name = name;
    }
    return self;
}

- (void)start
{
    while (true)
    {
        sleep(6);
        NSLog(@"I am a complexity %@", self.name);
    }
    
}

@end
