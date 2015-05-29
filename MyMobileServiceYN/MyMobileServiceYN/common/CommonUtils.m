//
//  CommonUtils.m
//  CMClient
//
//  Created by zhaol on 14-9-28.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "CommonUtils.h"
//#import "NSData+AES.h"
//#import "GTMBase64.h"
#import "SBJson.h"

@implementation CommonUtils
+(NSString*)formateFee:(double)fee{//格式化费用 #0.00
    NSNumberFormatter *numberFormatter=[[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumIntegerDigits:1];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:fee]];
}

+(NSString*)formateNumber:(NSNumber*)number FractionDigits:(int)num{//格式化数字,保留num位小数
    NSNumberFormatter *numberFormatter=[[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    [numberFormatter setMinimumFractionDigits:num];
    [numberFormatter setMaximumFractionDigits:num];
    [numberFormatter setMinimumIntegerDigits:1];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    return [numberFormatter stringFromNumber:number];
}

+(NSString*)formateFee2:(double)fee{//格式化费用 #0
    NSNumberFormatter *numberFormatter=[[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    [numberFormatter setMinimumFractionDigits:0];
    [numberFormatter setMaximumFractionDigits:1];
    [numberFormatter setMinimumIntegerDigits:1];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:fee]];
}
+(double)formateSecondsToMinutes:(double)seconds{
    return seconds/60.0;
}
+(NSString*)formateSecondsToMinutesOrHours:(double)seconds{//转秒到分或者小时，包含单位
    seconds=seconds/60.0/60.0;
    NSString *unit;
    NSString *times;
    if (seconds>1) {
        unit=@"小时";
//        seconds=round(seconds*10)/10;
        times=[NSString stringWithFormat:@"%.1f小时",seconds];
    }else{
        seconds=seconds*60.0;
        unit=@"分钟";
//        seconds=round(seconds);
        times=[NSString stringWithFormat:@"%.0f分钟",seconds];
    }
    return times;
}

+(NSString*)formateFlowWithByte:(double)byte{
    byte=byte/1024.0/1024.0/1024.0;
    NSString *type;
    if (byte<=1) {
        byte*=1024;
        type=@"MB";
    }else{
        type=@"GB";
    }
    NSString*numStr=[CommonUtils formateFee:byte];
    return [NSString stringWithFormat:@"%@%@",numStr,type];
}
+(NSString*)formateFlowWithByte2:(double)byte{
    byte=byte/1024/1024/1024;
    NSString *type;
    if (byte<=1) {
        byte*=1024;
        type=@"MB";
    }else{
        type=@"GB";
    }
    NSString*numStr=[CommonUtils formateFee2:byte];
    return [NSString stringWithFormat:@"%@%@",numStr,type];
}

+(NSDate *)getDateWithString:(NSString *)str formate:(NSString *)formate{
    //@"yyyy-MM-dd HH:mm:ss.S"
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:formate];
    NSDate* date = [inputFormatter dateFromString:str];
    return date;
}
+(NSString *)formateDate:(NSDate *)date formate:(NSString *)formate{
    //@"yyyy-MM-dd HH:mm:ss.S"
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:formate];
    return [inputFormatter stringFromDate:date];
}
+(NSDateComponents*)getNSDateComponentsWithDate:(NSDate*)date{
    //获取日期，星期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *comps = [calendar components:units fromDate:date];
    return comps;
}
//上个月
+(NSDate*)getLastMonthfromDate:(NSDate*)date{
    //获取日期，星期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *comps = [calendar components:units fromDate:date];
    [comps setMonth:[comps month]-1];
    return [calendar dateFromComponents:comps];
}
////128位解密 AES
//+(NSString*)stringWithAES128DecryptWithKey:(NSString*)key formStr:(NSString*)string{
//    NSData *base64Data=[GTMBase64 decodeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
//    NSData *data=[base64Data AES128DecryptWithKey:key];
//    NSString *returnStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    return returnStr;
//}
////128位加密 AES
//+(NSString*)stringWithAES128EncryptWithKey:(NSString*)key formStr:(NSString*)string{
//    NSData *data=[[string dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptWithKey:key];
//    NSString *returnStr=[NSData encodeBase64Data:data];
//    return returnStr;
//}
//json字符串转为object
+(id)objectWithJsonStr:(NSString*)jsonStr{
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSError *error = nil;
    return [parser objectWithString:jsonStr error:&error];
}
//格式化电话号码 137 4444 2222
+(NSString*)phoneNumberWithString:(NSString*)numberStr{
    NSMutableString *phoneNum=[[NSMutableString alloc]initWithString:numberStr];
    if(phoneNum.length>=7){
        [phoneNum insertString:@" " atIndex:7];
        [phoneNum insertString:@" " atIndex:3];
    }
    return phoneNum;
}


/**
 *  获取主题颜色
 *
 *  @return <#return value description#>
 */
+(UIColor*)getCurrentThemeColor
{
    GlobalThemeColor currentColor = [self getCurrentGlobalThemeColor];
    UIColor* themeColor;
    if (currentColor == GlobalThemeColorRed) {
        themeColor = UIColorFromRGB(rgbValue_Theme_red);
    }else if (currentColor == GlobalThemeColorBlue){
        themeColor = UIColorFromRGB(rgbValue_Theme_blue);
    }else if (currentColor == GlobalThemeColorGreen){
        themeColor = UIColorFromRGB(rgbValue_Theme_green);
    }else if (currentColor == GlobalThemeColorPueple){
        themeColor = UIColorFromRGB(rgbValue_Theme_pueple);
    }
    return themeColor;
}
/**
 *  获取主题颜色GlobalThemeColor
 *
 *  @return <#return value description#>
 */
+(GlobalThemeColor)getCurrentGlobalThemeColor{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename = [plistPath1 stringByAppendingPathComponent:@"currentTheme.plist"];
    NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    
    NSString *currentColor = [currentTheme objectForKey:@"currentTheme"];
    GlobalThemeColor themeColor;
    if ([currentColor isEqualToString:@"red"]) {
        themeColor=GlobalThemeColorRed;
    }else if ([currentColor isEqualToString:@"blue"]){
        themeColor=GlobalThemeColorBlue;
    }else if ([currentColor isEqualToString:@"green"]){
        themeColor=GlobalThemeColorGreen;
    }else if ([currentColor isEqualToString:@"pueple"]){
        themeColor=GlobalThemeColorPueple;
    }
    return themeColor;
}


+(void)setCurrentThemeColor:(NSString *)color
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"currentTheme.plist"];
    NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    [currentTheme setObject:color forKey:@"currentTheme"];
    [currentTheme writeToFile:filename atomically:YES];
    
    
}
@end
