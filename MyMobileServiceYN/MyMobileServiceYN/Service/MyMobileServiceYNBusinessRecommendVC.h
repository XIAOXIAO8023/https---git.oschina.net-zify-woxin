//
//  MyMobileServiceYNBusinessRecommendVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-4-30.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"
#import "MyMobileServiceYNHttpRequest.h"

@interface MyMobileServiceYNBusinessRecommendVC : MyMobileServiceYNBaseVC< UIScrollViewDelegate,ASIHTTPRequestDelegate>
{
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    UIScrollView *homeScrollView;
    NSString *pressedButtoTag;
    NSString *result;
}

@end
