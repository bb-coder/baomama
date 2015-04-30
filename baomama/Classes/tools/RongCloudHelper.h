//
//  RongCloudHelper.h
//  baomama
//
//  Created by bihongbo on 15/4/9.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface RongCloudHelper : NSObject

kSingletonInterface(RongCloudHelper)


+(NSString *)nonce;

+(NSString *)timestamp;

+(NSString *)signatureWithAppSecret:(NSString *)secret andNonce:(NSString *)nonce andTimestamp:(NSString *)timeStamp;

@end
