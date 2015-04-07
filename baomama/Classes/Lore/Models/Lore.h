//
//  Lore.h
//  baomama
//
//  Created by bb_coder on 14-8-20.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lore : NSObject<NSCoding>

//常识简介标题
@property (nonatomic,copy) NSString * title;
//常识图片路径
@property (nonatomic,copy) NSString * img;
//常识图片
@property (nonatomic,strong) UIImage * image;
//常识详情
@property (nonatomic,copy) NSString * message;
//常识id
@property (nonatomic,copy) NSString * no;
#pragma mark 用字典初始化
- (id)initWithDict:(NSDictionary *) dict;
@end
