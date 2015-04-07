//
//  DiningViewController.m
//  baomama
//
//  Created by bb_coder on 14-8-16.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "RecipesViewController.h"
#import "HttpTool.h"
#import "Recipes.h"
#import "UIImageView+WebCache.h"
#import "WaterFlowCellView.h"
#import "ShowViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SaveTool.h"
#import "MBProgressHUD.h"
@interface RecipesViewController ()<UIWebViewDelegate>
{
    int _index;//顶级分类索引
}
//食谱数据集合
@property (nonatomic,strong) NSMutableArray * diningArray;
//当前访问页数
@property (nonatomic,assign) int page;
//顶级分类
@property (nonatomic,strong) NSArray * cateArray;
//加载网路数据状态
@property (nonatomic,assign) BOOL isLoadingData;
@end

@implementation RecipesViewController
#pragma mark 加载顶级分类
- (void)loadCookCate
{
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"cookCate" withExtension:@"plist"];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfURL:url];
    _cateArray = dict[@"yi18"];
    _index = 0;
}

- (void)loadHttpData
{
    if (_isLoadingData) {
        return;
    }
    static int i = 0;
    self.isLoadingData = YES;
    if (_diningArray == nil) {
        _diningArray = [NSMutableArray array];
    }
    [HttpTool postWithPath:kCookPath params:
     @{
       @"page":@(_page),@"limit":@(20),@"type":@"id",@"id":_cateArray[_index][@"id"]
       }
                   success:^(id JSON)
     {
         NSArray * array = JSON[@"yi18"];
         for (NSDictionary *dict in array) {
             Recipes * recipes = [[Recipes alloc]initWithDict:dict];
             [HttpTool getWithPath:kCookShowPath params:@{@"id":recipes.no} success:^(id JSON) {
                 NSDictionary * dict = JSON[@"yi18"];
                 recipes.message = dict[@"message"];
             } failure:^(NSError *error) {
             }];
             [_diningArray addObject:recipes];
         }
         if (array.count > 0)
         {
             i--;
         }
         else{
             i++;
             if (i > 1000) {
                 [[[UIAlertView alloc]initWithTitle:@"网络错误" message:@"美女您的网络不太好哇～" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                 i = 0;
                 self.isLoadingData = NO;
                 return ;
             }
             if (_index < 9) {
                 _index++;
                 _page = 1;
             }
            
         }
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         [self.waterFlowView reloadData];
         self.isLoadingData = NO;
         _page++;
     }
                   failure:^(NSError *error) {
                       i++;
                       if (i > 1000) {
                           [[[UIAlertView alloc]initWithTitle:@"网络错误" message:@"美女您的网络不太好哇～" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                           i = 0;
                           self.isLoadingData = NO;
                           return ;
                       }
                       if (_index < 9) {
                           _index++;
                           _page = 1;
                       }
                       
                       self.isLoadingData = NO;
                       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                       [self.waterFlowView reloadData];
                       [self loadHttpData];
                       
                   }];
    
}

-(void)loadView
{
    [super loadView];
    //加载顶级分类
    [self loadCookCate];
    _page = 1;
    //加载网络数据
    [self loadHttpData];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置顶部20像素距离，空出状态栏
    if (iPhone7)
        [self.waterFlowView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    //定义指示器
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在努力加载...";
    hud.dimBackground = YES;
    
}


#pragma -waterFlow数据源方法
#pragma mark 瀑布列数
-(NSInteger)numberOfColmnsInWaterFlowView:(WaterFlowView *)waterFlowView
{
    return 1;
}
#pragma mark 瀑布行数
-(NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColmns:(NSInteger)colmns
{
    return _diningArray.count;
}

#pragma mark 瀑布流单元格
-(WaterFlowCellView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reCell = @"cell";
    WaterFlowCellView * cell = [waterFlowView dequeueReusableCellWithIdentifier:reCell];
    __weak typeof(WaterFlowCellView) *weakCell = cell;
    if (cell == nil) {
        cell = [[WaterFlowCellView alloc]initWithReuseIdentifier:reCell];
    }
    __weak Recipes * recipes = _diningArray[indexPath.row];
    cell.turnImage = nil;
    cell.textLabel.text = recipes.name;
    cell.isTurn = NO;
    //异步加载图像
    NSURL * url = [NSURL URLWithString:[kBaseImagePath stringByAppendingString:recipes.img]];
    //    [cell.imageView setImageWithURL:url];
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place.jpg"] options:SDWebImageLowPriority | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType,NSURL *imageURL) {
        recipes.image = image;
        weakCell.imageView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            weakCell.imageView.alpha = 1;
        }];
    }];
    return cell;
}
-(CGFloat) waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Recipes * recipes = _diningArray[indexPath.row];
    return recipes.w;
}

#pragma mark 刷新网络数据
-(void)waterFlowViewRefreshData:(WaterFlowView *)waterFlowView
{
    if (self.isLoadingData) {
        return;
    }
    [self loadHttpData];
    
}

#pragma mark 监听瀑布流点击
-(void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath waterFlowViewCell:(WaterFlowCellView *)cell
{
    CATransition * anim = [CATransition animation];
    anim.type = @"oglFlip";
    [cell.imageView.layer addAnimation:anim forKey:nil];
    if (!cell.isTurn) {
        cell.turnImage = cell.imageView.image;
        cell.imageView.image = [UIImage imageNamed:@"turn"];
        cell.isTurn = YES;
    }
    else
    {
        if (cell.isClickLeft) {
            NSString * title = nil;
            NSString * message = nil;
            NSString * btnTitle = nil;
            Recipes * recipes = _diningArray[indexPath.row];
            if ([[SaveTool sharedSaveTool] saveRecipes:recipes forKey:@"recipes"]){
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
        }
        else
        {
            Recipes * recipes = _diningArray[indexPath.row];
            ShowViewController * sv = [[ShowViewController alloc]init];
            [self presentViewController:sv animated:YES completion:nil];
            [HttpTool getWithPath:kCookShowPath params:@{@"id":recipes.no} success:^(id JSON) {
                NSDictionary * dict = JSON[@"yi18"];
                recipes.food = dict[@"food"];
                recipes.message = dict[@"message"];
                [sv loadDataWithObeject:recipes];
            } failure:^(NSError *error) {
                
            }];
        }
        cell.imageView.image = cell.turnImage;
        cell.turnImage = nil;
        cell.isTurn = NO;
    }
}
@end
