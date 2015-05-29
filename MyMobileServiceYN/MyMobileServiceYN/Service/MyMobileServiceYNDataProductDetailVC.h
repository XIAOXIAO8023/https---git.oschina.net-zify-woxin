//
//  MyMobileServiceYNDataProductDetailVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-21.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"

@class MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNDataProductDetailVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,ASIHTTPRequestDelegate>
{
    UIScrollView *homeScrollView;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    NSString *busiCode;
    BOOL isOrder;
}

@property (retain,nonatomic)NSDictionary *productDetail;

@end
