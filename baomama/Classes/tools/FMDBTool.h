//
//  FMDBTool.h
//  hdsugardoctor
//
//  Created by 毕洪博 on 15-2-4.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBTool : NSObject

/*
 打开数据库
 */
+(FMDatabase *)open;
/*
 获取数据库对象
 */
+(FMDatabase *)shareDb;
/*
 多线程安全的
 */
+(FMDatabaseQueue *)queue;
/*
 数据库路径
 */
+ (NSString *)path;

@end
