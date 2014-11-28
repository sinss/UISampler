//
//  DBHelper.h
//  UICatalog
//
//  Created by leo.chang on 11/28/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DBHelper : NSObject

+ (FMDatabase*)dbInstanceInBundle;
+ (FMDatabase*)dbInstanceInDocument;

@end
