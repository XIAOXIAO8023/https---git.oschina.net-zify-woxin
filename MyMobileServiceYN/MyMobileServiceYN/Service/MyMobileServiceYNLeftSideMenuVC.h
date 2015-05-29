//
//  MyMobileServiceYNLeftSideMenuVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-3.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface MyMobileServiceYNLeftSideMenuVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>
{
    UIScrollView *homeScrollView;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSString *busiCode;
    NSString *downLoadUrl;
    
}


@end
