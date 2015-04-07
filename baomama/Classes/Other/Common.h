//
//  Common.h
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//
//
//自定义日志输出
#ifdef DEBUG
#define BBLog(...) NSLog(__VA_ARGS__)
#else
#define BBLog(...)
#endif
//定义主题颜色
#define kBgColor [UIColor colorWithRed:255/255.0 green:228/255.0 blue:225/255.0 alpha:1]

#define kBgNightColor [UIColor colorWithRed:51/255.0 green:102/255.0 blue:153/255.0 alpha:1]