//
//  IconButton.m
//  sugarusers
//
//  Created by bihongbo on 4/29/15.
//  Copyright (c) 2015 HSDT. All rights reserved.
//

#import "IconButton.h"


@implementation IconButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width * 0.2, (contentRect.size.height - contentRect.size.width * 0.6)*0.5 - contentRect.size.height * 0.1, contentRect.size.width * 0.6, contentRect.size.width * 0.6);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height * 0.75, contentRect.size.width, contentRect.size.height * 0.2);
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

@end
