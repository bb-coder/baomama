//
//  FullBgImage.m
//  baomama
//
//  Created by bb_coder on 14-8-16.
//  Copyright (c) 2014年 bb-coder. All rights reserved.
//

#import "FullBgImage.h"

@implementation FullBgImage
+(UIImage *)bgImage
{
    UIImage * image = nil;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"nightable"]) {
        image = [UIImage imageNamed:@"bg_night.jpg"];
    }
    else
    image = [UIImage imageNamed:@"bg_day.jpg"];
    return image;
}
@end
