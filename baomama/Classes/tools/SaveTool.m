//
//  SaveTool.m
//  baomama
//
//  Created by bb_coder on 14-8-23.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "SaveTool.h"
#import "Lore.h"
#import "Recipes.h"
@implementation SaveTool
kSingletonImplements(SaveTool)
#pragma mark 保存任意数据

-(BOOL)saveImage:(UIImage *)image forKey:(NSString *)key
{
    NSArray * doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * path = doc[0];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",key]];
    [NSKeyedArchiver archiveRootObject:image toFile:path];
    return YES;
}

-(UIImage *)getImageWithKey:(NSString *)key
{
    NSArray * doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * path = doc[0];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",key]];
   return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

-(BOOL)saveLore:(Lore *)lore forKey:(NSString *)key
{
    NSArray * array = [self getDataArrayFromKey:key];
    NSMutableArray * mArray = [NSMutableArray arrayWithArray:array];
    if (mArray == nil) {
        mArray = [NSMutableArray array];
    }
        for (Lore * oj in mArray) {
            if ([oj.no isEqual:lore.no]) {
                return NO;
            }
        }
    [mArray addObject:lore];
    [NSKeyedArchiver archiveRootObject:mArray toFile:[self pathFromKey:key]];
    return YES;
}
-(BOOL)saveRecipes:(Recipes *)recipes forKey:(NSString *)key
{
    NSArray * array = [self getDataArrayFromKey:key];
    NSMutableArray * mArray = [NSMutableArray arrayWithArray:array];
    if (mArray == nil) {
        mArray = [NSMutableArray array];
    }
    for (Recipes * oj in mArray) {
        if ([oj.no isEqual:recipes.no]) {
            return NO;
        }
    }
    [mArray addObject:recipes];
    [NSKeyedArchiver archiveRootObject:mArray toFile:[self pathFromKey:key]];
    return YES;
}
#pragma mark 取出数据对应的数组
-(NSArray *)getDataArrayFromKey:(NSString *)key
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathFromKey:key]];
}
#pragma mark 取出文件路径
- (NSString *)pathFromKey:(NSString *)key
{
    NSArray * doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * path = doc[0];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",key]];
    return path;
}
#pragma mark 删除任意对象
-(void)deleteLore:(Lore *)lore forKey:(NSString *)key
{
    NSArray * array = [self getDataArrayFromKey:key];
    NSMutableArray * mArray = [NSMutableArray arrayWithArray:array];
    if (mArray == nil) {
        mArray = [NSMutableArray array];
    }
    NSMutableArray * tempArray = [NSMutableArray array];
    for (Lore * oj in mArray) {
        if ([lore.no isEqual:oj.no]) {
            [tempArray addObject:oj];
            break;
        }
    }
    [mArray removeObjectsInArray:tempArray];
    [NSKeyedArchiver archiveRootObject:mArray toFile:[self pathFromKey:key]];
}
-(void)deleteRecipes:(Recipes *)recipes forKey:(NSString *)key
{
    NSArray * array = [self getDataArrayFromKey:key];
    NSMutableArray * mArray = [NSMutableArray arrayWithArray:array];
    if (mArray == nil) {
        mArray = [NSMutableArray array];
    }
    NSMutableArray * tempArray = [NSMutableArray array];
    for (Recipes * oj in mArray) {
        if ([recipes.no isEqual:oj.no]) {
            [tempArray addObject:oj];
            break;
        }
    }
    [mArray removeObjectsInArray:tempArray];
    [NSKeyedArchiver archiveRootObject:mArray toFile:[self pathFromKey:key]];
  
}
@end
