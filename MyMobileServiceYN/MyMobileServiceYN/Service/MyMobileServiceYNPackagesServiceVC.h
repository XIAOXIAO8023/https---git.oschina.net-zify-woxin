//
//  MyMobileServiceYNPackagesServiceVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-28.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"

@interface MyMobileServiceYNPackagesServiceVC : MyMobileServiceYNBaseVC<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *dataProductListTableView;
    NSArray *productListArray;
    
//    MyMobileServiceYNHttpRequest *httpRequest;
//    NSMutableDictionary *requestBeanDic;
    
    NSString *selectProductListItem;
}


@end
