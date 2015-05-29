//
//  MyMobileServiceYNPackageOverInfoVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"

@class MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNPackageOverInfoVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *homeScrollView;
    UITableView *homeTableView;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    
    NSMutableArray *totleArray;
}

@end
