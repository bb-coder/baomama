//
//  NewFeatureViewController.m
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "LoreViewController.h"
#import "MainViewController.h"
#define kLabelText1 @"从此刻开始关注"
#define klabelText2 @"您和宝宝的健康"
@interface NewFeatureViewController ()
{
    CGSize _size;//视图的宽高
}
@end

@implementation NewFeatureViewController

-(void)loadView
{
    UIImageView * imageView = [[UIImageView alloc]init];
    //设置view为一个imageview
    imageView.frame = [UIScreen mainScreen].applicationFrame;
    imageView.backgroundColor = kBgColor;
    self.view = imageView;

    
}
#pragma mark 添加logo
- (void)addLogo
{
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"bg_welcome.jpg"];
    imageView.center = CGPointMake(_size.width * 0.5, _size.height * 0.4);
    imageView.bounds = (CGRect){CGPointZero,CGSizeMake(250, 200)};
    [self.view addSubview:imageView];
    
    //为logo设置动画
    imageView.transform = CGAffineTransformMakeTranslation(0, 50);
    [UIView animateWithDuration:2 animations:^{
        imageView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}
#pragma mark 添加两个label
- (void)addLabels
{
    UILabel * label1 = [[UILabel alloc]init];
    label1.text = kLabelText1;
    label1.font = [UIFont fontWithName:@"Helvetica" size:18.0f];
    label1.center =CGPointMake(_size.width * 0.5, _size.height * 0.7);
    label1.bounds =(CGRect){CGPointZero,CGSizeMake(250, 50)};
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc]init];
    label2.text = klabelText2;
    label2.font = [UIFont fontWithName:@"Helvetica" size:20.0f];
    label2.center =CGPointMake(_size.width * 0.5, _size.height * 0.8);
    label2.bounds =(CGRect){CGPointZero,CGSizeMake(250, 50)};
    [label2 setBackgroundColor:[UIColor clearColor]];
    [label2 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label2];
    
    
    //为标签设置动画
    label1.alpha = 0;
    [label1 setTransform:CGAffineTransformMakeTranslation(0, 100)];
    label2.alpha = 0;
    [label2 setTransform:CGAffineTransformMakeTranslation(0, 150)];
    [UIView animateWithDuration:2 animations:^{
        label1.alpha = 1;
        [label1 setTransform:CGAffineTransformMakeTranslation(0, 0)];
        label2.alpha = 1;
        [label2 setTransform:CGAffineTransformMakeTranslation(0, 0)];
        
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _size = self.view.bounds.size;
    //添加一个logo图片
    [self addLogo];
    //添加两个label标签
    [self addLabels];
}
#pragma mark 监听屏幕点击事件撤掉新特性界面
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.view.transform = CGAffineTransformMakeScale(1, 1);
    self.view.alpha = 1;
    [UIView animateWithDuration:.5f animations:^{
    self.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        self.view.window.rootViewController = [[MainViewController alloc]init];
    }];
}
@end












