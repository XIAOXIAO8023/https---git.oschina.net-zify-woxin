//
//  YearBillChannel.m
//  MyMobileServiceYN
//
//  Created by 陆楠 on 15/3/18.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import "YearBillChannel.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNParam.h"
#import "HTTPConfig.h"

@implementation YearBillChannel


-(void)sendYearBillRequestWithInfo:(NSDictionary *)dic viewController:(UIViewController *)vc
{
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    
    busiCode = @"queryAccount";
    
    NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
    [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"mobileNumber"];
    [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERISL_NUMBER"];
    [requestParamData setObject:@"queryAccount" forKey:@"intf_code"];
    [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:vc];
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    DebugNSLog(@"%@",[request responseString]);
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
}


@end
