//
//  BHBButtonListView.m
//  sugarusers
//
//  Created by bihongbo on 4/22/15.
//  Copyright (c) 2015 HSDT. All rights reserved.
//

#import "BHBButtonListView.h"

@interface BHBButtonListView ()

@property (nonatomic,strong)NSMutableArray * items;

@end

@implementation BHBButtonListView

-(NSMutableArray *)items
{
    if(!_items){
        _items = [NSMutableArray array];
    }
    return _items;
}

-(void)addItemWith:(UIView *)view
{
    [self.items addObject:view];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat itemW = self.width / 3;
    CGFloat itemH = self.height / 2;
    int i = 0;
    for (UIView * v in self.items) {
        v.tag = 1000 + i;
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [v addGestureRecognizer:tap];
        CGFloat x = (i % 3) * itemW;
        CGFloat y = (i / 3) * itemH;
        v.frame = CGRectMake(x, y, itemW, itemH);
        [self addSubview:v];
        i++;
    }
}

-(void)tapView:(UIGestureRecognizer *)tap
{
    UIView * v = tap.view;
    NSInteger index = v.tag - 1000;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithIndex:)]) {
        [self.delegate clickWithIndex:index];
    }
}


@end
