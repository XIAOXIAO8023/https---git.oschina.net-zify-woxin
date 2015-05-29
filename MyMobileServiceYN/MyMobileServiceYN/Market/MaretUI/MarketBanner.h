//
//  MarketBanner.h
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"

@interface MarketBanner : UIView
{
    CycleScrollView *bannerSc;
    
    UIPageControl *bannerPageCtr;
}

@property (nonatomic, retain) NSArray *adArr;

@end
