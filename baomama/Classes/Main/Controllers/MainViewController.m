//
//  MainViewController.m
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "MainViewController.h"
#import "WBNavigationController.h"
#import "LoreInfoViewController.h"
#import "RecipesViewController.h"
#import "SaveViewController.h"
#import "SettingViewController.h"
#import "FullBgImage.h"
#import "ContactsViewController.h"
#import "MessageViewController.h"
#import "RCIM.h"
#import "LoreViewController.h"

@interface MainViewController ()

@property (nonatomic,strong) MessageViewController * msgVc;

@end

@implementation MainViewController
#pragma mark 实现通知方法
-(void)updateNightable
{
    //模拟一次点击
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightable"]) {
        [_dock setBackgroundColor:kBgNightColor];
    }
    else
        [_dock setBackgroundColor:kBgColor];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[FullBgImage bgImage]]];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self updateNightable];
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化所有子控制器
    [self addControllers];
    //添加dock中的按钮
    [self addDockItems];
    //默认选中2item
//    [self dockItemClick:_dock from:1 to:1];
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateNightable) name:@"nightable" object:nil];
    
    [_dock click:1];
    
    
}


#pragma mark 添加DockItems
- (void) addDockItems
{
    [_dock addItemWithIcon:@"messege.png" andSelectedIcon:@"messege_selected.png" andTitle:@"消息"];
    [_dock addItemWithIcon:@"knowlege.png" andSelectedIcon:@"knowlege_selected.png" andTitle:@"资讯"];
    [_dock addItemWithIcon:@"dining.png" andSelectedIcon:@"dining_selected.png" andTitle:@"食谱"];
    [_dock addItemWithIcon:@"save.png" andSelectedIcon:@"save_selected.png" andTitle:@"收藏"];
    [_dock addItemWithIcon:@"seting.png" andSelectedIcon:@"seting_selected.png" andTitle:@"设置"];
}
#pragma mark 初始化所有控制器
- (void) addControllers
{
    //聊天
    WBNavigationController * nav1 = [[WBNavigationController alloc]init];
    // 创建会话列表视图控制器。
    self.msgVc = [[MessageViewController alloc]init];
    [RCIM setUserInfoFetcherWithDelegate:self.msgVc isCacheUserInfo:YES];
    [RCIM setFriendsFetcherWithDelegate:self.msgVc];
//    RCChatListViewController *chatListViewController = [[RCIM sharedRCIM]createConversationList:^(){
//        // 创建 ViewController 后，调用的 Block，可以用来实现自定义行为。
//    }];

    MessageViewController * message = self.msgVc;
    [nav1 addChildViewController:message];
    [self addChildViewController:nav1];
//    //联系人
//    WBNavigationController * nav2 = [[WBNavigationController alloc]init];
//    ContactsViewController * contact = [[ContactsViewController alloc]init];
//    [nav2 addChildViewController:contact];
//    [self addChildViewController:nav2];
    
    //常识
    WBNavigationController * nav3 = [[WBNavigationController alloc]init];
    LoreViewController * lore = [[LoreViewController alloc]init];
    [nav3 addChildViewController:lore];
    [self addChildViewController:nav3];
    //食谱
    RecipesViewController * recipes = [[RecipesViewController alloc]init];
    [self addChildViewController:recipes];
    //收藏
    WBNavigationController * nav4 = [[WBNavigationController alloc]init];
    SaveViewController * save = [[SaveViewController alloc]init];
    [nav4 addChildViewController:save];
    [self addChildViewController:nav4];
    //设置
    WBNavigationController * nav5 = [[WBNavigationController alloc]init];
    SettingViewController * setting = [[SettingViewController alloc]init];
    [nav5 addChildViewController:setting];
    [self addChildViewController:nav5];
    
}



@end
