//
//  ViewController.m
//  YearBill
//
//  Created by 陆楠 on 15/2/9.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "YearBill.h"
#import "MoveUtils.h"
#import "LNAnimationUtils.h"
#import "SnowView.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"
#import "ForthView.h"
#import "FifthView.h"
#import "LNAnimationNumber.h"
#import "LNElasticCircle.h"
#import "LNElasticRect.h"
#import "ArrowView.h"
#import "TuCaoVC.h"
#import "NDAboutVC.h"
#import "YearBillChannel.h"
#import "GlobalDef.h"
#import "YearBillUserInfo.h"
#import "MyMobileServiceYNWebViewVC.h"

#define PAGE_HEIGTH ([[UIScreen mainScreen] bounds].size.height - 64)

#define HE_SHENG_HUO_URL  @"http://kunming.wxcs.cn/Application/toDownload"
#define HE_YOU_XI_URL     @"http://g.10086.cn/s/client"
#define HE_SHI_PIN_URL    @"http://wap.cmvideo.cn/wap/mh/and/sy/index.jsp"


@interface YearBillVC ()
{
    int forePage;
    int currentPage;
    ArrowView *arrow;
}

@end

@implementation YearBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"年度账单";
    
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64)];
    [self.view addSubview:mainScrollView];
    mainScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, PAGE_HEIGTH * 6);
    [mainScrollView setDelegate:self];
    [mainScrollView setPagingEnabled:YES];
    [mainScrollView setBounces:NO];
    mainScrollView.showsVerticalScrollIndicator = NO;
    
    
    currentPage = 0;
    forePage = 0;
    
    UIButton *r = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [r setImage:[UIImage imageNamed:@"login_rem"] forState:UIControlStateNormal];
    [r addTarget:self action:@selector(pushAboutView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:r];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self sendYearBillRequestWithInfo:nil viewController:self];
}


