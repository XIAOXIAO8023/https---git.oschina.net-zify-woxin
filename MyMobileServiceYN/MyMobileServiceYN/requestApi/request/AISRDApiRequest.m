//
//  JFMallApiRequest.m
//  JFProject150506
//
//  Created by mouxiaochun on 15/5/6.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "AISRDApiRequest.h"
#import "AISRDRequest.h"
#import <UIKit/UIKit.h>
#import "MyMobileServiceYNParam.h"
@implementation AISRDApiRequest

//首页查询
+(AISRDRequest *)sycx:(AISRDCompletionBlock)completionBlock{
   AISRDRequest *request = [AISRDRequest startWithRequestType:AISRDRequestTypeSycx function:@"sycx" param:nil block:completionBlock];
    return request;
}

//登陆后首页查询
+(AISRDRequest *)hqyhxx:(AISRDCompletionBlock)completionBlock{
    AISRDRequest *request = [AISRDRequest startWithRequestType:AISRDRequestTypeHqyhxx function:@"hqyhxx" param:nil block:completionBlock];
    return request;
}

//检查版本
+(AISRDRequest *)checkVersion:(AISRDCompletionBlock)completionBlock{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:@"" forKey:@"SERIAL_NUMBER"];
    AISRDRequest *request = [AISRDRequest startWithRequestType:AISRDRequestType_checkVersion function:@"checkVersion" param:param block:completionBlock];
    return request;
}

//登录检查密码
+(AISRDRequest *)loginCheckPWD:(AISRDCompletionBlock)completionBlock{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:@"0" forKey:@"REMOVE_TAG"];
    [param setObject:@"3911" forKey:@"QUERYTYPE"];
    [param setObject:@"GETTHREENEW" forKey:@"QUERYDATA"];
    [param setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [param setObject:[MyMobileServiceYNParam getUserPassWord] forKey:@"USER_PASSWD"];
    
    AISRDRequest *request = [AISRDRequest startWithRequestType:AISRDRequestType_loginCheckPWD function:@"Login_CheckPWD" param:param block:completionBlock];
    return request;
}

//BusinessInfo 包括首页火热活动和手机商城等
+(AISRDRequest *)queryBusinessInfo:(AISRDCompletionBlock)completionBlock{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
	[param setObject:@"0000" forKey:@"EPARCHY_CODE"];
    
    AISRDRequest *request = [AISRDRequest startWithRequestType:AISRDRequestType_queryBusinessInfo function:@"QueryBusinessInfo" param:param block:completionBlock];
    return request;
}
//首页banner数据
+(AISRDRequest *)queryBanner:(AISRDCompletionBlock)completionBlock{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    if([[MyMobileServiceYNParam getCityCode] isEqualToString:@""]){
        [param setObject:@"全省" forKey:@"EPARCHY_CODE"];
    }else{
        [param setObject:[MyMobileServiceYNParam getCityCode] forKey:@"EPARCHY_CODE"];
    }
    AISRDRequest *request = [AISRDRequest startWithRequestType:AISRDRequestType_queryBanner function:@"QueryBanner" param:param block:completionBlock];
    return request;
}

@end
