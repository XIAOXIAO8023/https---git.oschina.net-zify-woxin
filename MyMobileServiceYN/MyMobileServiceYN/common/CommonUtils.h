//
//  CommonUtils.h
//  CMClient
//
//  Created by zhaol on 14-9-28.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalDef.h"

@interface CommonUtils : NSObject
+(NSString*)formateNumber:(NSNumber*)number FractionDigits:(int)num;//格式化数字,保留num位小数
+(NSString*)formateFee:(double)fee;//格式化费用
+(NSString*)formateFee2:(double)fee;//格式化费用
+(double)formateSecondsToMinutes:(double)seconds;//转秒到分
+(NSString*)formateSecondsToMinutesOrHours:(double)seconds;//转秒到分或者小时，包含单位
+(NSString*)formateFlowWithByte:(double)byte;//格式化流量：byte->MB/GB 如1.00MB/1.00GB
+(NSString*)formateFlowWithByte2:(double)byte;//格式化流量：byte->MB/GB 如1MB/1GB
+(NSDate*)getDateWithString:(NSString*)str formate:(NSString*)formate;
+(NSString*)formateDate:(NSDate*)date formate:(NSString*)formate;
+(NSDateComponents*)getNSDateComponentsWithDate:(NSDate*)date;
+(NSDate*)getLastMonthfromDate:(NSDate*)date;//上个月今天
////128位解密 AES
//+(NSString*)stringWithAES128DecryptWithKey:(NSString*)key formStr:(NSString*)string;
////128位加密 AES
//+(NSString*)stringWithAES128EncryptWithKey:(NSString*)key formStr:(NSString*)string;
+(id)objectWithJsonStr:(NSString*)jsonStr;//json字符串转为dictionary
+(NSString*)phoneNumberWithString:(NSString*)numberStr;//格式化电话号码 137 4444 2222

/**
 *  获取主题颜色
 *
 *  @return <#return value description#>
 */
+(UIColor*)getCurrentThemeColor;
/**
 *  获取主题颜色GlobalThemeColor
 *
 *  @return <#return value description#>
 */
+(GlobalThemeColor)getCurrentGlobalThemeColor;

+(void)setCurrentThemeColor:(NSString *)color;
@end
