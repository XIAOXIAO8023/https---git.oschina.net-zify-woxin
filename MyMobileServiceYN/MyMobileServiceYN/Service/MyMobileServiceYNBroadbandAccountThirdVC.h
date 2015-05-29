//
//  MyMobileServiceYNBroadbandAccountThirdVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-4-1.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"

@class  MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNBroadbandAccountThirdVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,UITextFieldDelegate>
{
    UIScrollView *homeScrollView;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    UIButton *nextButton;
    
    NSString *custName;
    NSString *idNumber;
    NSString *contactPhone;
}

@property (nonatomic ,strong) NSDictionary *rowData;
@property (nonatomic ,strong) NSMutableDictionary *broadBandDic;

@end
