//
//  DiningTool.h
//  baomama
//
//  Created by bihongbo on 15/4/8.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipes.h"

typedef void(^GetDiningDataCompleteBlock)(NSArray * recipes);

@interface DiningTool : NSObject

//获取食谱数据
+(void) getDiningDataWithPage:(NSInteger)page andCaIndex:(NSInteger)index andCompleteBlock:(GetDiningDataCompleteBlock)block;

+(NSArray *)getTopCategory;

@end
