//
//  MKUserInfo.m
//  MyMobileServiceYN
//
//  Created by 陆楠 on 15/3/30.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import "MKUserInfo.h"
#import "MyMobileServiceYNParam.h"

@implementation MKUserInfo

#pragma mark - -物品相关
/*
 *商城总包
 */
static NSArray *kHomeInfoArray;
+(void)setHomeInfoArray:(NSArray *)homeInfoArray
{
    kHomeInfoArray = homeInfoArray;
    
    NSMutableArray *ticketInfoArray = [[NSMutableArray alloc]init];
    NSMutableArray *goodsInfoArray = [[NSMutableArray alloc]init];
    NSMutableArray *localTimePackageArray = [[NSMutableArray alloc]init];
    NSMutableArray *countryTimePackageArray = [[NSMutableArray alloc]init];
    NSMutableArray *flowPackageArray = [[NSMutableArray alloc]init];
    NSMutableArray *chargePackageArray = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0;i < homeInfoArray.count;i ++ ) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[homeInfoArray objectAtIndex:i]];
        NSString *name = [[dic objectForKey:@"TRADE_NAME"] stringByReplacingOccurrencesOfString:@"\\346" withString:@""];
        [dic setObject:name.copy forKey:@"TRADE_NAME"];
        if ([[dic objectForKey:@"TYPE"]isEqualToString:@"2"]) {
            [ticketInfoArray addObject:dic.copy];
        }else if ([[dic objectForKey:@"TYPE"]isEqualToString:@"3"]){
            [goodsInfoArray addObject:dic.copy];
        }else if ([[dic objectForKey:@"TYPE"]isEqualToString:@"11"]){
            [localTimePackageArray addObject:dic.copy];
        }else if ([[dic objectForKey:@"TYPE"]isEqualToString:@"12"]){
            [countryTimePackageArray addObject:dic.copy];
        }else if ([[dic objectForKey:@"TYPE"]isEqualToString:@"13"]){
            [flowPackageArray addObject:dic.copy];
        }else if ([[dic objectForKey:@"TYPE"]isEqualToString:@"14"]){
            [chargePackageArray addObject:dic.copy];
        }
    }
    
    [self setTicketInfoArry:ticketInfoArray];
    [self setGoodsInfoArray:goodsInfoArray];
    [self setLocalTimePackageArray:localTimePackageArray];
    [self setCountryTimePackageArray:countryTimePackageArray];
    [self setFlowPackageArray:flowPackageArray];
    [self setChargePackageArray:chargePackageArray];
}
+(NSArray *)getHomeInfoArry
{
    return kHomeInfoArray;
}

/*
 *电子券信息 type = 2
 */
static NSArray *kTicketInfoArray;
+(void)setTicketInfoArry:(NSArray *)ticketInfoArray
{
    kTicketInfoArray = ticketInfoArray;
}
+(NSArray *)getTicketInfoArray
{
    return kTicketInfoArray;
}

/*
 *实物信息 type = 3
 */
static NSArray *kGoodsInfoArray;
+(void)setGoodsInfoArray:(NSArray *)goodsInfoArray
{
    kGoodsInfoArray = goodsInfoArray;
}
+(NSArray *)getGoodsInfoArray
{
    return kGoodsInfoArray;
}

/*
 *本地通话时长包信息 type = 11
 */
static NSArray *kLocalTimePackageArray;
+(void)setLocalTimePackageArray:(NSArray *)localTimePackageArray
{
    kLocalTimePackageArray = localTimePackageArray;
}
+(NSArray *)getLocalTimePackageArray
{
    return kLocalTimePackageArray;
}

/*
 *国内通话时长包信息 type = 12
 */
static NSArray *kCountryTimePackageArray;
+(void)setCountryTimePackageArray:(NSArray *)countryTimePackageArray
{
    kCountryTimePackageArray  = countryTimePackageArray;
}
+(NSArray *)getCountryTimePackageArray
{
    return kCountryTimePackageArray;
}

/*
 *流量包信息 type = 13
 */
static NSArray *kFlowPackageArray;
+(void)setFlowPackageArray:(NSArray *)flowPackageArray
{
    kFlowPackageArray = flowPackageArray;
}
+(NSArray *)getFlowPackageArray
{
    return kFlowPackageArray;
}

/*
 *话费包信息  type = 14
 */
static NSArray *kChargePackageArray;
+(void)setChargePackageArray:(NSArray *)chargePackageArray
{
    kChargePackageArray = chargePackageArray;
}
+(NSArray *)getChargePackageArray
{
    return kChargePackageArray;
}

/*
 *主页显示的基础通信包
 */
