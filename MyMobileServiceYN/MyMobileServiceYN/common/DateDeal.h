//
//  DateDeal.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-18.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateDeal : NSObject

+(NSDateComponents *)getDateComponents;
+(NSInteger)getYear;
+(NSInteger)getMonth;
+(NSInteger)getDay;
+(NSArray *)getYearMonthSixBefore;
+(NSString *)getYearMonthNow;
+(NSInteger)getSecond;
+(NSInteger)getDays;
+(NSInteger)getCurrentMonthFromMonth:(NSString *)futureDate;

@end
