//
//  ViewController.h
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZNSegmentedControl.h"
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MarketPackageV.h"
@class PackageButton;

@interface MarketVC : MyMobileServiceYNBaseVC<DZNSegmentedControlDelegate,ASIHTTPRequestDelegate,MarketPackageVDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *jifenScrollView;
    
    UIView *buttonV;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    
    NSString *busiCode;
    
    PackageButton *currentB;
    
    UIWebView *web;
}

@end

