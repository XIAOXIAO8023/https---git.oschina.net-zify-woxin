//
//  MyMobileServiceYNCustComplainHistoryListVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface MyMobileServiceYNCustComplainHistoryListVC : MyMobileServiceYNBaseVC<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>{
    
    MyMobileServiceYNHttpRequest *httpRequest;
}


@property (nonatomic,strong) NSArray *complainHistoryArray;


@end
