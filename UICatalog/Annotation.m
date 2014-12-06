//
//  Annotation.m
//  UICatalog
//
//  Created by Leo on 12/6/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

- (NSString *)subtitle
{
    return _content;
}

- (NSString *)title
{
    return _titie;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init])
    {
        self.coordinate = coordinate;
    }
    return self;
}

@end
