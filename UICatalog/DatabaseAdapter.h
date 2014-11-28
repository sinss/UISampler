//
//  DatabaseAdapter.h
//  UICatalog
//
//  Created by leo.chang on 11/28/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseAdapter : NSObject

+ (DatabaseAdapter*)shareInstance;

- (void)getSpots;

@end
