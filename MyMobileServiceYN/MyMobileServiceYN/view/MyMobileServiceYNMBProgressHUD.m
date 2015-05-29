//
//  MyMobileServiceYNMBProgressHUD.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-5.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNMBProgressHUD.h"

@implementation MyMobileServiceYNMBProgressHUD

-(void)showTextHUDWithVC:(UIView *)view;
{
    if (HUD == nil) {
        //初始化进度框，置于当前的View当中
        HUD = [[MBProgressHUD alloc]initWithView:view];
        [view addSubview:HUD];
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.delegate = self;
        //小矩形的背景色
        HUD.color = [UIColor blackColor];//这儿表示无背景
        //显示的文字
        HUD.labelText = @"请稍后";
        //是否有庶罩
        //如果设置此属性则当前的view置于后台
        HUD.dimBackground = YES;
    }
    [HUD show:YES];
}
-(void)removeHUD
{
    if (HUD != nil)
    {
        [HUD removeFromSuperview];
        HUD = nil;
    }
}

@end
