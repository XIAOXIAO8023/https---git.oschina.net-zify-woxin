//
//  MyMobileServiceYNPackageOverDetailInfoVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"

@class MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNPackageOverDetailInfoVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,ASIHTTPRequestDelegate>
{
    UIScrollView *homeScrollView;
    UIScrollView *DetailScrollView;
    
    
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    
    UIButton *leftButton;
    UIButton *centerButton;
    UIButton *rightButton;
    NSMutableArray *buttonTitleArray;
    NSInteger buttonId;
    NSArray *array;
    
    int scrollCount;            // 滚动次数
    float lastScrollX;          // 最后一次滚动的x坐标
}

@end
