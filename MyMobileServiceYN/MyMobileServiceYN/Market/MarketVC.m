//
//  ViewController.m
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "MarketVC.h"
#import "CycleScrollView.h"
#import "SomeViewHeightDef.h"
#import "MarketBanner.h"
#import "MKImageAndLabelButton.h"
#import "MarketTicket.h"
#import "MarketGift.h"
#import "QuerryPointVC.h"
#import "RegiftPointVC.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"
#import "MKUserInfo.h"
#import "PackageButton.h"
#import "UIImageView+WebCache.h"
#import "RefreshView.h"
#import "MyMobileServiceYNLoginVC.h"

@interface MarketVC ()<RefreshViewDelegate>
{
    RefreshView *refishView;
    
    BOOL webIsLoad;
}

@end

@implementation MarketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAfterLogin) name:@"iHaveLoggedIn" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(totalPointChanged:) name:@"totalPointChanged" object:nil];
    
    [self loadSeg];
    
    [self loadWebView];
    
    [self loadJiFenView];
    
    [self sendRequestWithBusinessCode:@"QUERY_JFMALLDATA"];
    
}

#pragma mark -
#pragma mark segment排版
-(void)loadSeg
{
    DZNSegmentedControl *dzCtr = [[DZNSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [self.view addSubview:dzCtr];
    dzCtr.items = @[@"积分汇",@"手机汇"];
    [dzCtr setShowsCount:NO];
    dzCtr.delegate = self;
    [dzCtr addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark - 手机汇
-(void)loadWebView
{
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 30, 320, [UIScreen mainScreen].bounds.size.height - 64 - TabBar_HEIGHT - 30)];
    [web setHidden:YES];
    webIsLoad = NO;
    [self.view addSubview:web];
    UIView *white = [[UIView alloc]initWithFrame:CGRectMake(0, web.frame.size.height + 30, 320, TabBar_HEIGHT)];
    [self.view addSubview:white];
    white.backgroundColor = [UIColor whiteColor];
}

#pragma mark -
#pragma mark 积分汇
-(void)loadJiFenView
{
    jifenScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, 320, [UIScreen mainScreen].bounds.size.height - 64 - 30)];
    jifenScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:jifenScrollView];
    [jifenScrollView setShowsVerticalScrollIndicator:NO];
    jifenScrollView.delegate = self;
}

-(void)setJiFenContent
{
    [self setContentBanner];
    
    [self setBtnBelowBanner];
    
    [self setPackageView];
    
    [self setTicketView];
    
    [self setGiftView];
    
    UIView *gi = (UIView *)[self.view viewWithTag:4444];
    jifenScrollView.contentSize = CGSizeMake(320, gi.frame.origin.y + gi.frame.size.height + 49);
}

#pragma mark ~广告栏
-(void)setContentBanner
{
    MarketBanner *banner = [[MarketBanner alloc]initWithFrame:CGRectMake(10, 5, 300, JF_BANNER_HEIGHT - 5)];
    banner.layer.cornerRadius = 5.0f;
    [jifenScrollView addSubview:banner];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    [image sd_setImageWithURL:[NSURL URLWithString:@"http://218.202.0.168:8099/jfbanner/banner_1.png"]
             placeholderImage:[UIImage imageNamed:@"ad_loading"]
                      options:SDWebImageProgressiveDownload];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    [image2 sd_setImageWithURL:[NSURL URLWithString:@"http://218.202.0.168:8099/jfbanner/banner_1.png"]
             placeholderImage:[UIImage imageNamed:@"ad_loading"]
                      options:SDWebImageProgressiveDownload];
    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    [image3 sd_setImageWithURL:[NSURL URLWithString:@"http://218.202.0.168:8099/jfbanner/banner_1.png"]
             placeholderImage:[UIImage imageNamed:@"ad_loading"]
                      options:SDWebImageProgressiveDownload];
    banner.adArr = @[image,image2,image3];
    
    banner.tag = 1111;
}

