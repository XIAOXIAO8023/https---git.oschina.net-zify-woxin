//
//  MyMobileServiceYNPackagesServiceDetailVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-28.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface MyMobileServiceYNPackagesServiceDetailVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,ASIHTTPRequestDelegate>
{
    UIScrollView *homeScrollView;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    NSString *busiCode;
    BOOL isOrder;
    
    NSInteger packageViewHeight;
    NSInteger packageViewCurrentHeight;
}

@property (retain,nonatomic)NSDictionary *productDetail;

@end
