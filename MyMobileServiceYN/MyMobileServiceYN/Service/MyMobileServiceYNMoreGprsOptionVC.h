//
//  MyMobileServiceYNMoreGprsOption.h
//  MyMobileServiceYN
//
//  Created by CRMac on 14-3-14.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"

@class MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNMoreGprsOptionVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate, ASIHTTPRequestDelegate>
{
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
}

@property (nonatomic,strong)NSMutableArray *arrayWithPackage;
@property NSInteger pageTag;

@end
