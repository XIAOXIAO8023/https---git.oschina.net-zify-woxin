//
//  MyMobileServiceYNViewController.h
//  MyMobileServiceYN
//
//  Created by CRMac on 14-3-11.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"

@class MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNCurrentExpenseVC: MyMobileServiceYNBaseVC<UIScrollViewDelegate,ASIHTTPRequestDelegate>{
    NSMutableArray *list;
    
    UIScrollView *scrollView;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    
    NSString *busiCode;
    NSInteger requestTime;
    
    NSArray *DetailArray;
}

@end
