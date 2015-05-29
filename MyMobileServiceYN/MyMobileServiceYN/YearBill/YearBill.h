//
//  ViewController.h
//  YearBill
//
//  Created by 陆楠 on 15/2/9.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FirstView;
@class SecondView;
@class ThirdView;
@class ForthView;
@class FifthView;
#import "SixthView.h"
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNParam.h"

@interface YearBillVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,PushViewDelegate,ASIHTTPRequestDelegate>
{
    UIScrollView *mainScrollView;
    
    FirstView *firstView;
    SecondView *secondView;
    ThirdView *thirdView;
    ForthView *forthView;
    FifthView *fifthView;
    SixthView *sixthView;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    
    NSString *busiCode;
}

@end

