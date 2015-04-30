//
//  RongCloudTool.m
//  baomama
//
//  Created by bihongbo on 15/4/9.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import "RongCloudTool.h"
#import "HttpTool.h"
#import "RCIM.h"
#import "AFNetworking.h"
#import "RongCloudHelper.h"

#define kRongCloudToken @"RongCloud_userToken"
#define kRongCloudApp_Key @"3argexb6r9uze"
#define kRongCloudApp_secret @"NjXWLZz6Omatt"

@implementation RongCloudTool

+ (void)getRUidWithUserId:(NSString *)userId andName:(NSString *)name andPortraintUri:(NSString *)url andBlock:(SuccessBlock)block
{
    
    if(!userId || [userId isEqualToString:@""])
        NSAssert(@"用户id不能为空",@"errorCode:1001");
    if(!name)
        name = @"";
    if (!url) {
        url = @"";
    }
    
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]init];
    NSString * nonce = [RongCloudHelper nonce];
    NSString * timestamp = [RongCloudHelper timestamp];
    
    [manager.requestSerializer setValue:kRongCloudApp_Key forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:[RongCloudHelper signatureWithAppSecret:kRongCloudApp_secret andNonce:nonce andTimestamp:timestamp] forHTTPHeaderField:@"Signature"];
    [manager POST:@"http://api.cn.rong.io/user/getToken.json" parameters:@{@"userId":userId,@"name":name,@"portraitUri":url} success:^(NSURLSessionDataTask *task, id responseObject) {
        if(block)
            block(responseObject[@"token"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error-:%@",error.description);
    }];
}

+(NSString *)rongCloud_userToken
{
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:kRongCloudToken];
    return token;
}

+ (void)loginWithUserId:(NSString *)userId andName:(NSString *)name andHeaderImageUrlStr:(NSString *)urlStr andBlock:(CompleteBlock)block
{
    [self getRUidWithUserId:userId andName:name andPortraintUri:urlStr andBlock:^(NSString *token) {
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:kRongCloudToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [RCIM connectWithToken:token completion:^(NSString *userId) {
        
            if (block) {
                block();
            }
        } error:^(RCConnectErrorCode status) {
            
        }];
    }];
    
}

@end
