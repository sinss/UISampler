//
//  DatabaseAdapter.m
//  UICatalog
//
//  Created by leo.chang on 11/28/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "DatabaseAdapter.h"
#import "DBHelper.h"
#import "FMDatabase.h"

@implementation DatabaseAdapter

+ (DatabaseAdapter*)shareInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[DatabaseAdapter alloc] init];
    });
    
    return instance;
}

- (NSArray*)getSpots
{
    NSMutableArray *items = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        FMResultSet *rs = [[DBHelper dbInstanceInBundle] executeQuery:@"select * from locations order by serial"];
        
        while ([rs next])
        {
            NSLog(@"%@", [rs stringForColumn:@"spot"]);
        }
        
    });
    
    return items;
}

- (void)getSpotsCompletion:(QueryFinish)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        NSMutableArray *items = [NSMutableArray array];
        FMResultSet *rs = [[DBHelper dbInstanceInBundle] executeQuery:@"select * from locations order by serial"];
        if (!rs)
        {
            //callback
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(NO, items);
            });
            return;
        }
        while ([rs next])
        {
            [items addObject:[rs stringForColumn:@"spot"]];
            NSLog(@"%@", [rs stringForColumn:@"spot"]);
        }
        //callback
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(YES, items);
        });
    });
}

@end
