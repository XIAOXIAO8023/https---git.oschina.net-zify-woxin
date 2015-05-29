//
//  MyMobileServiceYNCustComplainHistoryDetailVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface MyMobileServiceYNCustComplainHistoryDetailVC : MyMobileServiceYNBaseVC<ASIHTTPRequestDelegate>{
    UIScrollView *homeScrollView;
    NSString *busiCode;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *complainDetailInfo;
    
    NSInteger complainDetailHeight;
    NSInteger complainDetailCurrentHeight;
}


@property (nonatomic,strong) NSString *sheetNumber;

@end
