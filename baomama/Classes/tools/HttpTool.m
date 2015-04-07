//
//  HttpTool.m
//  baomama
//
//  Created by bb_coder on 14-8-20.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool
+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method
{
    // 1.创建post请求
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kBasePath]];
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    // 拼接传进来的参数
    if (params) {
        [allParams setDictionary:params];
    }
    
    NSURLRequest *request = [client requestWithMethod:method path:path parameters:allParams];
    
    // 2.创建AFJSONRequestOperation对象
    NSOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
        {
            if (success == nil) return;
                success(JSON);
        }
        failure :
        ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
        {
            if (failure == nil) return;
                failure(error);
        }];
    // 3.发送请求
    [op start];
}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params success:success failure:failure method:@"POST"];
}

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params success:success failure:failure method:@"GET"];
}
@end
