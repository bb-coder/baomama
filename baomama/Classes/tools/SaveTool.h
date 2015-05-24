//
//  SaveTool.h
//  baomama
//
//  Created by bb_coder on 14-8-23.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Singleton.h"
@class Lore;
@class Recipes;
@interface SaveTool : NSObject
kSingletonInterface(SaveTool)
-(BOOL)saveLore:(Lore *)lore forKey:(NSString *)key;
-(BOOL)saveRecipes:(Recipes *)recipes forKey:(NSString *)key;
-(NSArray *)getDataArrayFromKey:(NSString *)key;
-(void)deleteLore:(Lore *)lore forKey:(NSString *)key;
-(void)deleteRecipes:(Recipes *)recipes forKey:(NSString *)key;

-(BOOL)saveImage:(UIImage *)image forKey:(NSString *)key;
-(UIImage *)getImageWithKey:(NSString *)key;
@end