- (void)loadFirstView
{
    firstView = [[FirstView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 64)];
    [mainScrollView addSubview:firstView];
    
    secondView = [[SecondView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64, 320, [[UIScreen mainScreen] bounds].size.height - 64)];
    [mainScrollView addSubview:secondView];
    if ([[YearBillUserInfo getMostCost] isEqualToString:@"电话"]) {
        secondView.type = 1;
    }else if ([[YearBillUserInfo getMostCost] isEqualToString:@"短信"]) {
        secondView.type = 2;
    }else if ([[YearBillUserInfo getMostCost] isEqualToString:@"套餐"]) {
        secondView.type = 3;
    }else if ([[YearBillUserInfo getMostCost] isEqualToString:@"上网"]) {
        secondView.type = 4;
    }else if ([[YearBillUserInfo getMostCost] isEqualToString:@"其它"]) {
        secondView.type = 5;
    }
    
    thirdView = [[ThirdView alloc]initWithFrame:CGRectMake(0, PAGE_HEIGTH * 2, 320, PAGE_HEIGTH)];
    [mainScrollView addSubview:thirdView];
    if ([YearBillUserInfo getCallTimes] < [YearBillUserInfo getAnswerTimes]) {
        thirdView.type = 1;
    }else if ([YearBillUserInfo getCallTimes] > [YearBillUserInfo getAnswerTimes]) {
        thirdView.type = 2;
    }else{
        thirdView.type = 3;
    }
    
    forthView = [[ForthView alloc]initWithFrame:CGRectMake(0, PAGE_HEIGTH * 3, 320, PAGE_HEIGTH)];
    [mainScrollView addSubview:forthView];
    forthView.type = [YearBillUserInfo getMostFlowTime] + 1;
    
    fifthView = [[FifthView alloc]initWithFrame:CGRectMake(0, PAGE_HEIGTH * 4, 320, PAGE_HEIGTH)];
    [mainScrollView addSubview:fifthView];
    if ([[YearBillUserInfo getUserType] isEqualToString:@"S"]) {
        fifthView.type = 1;
    }else if ([[YearBillUserInfo getUserType] isEqualToString:@"T"]) {
        fifthView.type = 2;
    }else if ([[YearBillUserInfo getUserType] isEqualToString:@"J"]) {
        fifthView.type = 3;
    }else{
        fifthView.type = 4;
    }
    
    sixthView = [[SixthView alloc]initWithFrame:CGRectMake(0, PAGE_HEIGTH * 5, 320, PAGE_HEIGTH)];
    [mainScrollView addSubview:sixthView];
    sixthView.pushViewDelegate = self;
    
    arrow = [[ArrowView alloc]initWithFrame:CGRectMake(135, self.view.frame.size.height - 50, 50, 50)];
    [self.view addSubview:arrow];
    arrow.image = [UIImage imageNamed:@"jiantou"];
    [arrow startAnimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (mainScrollView.contentOffset.y != 0) {
        [firstView stopSnow];
        if (mainScrollView.contentOffset.y == PAGE_HEIGTH) {
            currentPage = 1;
            if (forePage != currentPage) {
                [secondView startAnimation];
            }
            forePage = 1;
        }else if (mainScrollView.contentOffset.y == PAGE_HEIGTH*2) {
            currentPage = 2;
            if (forePage != currentPage) {
                [thirdView startAnimation];
            }
            forePage = 2;
        }else if (mainScrollView.contentOffset.y == PAGE_HEIGTH*3) {
            currentPage = 3;
            if (forePage != currentPage) {
                [forthView startAnimation];
            }
            forePage = 3;
        }else if (mainScrollView.contentOffset.y == PAGE_HEIGTH*4) {
            currentPage = 4;
            if (forePage != currentPage) {
                [fifthView startAnimation];
            }
            forePage = 4;
        }else if (mainScrollView.contentOffset.y == PAGE_HEIGTH*5) {
            currentPage = 5;
            if (forePage != currentPage) {
                [sixthView startAnimation];
            }
            forePage = 5;
        }
    }else {
        currentPage = 0;
        [firstView fallSnow];
        forePage = 0;
    }
}

-(void)pushuViewFromSixView:(UIButton *)btn
{
    if (btn.tag == 200) {
        NSLog(@"和生活...");
        MyMobileServiceYNWebViewVC *w1 = [[MyMobileServiceYNWebViewVC alloc]init];
        w1.webUrlString = HE_SHENG_HUO_URL;
        [self presentWebVC:w1 animated:YES];
    }else if (btn.tag == 201){
        NSLog(@"和游戏...");
        MyMobileServiceYNWebViewVC *w2 = [[MyMobileServiceYNWebViewVC alloc]init];
        w2.webUrlString = HE_YOU_XI_URL;
        [self presentWebVC:w2 animated:YES];
    }else if (btn.tag == 202){
        NSLog(@"和视频");
        MyMobileServiceYNWebViewVC *w3 = [[MyMobileServiceYNWebViewVC alloc]init];
        w3.webUrlString = HE_SHI_PIN_URL;
        [self presentWebVC:w3 animated:YES];
    }else if (btn.tag == 203){
        NSLog(@"我要吐槽...");
        TuCaoVC *tc = [[TuCaoVC alloc]init];
        [self.navigationController pushViewController:tc animated:YES];
    }
}

-(void)pushAboutView
{
    NDAboutVC *a = [[NDAboutVC alloc]init];
    [self.navigationController pushViewController:a animated:YES];
}



-(void)sendYearBillRequestWithInfo:(NSDictionary *)dic viewController:(UIViewController *)vc
{
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    
    busiCode = @"queryAccount";
    
    NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
    [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"mobileNumber"];
    [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [requestParamData setObject:@"queryAccount" forKey:@"intf_code"];
    [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:vc];
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    DebugNSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSError *error;
    NSDictionary *resultJSON = [[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error] objectAtIndex:0];
    NSLog(@"%@",resultJSON);
    
    [YearBillUserInfo setOnlineYear:((NSString *)[resultJSON objectForKey:@"ONLINE_YEAR"]).floatValue];
    [YearBillUserInfo setPhoneCall:((NSString *)[resultJSON objectForKey:@"PHONE_CALL"]).floatValue];
    [YearBillUserInfo setSendSMS:((NSString *)[resultJSON objectForKey:@"SEND_SMS"]).floatValue];
    [YearBillUserInfo setPhoneWap:((NSString *)[resultJSON objectForKey:@"PHONE_WAP"]).floatValue];
    [YearBillUserInfo setPackageBusi:((NSString *)[resultJSON objectForKey:@"PACKAGE_BUSI"]).floatValue];
    [YearBillUserInfo setOtherBusi:((NSString *)[resultJSON objectForKey:@"OTHER_BUSI"]).floatValue];
    [YearBillUserInfo setCallTimes:((NSString *)[resultJSON objectForKey:@"CALL_TIMES"]).intValue];
    [YearBillUserInfo setAnswerTimes:((NSString *)[resultJSON objectForKey:@"ANSWER_TIMES"]).intValue];
    [YearBillUserInfo setTotalFlow:((NSString *)[resultJSON objectForKey:@"TOTAL_FLOW"]).intValue];
    [YearBillUserInfo setAverageFlow:((NSString *)[resultJSON objectForKey:@"AVERAGE_FLOW"]).intValue];
    [YearBillUserInfo setUserType:((NSString *)[resultJSON objectForKey:@"USER_TYPE"])];
    [YearBillUserInfo setFlowTime1:((NSString *)[resultJSON objectForKey:@"FLOW_TIME1"]).intValue];
    [YearBillUserInfo setFlowTime2:((NSString *)[resultJSON objectForKey:@"FLOW_TIME2"]).intValue];
    [YearBillUserInfo setFlowTime3:((NSString *)[resultJSON objectForKey:@"FLOW_TIME3"]).intValue];
    [YearBillUserInfo setFlowTime4:((NSString *)[resultJSON objectForKey:@"FLOW_TIME4"]).intValue];
    [YearBillUserInfo setFlowTime5:((NSString *)[resultJSON objectForKey:@"FLOW_TIME5"]).intValue];
    [YearBillUserInfo setFlowTime6:((NSString *)[resultJSON objectForKey:@"FLOW_TIME6"]).intValue];
    [YearBillUserInfo setResultInfo:((NSString *)[resultJSON objectForKey:@"X_RESULTINFO"])];
    [YearBillUserInfo setQueryCode:((NSString *)[resultJSON objectForKey:@"QUERY_CYCLE"])];
    
    [self loadFirstView];
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:@"查询失败，请检查网络..."
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    [alert show];
}



-(void)presentWebVC:(UIViewController *)webVC animated:(BOOL)animated{
    if (webVC!=nil){
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController: webVC];
        //设置nav bar 颜色
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath = [paths objectAtIndex:0];
        NSString *filename=[plistPath stringByAppendingPathComponent:@"currentTheme.plist"];
        NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
        
        UIColor *color = nil;
        
        if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"red"]) {
            color = UIColorFromRGB(rgbValue_Theme_red);
        }else if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"green"]){
            color = UIColorFromRGB(rgbValue_Theme_green);
        }else if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"pueple"]){
            color = UIColorFromRGB(rgbValue_Theme_pueple);
        }else{
            color = UIColorFromRGB(rgbValue_Theme_blue);
        }
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [[UINavigationBar appearance] setBarTintColor:color];
        }else{
            [[UINavigationBar appearance] setTintColor:color];
        }
        [nav.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:appTypeFace size:18.0], UITextAttributeFont,nil]];
        [self presentModalViewController:nav animated:animated];
    }
}

@end








