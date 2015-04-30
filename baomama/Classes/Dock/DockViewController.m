//
//  DockViewController.m
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb_coder. All rights reserved.
//

#import "DockViewController.h"
#define kDockHeight 49
@interface DockViewController ()<UITabBarControllerDelegate>

@end

@implementation DockViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加dock
    [self addDock];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dockHide) name:@"dockHide" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dockShow) name:@"dockShow" object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dockHide" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dockShow" object:nil];
}

-(void)dockHide
{
    [UIView animateWithDuration:0.25 animations:^{
//        _dock.hidden = YES;
        if(_dock.y < self.view.height)
        _dock.y += kDockHeight;
    }];
}

-(void)dockShow
{
    [UIView animateWithDuration:0.25 animations:^{
        if(_dock.y >= self.view.height)
        _dock.y -= kDockHeight;
    }];
}


#pragma mark 添加dock
- (void)addDock
{
//    Dock * dock = [[Dock alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight)];
    Dock * dock = [[Dock alloc]initWithFrame:self.tabBar.frame];
    self.tabBar.hidden = YES;
    [self.view addSubview:dock];
    
    dock.delegate = self;
    _dock = dock;
}
#pragma mark dock代理方法
-(void)dockItemClick:(Dock *)dock from:(int)from to:(int)to
{
//    if (to < 0 || to > self.childViewControllers.count) {
//        return ;
//    }
//    UIViewController * oldVC = self.childViewControllers[from];
//    UIViewController * newVC = self.childViewControllers[to];
//    CGFloat width = self.view.bounds.size.width;
//    CGFloat height;
//
//    height = self.view.bounds.size.height - kDockHeight;
//    newVC.view.frame = CGRectMake(0, 0, width, height);
//    [oldVC.view removeFromSuperview];
//    [self.view addSubview:newVC.view];
    self.selectedIndex = to;
    self.tabBar.hidden = YES;
}

@end
