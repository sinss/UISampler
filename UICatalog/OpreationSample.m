//
//  OpreationSample.m
//  UICatalog
//
//  Created by leo.chang on 11/29/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "OpreationSample.h"
#import "ComplexityWork.h"

@implementation OpreationSample

- (id)init
{
    self = [super init];
    if (self)
    {
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 5;
        
        self.queue2 = [NSOperationQueue new];
        [self createOperation];
    }
    return self;
}

- (void)createOperation
{
    for (int i = 0 ; i < 10 ; i++)
    {
        NSInvocationOperation *o = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doWork:) object:[NSString stringWithFormat:@"James"]];
        
        [self.queue addOperation:o];
        
        ComplexityWork *o2 = [[ComplexityWork alloc] initWithName:@"Tom"];
        
        [self.queue2 addOperation:o2];
        
    }
}

- (void)doWork:(NSString*)name
{
//    while (true)
//    {
//        sleep(5);
//        NSLog(@"I am %@!!", name);
//    }
}

@end