#pragma mark ~~广告栏下方按钮
-(void)setBtnBelowBanner
{
    buttonV = [[UIView alloc]initWithFrame:CGRectMake(10, JF_BANNER_HEIGHT + 10, 300, JF_BUTTON_BELOW_BANNER_HEIHTT)];
    [jifenScrollView addSubview:buttonV];
    buttonV.layer.borderWidth = 0.5f;
    buttonV.layer.borderColor = UIColorFromRGB(0xcecece).CGColor;
    buttonV.layer.cornerRadius = 5.0f;
    
    UIButton *left = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, JF_BUTTON_BELOW_BANNER_HEIHTT)];
    [buttonV addSubview:left];
    UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5f, 25, 25)];
    [left addSubview:leftImage];
    leftImage.image = [UIImage imageNamed:@"icon_search"];
    UILabel *leftL = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 120, left.frame.size.height)];
    [left addSubview:leftL];
    leftL.font = [UIFont fontWithName:@"Arial" size:14];
    leftL.textColor = [UIColor grayColor];
    left.tag = 101;
    [left addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    NSString *s = [NSString stringWithFormat:@"积分查询: %ld",(long)[MKUserInfo getTotalPoint]];
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc]initWithString:s];
    NSRange r = [s rangeOfString:[NSString stringWithFormat:@"%ld",(long)[MKUserInfo getTotalPoint]]];
    [as addAttribute:NSForegroundColorAttributeName
               value:UIColorFromRGB(0xfc6b9f)
               range:r];
    leftL.attributedText = as;
    leftL.tag = 201;
    
    MKImageAndLabelButton *right = [[MKImageAndLabelButton alloc]initWithFrame:CGRectMake(150, 0, 150, JF_BUTTON_BELOW_BANNER_HEIHTT)];
    [buttonV addSubview:right];
    right.title = @"积分转赠";
    right.titleImage = [UIImage imageNamed:@"icon_zzls"];
    right.tag = 102;
    [right addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ~积分兑换基础通信
-(void)setPackageView
{
    MarketPackageV *pa = [[MarketPackageV alloc]initWithFrame:CGRectMake(0, JF_BANNER_HEIGHT+JF_BUTTON_BELOW_BANNER_HEIHTT + 15, 320, 0)];
    pa.tag = 2222;
    if([[MKUserInfo getHomePackageArray] count] > 0){
        [jifenScrollView addSubview:pa];
        pa.delegate = self;
        pa.packageArray = [MKUserInfo getHomePackageArray];
    }
}

#pragma mark ~积分兑换电子券
-(void)setTicketView
{
    MarketTicket *ti = [[MarketTicket alloc]initWithFrame:CGRectMake(0,JF_BANNER_HEIGHT+JF_BUTTON_BELOW_BANNER_HEIHTT+ 15 +JF_PACKAGE_VIEW_HEIGHT, 320, 0)];
    ti.tag = 3333;
    if ([[MKUserInfo getTicketInfoArray] count] > 0) {
        [jifenScrollView addSubview:ti];
        ti.ticketArry = [MKUserInfo getTicketInfoArray];
    }
}

#pragma mark ~兑换实物礼品
-(void)setGiftView
{
    UIView *t = (UIView *)[self.view viewWithTag:3333];
    MarketGift *gi = [[MarketGift alloc]initWithFrame:CGRectMake(0, t.frame.origin.y + t.frame.size.height + 5, 320, 0)];
    gi.tag = 4444;
    if ([[MKUserInfo getGoodsInfoArray] count] > 0) {
        [jifenScrollView addSubview:gi];
        gi.giftArry = [MKUserInfo getGoodsInfoArray];
    }
}


#pragma mark -
#pragma mark segDelegate
-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar{
    return UIBarPositionBottom;
}

- (void)selectedSegment:(DZNSegmentedControl *)control
{
    if (control.selectedSegmentIndex == 0) {
        [jifenScrollView setHidden:NO];
        [web setHidden:YES];
    }else{
        [jifenScrollView setHidden:YES];
        [web setHidden:NO];
        if (!webIsLoad) {
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://kdt.im/60jNtnkK"]];
            [web loadRequest:request];
            webIsLoad = YES;
        }
    }
}

#pragma mark -
#pragma mark 按钮点击事件
-(void)buttonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([MyMobileServiceYNParam getIsLogin]) {
        if (btn.tag == 101) {
            QuerryPointVC *qp = [[QuerryPointVC alloc]init];
            [self.navigationController pushViewController:qp animated:YES];
        }else if (btn.tag == 102){
            RegiftPointVC *rp = [[RegiftPointVC alloc]init];
            [self.navigationController pushViewController:rp animated:YES];
        }
    }else{
        MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
        [self presentViewController:login animated:YES completion:nil];
    }
    
}

#pragma mark - 登陆事件处理
-(void)setAfterLogin
{
    [self sendRequestWithBusinessCode:@"HQSM_IntegralQryAcctInfos"];
}

#pragma mark - MarketPackageVdelegate
-(void)MarketPackageVPackageButtonPressed:(PackageButton *)button
{
    if ([MyMobileServiceYNParam getIsLogin]) {
        currentB = button;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:[NSString stringWithFormat:@"亲爱的客户，您所订购的礼包需要扣除%@积分，并且%@，是否确定兑换？",[button.packageInfo objectForKey:@"INTEGRAL_VALUE"],[button.packageInfo objectForKey:@"RSRV_STR1"]]
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
        alert.tag = 10000;
        [alert show];
    }else{
        MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
        [self presentViewController:login animated:YES completion:nil];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10000) {
        if (buttonIndex == 1) {
            [self sendRequestWithBusinessCode:@"ITF_CRM_SaleActiveTradeReg"];
        }
    }
}

