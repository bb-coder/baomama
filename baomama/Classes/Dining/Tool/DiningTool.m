//
//  DiningTool.m
//  baomama
//
//  Created by bihongbo on 15/4/8.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import "DiningTool.h"
#import "HttpTool.h"

@implementation DiningTool

static NSArray * arr;

+(NSArray *)getTopCategory
{
    return arr;
}

#pragma mark 加载顶级分类
+(void)load
{
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"cookCate" withExtension:@"plist"];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfURL:url];
    arr = dict[@"yi18"];
}

+(void) getDiningDataWithPage:(NSInteger)page andCaIndex:(NSInteger)index  andCompleteBlock:(GetDiningDataCompleteBlock)block
{
    NSMutableArray * recipesArr = [NSMutableArray array];
    [HttpTool postWithPath:kCookPath params:
     @{
       @"page":@(page),@"limit":@(20),@"type":@"id",@"id":arr[index][@"id"]
       }
                   success:^(id JSON)
     {
         NSArray * array = JSON[@"yi18"];
         for (NSDictionary *dict in array) {
             Recipes * recipes = [[Recipes alloc]initWithDict:dict];
             [HttpTool getWithPath:kCookShowPath params:@{@"id":recipes.no} success:^(id JSON) {
                 NSDictionary * dict = JSON[@"yi18"];
                 recipes.message = dict[@"message"];
             } failure:^(NSError *error) {
             }];
             [recipesArr addObject:recipes];
         }
         if(block)
         block(recipesArr);
     }
                   failure:^(NSError *error) {
                       
                   }];
}

@end
