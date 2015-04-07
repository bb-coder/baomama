//
//  Lore.m
//  baomama
//
//  Created by bb_coder on 14-8-20.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "Lore.h"

@implementation Lore
#pragma mark -coding代理方法
#pragma mark 编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_img forKey:@"img"];
    [aCoder encodeObject:_message forKey:@"message"];
    [aCoder encodeObject:_no forKey:@"id"];
    [aCoder encodeObject:_image forKey:@"image"];
}
#pragma mark 解码
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.no = [aDecoder decodeObjectForKey:@"id"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}

#pragma mark 用字典初始化方法
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _title = dict[@"title"];
        _img = dict[@"img"];
        _no = dict[@"id"];
        _message = dict[@"message"];
    }
    return self;
}
@end
