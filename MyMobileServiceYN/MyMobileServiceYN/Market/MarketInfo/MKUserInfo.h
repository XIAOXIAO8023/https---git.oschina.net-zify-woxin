//
//  MKUserInfo.h
//  MyMobileServiceYN
//
//  Created by 陆楠 on 15/3/30.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKUserInfo : NSObject

#pragma mark - -物品相关
+(void)setHomeInfoArray:(NSArray *)homeInfoArray;
+(NSArray *)getHomeInfoArry;

+(NSArray *)getTicketInfoArray;

+(NSArray *)getGoodsInfoArray;

+(NSArray *)getFlowPackageArray;

+(NSArray *)getLocalTimePackageArray;

+(NSArray *)getCountryTimePackageArray;

+(NSArray *)getChargePackageArray;

+(NSArray *)getHomePackageArray;

#pragma mark - -积分相关
+(void)setHomePointArray:(NSArray *)homePointArray;
+(NSArray *)getHomePointArray;

+(void)setUnzeroPointArray:(NSArray *)unzeroPointArray;
+(NSArray *)getUnzeroPointArray;

+(void)setTotalPoint:(NSInteger)totalPoint;
+(NSInteger)getTotalPoint;

+(void)setPointInOutArray:(NSArray *)pointInOutArray;
+(NSArray *)getPointInOutArray;

+(NSArray *)getPointInArray;

+(NSArray *)getPointOutArray;

+(void)setGiftRecordArray:(NSArray *)giftRecordArray;
+(NSArray *)getGiftRecordArray;

@end








