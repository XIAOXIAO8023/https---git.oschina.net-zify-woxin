//
//  DateDeal.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-18.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "DateDeal.h"

@implementation DateDeal

+(NSDateComponents *)getDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    return comps;
}

+(NSInteger)getYear
{
    NSDateComponents *comps = [self getDateComponents];
    return [comps year];
}

+(NSInteger)getMonth
{
    NSDateComponents *comps = [self getDateComponents];
    return [comps month];
}

+(NSInteger)getDay{
    NSDateComponents *comps = [self getDateComponents];
    return [comps day];
}

+(NSArray *)getYearMonthSixBefore
{
    NSDateComponents *comps = [self getDateComponents];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    
    NSMutableArray *returnCycle = [[NSMutableArray alloc]init];
    
    for (int i=5; i>=0; i--) {
        NSMutableString *cycleSixMonthBeforeNow=[[NSMutableString alloc]init];
        if (month > i) {
            if((month-i)>9){
                [cycleSixMonthBeforeNow appendString:[NSString stringWithFormat:@"%d%d",year,(month-i)]];
            }else{
                [cycleSixMonthBeforeNow appendString:[NSString stringWithFormat:@"%d0%d",year,(month-i)]];
            }
        }
        else
        {
            if ((12+month-i)>9) {
                [cycleSixMonthBeforeNow appendString:[NSString stringWithFormat:@"%d%d",(year-1),(12+month-i)]];
            }else
            {
                [cycleSixMonthBeforeNow appendString:[NSString stringWithFormat:@"%d0%d",(year-1),(12+month-i)]];
            }
        }
        
        [returnCycle addObject:cycleSixMonthBeforeNow];
    }
    return returnCycle;
    
}

+(NSString *)getYearMonthNow
{
    NSDateComponents *comps = [self getDateComponents];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    
    NSMutableString *cycleSixMonthBeforeNow=[[NSMutableString alloc]init];

    if (month>9) {
        [cycleSixMonthBeforeNow appendString:[NSString stringWithFormat:@"%d%d",year,month]];
    }else
    {
        [cycleSixMonthBeforeNow appendString:[NSString stringWithFormat:@"%d0%d",year,month]];
    }
    return cycleSixMonthBeforeNow;
}

+(NSInteger)getSecond
{
    NSDateComponents *comps = [self getDateComponents];
    return [comps second];
}

+(NSInteger)getDays{
    NSDate *today = [NSDate date];
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:today];
    return days.length;
}

+(NSInteger)getCurrentMonthFromMonth:(NSString *)futureDate{
    NSString *temp=futureDate;
    NSInteger futureYear=[[temp substringToIndex:4] integerValue];
    NSInteger futureMonth=[[temp substringFromIndex:4] integerValue];
    NSInteger currentYear=[self getYear];
    NSInteger currentMonth=[self getMonth];
    if(futureYear<=currentYear&&futureMonth<=currentMonth){
        return 0;
    }else{
        if(futureYear==currentYear&&futureMonth>currentMonth){
            return futureMonth-currentMonth;
        }else if(futureYear>currentYear){
            if(futureYear-currentYear>1){
                return 12-currentMonth+futureMonth+(futureYear-currentYear-1)*12;
            }else{
                return 12-currentMonth+futureMonth;
            }
        }else{
            return 0;
        }
    }
}


@end