+(NSArray *)getHomePackageArray
{
    NSMutableArray *array;
    
    if ([MyMobileServiceYNParam getIsLogin]) {
        NSDictionary *flowDic = [[self getFlowPackageArray] objectAtIndex:0];
        NSDictionary *countryTimeDic = [[self getChargePackageArray] objectAtIndex:0];
        NSDictionary *LocalTimeDic = [[self getLocalTimePackageArray] objectAtIndex:0];
        for (NSDictionary *dic in [self getFlowPackageArray]) {
            if ([[dic objectForKey:@"INTEGRAL_VALUE"] integerValue] < [self getTotalPoint]) {
                flowDic = dic;
            }else{
                break;
            }
        }
        for (NSDictionary *dic in [self getCountryTimePackageArray]) {
            if ([[dic objectForKey:@"INTEGRAL_VALUE"] integerValue] < [self getTotalPoint]) {
                countryTimeDic = dic;
            }else{
                break;
            }
        }
        for (NSDictionary *dic in [self getLocalTimePackageArray]) {
            if ([[dic objectForKey:@"INTEGRAL_VALUE"] integerValue] < [self getTotalPoint]) {
                LocalTimeDic = dic;
            }else{
                break;
            }
        }
        array = [[NSMutableArray alloc]initWithObjects:flowDic,countryTimeDic,LocalTimeDic, nil];
    }else{
        array = [[NSMutableArray alloc]init];
        [array addObject:[[self getFlowPackageArray] objectAtIndex:0]];
        [array addObject:[[self getCountryTimePackageArray] objectAtIndex:0]];
        [array addObject:[[self getLocalTimePackageArray] objectAtIndex:0]];
    }
    
    return array;
}

#pragma mark -  -积分相关
/*
 *可用积分查询返回信息
 */
static NSArray *kHomePointArray;
+(void)setHomePointArray:(NSArray *)homePointArray
{
    kHomeInfoArray = homePointArray;
    NSMutableArray *unzeroPointArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in homePointArray) {
        if (![[dic objectForKey:@"SCORE_VALUE"] isEqualToString:@"0"]) {
            [unzeroPointArray addObject:dic.copy];
        }
    }
    [self setUnzeroPointArray:unzeroPointArray];
}
+(NSArray *)getHomePointArray
{
    return kHomeInfoArray;
}

/*
 *非零可用积分记录
 */
static NSArray *kUnzeroPointArray;
+(void)setUnzeroPointArray:(NSArray *)unzeroPointArray
{
    kUnzeroPointArray = unzeroPointArray;
    NSInteger totalPoint = 0;
    for (NSDictionary *dic in kUnzeroPointArray) {
        totalPoint += [[dic objectForKey:@"SCORE_VALUE"] integerValue];
    }
    [self setTotalPoint:totalPoint];
}
+(NSArray *)getUnzeroPointArray
{
    return kUnzeroPointArray;
}

/*
 *可用积分总值
 */
static NSInteger kTotalPoint;
+(void)setTotalPoint:(NSInteger)totalPoint
{
    if (kTotalPoint != totalPoint) {
        kTotalPoint = totalPoint;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"totalPointChanged" object:nil];
    }
}
+(NSInteger)getTotalPoint
{
    return kTotalPoint;
}

/*
 *积分出入总记录
 */
static NSArray *kPointInOutArray;
+(void)setPointInOutArray:(NSArray *)pointInOutArray
{
    kPointInOutArray = pointInOutArray;
    NSMutableArray *pointInArray = [[NSMutableArray alloc]init];
    NSMutableArray *pointOutArray  = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in pointInOutArray) {
        if ([[dic objectForKey:@"OPERA_TYPE"] isEqualToString:@"1"]) {
            [pointInArray addObject:dic.copy];
        }else if ([[dic objectForKey:@"OPERA_TYPE"] isEqualToString:@"2"]){
            [pointOutArray addObject:dic.copy];
        }
    }
    
    [self setPointInArray:pointInArray];
    [self setPointOutArray:pointOutArray];
    
}
+(NSArray *)getPointInOutArray
{
    return kPointInOutArray;
}

/*
 *积分入账记录
 */
static NSArray *kPointInArray;
+(void)setPointInArray:(NSArray *)pointInArray
{
    kPointInArray = pointInArray;
}
+(NSArray *)getPointInArray
{
    return kPointInArray;
}

/*
 *积分出账记录
 */
static NSArray *kPointOutArray;
+(void)setPointOutArray:(NSArray *)pointOutArray
{
    kPointOutArray = pointOutArray;
}
+(NSArray *)getPointOutArray
{
    return kPointOutArray;
}

/*
 *积分转赠
 */
static NSArray *kGiftRecordArray;
+(void)setGiftRecordArray:(NSArray *)giftRecordArray
{
    kGiftRecordArray = giftRecordArray;
}
+(NSArray *)getGiftRecordArray
{
    return kGiftRecordArray;
}

@end





























