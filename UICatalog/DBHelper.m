//
//  DBHelper.m
//  UICatalog
//
//  Created by leo.chang on 11/28/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper

+ (FMDatabase*)dbInstanceInBundle
{
    {
        //取得Main bundle底下的路徑
        NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"db" ofType:@"sqlite"];
        
        //create singleton object
        static FMDatabase *db = nil;
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            db = [FMDatabase databaseWithPath:dbPath];
            if ([db open])
            {
                NSLog(@"db path : %@", dbPath);
                NSLog(@"open db.sqlite succeed");
            }
        });
        
        return db;
    }
}

+ (FMDatabase*)dbInstanceInDocument
{
    NSError *error = nil;
    //欲複製的路徑
    NSString *dbPath = [self getDocumentPathForFileName:@"db" andExtension:@"slqite"];
    //bundle裡的路徑
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"db" ofType:@"sqlite"];
    
    //判斷是已存在，不存在就複製過去
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath])
    {
        if (![[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:dbPath error:&error])
        {
            NSLog(@"faild to copy db.sqlite (%@)", error);
        }
    }
    
    //create singleton object
    static FMDatabase *db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [FMDatabase databaseWithPath:dbPath];
        if ([db open])
        {
            NSLog(@"saveDB path : %@", dbPath);
            NSLog(@"open db.sqlite succeed");
        }
    });
    
    return db;
}

+ (NSString*)getDocumentPathForFileName:(NSString*)fileName andExtension:(NSString*)ext
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    fullPath = [fullPath stringByAppendingPathExtension:ext];
    
#warning 千萬不要用這方式建立檔案路徑
    NSString *tmp = [NSString stringWithFormat:@"%@/%@", fileName, ext];
    
    return fullPath;
}

@end
