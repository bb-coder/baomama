//
//  CycleScrollView.h
//  sugarusers
//
//  Created by bihongbo on 4/21/15.
//  Copyright (c) 2015 HSDT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHBCycleScrollView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);
/**
 是否显示pageControll
 **/
@property (assign, nonatomic) BOOL showPageControll;
/**
 pageControll,默认隐藏
 **/
@property (nonatomic , strong,readonly)   UIPageControl * pageControl;


- (void)configContentViews;

@end