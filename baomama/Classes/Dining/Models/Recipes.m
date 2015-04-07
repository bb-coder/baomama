//
//  Recipes.m
//  baomama
//
//  Created by bb_coder on 14-8-21.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "Recipes.h"

@implementation Recipes

#pragma mark －nscoding代理方法
#pragma mark 编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_img forKey:@"img"];
    [aCoder encodeObject:@(_w) forKey:@"w"];
    [aCoder encodeObject:@(_h) forKey:@"h"];
    [aCoder encodeObject:_no forKey:@"no"];
    [aCoder encodeObject:_food forKey:@"food"];
    [aCoder encodeObject:_message forKey:@"message"];
    [aCoder encodeObject:_image forKey:@"image"];
}
#pragma mark 解码
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.w = [[aDecoder decodeObjectForKey:@"w"] doubleValue];
        self.h = [[aDecoder decodeObjectForKey:@"h"]doubleValue];
        self.no = [aDecoder decodeObjectForKey:@"no"];
        self.food = [aDecoder decodeObjectForKey:@"food"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}
#pragma mark 利用字典初始化对象
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.img = dict[@"img"];
        self.no = dict[@"id"];
        self.w = 150 - arc4random_uniform(30);
    }
    return self;
}
@end
