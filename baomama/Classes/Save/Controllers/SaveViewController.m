//
//  SaveViewController.m
//  baomama
//
//  Created by bb_coder on 14-8-16.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "SaveViewController.h"
#import "Lore.h"
#import "Recipes.h"
#import "SaveTool.h"
#import "UIImageView+WebCache.h"
#import "ShowViewController.h"
#define kLabelFont [UIFont systemFontOfSize:14]
@interface SaveViewController ()
{
    NSMutableArray * _loreArray;//常识数组
    NSMutableArray * _recipesArray;//菜谱数组
    UIColor * _colorState;//颜色状态
}
@end

@implementation SaveViewController
-(void)updateNightable
{
    [self viewWillAppear:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"nightable"]) {
        _colorState = [UIColor lightGrayColor];
        self.tableView.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        self.tableView.backgroundColor = [UIColor whiteColor];
        _colorState = [UIColor whiteColor];
    }
    _loreArray = [NSMutableArray arrayWithArray:[[SaveTool sharedSaveTool] getDataArrayFromKey:@"lore"]];
    _recipesArray = [NSMutableArray arrayWithArray:[[SaveTool sharedSaveTool] getDataArrayFromKey:@"recipes"]];
    if (!_loreArray) {
        _loreArray = [NSMutableArray array];
    }
    if (!_recipesArray) {
        _recipesArray = [NSMutableArray array];
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"收藏"];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateNightable) name:@"nightable" object:nil];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
}


#pragma mark -tableView数据源方法
#pragma mark 分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark 每组的标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? @"常识" : @"食谱";
}

#pragma mark 每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return section == 0 ? _loreArray.count : _recipesArray.count;
}

#pragma mark 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * loreCell = @"loreCell";
    static NSString * repicesCell = @"repicesCell";
    SWTableViewCell * cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:loreCell];
        if (cell == nil) {
            NSMutableArray *rightUtilityButtons = [NSMutableArray new];
//            [rightUtilityButtons addUtilityButtonWithColor:
//             [UIColor colorWithRed:204/255.0 green:204/255.0 blue:153/255.0 alpha:1.0f]
//                                                     title:@"分享"];
            [rightUtilityButtons addUtilityButtonWithColor:
             [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                     title:@"删除"];
            cell = [[SWTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:loreCell containingTableView:tableView indexPath:indexPath leftUtilityButtons:nil rightUtilityButtons:rightUtilityButtons];
            cell.imageView.layer.cornerRadius = 6;
            cell.imageView.layer.masksToBounds = YES;
            cell.textLabel.numberOfLines = 0;
            cell.imageView.frame = CGRectMake(0, 0, 100, 100);
            cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
            cell.delegate = self;
        }
        Lore * lore = _loreArray[indexPath.row];
        cell.imageView.image = lore.image;
        [cell.textLabel setText:lore.title];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:repicesCell];
        if (cell == nil) {
            NSMutableArray *rightUtilityButtons = [NSMutableArray new];
//            [rightUtilityButtons addUtilityButtonWithColor:
//             [UIColor colorWithRed:204/255.0 green:204/255.0 blue:153/255.0 alpha:1.0f]
//                                                     title:@"分享"];
            [rightUtilityButtons addUtilityButtonWithColor:
             [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                     title:@"删除"];
            cell = [[SWTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:loreCell containingTableView:tableView indexPath:indexPath leftUtilityButtons:nil rightUtilityButtons:rightUtilityButtons];
            
            cell.imageView.layer.cornerRadius = 6;
            cell.imageView.layer.masksToBounds = YES;
            cell.textLabel.numberOfLines = 0;
            cell.imageView.frame = CGRectMake(0, 0, 100, 100);
            cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
            cell.delegate = self;
        }
        Recipes * recipes = _recipesArray[indexPath.row];
        cell.imageView.image = recipes.image;
        [cell.textLabel setText:recipes.name];
    }
    cell.backgroundColor = _colorState;
    return cell;
}

#pragma mark 每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark tableView代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Lore * lore = _loreArray[indexPath.row];
        ShowViewController * sv = [[ShowViewController alloc]init];
        [sv loadDataWithObeject:lore];
        [self presentViewController:sv animated:YES completion:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else
    {
        Recipes * recipes = _recipesArray[indexPath.row];

        ShowViewController * sv = [[ShowViewController alloc]init];
        [sv loadDataWithObeject:recipes];
        [self presentViewController:sv animated:YES completion:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - SWTableViewDelegate
- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
//        case 1:
//        {
//            //分享
//            
//            [cell hideUtilityButtonsAnimated:YES];
//            break;
//        }
        case 0:
        {
            // Delete button was pressed
                        NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            if (cellIndexPath.section == 0) {
                [[SaveTool sharedSaveTool] deleteLore:_loreArray[cellIndexPath.row] forKey:@"lore"];
                [_loreArray removeObjectAtIndex:cellIndexPath.row];
            }
            else
            {
                [[SaveTool sharedSaveTool] deleteRecipes:_recipesArray[cellIndexPath.row] forKey:@"recipes"];
                [_recipesArray removeObjectAtIndex:cellIndexPath.row];
            }
                        [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}

@end
