//
//  MyMobileServiceYNHttpRequest.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-5.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNHttpRequest.h"
#import "ASIFormDataRequest.h"
#import "MyMobileServiceYNParam.h"
#import "HTTPConfig.h"

@implementation MyMobileServiceYNHttpRequest
-(void)setRequestDelegatNil
{
    //如果存在则清空
    if (request.delegate != nil) {
        request.delegate = nil;
    }
}

//获取http请求共用数据paramData
-(NSMutableDictionary *)getHttpPostParamData:(NSString *)busiCode
{
    NSMutableDictionary *paramData = [[NSMutableDictionary alloc]init];
    [paramData setObject:[MyMobileServiceYNParam getVersion] forKey:@"version"];
    [paramData setObject:[MyMobileServiceYNParam getPattern] forKey:@"pattern"];
    NSMutableString *mobileModel=[[NSMutableString alloc]initWithString:[[UIDevice currentDevice] model]];
    [mobileModel appendString:[[UIDevice currentDevice] systemVersion]];
    [paramData setObject:mobileModel forKey:@"mobileModel"];
    [paramData setObject:[[UIDevice currentDevice] systemVersion] forKey:@"mobileVersion"];
    [paramData setObject:busiCode forKey:@"intf_code"];
    [paramData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"staffid"];
    [paramData setObject:[MyMobileServiceYNParam getUserPassWord] forKey:@"psd"];
    [paramData setObject:[MyMobileServiceYNParam getCityCode] forKey:@"eparchyCode"];
    [paramData setObject:@"iOS" forKey:@"Platform"];
    if([MyMobileServiceYNParam getIsAutoLogin]){
        [paramData setObject:@"0" forKey:@"autologin"];
    }else{
        [paramData setObject:@"-1" forKey:@"autologin"];
    }
    if ([MyMobileServiceYNParam getIsDynamicPW]) {
        [paramData setObject:@"1" forKey:@"loginType"];
    }else{
        [paramData setObject:@"0" forKey:@"loginType"];
    }
    return paramData;
}

//获取调用接口url，根据登录状态，是否需要使用https及接口等级进行设置
-(void)startAsynchronous:(NSString *)busiCode requestParamData:(NSMutableDictionary *)requestParamData viewController:(UIViewController *)viewController{
    
    NSMutableString *stringUrl = [[NSMutableString alloc] initWithString:SERVER_URL];
    NSURL *url = [NSURL URLWithString:stringUrl];
    request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:viewController];
    request.shouldPresentProxyAuthenticationDialog = false;
    [request setShouldAttemptPersistentConnection:NO]; //关闭连接重用机制
    [request setTimeOutSeconds:60]; //设置超时时间为60s
    
    NSError *error;
    NSData *registerData = [NSJSONSerialization dataWithJSONObject:requestParamData options:NSJSONWritingPrettyPrinted error:&error];
    NSString *requestJsonString = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
    DebugNSLog(@"%@",requestJsonString);
    //判断
    if ([busiCode isEqualToString:@"Login_CheckPWD"]) {
        [request setPostValue:requestJsonString forKey:@"paramdata"];
        [request setValidatesSecureCertificate:NO];
        [ASIHTTPRequest clearSession];
        [request startAsynchronous];
    }else if ([busiCode isEqualToString:@"Login_CheckDynamicPsd"]){
        //调用服务器接口获取数据
        [request setPostValue:requestJsonString forKey:@"paramdata"];
        [request setValidatesSecureCertificate:NO];
        [ASIHTTPRequest clearSession];
        [request startAsynchronous];
    }else if ([busiCode isEqualToString:@"checkVersion"]){
        //调用服务器接口获取数据
        [request setPostValue:requestJsonString forKey:@"paramdata"];
        [request setValidatesSecureCertificate:NO];
        [request startAsynchronous];
    }else if ([busiCode isEqualToString:@"QueryBanner"]){
        //调用服务器接口获取数据
        [request setPostValue:requestJsonString forKey:@"paramdata"];
        [request setValidatesSecureCertificate:NO];
//        [request setUseCookiePersistence:YES];
        [request startAsynchronous];
    }
    else if ([busiCode isEqualToString:@"DynamicPsd"]){
        //调用动态密码接口
        [request setPostValue:requestJsonString forKey:@"paramdata"];
        [request setValidatesSecureCertificate:NO];
        [request startAsynchronous];
    } else if ([busiCode isEqualToString:@"QueryBusinessInfo"]){
        //调用动态密码接口
        [request setPostValue:requestJsonString forKey:@"paramdata"];
        [request setValidatesSecureCertificate:NO];
        [request startAsynchronous];
    }else if ([busiCode isEqualToString:@"QUERY_JFMALLDATA"]){
        //调用动态密码接口
        [request setPostValue:requestJsonString forKey:@"paramdata"];
        [request setValidatesSecureCertificate:NO];
        [request setUseCookiePersistence:YES];
        [request startAsynchronous];
    }else{
        if (![MyMobileServiceYNParam getIsLogin]) {
            //未登录，跳转到登陆框
            
        }//gIsLogin
        else{
            //设置url为https url
            //调用服务器接口获取数据
            [request setPostValue:requestJsonString forKey:@"paramdata"];
            [request setValidatesSecureCertificate:NO];
            [request setUseCookiePersistence:YES];
            [request startAsynchronous];
        }//gIsLoginOK
    }
}


@end
