//
//  UINavigationBar+BackGroudColor.m
//  baomama
//
//  Created by bihongbo on 15/4/9.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import "UINavigationBar+BackGroudColor.h"
#import <objc/runtime.h>

@implementation UINavigationBar (BackGroudColor)

static char overlayKey;

-(UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

-(void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)bhb_setBackgroundColor:(UIColor *)backgroudColor
{
    if(!self.overlay)
    {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];
        self.overlay = [[UIView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroudColor;
}

@end
