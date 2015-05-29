//
//  MyMobileServiceYNLoginVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-5.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"

@class MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNLoginVC : MyMobileServiceYNBaseVC<UITextFieldDelegate,ASIHTTPRequestDelegate>
{
    UIView *loginView;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    NSString *busiCode;
    BOOL isDynamic;
}

@end
