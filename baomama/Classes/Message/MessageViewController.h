//
//  MessageViewController.h
//  baomama
//
//  Created by bihongbo on 15/4/8.
//  Copyright (c) 2015年 bb-coder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCIM.h"
#import "RCChatListViewController.h"

@interface MessageViewController : RCChatListViewController<RCIMUserInfoFetcherDelegagte,RCIMFriendsFetcherDelegate>
-(NSArray *)getFriends;
-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion;
@end
