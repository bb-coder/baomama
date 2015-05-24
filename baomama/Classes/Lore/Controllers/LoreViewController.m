//
//  LoreViewController.m
//  baomama
//
//  Created by bihongbo on 4/29/15.
//  Copyright (c) 2015 bb-coder. All rights reserved.
//

#import "LoreViewController.h"
#import "BHBCycleScrollView.h"
#import "LoreTool.h"
#import "BHBButtonListView.h"
#import "LoreInfoViewController.h"
#import "ShowViewController.h"
#import "IconButton.h"
#import "UINavigationBar+BackGroudColor.h"



@interface LoreViewController ()<BHBButtonListViewDelegate>
{
    NSArray * titleArr;
}

@property (nonatomic,strong)NSMutableArray * topAdArray;

@property (nonatomic,weak) BHBCycleScrollView * topView;

@end

@implementation LoreViewController

-(NSMutableArray *)topAdArray
{
    if(!_topAdArray){
        _topAdArray = [NSMutableArray array];
    }
    return _topAdArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleArr = @[@"老人健康",@"孩子健康",@"健康饮食",@"男性健康",@"女性保养",@"孕婴手册"];
//    self.title = @"资讯";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //透明导航栏
    if(self.navigationController){
        
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        self.navigationController.navigationBar.hidden = YES;
//        [self.navigationController.navigationBar bhb_setBackgroundColor:[UIColor clearColor]];
        
    }
    
    //添加顶部滚动视图
    [self addTopScrollView];
    //添加换一换按钮
    [self addRandomDataBtn];
    //添加按钮列表
    [self addButtonList];
    
    [self random];
    
    
}

-(void)addButtonList
{
    BHBButtonListView * bList = [[BHBButtonListView alloc]initWithFrame:CGRectMake(0, self.view.height * 0.5, self.view.width, self.view.height * 0.5 - 49)];
    bList.delegate = self;
    
    
    
    NSArray * colorArr = @[[UIColor purpleColor],[UIColor brownColor],[UIColor greenColor],[UIColor blueColor],[UIColor redColor],[UIColor grayColor]];
    for (int i = 0; i < 6; i++) {
        IconButton * btn = [IconButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:titleArr[i]] forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:colorArr[i] forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [bList addItemWith:btn];
    }
    [self.view addSubview:bList];
}

-(void)clickWithIndex:(NSInteger)index
{
    LoreInfoViewController * infoVC = [[LoreInfoViewController alloc]init];
    infoVC.cateIndex = index + 1;
    infoVC.navigationItem.title = titleArr[index];
    [self.navigationController pushViewController:infoVC animated:YES];
}


- (void)addRandomDataBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
    [btn setTitle:@"换一换" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(random) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, self.topView.y + self.topView.height + self.view.height * 0.015, self.topView.width, self.view.height * 0.07);
    [self.view addSubview:btn];
}

- (void)random
{
    [self reloadDataWithIndex:arc4random_uniform(6)];
}

- (void)addTopScrollView
{
    BHBCycleScrollView * topView = [[BHBCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.4) animationDuration:3];
    [self.view addSubview:topView];
    self.topView = topView;
    self.topView.showPageControll = YES;
}

- (void)reloadDataWithIndex:(NSInteger)index
{
    [LoreTool getLoreDataWithPage:1 andIndex:index andNum:5 andCompleteBlock:^(NSArray *lores) {
        if (lores.count <= 0) {
            return ;
        }
        self.topAdArray = nil;
        [self.topAdArray addObjectsFromArray:lores];
        self.topView.totalPagesCount = ^NSInteger(){
            return self.topAdArray.count;
        };
        self.topView.TapActionBlock = ^(NSInteger pageIndex){
            
            Lore * l = self.topAdArray[pageIndex];
            ShowViewController * show = [[ShowViewController alloc]init];
            [show loadDataWithObeject:l];
            [self presentViewController:show animated:YES completion:nil];
            
        };
        
        self.topView.fetchContentViewAtIndex = ^(NSInteger pageIndex){
            Lore * l = self.topAdArray[pageIndex];
            UIImageView * imgv = [[UIImageView alloc]initWithFrame:self.topView.bounds];
            [imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImagePath,l.img]]];
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.topView.height * 0.6, self.topView.width, self.topView.height * 0.4)];
            label.text = l.title;
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
            [imgv addSubview:label];
            return imgv;
        };
        [self.topView configContentViews];
    }];

}

@end
