//
//  LoreTool.m
//  baomama
//
//  Created by bihongbo on 15/4/8.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import "LoreTool.h"
#import "HttpTool.h"

@implementation LoreTool

+ (void) getLoreDataWithPage:(NSInteger)page andCompleteBlock:(getLoreComplete)block
{
    [self getLoreDataWithPage:page andIndex:6 andNum:5 andCompleteBlock:^(NSArray *lores) {
        block(lores);
    }];
}

+ (void) getLoreDataWithPage:(NSInteger)page andIndex:(NSInteger)index andNum:(NSInteger)nums andCompleteBlock:(getLoreComplete)block
{
    NSMutableArray * lores = [NSMutableArray array];
    [HttpTool getWithPath:kLorePath params:
     @{@"page": @(page),@"limit":@(nums),@"type":@"count",@"id":@(index) } success:^(id JSON) {
         NSArray * array = JSON[@"yi18"];
         for (NSDictionary * dict in array) {
             Lore * lore = [[Lore alloc]initWithDict:dict];
             [HttpTool getWithPath:kLoreShowPath params:@{@"id":lore.no} success:^(id JSON) {
                 NSDictionary * dict = JSON[@"yi18"];
                 lore.message = dict[@"message"];
             } failure:^(NSError *error) {
             }];
             [lores addObject:lore];
         }
         if(block)
         {
             block(lores);
         }
     } failure:^(NSError *error) {
         
     }];

}

@end
