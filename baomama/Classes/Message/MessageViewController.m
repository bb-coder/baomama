//
//  MessageViewController.m
//  baomama
//
//  Created by bihongbo on 15/4/8.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import "MessageViewController.h"
#import "UINavigationBar+BackGroudColor.h"
#import "ZBarSDK.h"
#import "ReaderQRViewController.h"
#import "ZBarReaderView.h"
#import "RCChatViewController.h"

@interface MessageViewController ()<ZBarReaderDelegate>



@end

@implementation MessageViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshChatListView];
    
}

-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    // 此处最终代码逻辑实现需要您从本地缓存或服务器端获取用户信息。
    
    [[FMDBTool queue] inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:@"select * from FRIENDS where userId = ?",userId];
        while (rs.next) {
            RCUserInfo * user = [[RCUserInfo alloc]init];
            user.userId = [rs stringForColumn:@"userId"];
            user.name = [rs stringForColumn:@"name"];
            [rs close];
            return completion(user);
        }
    }];
    return completion(nil);
}

-(NSArray *)getFriends
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    [[FMDBTool queue] inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:@"select * from FRIENDS"];
        while (rs.next) {
            RCUserInfo * user = [[RCUserInfo alloc]init];
            user.userId = [rs stringForColumn:@"userId"];
            user.name = [rs stringForColumn:@"name"];
            [array addObject:user];
        }
        [rs close];
    }];
    return array;
}

-(void)addChatController:(UIViewController *)controller
{
    RCChatViewController * chat = (RCChatViewController *)controller;
    [super addChatController:controller];
    chat.enablePOI = NO;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

//    生成二维码
//    [QRCodeGenerator qrImageForString:@"123" imageSize:100];
    
    [self setNavigationTitle:@"消息" textColor:[UIColor whiteColor]];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 75, 44);
    [btn setTitle:@"添加好友" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)addFriend
{

    
//    ZBarReaderViewController *reader = [[ZBarReaderViewController alloc] init];
//    reader.readerDelegate = self;
//    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//    
//    ZBarImageScanner *scanner = reader.scanner;
//    
//    [scanner setSymbology: ZBAR_I25
//                   config: ZBAR_CFG_ENABLE
//                       to: 0];
    ReaderQRViewController * reader = [[ReaderQRViewController alloc]init];
    
    [self presentViewController:reader animated:YES completion:nil];
}

//- (void) imagePickerController: (UIImagePickerController*) reader
// didFinishPickingMediaWithInfo: (NSDictionary*) info
//{
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        break;
//    
//    BBLog(@"%@",[info objectForKey: UIImagePickerControllerOriginalImage]);
//    [reader dismissViewControllerAnimated:YES completion:nil];
//    
//    NSLog(@"%@",symbol.data);
//    
//}





@end
