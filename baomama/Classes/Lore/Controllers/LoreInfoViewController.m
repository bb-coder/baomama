//
//  LoreViewController.m
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "LoreInfoViewController.h"
#import "Lore.h"
#import "HttpTool.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "ShowViewController.h"
#import "MJRefresh.h"
#import "SaveTool.h"
#import "LoreTool.h"
#import "UINavigationBar+BackGroudColor.h"

#define kLabelFont [UIFont systemFontOfSize:14]
@interface LoreInfoViewController ()
{
    NSMutableArray * _loreArray;//常识数据集
    int  _page;//访问页数
    BOOL _isLoading;//是否正在加载
    UIColor * _colorState;//颜色状态
}
@end

@implementation LoreInfoViewController
#pragma mark 加载网络数据
- (void)loadHttpData
{
    _isLoading = YES;
    
    [LoreTool getLoreDataWithPage:_page andIndex:self.cateIndex andNum:20 andCompleteBlock:^(NSArray *lores) {
        if(lores.count <= 0) return ;
        if (_page == 1) {
            [_loreArray removeAllObjects];
        }
            [_loreArray addObjectsFromArray:lores];
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        _page ++;
        _isLoading = NO;
    }];
}
#pragma mark 实现通知方法
-(void)updateNightable
{
    [self viewWillAppear:NO];
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"nightable"]) {
        _colorState = [UIColor lightGrayColor];
        self.tableView.backgroundColor = [UIColor grayColor];
    }
    else
    {
        self.tableView.backgroundColor = [UIColor whiteColor];
        _colorState = [UIColor whiteColor];
    }
}
-(void)loadView
{
    [super loadView];
    _loreArray = [NSMutableArray array];

}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    if (_isLoading) {
        return;
    }
    _page = 1;
    [self loadHttpData];
}

- (void)footerRereshing
{
    [self loadHttpData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController setHidesBarsOnSwipe:YES];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -49, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    btn.frame = CGRectMake(0, 0, 70, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //加载refresh
    [self setupRefresh];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateNightable) name:@"nightable" object:nil];
    
}

-(void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -tableView数据源方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _loreArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * myCell = @"cell";
    SWTableViewCell * cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        NSMutableArray *rightUtilityButtons = [NSMutableArray array];
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                 title:@"收藏"];
//        [rightUtilityButtons addUtilityButtonWithColor:
//         [UIColor colorWithRed:204/255.0 green:204/255.0 blue:153/255.0 alpha:1.0f]
//                                                 title:@"分享"];
//        [rightUtilityButtons addUtilityButtonWithColor:
//         [UIColor colorWithRed:0/255.0 green:204/255.0 blue:255/255.0 alpha:1.0f]
//                                                 title:@"查看"];

        cell = [[SWTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell containingTableView:tableView indexPath:indexPath leftUtilityButtons:nil rightUtilityButtons:rightUtilityButtons];
        cell.imageView.layer.cornerRadius = 6;
        cell.imageView.layer.masksToBounds = YES;
        cell.textLabel.numberOfLines = 0;
        cell.imageView.frame = CGRectMake(0, 0, 100, 100);
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.delegate = self;
    }
    Lore * lore = _loreArray[indexPath.row];
    [cell.textLabel setText:lore.title];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImagePath,lore.img]];
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place.jpg"] options:SDWebImageLowPriority|SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType,NSURL *imageURL) {
        lore.image = image;
    }];
    cell.backgroundColor = _colorState;
    return cell;
}
#pragma mark - tableview代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        Lore * lore = _loreArray[indexPath.row];
        ShowViewController * sv = [[ShowViewController alloc]init];
        [sv loadDataWithObeject:lore];
        [self presentViewController:sv animated:YES completion:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
#pragma mark - SWTableViewDelegate
- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            NSString * title = nil;
            NSString * message = nil;
            NSString * btnTitle = nil;
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            Lore * lore = _loreArray[cellIndexPath.row];
            if ([[SaveTool sharedSaveTool] saveLore:lore forKey:@"lore"]){
                title = @"收藏成功";
                message = @"美女，您收藏成功了，可以去收藏查看您的最新收藏！";
                btnTitle = @"知道了";
            }
            else
            {
                title = @"收藏失败";
                message = @"囧，美女，这个您早就收藏过了！";
                btnTitle = @"知道了";
            }
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:btnTitle otherButtonTitles: nil];
            [alertTest show];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
//        case 1:
//        {
//            //分享
//            break;
//        }
        default:
            break;
    }
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    BOOL nightable = [[NSUserDefaults standardUserDefaults]boolForKey:@"nightable"];
//    UIColor * color;
//    if(nightable)
//    color = kBgNightColor;
//    else
//        color = kBgColor;
//    
//    CGFloat offSetY = scrollView.contentOffset.y;
//    if (offSetY < 0) {
//        CGFloat alpha = 1 - ((64 + offSetY) / 64);
//        if(alpha == 1){
//            [UIView animateWithDuration:0.25 animations:^{
//                CGRect frame = self.navigationController.navigationBar.frame;
//                frame.size.height = 0;
//                self.navigationController.navigationBar.frame = frame;
//            }];
//        }else
//        {
//            [UIView animateWithDuration:0.25 animations:^{
//                CGRect frame = self.navigationController.navigationBar.frame;
//                frame.size.height = 44;
//                self.navigationController.navigationBar.frame = frame;
//            }];
//            [self.navigationController.navigationBar bhb_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//        }
//        
//    }
//    else{
//        [self.navigationController.navigationBar bhb_setBackgroundColor:[color colorWithAlphaComponent:0]];
//    }
//}

@end
