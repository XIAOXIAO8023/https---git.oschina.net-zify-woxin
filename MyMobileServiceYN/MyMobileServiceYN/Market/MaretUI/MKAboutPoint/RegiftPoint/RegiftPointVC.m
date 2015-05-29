//
//  RegiftPointVC.m
//  Market
//
//  Created by 陆楠 on 15/3/25.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "RegiftPointVC.h"
#import "RPFaultV.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"
#import "MKUserInfo.h"

@interface RegiftPointVC ()

@end

@implementation RegiftPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"积分转赠";
    
//    [self initViewType];
    [self sendRequestWithBusinessCode:@"ITF_CRM_ScoreDonateChk" withInfo:nil];
}

-(void)initViewTypeWithReason:(NSString *)reason
{
    if (type == QualificationLack) {
        RPFaultV *f1 = [[RPFaultV alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:f1];
        f1.faultReason = RPFaultReasonLackAge;
    }else if (type == QualificationOver) {
        RPFaultV *f2 = [[RPFaultV alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:f2];
        f2.faultReason = RPFaultReasonOverPoint;
    }else if (type == QualificationOther){
        RPFaultV *f2 = [[RPFaultV alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:f2];
        f2.faultReason = RPFaultReasonCommon;
        f2.commonReason =reason;
    }else if (type == QualificationYes){
        RPGiftPointV *f3 = [[RPGiftPointV alloc]initWithFrame:self.view.bounds];
        f3.delegate = self;
        [self.view addSubview:f3];
    }
}


-(void)RPGiftPointVButtonPressed:(id)info
{
    NSDictionary *dic = (NSDictionary *)info;
    
    if ([[dic objectForKey:@"action"] isEqualToString:@"getCaptcha"]) {
        [self sendRequestWithBusinessCode:@"donateDynamicPsd" withInfo:nil];
    }else if ([[dic objectForKey:@"action"] isEqualToString:@"commit"]) {
        commitInfo = info;
        [self sendRequestWithBusinessCode:@"ITF_CRM_ScoreDonateCrm" withInfo:info];
    }
}

-(void)sendRequestWithBusinessCode:(NSString *)code withInfo:(id)info
{
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    busiCode = code;
    NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
    
    if ([busiCode isEqualToString:@"ITF_CRM_ScoreDonateChk"]) {
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:@"0" forKey:@"TransferPoint"];
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"LMobile"];
        [requestParamData setObject:@"11111111111" forKey:@"BMobile"];
        [requestParamData setObject:@"ITF_CRM_ScoreDonateChk" forKey:@"intf_code"];
        
        [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
    }else if ([busiCode isEqualToString:@"donateDynamicPsd"]){
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:@"donateDynamicPsd" forKey:@"intf_code"];
        [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
    }else if ([busiCode isEqualToString:@"ITF_CRM_ScoreDonateCrm"]){
        NSDictionary *dic = (NSDictionary *)info;
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"LMobile"];
        [requestParamData setObject:[dic objectForKey:@"person"] forKey:@"BMobile"];
        [requestParamData setObject:[dic objectForKey:@"captcha"] forKey:@"donatePassword"];
        [requestParamData setObject:[dic objectForKey:@"point"] forKey:@"TransferPoint"];
        [requestParamData setObject:@"ITF_CRM_ScoreDonateCrm" forKey:@"intf_code"];
        
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
    
    if ([busiCode isEqualToString:@"ITF_CRM_ScoreDonateChk"]) {
        NSArray *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        if ([[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
            if ([[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTINFO"] isEqualToString:@"ok"]) {
                type = QualificationYes;
            }
            [self initViewTypeWithReason:[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTINFO"]];
        }else{
            type = QualificationOther;
            [self initViewTypeWithReason:[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTINFO"]];
        }
    }else if ([busiCode isEqualToString:@"donateDynamicPsd"]){
        NSArray *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        if ([[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
            NSLog(@"成功提交短信...");
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                           message:[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTINFO"]
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }
    }else if ([busiCode isEqualToString:@"ITF_CRM_ScoreDonateCrm"]){
        NSArray *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        if ([[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                           message:[[resultJSON objectAtIndex:0] objectForKey:@"X_RSPDESC"]
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
            [MKUserInfo setTotalPoint:([MKUserInfo getTotalPoint] - [[((NSDictionary *)commitInfo) objectForKey:@"point"] integerValue])];
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
                                                   message:@"请求失败，请检查网络..."
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    [alert show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
