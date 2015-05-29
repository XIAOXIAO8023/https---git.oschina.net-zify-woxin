//
//  MyMobileServiceYNHomeVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-2-25.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"
#import "GrayPageControl.h"
#import "CycleScrollView.h"
#import "DZNSegmentedControl.h"
#import "WaterBallView.h"


typedef enum : NSUInteger {
    UserInfoTypeFee,//话费
    UserInfoTypeFlow,//流量
    UserInfoTypeWlan,//wlan
} UserInfoType;

@class MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNHomeVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate,DZNSegmentedControlDelegate>
{
    UIScrollView *homeScrollView;
    UIScrollView *tabBarScrollView;
    UIScrollView *userInfoScrollView;
    UIPageControl *tabBarPageControl;
    
    UIView *UserInfoView;
    
    BOOL isRefreshMenu;
    
    NSString *menuListFielPath;
    NSMutableDictionary *menuListDicSandbox;
    NSMutableArray *menuListArray;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    
    NSString *busiCode;
    
    BOOL isCurrentMonthCostRequest;
    BOOL isCurrentCost;
    
    int menuWidthCount;
    
    UIButton *sideRightMenuButton;
    
    UIView *guessYourLoveView;
    
    UIImageView *logoImageView;
    UIButton *toCloseButton;
    
    NSInteger ImageNum;
    int viewLoadCount;
    int currPage;
    
    //首页数据
    NSMutableArray *hotArray;//火热活动
    NSMutableArray *phoneArray;//手机商城
    NSMutableArray *taskArray;//任务专区
    BOOL isShowGprs;
    BOOL isShowWlan;
    NSMutableDictionary *gprsDic;//gprs
    NSMutableDictionary *wlanFlowDic;//m
    NSMutableDictionary *wlanTimeDic;//时长
    
    NSString *returnFee;//返还
    NSString *giveFee;//赠送
    NSString *bdCostFee;//保底消费
    BOOL isShowFeeDetailView;//是否展示话费详情视图
    
    //需要更改主题的view
    UIColor *currThemeColor;
    UILabel *valueLabel;//余额金钱
    WaterBallView *waterView;//流量球
    UILabel *percentLabel;//流量球百分比
    
    UILabel *remain01;//剩余01
    UILabel *remain02;
    
    NSString *downLoadUrl;  //新版下载
    
    NSString *sessionID;//SessionID
}

@property (nonatomic,strong) DZNSegmentedControl* control;
@property (nonatomic,strong) NSString *sessionID;//SessionID
@end
