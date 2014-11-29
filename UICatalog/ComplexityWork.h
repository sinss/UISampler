//
//  ComplexityWork.h
//  UICatalog
//
//  Created by leo.chang on 11/29/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplexityWork : NSOperation

@property (nonatomic, strong) NSString *name;

- (id)initWithName:(NSString*)name;

@end
