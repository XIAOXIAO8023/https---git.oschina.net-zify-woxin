//
//  MyMobileServiceYNBroadbandAccountFourthVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-4-1.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"

@class  MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNBroadbandAccountFourthVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,UITextFieldDelegate,ASIHTTPRequestDelegate>
{
    UIScrollView *homeScrollView;
    MyMobileServiceYNHttpRequest *httpRequest;
}

@property (nonatomic, strong)NSMutableDictionary *broadBandDic;

@end
