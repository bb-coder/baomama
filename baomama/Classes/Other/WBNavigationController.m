//
//  WBNavigationController.m
//  xinlangweibo
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb_coder. All rights reserved.
//

#import "WBNavigationController.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark 实现通知方法
-(void)updateNightable
{
    BOOL nightable = [[NSUserDefaults standardUserDefaults]boolForKey:@"nightable"];
    UINavigationBar * bar = [UINavigationBar appearance];
    //设置nav背景颜色
    if (nightable)
        [bar setTintColor:kBgNightColor];
    else
        [bar setTintColor:kBgColor];
    //设置字颜色和阴影
    [bar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor blackColor],
                                  UITextAttributeTextShadowOffset:[NSValue valueWithCGSize:CGSizeMake(0, 0)]}];
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        if (nightable)
            [bar setBarTintColor:kBgNightColor];
        else
            [bar setBarTintColor:kBgColor];
    }
#endif

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateNightable) name:@"nightable" object:nil];
    BOOL nightable = [[NSUserDefaults standardUserDefaults]boolForKey:@"nightable"];
    UINavigationBar * bar = [UINavigationBar appearance];
    //设置nav背景颜色
    if (nightable)
        [bar setTintColor:kBgNightColor];
    else
        [bar setTintColor:kBgColor];
    //设置字颜色和阴影
    [bar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor blackColor],
                                  UITextAttributeTextShadowOffset:[NSValue valueWithCGSize:CGSizeMake(0, 0)]}];
#ifdef __IPHONE_7_0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        if (nightable)
            [bar setBarTintColor:kBgNightColor];
        else
            [bar setBarTintColor:kBgColor];
    }
#endif

    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
