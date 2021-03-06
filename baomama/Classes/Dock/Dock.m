//
//  Dock.m
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb_coder. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"
#define kSelectedItemBack @"slider_selected.jpg"
@interface Dock()
{
    DockItem * _selectedItem;
}

@property (nonatomic,strong) NSMutableArray * items;
@end

@implementation Dock

-(NSMutableArray *)items
{
    if(!_items){
        _items = [NSMutableArray array];
    }
    return _items;
}

#pragma mark 添加dockitem
-(void)addItemWithIcon:(NSString *)icon andSelectedIcon:(NSString *)selectedIcon andTitle:(NSString *)title
{
    DockItem * item = [[DockItem alloc]init];
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateSelected];
    
    [item setTitle:title forState:UIControlStateNormal];
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    
    [self.items addObject:item];
    [self addSubview:item];
    NSInteger count = self.items.count;
//    if (count == 1) {
//        BBLog(@"%ld",(long)count);
//        [self itemClick:item];
//    }
    CGSize size = self.bounds.size;
    for (int i = 0; i < count; i++) {
        DockItem * itemf = self.items[i];
        itemf.tag = i;
        [itemf setFrame:CGRectMake(i * (size.width / count), 0,size.width / count, size.height)];
        
        [itemf setBackgroundImage:[UIImage imageNamed:kSelectedItemBack] forState:UIControlStateSelected];
    }
}

- (void) click:(NSInteger) index
{
    [self itemClick:self.items[index]];
}

#pragma mark 监听按钮点击事件
- (void) itemClick:(DockItem *) item
{
    if ([_delegate respondsToSelector:@selector(dockItemClick:from:to:)]) {
        [_delegate dockItemClick:self from:(int)_selectedItem.tag to:(int)item.tag];
    }
    
    _selectedItem.selected = NO;
    
    item.selected = YES;
    
    _selectedItem = item;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"销毁了？？？");
}


@end
