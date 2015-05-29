//
//  LNSideViewController.h
//  LNSideViewController
//
//  Created by 陆楠 on 14/12/1.
//  Copyright (c) 2014年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalDef.h"
#import "MyMobileServiceYN10086SupportVC.h"
#import "MyMobileServiceYNAboutUSVC.h"
#import "MyMobileServiceYNChangeThemeVC.h"
#import "MyMobileServiceYNLoginVC.h"
#import "MyMobileServiceYNRechargeVC.h"
#import "MyMobileServiceYNAppRecommendVC.h"
#import "MyMobileServiceYNCustomerServiceVC.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNBaseVC.h"


@interface LNSideViewController : MyMobileServiceYNBaseVC<UIScrollViewDelegate,UIAlertViewDelegate>
{
    UIView *rootView;
    UIScrollView *mainScrollView;
}

@property (nonatomic ,retain) UIViewController *contentView; //右侧的View
@property (nonatomic ,retain) UIViewController *leftSideView;//左侧的View
@property (nonatomic) CGFloat scale;//放缩比例
@property (nonatomic , copy) UIImage *backgroundImage;//背景图片
@property (nonatomic) CGFloat rightViewGap;//右侧边距
@property (nonatomic) CGFloat rightGap;
@property (nonatomic ,retain) UINavigationController *contentNav;//右侧的navigationcontroller

-(instancetype)initWithLeftSideView:(UIViewController *)leftSideView contentView:(UIViewController *)contentView scale:(CGFloat)scale backgroundImage:(UIImage *)backgroundImage;//初始化方法

@end