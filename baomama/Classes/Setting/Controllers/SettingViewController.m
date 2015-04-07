//
//  SettingViewController.m
//  baomama
//
//  Created by bb_coder on 14-8-16.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "SettingViewController.h"
#import "WBNavigationController.h"
#import <StoreKit/StoreKit.h>

@interface SettingViewController ()<SKStoreProductViewControllerDelegate>
{
    UITextView * _textView;//免责声明
    UIColor * _colorState;//颜色状态
}
@end

@implementation SettingViewController
#pragma mark 实现通知方法
-(void)updateNightable
{
    [self viewWillAppear:NO];
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"nightable"]) {
        self.tableView.backgroundColor = [UIColor lightGrayColor];
        _colorState = [UIColor lightGrayColor];
    }
    else
    {
        self.tableView.backgroundColor = [UIColor whiteColor];
        
        _colorState = [UIColor whiteColor];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"设置"];
    self.tableView.scrollEnabled = NO;
    _textView = [[UITextView alloc]init];
    _textView.text = @"\n\n\n\n          免责声明 单击此页面可退出\n任何使用本手机客户端的的用户均应仔细阅读本声明，用户可选择不使用本手机端系统，用户使用本手机客户端的行为将被视为对本声明全部内容的认可。\n“宝妈妈”是一个公共的免费苹果应用分享，旨在为广大的已经是妈妈的和即将成为妈妈和有愿望成为妈妈的女性朋友提供有用的信息。\n“宝妈妈”仅为用户提供常识和食谱类信息，“宝妈妈”上的信息及相关资料均由用户在医药吧网站上传时填写和上传，或者由第三方提供。“宝妈妈”仅可能会对其文字内容在尊重原意的前提下进行编辑,本客户端所用图片非原创全部著名了出处。\n“宝妈妈”一贯高度重视知识产权保护并遵守中华人民共和国各项知识产权法律、法规和具有约束力的规范性文件。本客户端坚决反对任何违反中华人民共和国有关著作权的法律法规的行为。由于我们无法对用户上传到服务器的所有信息进行充分的监测，我们制定了旨在保护知识产权权利人合法权益的措施和步骤，当著作权人和/或依法可以行使信息网络传播权的权利人（以下简称“权利人“）发现“宝妈妈”上用户上传或者第三方内容侵犯其信息网络传播权时，权利人应事先向“宝妈妈”发出权利通知，“宝妈妈”将根据相关法律规定采取措施删除或修改相关内容。具体措施和步骤如下：\n如果阁下是某一资料或图片的著作权人和/或依法可以行使信息网络传播权的权利人，且您认为“宝妈妈”上用户上传或第三方提供的内容侵犯了您对该等作品的信息网络传播权，请阁下务必书面通知或联系“宝妈妈”，阁下应对书面通知陈述之真实性负责。\n为方便“宝妈妈”及时处理阁下之意见，请先准备以下内容：\n•--阁下的名称（姓名）、联系方式及地址；\n•--要求删除的资源的名称和描述；\n•--构成侵权地初步证明材料，谨此提示以下材料可能构成初步证明。\n对于涉嫌侵权作品拥有著作权或依法可以行使信息网络传播权的权属证明；对涉嫌侵权作品侵权事实的举证。\n联系邮箱：bbcoderios@gmail.com\n“宝妈妈”会认真协助您处理相关事宜，期待带给您良好的用户体验。";
    _textView.editable = NO;
    _textView.font = [UIFont systemFontOfSize:16];
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateNightable) name:@"nightable" object:nil];
    
    
    
}

#pragma mark - tableView数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    UISwitch * sw = [[UISwitch alloc]init];
    sw.On = [[NSUserDefaults standardUserDefaults]boolForKey:@"nightable"];
    cell.backgroundColor = _colorState;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"夜间模式";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryView = sw;
            [sw addTarget:self action:@selector(nightable:) forControlEvents:UIControlEventValueChanged];
            break;
        case 1:
            cell.textLabel.text = @"回馈评论";
            break;
        case 2:
            cell.textLabel.text = @"免责声明";
            break;
        default:
            break;
    }
    return cell;
    
}
#pragma mark 监听夜间模式点击
- (void) nightable:(UISwitch *) sw
{
    if (sw.isOn) {
        //夜间模式
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"nightable"];
    }
    else
    {
        //取消夜间模式
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"nightable"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"nightable" object:nil];
}
#pragma mark tableview代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            [self evaluate];
            break;
        case 2:
            _textView.frame = self.view.bounds;
            [_textView addGestureRecognizer:tap];
            [self.view addSubview:_textView];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 返回按钮
-(void) back
{
    [_textView removeFromSuperview];
}

#pragma mark 评论
- (void)evaluate{
    
    //初始化控制器
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    //设置代理请求为当前控制器本身
    storeProductViewContorller.delegate = self;
    //加载一个新的视图展示
    [storeProductViewContorller loadProductWithParameters:
     //appId
     @{SKStoreProductParameterITunesItemIdentifier : @"912225653"} completionBlock:^(BOOL result, NSError *error) {
         //block回调
         if(error){
             BBLog(@"error");
         }else{
             //模态弹出AppStore应用界面
             [self presentViewController:storeProductViewContorller animated:YES completion:^{
                 
             }
              ];
         }
     }];
}

//取消按钮监听方法
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
