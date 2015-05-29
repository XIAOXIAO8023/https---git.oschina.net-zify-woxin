//
//  MarketMoreVC.m
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "MarketMoreVC.h"
#import "LNAnimationNumber.h"
#import "PackageButton.h"
#import "ImageUtils.h"
#import "MKUserInfo.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNLoginVC.h"

@implementation MarketMoreVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"通信礼包";
    
    scroll = [[UIScrollView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:scroll];
    
//    [self loadTitleView];
    
    [self loadSegment];
    
//    [self loadAttentionview];
    
    self.packageArry = [MKUserInfo getLocalTimePackageArray];
}

-(void)loadTitleView
{
    title = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 78)];
    [self.view addSubview:title];
    title.image = [UIImage imageNamed:@"top_bg"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 2.5, 200, 25)];
    [title addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Arial" size:14];
    
    NSString *s = [NSString stringWithFormat:@"当前可兑换积分: %ld",(long)[MKUserInfo getTotalPoint]];
    NSMutableAttributedString *ss = [[NSMutableAttributedString alloc]initWithString:s];
    NSRange range = [s rangeOfString:[NSString stringWithFormat:@"%ld",(long)[MKUserInfo getTotalPoint]]];
    
    [ss addAttribute:NSFontAttributeName
               value:[UIFont fontWithName:@"Arial" size:18]
               range:range];
    [label setAttributedText:ss];
}

-(void)loadSegment
{
    segmentV = [[DZNSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [self.view addSubview:segmentV];
    segmentV.items = @[@"本地通话",@"国内长途",@"流量",@"话费"];
    [segmentV setShowsCount:NO];
    segmentV.height = 40;
    segmentV.delegate = self;
    [segmentV addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
}

-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar{
    return UIBarPositionBottom;
}

-(void)setPackageArry:(NSArray *)packageArry
{
    scroll.frame = CGRectMake(0, 40, 320, [UIScreen mainScreen].bounds.size.height - 94);
    _packageArry = packageArry;
    
    if (contentView) {
        [contentView removeFromSuperview];
    }
    
    contentView = [[UIView alloc]initWithFrame:CGRectZero];
    [scroll addSubview:contentView];
    
    NSInteger tmpH = 10;
    if (_packageArry.count) {
        for (NSInteger i = 0; i < _packageArry.count / 2 + 1; i++) {
            NSInteger tmpW = 10;
            for (NSInteger j = 0; j < ((_packageArry.count - 2*i)<2?(_packageArry.count - 2*i):2); j++) {
                PackageButton *bt = [[PackageButton alloc]initWithFrame:CGRectMake(tmpW, tmpH, 145, 155)];
                [contentView addSubview:bt];
                bt.backgroundColor = [UIColor whiteColor];
                bt.layer.borderColor = UIColorFromRGB(0xcecece).CGColor;
                bt.layer.borderWidth = 0.5f;
                bt.layer.cornerRadius = 5.0f;
                bt.JFtitle.layer.borderWidth = 0.5f;
                bt.JFtitle.layer.borderColor = UIColorFromRGB(0xcecece).CGColor;
                bt.packageInfo = [packageArry objectAtIndex:i * 2 + j];
                [bt addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                tmpW += 155;
            }
            tmpH += 165;
        }
    }
    if (!(_packageArry.count % 2)) {
        tmpH -= 185;
    }
    
    contentView.frame = CGRectMake(0, 0, 320, tmpH);
    scroll.contentSize = contentView.bounds.size;
}

-(void)loadAttentionview
{
    UILabel *att = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 84, 320, 20)];
    [self.view addSubview:att];
    att.textColor = [UIColor redColor];
    att.font = [UIFont fontWithName:@"Arial" size:12];
    att.textAlignment = NSTextAlignmentCenter;
    att.text = @"当月兑换，下月生效一个月，月末到期";
}


-(void)buttonPressed:(id)sender
{
    if ([MyMobileServiceYNParam getIsLogin]) {
        currentB = (PackageButton *)sender;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:[NSString stringWithFormat:@"亲爱的客户，您所订购的礼包需要扣除%@积分，并且%@，是否确定兑换？",[currentB.packageInfo objectForKey:@"INTEGRAL_VALUE"],[currentB.packageInfo objectForKey:@"RSRV_STR1"]]
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
        
        [alert show];
    }else{
        MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
        [self presentViewController:login animated:YES completion:nil];
    }
}

#pragma mark - alertViewdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self sendRequestWithBusinessCode:@"ITF_CRM_SaleActiveTradeReg" button:currentB];
    }
}


-(void)selectedSegment:(DZNSegmentedControl *)control
{
    if (control.selectedSegmentIndex == 0) {
        self.packageArry = [MKUserInfo getLocalTimePackageArray];
    }else if (control.selectedSegmentIndex == 1){
        self.packageArry = [MKUserInfo getCountryTimePackageArray];
    }else if (control.selectedSegmentIndex == 2){
        self.packageArry = [MKUserInfo getFlowPackageArray];
    }else if (control.selectedSegmentIndex == 3){
        self.packageArry = [MKUserInfo getChargePackageArray];
    }
    
}

#pragma mark - http通信
-(void)sendRequestWithBusinessCode:(NSString *)code button:(PackageButton *)btn
{

    [HUD showTextHUDWithVC:self.view.window];
        
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    busiCode = code;
    NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
    
    if ([busiCode isEqualToString:@"ITF_CRM_SaleActiveTradeReg"]) {
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:@"ITF_CRM_SaleActiveTradeReg" forKey:@"intf_code"];
        [requestParamData setObject:@"010003" forKey:@"CAMPN_TYPE"];
        [requestParamData setObject:[btn.packageInfo objectForKey:@"RSRV_STR2"] forKey:@"CAMPN_ID"];
        [requestParamData setObject:[btn.packageInfo objectForKey:@"RSRV_STR3"] forKey:@"PRODUCT_ID"];
        [requestParamData setObject:[btn.packageInfo objectForKey:@"GOODS_CODE"] forKey:@"PACKAGE_ID"];
        
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
    if ([busiCode isEqualToString:@"ITF_CRM_SaleActiveTradeReg"]) {
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
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    if (HUD) {
        [HUD removeHUD];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:@"兑换失败，请检查网络..."
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    [alert show];
}



@end








