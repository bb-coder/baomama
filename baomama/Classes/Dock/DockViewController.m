//
//  DockViewController.m
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb_coder. All rights reserved.
//

#import "DockViewController.h"
#define kDockHeight 44
@interface DockViewController ()
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
}

#pragma mark 添加dock
- (void)addDock
{
    Dock * dock = [[Dock alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight)];
    dock.delegate = self;
    _dock = dock;
    [self.view addSubview:_dock];
}
#pragma mark dock代理方法
-(void)dockItemClick:(Dock *)dock from:(int)from to:(int)to
{
    if (to < 0 || to > self.childViewControllers.count) {
        return ;
    }
    UIViewController * oldVC = self.childViewControllers[from];
    UIViewController * newVC = self.childViewControllers[to];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height - kDockHeight;
    newVC.view.frame = CGRectMake(0, 0, width, height);
    [oldVC.view removeFromSuperview];
    [self.view addSubview:newVC.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
