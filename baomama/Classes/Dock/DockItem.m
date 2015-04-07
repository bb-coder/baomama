//
//  DockItem.m
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb_coder. All rights reserved.
//

#import "DockItem.h"
#define kImageTitleRatio 0.6
@implementation DockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.imageView setContentMode:UIViewContentModeCenter];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark 重写高亮方法屏蔽高亮状态
-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:NO];
}

#pragma mark 重写按钮设置图片方法
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * kImageTitleRatio);
}

#pragma mark 重写按钮设置标题方法
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.frame.size.height * kImageTitleRatio, self.frame.size.width, self.frame.size.height * (1 - kImageTitleRatio));
}
@end
