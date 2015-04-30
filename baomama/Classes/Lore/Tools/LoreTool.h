//
//  LoreTool.h
//  baomama
//
//  Created by bihongbo on 15/4/8.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lore.h"

typedef void(^getLoreComplete)(NSArray * lores);

@interface LoreTool : NSObject

//获取常识数据
+ (void) getLoreDataWithPage:(NSInteger)page andCompleteBlock:(getLoreComplete)block;

+ (void) getLoreDataWithPage:(NSInteger)page andIndex:(NSInteger)index andNum:(NSInteger)nums andCompleteBlock:(getLoreComplete)block;

@end
