//
//  DatabaseAdapter.h
//  UICatalog
//
//  Created by leo.chang on 11/28/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpotItem.h"

typedef void (^QueryFinish) (BOOL success, NSArray *result);

@interface DatabaseAdapter : NSObject

+ (DatabaseAdapter*)shareInstance;

- (NSArray*)getSpots;

- (void)getSpotsCompletion:(QueryFinish)completion;

@end
