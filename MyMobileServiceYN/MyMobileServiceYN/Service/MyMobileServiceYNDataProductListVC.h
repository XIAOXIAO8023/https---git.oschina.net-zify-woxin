//
//  MyMobileServiceYNDataProductListVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-21.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"

@class MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNDataProductListVC : MyMobileServiceYNBaseVC<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    UITableView *dataProductListTableView;
    NSArray *productListArray;
    NSArray *canSelectArray;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    
    NSString *selectProductListItem;
}

@end
