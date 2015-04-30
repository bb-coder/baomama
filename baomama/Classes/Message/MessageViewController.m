//
//  MessageViewController.m
//  baomama
//
//  Created by bihongbo on 15/4/8.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import "MessageViewController.h"
#import "UINavigationBar+BackGroudColor.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    // 此处最终代码逻辑实现需要您从本地缓存或服务器端获取用户信息。
    
    if ([@"1" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"1";
        user.name = @"韩梅梅";
        user.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";
        
        return completion(user);
    }
    
    if ([@"bhbwudi" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"3";
        user.name = @"李雷";
        user.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";
        
        return completion(user);
    }
    
    return completion(nil);
}

-(NSArray *)getFriends
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    RCUserInfo *user1 = [[RCUserInfo alloc]init];
    user1.userId = @"1";
    user1.name = @"韩梅梅";
    user1.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";
    [array addObject:user1];
    
//    RCUserInfo *user2 = [[RCUserInfo alloc]init];
//    user2.userId = @"2";
//    user2.name = @"李雷";
//    user2.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";
//    [array addObject:user2];
    
    return array;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self setNavigationTitle:@"消息" textColor:[UIColor whiteColor]];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 75, 44);
    [btn setTitle:@"添加好友" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)addFriend
{
    BBLog(@"添加好友");
}

@end
