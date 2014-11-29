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
/*
 sandbox
 1. app/Document --> 部份備份到iCloud上面去, 網路下載的資料
 2. app/Cache　--> 放下載資料, 可能會被清掉
 3. app/Library -->　不會被清除
 */
+ (FMDatabase*)dbInstanceInBundle;
+ (FMDatabase*)dbInstanceInDocument;

@end
