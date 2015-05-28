//
//  AccountTool.m
//  baomama
//
//  Created by bihongbo on 5/24/15.
//  Copyright (c) 2015 bb-coder. All rights reserved.
//

#import "AccountTool.h"
#import "SaveTool.h"


@implementation AccountTool

kSingletonImplements(AccountTool)

-(void)setUserId:(NSString *)userId
{
    _userId = userId;
    
    UIImage * image = [QRCodeGenerator qrImageForString:[NSString stringWithFormat:@"baomama%@",userId] imageSize:320];
    BBLog(@"%@",userId);
    [[SaveTool sharedSaveTool] saveImage:image forKey:@"MyQR"];
}

@end