#pragma mark - http通信
-(void)sendRequestWithBusinessCode:(NSString *)code
{
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    busiCode = code;
    NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
    
    if ([busiCode isEqualToString:@"QUERY_JFMALLDATA"]) {
        [requestParamData setObject:@"" forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:@"QUERY_JFMALLDATA" forKey:@"intf_code"];
        [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
    }else if ([busiCode isEqualToString:@"HQSM_IntegralQryAcctInfos"]){
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:@"HQSM_IntegralQryAcctInfos" forKey:@"intf_code"];
        [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
    }else if ([busiCode isEqualToString:@"ITF_CRM_SaleActiveTradeReg"]) {
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:@"ITF_CRM_SaleActiveTradeReg" forKey:@"intf_code"];
        [requestParamData setObject:@"010003" forKey:@"CAMPN_TYPE"];
        [requestParamData setObject:[currentB.packageInfo objectForKey:@"RSRV_STR2"] forKey:@"CAMPN_ID"];
        [requestParamData setObject:[currentB.packageInfo objectForKey:@"RSRV_STR3"] forKey:@"PRODUCT_ID"];
        [requestParamData setObject:[currentB.packageInfo objectForKey:@"GOODS_CODE"] forKey:@"PACKAGE_ID"];
        
        [HUD showTextHUDWithVC:self.view.window];
        
        [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (HUD) {
        [HUD removeHUD];
    }
    NSData *responseData = [request responseData];
    DebugNSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    if ([busiCode isEqualToString:@"QUERY_JFMALLDATA"]) {
        NSArray *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        if (resultJSON.count > 0) {
            [MKUserInfo setHomeInfoArray:resultJSON];
            if ([MyMobileServiceYNParam getIsLogin]){
                [self sendRequestWithBusinessCode:@"HQSM_IntegralQryAcctInfos"];
            }
            [self setJiFenContent];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                           message:[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTINFO"]
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }
    }else if ([busiCode isEqualToString:@"HQSM_IntegralQryAcctInfos"]){
        NSArray *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        if ([[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
            [MKUserInfo setHomePointArray:resultJSON];
            MarketPackageV *pa = (MarketPackageV *)[jifenScrollView viewWithTag:2222];
            pa.packageArray = [MKUserInfo getHomePackageArray];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                           message:[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTINFO"]
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }
    }else if ([busiCode isEqualToString:@"ITF_CRM_SaleActiveTradeReg"]) {
        NSArray *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        if ([[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"恭喜您！兑换成功！"
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [MKUserInfo setTotalPoint:([MKUserInfo getTotalPoint] - [[currentB.packageInfo objectForKey:@"INTEGRAL_VALUE"] integerValue])];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                           message:[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTINFO"]
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    if (refishView) {
        [refishView removeFromSuperview];
    }
    NSArray *nils = [[NSBundle mainBundle]loadNibNamed:@"RefreshView" owner:self options:nil];
    refishView = [nils objectAtIndex:0];
    
    [refishView setupWithOwner:jifenScrollView delegate:self];
    [refishView stopLoading];
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    if (HUD) {
        [HUD removeHUD];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:@"请求失败，请检查网络..."
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    [alert show];
    [refishView stopLoading];
}

-(void)totalPointChanged:(NSNotification *)notification
{
    UILabel *l = (UILabel *)[[buttonV viewWithTag:101] viewWithTag:201];
    NSString *s = [NSString stringWithFormat:@"积分查询: %ld",(long)[MKUserInfo getTotalPoint]];
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc]initWithString:s];
    NSRange r = [s rangeOfString:[NSString stringWithFormat:@"%ld",(long)[MKUserInfo getTotalPoint]]];
    [as addAttribute:NSForegroundColorAttributeName
               value:UIColorFromRGB(0xfc6b9f)
               range:r];
    l.attributedText = as;
}

#pragma  mark - refresh

// 刚拖动的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView_ {
    [refishView scrollViewWillBeginDragging:scrollView_];
}
// 拖动过程中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView_ {
    [refishView scrollViewDidScroll:scrollView_];
}
// 拖动结束后
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView_ willDecelerate:(BOOL)decelerate {
    [refishView scrollViewDidEndDragging:scrollView_ willDecelerate:decelerate];
}

- (void)refreshViewDidCallBack {
    if ([MyMobileServiceYNParam getIsLogin]) {
        [refishView startLoading];
        [self sendRequestWithBusinessCode:@"HQSM_IntegralQryAcctInfos"];
    }
}

#pragma -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











