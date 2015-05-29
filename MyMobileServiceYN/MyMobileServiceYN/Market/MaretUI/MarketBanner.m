//
//  MarketBanner.m
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "MarketBanner.h"

@implementation MarketBanner

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadBanner];
    
    return self;
}

-(void)setAdArr:(NSArray *)adArr
{
    _adArr = adArr;
    
    [self refreshAd];
}

-(void)loadBanner
{
    bannerSc = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, 300, 100) animationDuration:5.0f];
    [self addSubview:bannerSc];
    
    bannerPageCtr = [[UIPageControl alloc]initWithFrame:CGRectMake(120, self.frame.size.height - 20, 80, 20)];
//    [self addSubview:bannerPageCtr];
    bannerPageCtr.currentPage = 0;
}

-(void)refreshAd
{
    NSInteger count = _adArr.count;
    NSArray *arr = _adArr;
    [bannerSc setFetchContentViewAtIndex:^UIView *(NSInteger index) {
        return [arr objectAtIndex:index];
    }];
    
    [bannerSc setTotalPagesCount:^NSInteger{
        return arr.count;
    }];
    
    bannerPageCtr.numberOfPages = count;
    
}


@end












