//
//  MyMobileServiceYNBaseVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-2-25.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNMBProgressHUD.h"
#import "ReturnMessageDeal.h"
#import "HTTPConfig.h"

@interface MyMobileServiceYNBaseVC : UIViewController
{
    MyMobileServiceYNMBProgressHUD *HUD;//等待框
    ReturnMessageDeal *returnMessageDeal;
}

-(void)setButtonBorder:(UIButton *)button;
-(void)presentWebVC:(UIViewController *)webVC animated:(BOOL)animated;
@end
