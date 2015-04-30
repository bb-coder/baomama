//
//  BHBButtonListView.h
//  sugarusers
//
//  Created by bihongbo on 4/22/15.
//  Copyright (c) 2015 HSDT. All rights reserved.
//
//按钮集合控件


#import <UIKit/UIKit.h>

@class BHBButtonListView;

@protocol  BHBButtonListViewDelegate<NSObject>

@optional
/**
 *  视图点击事件
 *
 *  @param index 点击序号
 */
-(void) clickWithIndex:(NSInteger)index;


@end


@interface BHBButtonListView : UIView

/**
 *  动态增加一项
 *
 *  @param view 增加视图
 */
-(void)addItemWith:(UIView *)view;

/**
 *  代理属性，可以监听点击事件
 */
@property (weak, nonatomic) id<BHBButtonListViewDelegate> delegate;

@end
