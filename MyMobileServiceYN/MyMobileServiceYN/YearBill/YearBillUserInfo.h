//
//  YearBillUserInfo.h
//  MyMobileServiceYN
//
//  Created by 陆楠 on 15/3/18.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YearBillUserInfo : NSObject

// 在线时间
+(void)setOnlineYear:(float)OnlineYear;
+(float)getOnlineYear;
// 电话消费
+(void)setPhoneCall:(float)PhoneCall;
+(float)getPhoneCall;
// 短信消费
+(void)setSendSMS:(float)SendSMS;
+(float)getSendSMS;
// 上网消费
+(void)setPhoneWap:(float)PhoneWap;
+(float)getPhoneWap;
// 套餐消费
+(void)setPackageBusi:(float)PackageBusi;
+(float)getPackageBusi;
// 其他消费
+(void)setOtherBusi:(float)OtherBusi;
+(float)getOtherBusi;
// 打电话次数
+(void)setCallTimes:(int)CallTimes;
+(int)getCallTimes;
// 接电话次数
+(void)setAnswerTimes:(int)AnswerTimes;
+(int)getAnswerTimes;
// 总流量
+(void)setTotalFlow:(int)TotalFlow;
+(int)getTotalFlow;
// 平均流量
+(void)setAverageFlow:(int)AverageFlow;
+(int)getAverageFlow;
// 用户类型
+(void)setUserType:(NSString *)UserType;
+(NSString *)getUserType;
// 时间段1（上午）流量
+(void)setFlowTime1:(int)FlowTime1;
+(int)getFlowTime1;
// 时间段2（中午）流量
+(void)setFlowTime2:(int)FlowTime2;
+(int)getFlowTime2;
// 时间段3（下午）流量
+(void)setFlowTime3:(int)FlowTime3;
+(int)getFlowTime3;
// 时间段4（晚上）流量
+(void)setFlowTime4:(int)FlowTime4;
+(int)getFlowTime4;
// 时间段5（深夜）流量
+(void)setFlowTime5:(int)FlowTime5;
+(int)getFlowTime5;
// 时间段6（凌晨）流量
+(void)setFlowTime6:(int)FlowTime6;
+(int)getFlowTime6;
// 查询结果信息反馈
+(void)setResultInfo:(NSString *)ResultInfo;
+(NSString *)getResultInfo;
// 查询周期
+(void)setQueryCode:(NSString *)QueryCode;
+(NSString *)getQueryCode;


// 总消费金额
+(float)getTotalCost;
// 最高消费金额
+(NSString *)getMostCost;
// 消费金额从大到小排序
+(NSArray *)getCostArry;
// 流量使用最多时段
+(int)getMostFlowTime;

+(NSDictionary *)getMostCostDic;

@end





