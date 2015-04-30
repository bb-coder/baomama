//
//  ShowViewController.m
//  baomama
//
//  Created by bb_coder on 14-8-22.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "ShowViewController.h"
#import "HttpTool.h"
#import "Recipes.h"
#import "Lore.h"
@interface ShowViewController ()
{
    UIImageView * _imageView;
    UIWebView * _webView;
}
@end

@implementation ShowViewController
-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark 加载Show视图数据
-(void)loadDataWithObeject:(id)object
{
    
    if ([object isKindOfClass:[Recipes class]]) {
        Recipes * recipes = object;
        _webView = [[UIWebView alloc]init];
        [_webView loadHTMLString:recipes.message baseURL:nil];
        CGFloat y = 0;
        if (iPhone7) {
            y += 20;
        }
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, 320, 200);
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBaseImagePath,recipes.img]];
        if (recipes.image) {
            [_imageView setImage:recipes.image];
        }
        else
            [_imageView sd_setImageWithURL:url];
        _webView.frame = CGRectMake(0, y + 200, self.view.frame.size.width, self.view.frame.size.height - 200 -y);
        UIScrollView * scroll = [_webView subviews][0];
        scroll.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_imageView];
        [self.view addSubview:_webView];
    }
    else if([object isKindOfClass:[Lore class]])
    {
        Lore * lore = object;
        _webView = [[UIWebView alloc]init];
        [_webView loadHTMLString:lore.message baseURL:nil];
        CGFloat y = 0;
        if (iPhone7) {
            y += 20;
        }
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, 320, 200);
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBaseImagePath,lore.img]];
        if (lore.image) {
            [_imageView setImage:lore.image];
        }
        else
            [_imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place.jpg"]];
        _webView.frame = CGRectMake(0, y + 200, self.view.frame.size.width, self.view.frame.size.height - 200 -y);
        UIScrollView * scroll = [_webView subviews][0];
        scroll.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_imageView];
        [self.view addSubview:_webView];
    }
    [_imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(save:)];
    [_imageView addGestureRecognizer:tap];
}
-(void) save:(UISwipeGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark webview下scrollview代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    if(y < 0)
    {
        _imageView.transform = CGAffineTransformMakeScale(1.0f - y/100, 1.0f - y/100);
    }
}
@end
