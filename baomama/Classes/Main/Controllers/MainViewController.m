//
//  MainViewController.m
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "MainViewController.h"
#import "WBNavigationController.h"
#import "LoreViewController.h"
#import "RecipesViewController.h"
#import "SaveViewController.h"
#import "SettingViewController.h"
#import "FullBgImage.h"
@interface MainViewController ()
@end

@implementation MainViewController
#pragma mark 实现通知方法
-(void)updateNightable
{
    //模拟一次点击
    [self dockItemClick:_dock from:3 to:3];
    [self viewWillAppear:NO];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightable"]) {
        [_dock setBackgroundColor:kBgNightColor];
    }
    else
        [_dock setBackgroundColor:kBgColor];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[FullBgImage bgImage]]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化所有子控制器
    [self addControllers];
    //添加dock中的按钮
    [self addDockItems];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateNightable) name:@"nightable" object:nil];
    
}
#pragma mark 添加DockItems
- (void) addDockItems
{
    [_dock addItemWithIcon:@"knowlege.png" andSelectedIcon:@"knowlege_selected.png" andTitle:@"常识"];
    [_dock addItemWithIcon:@"dining.png" andSelectedIcon:@"dining_selected.png" andTitle:@"食谱"];
    [_dock addItemWithIcon:@"save.png" andSelectedIcon:@"save_selected.png" andTitle:@"收藏"];
    [_dock addItemWithIcon:@"seting.png" andSelectedIcon:@"seting_selected.png" andTitle:@"设置"];
}
#pragma mark 初始化所有控制器
- (void) addControllers
{
    //常识
    WBNavigationController * nav1 = [[WBNavigationController alloc]init];
    LoreViewController * lore = [[LoreViewController alloc]init];
    [nav1 addChildViewController:lore];
    [self addChildViewController:nav1];
    //食谱
    RecipesViewController * recipes = [[RecipesViewController alloc]init];
    [self addChildViewController:recipes];
    //收藏
    WBNavigationController * nav3 = [[WBNavigationController alloc]init];
    SaveViewController * save = [[SaveViewController alloc]init];
    [nav3 addChildViewController:save];
    [self addChildViewController:nav3];
    //设置
    WBNavigationController * nav4 = [[WBNavigationController alloc]init];
    SettingViewController * setting = [[SettingViewController alloc]initWithStyle:UITableViewStylePlain];
    [nav4 addChildViewController:setting];
    [self addChildViewController:nav4];

}



@end
