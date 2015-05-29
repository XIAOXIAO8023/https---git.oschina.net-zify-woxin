//
//  FirstView02.m
//  YearBill
//
//  Created by 陆楠 on 15/2/11.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "FirstView02.h"
#import "SpinView.h"
#import "MoveUtils.h"
#import "HotAirBalloonView.h"

@implementation FirstView02

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_blue.png"]];
    
    [self addSubviews];
    
    return self;
}


-(void)addSubviews
{
    [self addSun];// 放一个太阳
    [self addHotAirBalloon];//放一个热气球
    [self addClouds];//放几朵云
    [self addSeasonView];//季节图片
    
}

-(void)addHotAirBalloon
{
    HotAirBalloonView *balloon = [[HotAirBalloonView alloc]initWithFrame:CGRectMake(self.frame.size.width - 20, self.frame.size.height * 2 / 5 , 23, 35)];
    [self addSubview:balloon];
    balloon.image = [UIImage imageNamed:@"hot.png"];
    [balloon startAnimation];
}


-(void)addSun
{
    SpinView *sun = [[SpinView alloc]initWithFrame:CGRectMake(self.frame.size.width / 5, self.frame.size.height / 4, 40, 40)];
    [self addSubview:sun];
    sun.image = [UIImage imageNamed:@"sun.png"];
    sun.tag = 11111;
}


-(void)addClouds
{
    UIImageView *cloud01 = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 5, self.frame.size.height * 28 / 96, 31, 21)];
    [self addSubview:cloud01];
    cloud01.image = [UIImage imageNamed:@"yun_1.png"];
    [MoveUtils moveView:cloud01 to:CGPointMake(cloud01.frame.origin.x + 200, cloud01.frame.origin.y) withDuration:6.0f completion:nil];
    
    UIImageView *cloud02 = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2, self.frame.size.height * 23 / 96, 24, 16)];
    [self addSubview:cloud02];
    cloud02.image = [UIImage imageNamed:@"yun_2.png"];
    [MoveUtils moveView:cloud02 to:CGPointMake(cloud02.frame.origin.x + 100, cloud02.frame.origin.y) withDuration:6.0f completion:nil];
    
    
    UIImageView *cloud03 = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 4, self.frame.size.height * 17 / 96, 20, 12)];
    [self addSubview:cloud03];
    cloud03.image = [UIImage imageNamed:@"yun_3.png"];
    [MoveUtils moveView:cloud03 to:CGPointMake(cloud03.frame.origin.x + 80, cloud03.frame.origin.y) withDuration:6.0f completion:nil];
}

-(void)addSeasonView
{
    UIImageView *season = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 185, 320, 185)];
    [self addSubview:season];
    season.image = [UIImage imageNamed:@"foot_chun"];
}


@end








