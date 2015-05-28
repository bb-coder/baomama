//
//  AppDelegate.m
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "AppDelegate.h"
#import "NewFeatureViewController.h"
#import "LoreInfoViewController.h"
#import "MainViewController.h"
#import "RongCloudTool.h"
#import "RCIM.h"
#import "FMDBTool.h"
#import "AccountTool.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //设置默认主题模式
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"nightable"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"nightable"];
    }
    //取出当前版本信息
    NSString * key = (NSString *)kCFBundleVersionKey;
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //取出沙箱中的版本信息
    NSString * saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ([currentVersion isEqualToString:saveVersion]) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        self.window.rootViewController = [[MainViewController alloc]init];
    }else
    {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.window.rootViewController = [[NewFeatureViewController alloc] init];
    }

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    

    
    
    // 初始化 SDK，传入 App Key，deviceToken 暂时为空，等待获取权限。
    [RCIM initWithAppKey:@"ik1qhw091e67p" deviceToken:nil];
    
    FMDatabaseQueue * qu = [FMDBTool queue];
    
    __block BOOL isHasFriends = NO;
    [qu inDatabase:^(FMDatabase *db) {
        
        FMResultSet * rs = [db executeQuery:@"select * from FRIENDS"];
        isHasFriends = rs.next;
        [rs close];
    }];
#if DEBUG
    if (!isHasFriends) {
        [qu inDatabase:^(FMDatabase *db) {
            [db executeUpdate:@"insert into FRIENDS(name,userId) values(?,?)",@"李雷",@"李雷:0"];
            [db executeUpdate:@"insert into FRIENDS(name,userId) values(?,?)",@"张三",@"张三:0"];
        }];
    }
#endif
    
    [qu inDatabase:^(FMDatabase *db) {
       FMResultSet * rs = [db executeQuery:@"select * from USERS"];
        if (rs.next) {
            [AccountTool sharedAccountTool].name = [rs stringForColumn:@"name"];
            [AccountTool sharedAccountTool].userId = [rs stringForColumn:@"userId"];
            [AccountTool sharedAccountTool].img = [rs stringForColumn:@"img"];
            
        [RongCloudTool loginWithUserId:[AccountTool sharedAccountTool].userId andName:[AccountTool sharedAccountTool].name andHeaderImageUrlStr:[AccountTool sharedAccountTool].img andBlock:^{
                BBLog(@"登陆成功！！");
            }];
        }
        [rs close];
    }];
    
    
#ifdef __IPHONE_8_0
    // 在 iOS 8 下注册苹果推送，申请推送权限。
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                         |UIUserNotificationTypeSound
                                                                                         |UIUserNotificationTypeAlert) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#else
    // 注册苹果推送，申请推送权限。
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
#endif
    return YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    // Register to receive notifications.
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    // Handle the actions.
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    BBLog(@"%@",notification);
}


// 获取苹果推送权限成功。
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 设置 deviceToken。
    [[RCIM sharedRCIM] setDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    BBLog(@"%@",error);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
