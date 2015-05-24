//
//  FMDBTool.m
//  hdsugardoctor
//
//  Created by 毕洪博 on 15-2-4.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import "FMDBTool.h"

static FMDatabase * db;
static FMDatabaseQueue * queue;

@implementation FMDBTool

+(FMDatabase *)open
{
    if (!db)
    {
    NSString *dbPath = [self path];
    db = [FMDatabase databaseWithPath:dbPath];
    }
    if (![db open]) {
        return nil;
    }
    else
    {
        
        [self excuteInit:db];
        
        return db;
    }

}

+(void) excuteInit:(FMDatabase *)db
{
    [db executeUpdate:@"create table if not exists USERS(id integer PRIMARY KEY AUTOINCREMENT,userId string,name string,headerImg string);"];
    [db executeUpdate:@"create table if not exists FRIENDS(id integer PRIMARY KEY AUTOINCREMENT,userId string,name string,headerImg string);"];
    
}

+(FMDatabase *)shareDb
{
    [self open];
    return db;
}

+ (NSString *)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    return dbPath;
}

+(FMDatabaseQueue *)queue
{
    NSString * dbPath = [self path];
    if (!queue) {
        queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [queue inDatabase:^(FMDatabase *db) {
            [self excuteInit:db];
        }];
    }
    return queue;
}

@end
