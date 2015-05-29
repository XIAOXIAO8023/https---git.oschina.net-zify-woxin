//
//  ReturnMessageDeal.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-18.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "ReturnMessageDeal.h"
#import "MyMobileServiceYNParam.h"

@implementation ReturnMessageDeal

-(NSString *)returnMessage:(NSString *)returnCode andreturnMessage:(NSString *)returnMessage
{
    NSString *contentString = @"尊敬的用户，由于系统或者网络原因，当前操作暂不可用，对您造成的不便敬请谅解。";
    if ([returnCode isEqualToString:@"1000"]) {
        //系统失败
        contentString = @"[1000]尊敬的用户，由于系统或者网络原因，当前操作暂不可用，对您造成的不便敬请谅解。";
    }else if ([returnCode isEqualToString:@"1620"]){
        //登录超时
        contentString = returnMessage;
        [MyMobileServiceYNParam setNoUserInfo];
    }else if ([returnMessage isEqualToString:@""]){
        contentString = @"网络异常";
    }
    else{
        contentString = returnMessage;
    }
    return contentString;
}

@end
