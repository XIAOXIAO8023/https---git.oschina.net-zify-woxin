//
//  YearBillUserInfo.m
//  MyMobileServiceYN
//
//  Created by 陆楠 on 15/3/18.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import "YearBillUserInfo.h"

@implementation YearBillUserInfo

static float gOnlineYear = 0.0f;

static float gPhoneCall = 0.0f;

static float gSendSMS = 0.0f;

static float gPhoneWap = 0.0f;

static float gPackageBusi = 0.0f;

static float gOtherBusi = 0.0f;

static int gCallTimes = 0;

static int gAnswerTimes = 0;

static int gTotalFlow = 0;

static int gAverageFlow = 0;

static NSString *gUserType = @"";

static int gFlowTime1 = 0;

static int gFlowTime2 = 0;

static int gFlowTime3 = 0;

static int gFlowTime4 = 0;

static int gFlowTime5 = 0;

static int gFlowTime6 = 0;

static NSString *gResultInfo = @"";

static NSString *gQueryCode = @"";


+(void)setOnlineYear:(float)OnlineYear
{
    gOnlineYear = OnlineYear;
}
+(float)getOnlineYear
{
    return gOnlineYear;
}

+(void)setPhoneCall:(float)PhoneCall
{
    gPhoneCall = PhoneCall;
}
+(float)getPhoneCall
{
    return gPhoneCall;
}

+(void)setSendSMS:(float)SendSMS
{
    gSendSMS = SendSMS;
}
+(float)getSendSMS
{
    return gSendSMS;
}

+(void)setPhoneWap:(float)PhoneWap
{
    gPhoneWap = PhoneWap;
}
+(float)getPhoneWap
{
    return gPhoneWap;
}

+(void)setPackageBusi:(float)PackageBusi
{
    gPackageBusi = PackageBusi;
}
+(float)getPackageBusi
{
    return gPackageBusi;
}

+(void)setOtherBusi:(float)OtherBusi
{
    gOtherBusi = OtherBusi;
}
+(float)getOtherBusi
{
    return gOtherBusi;
}

+(void)setCallTimes:(int)CallTimes
{
    gCallTimes = CallTimes;
}
+(int)getCallTimes
{
    return gCallTimes;
}

+(void)setAnswerTimes:(int)AnswerTimes
{
    gAnswerTimes = AnswerTimes;
}
+(int)getAnswerTimes
{
    return gAnswerTimes;
}

+(void)setTotalFlow:(int)TotalFlow
{
    gTotalFlow = TotalFlow;
}
+(int)getTotalFlow
{
    return gTotalFlow;
}

+(void)setAverageFlow:(int)AverageFlow
{
    gAverageFlow = AverageFlow;
}
+(int)getAverageFlow
{
    return gAverageFlow;
}

+(void)setUserType:(NSString *)UserType
{
    gUserType = UserType;
}
+(NSString *)getUserType
{
    return gUserType;
}

+(void)setFlowTime1:(int)FlowTime1
{
    gFlowTime1 = FlowTime1;
}
+(int)getFlowTime1
{
    return gFlowTime1;
}

+(void)setFlowTime2:(int)FlowTime2
{
    gFlowTime2 = FlowTime2;
}
+(int)getFlowTime2
{
    return gFlowTime2;
}

+(void)setFlowTime3:(int)FlowTime3
{
    gFlowTime3 = FlowTime3;
}
+(int)getFlowTime3
{
    return gFlowTime3;
}

+(void)setFlowTime4:(int)FlowTime4
{
    gFlowTime4 = FlowTime4;
}
+(int)getFlowTime4
{
    return gFlowTime4;
}

+(void)setFlowTime5:(int)FlowTime5
{
    gFlowTime5 = FlowTime5;
}
+(int)getFlowTime5
{
    return gFlowTime5;
}

+(void)setFlowTime6:(int)FlowTime6
{
    gFlowTime6 = FlowTime6;
}
+(int)getFlowTime6
{
    return gFlowTime6;
}

+(void)setResultInfo:(NSString *)ResultInfo
{
    gResultInfo = ResultInfo;
}
+(NSString *)getResultInfo
{
    return gResultInfo;
}

+(void)setQueryCode:(NSString *)QueryCode
{
    gQueryCode = QueryCode;
}
+(NSString *)getQueryCode
{
    return gQueryCode;
}


+(float)getTotalCost
{
    return [self getPhoneCall]+[self getPhoneWap]+[self getSendSMS]+[self getPackageBusi]+[self getOtherBusi];
}

+(NSArray *)getCostArry
{
    NSDictionary *d1 = @{@"name":@"电话",@"cost":@(gPhoneCall)};
    NSDictionary *d2 = @{@"name":@"短信",@"cost":@(gSendSMS)};
    NSDictionary *d3 = @{@"name":@"上网",@"cost":@(gPhoneWap)};
    NSDictionary *d4 = @{@"name":@"套餐",@"cost":@(gPackageBusi)};
    NSDictionary *d5 = @{@"name":@"其它",@"cost":@(gOtherBusi)};
    
    NSDictionary *temp;
    
    NSMutableArray *arr= [NSMutableArray arrayWithObjects:d1,d2,d3,d4,d5, nil];
    
    for (int i = 0; i < arr.count - 1; i++) {
        for (int j = i + 1; j < arr.count; j++) {
            if (((NSNumber *)[[arr objectAtIndex:i] objectForKey:@"cost"]).floatValue <
                ((NSNumber *)[[arr objectAtIndex:j] objectForKey:@"cost"]).floatValue) {
                temp = arr[i];
                arr[i] = [arr objectAtIndex:j];
                arr[j] = temp;
            }
        }
    }
    
    return arr;
}

+(NSString *)getMostCost
{
    return [[[self getCostArry] objectAtIndex:0] objectForKey:@"name"];
}

+(NSDictionary *)getMostCostDic
{
    return [[self getCostArry] objectAtIndex:0];
}

+(int)getMostFlowTime
{
    int a[6] = {gFlowTime1,gFlowTime2,gFlowTime3,gFlowTime4,gFlowTime5,gFlowTime6};
    
    int max = 6;
    if (a[0]+a[1]+a[2]+a[3]+a[4]+a[5]) {
        max = 0;
        for (int i = 0; i < 6; i++) {
            if (a[max] < a[i]) {
                max = i;
            }
        }
    }
    
    return max;
}

@end













