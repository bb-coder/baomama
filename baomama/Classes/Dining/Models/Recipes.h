//
//  Recipes.h
//  baomama
//
//  Created by bb_coder on 14-8-21.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipes : NSObject<NSCoding>
//食谱名字
@property (nonatomic,copy) NSString * name;
//食谱图片
@property (nonatomic,copy) NSString * img;
//食谱图片
@property (nonatomic,strong) UIImage * image;
//食谱详情id
@property (nonatomic,copy) NSString * no;
//食谱配料
@property (nonatomic,copy) NSString * food;
//食谱详情
@property (nonatomic,copy) NSString * message;
//图片宽
@property (nonatomic,assign) CGFloat w;
//图片高
@property (nonatomic,assign) CGFloat h;
#pragma mark 用字典初始化一个食谱
-(id)initWithDict:(NSDictionary *) dict;
@end
