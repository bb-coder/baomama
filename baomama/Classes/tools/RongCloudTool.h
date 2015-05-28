//
//  RongCloudTool.h
//  baomama
//
//  Created by bihongbo on 15/4/9.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRongCloudToken @"RongCloud_userToken"
#define kRongCloudApp_Key @"ik1qhw091e67p"
#define kRongCloudApp_secret @"Lkz7ImJ8XN"

typedef void (^SuccessBlock)(NSString * token);
typedef void (^CompleteBlock)();

@interface RongCloudTool : NSObject

+ (void)getRUidWithUserId:(NSString *)userId andName:(NSString *)name andPortraintUri:(NSString *)url andBlock:(SuccessBlock)block;

+ (void)loginWithUserId:(NSString *)userId andName:(NSString *)name andHeaderImageUrlStr:(NSString *)urlStr andBlock:(CompleteBlock)block;

+(NSString *)rongCloud_userToken;

@end
