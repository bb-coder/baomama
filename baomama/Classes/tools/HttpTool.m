//
//  HttpTool.m
//  baomama
//
//  Created by bb_coder on 14-8-20.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "HttpTool.h"
#import "RongCloudHelper.h"

@implementation HttpTool
+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method andRongCloud:(BOOL)isRongCloud
{
    // 1.创建post请求
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kBasePath]];
    
    if(isRongCloud){
        NSString * nonce = [RongCloudHelper nonce];
        NSString * timestamp = [RongCloudHelper timestamp];
        
    [manager.requestSerializer setValue:@"pwe86ga5el9r6" forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:[RongCloudHelper signatureWithAppSecret:@"INkARB3bsFW9" andNonce:nonce andTimestamp:timestamp] forHTTPHeaderField:@"Signature"];
    }
    
    if([method isEqualToString:@"POST"])
    {
        [manager POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success == nil) return;
            success(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure == nil) return;
            failure(error);
        }];
    }
    else if([method isEqualToString:@"GET"])
    {
        [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success == nil) return;
            success(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure == nil) return;
            failure(error);
        }];
    }
}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params success:success failure:failure method:@"POST" andRongCloud:NO];
}

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params success:success failure:failure method:@"GET" andRongCloud:NO];
}

+ (void)rongCloudUserWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params success:success failure:failure method:@"POST" andRongCloud:YES];
}

@end
