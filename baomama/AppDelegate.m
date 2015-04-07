//
//  AppDelegate.m
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "AppDelegate.h"
#import "NewFeatureViewController.h"
#import "LoreViewController.h"
#import "MainViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [ShareSDK registerApp:@"2d54809176e0"];
//    [ShareSDK connectSinaWeiboWithAppKey:@"3205346392"
//                               appSecret:@"c8e0a5204100c5788c477ce3f4a55431"
//                             redirectUri:@""];
    
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
    return YES;
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
