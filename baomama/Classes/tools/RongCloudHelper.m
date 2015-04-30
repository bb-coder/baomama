//
//  RongCloudHelper.m
//  baomama
//
//  Created by bihongbo on 15/4/9.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import "RongCloudHelper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation RongCloudHelper

kSingletonImplements(RongCloudHelper)

+(NSString *)nonce
{
    u_int32_t randNumber = arc4random_uniform(INT32_MAX);
    return [NSString stringWithFormat:@"%d",randNumber];
}

+(NSString *)timestamp
{
    NSTimeInterval ts = [[NSDate date] timeIntervalSince1970];
    NSLog(@"%@",[NSString stringWithFormat:@"%f",ts]);
    return [NSString stringWithFormat:@"%f",ts];
}

+(NSString *)signatureWithAppSecret:(NSString *)secret andNonce:(NSString *)nonce andTimestamp:(NSString *)timeStamp
{
    NSString * wantSha1 = [NSString stringWithFormat:@"%@%@%@",secret,nonce,timeStamp];
    
    return [self sha1:wantSha1];
}


+(NSString *)sha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    NSLog(@"sha1String--:%@",output);
    return output;
}


@end
