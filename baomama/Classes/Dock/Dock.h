//
//  Dock.h
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb_coder. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dock;
@protocol DockDelegate <NSObject>

@optional
- (void) dockItemClick:(Dock *) dock from:(int) from to:(int)to;

@end

@interface Dock : UIView
#pragma mark 添加dockitem
- (void)addItemWithIcon:(NSString *)icon andSelectedIcon:(NSString *) selectedIcon andTitle:(NSString *) title;
- (void) click:(NSInteger) index;

@property (weak,nonatomic) id<DockDelegate> delegate;
@end
