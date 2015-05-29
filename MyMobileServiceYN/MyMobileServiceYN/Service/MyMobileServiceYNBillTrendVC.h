//
//  MyMobileServiceYNBillTrendVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-6.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"
#import "MyMobileServiceYNBaseVC.h"

@interface MyMobileServiceYNBillTrendVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,PNChartDelegate>
{
    UIScrollView *homeScrollView;
}

@property (retain,nonatomic) NSArray *cycleArray;
@property (retain,nonatomic) NSArray *billInfoArray;

@end
