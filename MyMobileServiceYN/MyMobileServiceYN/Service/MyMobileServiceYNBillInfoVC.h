//
//  MyMobileServiceYNBillInfoVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-6.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"

@class PNBarChart,MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNBillInfoVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,ASIHTTPRequestDelegate>
{
    UIScrollView *homeScrollView;
    UIScrollView *DetailScrollView;
//    UIView *billMonthView;//账单月份展示及选择视图
//    UIView *billAmountView;//账单总额
    
    UIScrollView *billView;
    PNBarChart * barChart;
    UIButton *sixMonthButton;
    
    UIView *pressedView;
    UIButton *leftButton;
    UIButton *centerButton;
    UIButton *rightButton;
    NSArray *buttonTitleArray;
    NSArray *titleArray;
    
    NSInteger buttonId;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    
    NSInteger cycleNum;
    
    NSMutableArray *billAllInfoArray;
    
    UIAlertView *onlyAlertView;
}

@end
