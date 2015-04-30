//
//  ContactsViewController.m
//  baomama
//
//  Created by bihongbo on 15/4/8.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import "ContactsViewController.h"
#import "RCIM.h"

@interface ContactsViewController ()
// 定义一个按钮。
@property (nonatomic,strong) UIButton *button;
@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建一个按钮
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setFrame:CGRectMake(50, 100, 80, 40)];
    [self.button setTitle:@"Start Chat" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

// 按钮点击事件。
-(IBAction)buttonClicked:(id)sender
{
    // 连接融云服务器。
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"userToken"];
    [RCIM connectWithToken:token completion:^(NSString *userId) {
        // 此处处理连接成功。
        BBLog(@"Login successfully with userId: %@.", userId);
        
        // 创建单聊视图控制器。
        RCChatViewController *chatViewController = [[RCIM sharedRCIM]createPrivateChat:@"3" title:@"李雷" completion:^(){
            // 创建 ViewController 后，调用的 Block，可以用来实现自定义行为。
        }];
        // 把单聊视图控制器添加到导航栈。
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:(UIViewController *)chatViewController animated:YES];
        
    } error:^(RCConnectErrorCode status) {
        // 此处处理连接错误。
        NSLog(@"Login failed.%ld",status);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
