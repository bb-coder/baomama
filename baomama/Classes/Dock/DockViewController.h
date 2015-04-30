//
//  DockViewController.h
//  baomama
//
//  Created by bb_coder on 14-8-15.
//  Copyright (c) 2014年 bb_coder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dock.h"
@interface DockViewController : UITabBarController<DockDelegate>
{
    Dock * _dock;
}

//#pragma mark dock代理方法
//-(void)dockItemClick:(Dock *)dock from:(int)from to:(int)to;
@end
