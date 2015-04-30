//
//  WBNavigationController.m
//  xinlangweibo
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb_coder. All rights reserved.
//

#import "WBNavigationController.h"
#import "UINavigationBar+BackGroudColor.h"

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
    [bar setTintColor:[UIColor whiteColor]];
    [bar setBarTintColor:[UIColor whiteColor]];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    if(nightable){
        [bar bhb_setBackgroundColor:kBgNightColor];
        
    }
    else
    {
        [bar bhb_setBackgroundColor:kBgColor];
    }
    
    UINavigationBar * bar1 = self.navigationBar;
    [bar1 setTintColor:[UIColor whiteColor]];
    [bar1 setBarTintColor:[UIColor whiteColor]];
    [bar1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [bar1 setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    if(nightable){
        [bar1 bhb_setBackgroundColor:kBgNightColor];
        
    }
    else
    {
        [bar1 bhb_setBackgroundColor:kBgColor];
    }


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateNightable) name:@"nightable" object:nil];
    [self updateNightable];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"dockHide" object:nil];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if(self.viewControllers.count == 2)
        [[NSNotificationCenter defaultCenter]postNotificationName:@"dockShow" object:nil];
    return [super popViewControllerAnimated:animated];
}

-(NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([self.viewControllers indexOfObject:viewController] == 1)
        [[NSNotificationCenter defaultCenter]postNotificationName:@"dockShow" object:nil];
    return [super popToViewController:viewController animated:animated];
}

-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"dockShow" object:nil];
    return [super popToRootViewControllerAnimated:animated];
}

@end
