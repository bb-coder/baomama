//
//  AccountTool.h
//  baomama
//
//  Created by bihongbo on 5/24/15.
//  Copyright (c) 2015 bb-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountTool : NSObject

kSingletonInterface(AccountTool)


@property (copy, nonatomic) NSString * name;

@property (copy, nonatomic) NSString * userId;

@property (copy, nonatomic) NSString * img;

@end
