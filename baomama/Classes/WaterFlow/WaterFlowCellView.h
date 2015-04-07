//
//  WaterFlowCellView.h
//  瀑布流demo
//
//  Created by 毕洪博 on 14-8-11.
//  Copyright (c) 2014年 bb_coder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFlowCellView : UIView
//图像
@property (nonatomic,strong) UIImageView * imageView;
//文字简介
@property (nonatomic,strong) UILabel * textLabel;
//是否被选中
@property (nonatomic,assign,getter = isSelected) BOOL selected;
//可重用标识
@property (nonatomic,copy) NSString * reuseIdentifier;
//正反面
@property (nonatomic,assign) BOOL isTurn;
//点击了左面还是右面
@property (nonatomic,assign) BOOL isClickLeft;
//背面的图片
@property (nonatomic,strong) UIImage * turnImage;
- (id) initWithReuseIdentifier:(NSString *) reuseIdentifier;
@end
