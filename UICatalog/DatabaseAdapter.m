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

- (void)getSpots
{
    FMResultSet *rs = [[DBHelper dbInstanceInBundle] executeQuery:@"select * from locations order by serial"];
    while ([rs next])
    {
        NSLog(@"%@", [rs stringForColumn:@"spot"]);
    }
}

@end
