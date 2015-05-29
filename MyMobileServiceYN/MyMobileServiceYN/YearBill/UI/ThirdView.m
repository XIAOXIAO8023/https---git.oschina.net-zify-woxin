//
//  ThirdView.m
//  YearBill
//
//  Created by 陆楠 on 15/3/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "ThirdView.h"
#import "LNAnimationNumber.h"
#import "LNAnimationNumber02.h"
#import "LNElasticRect.h"
#import "YBColorDef.h"
#import "YearBillUserInfo.h"


@implementation ThirdView
{
    LNAnimationNumber *labelUp;
    LNAnimationNumber02 *labelDown;
    LNElasticRect *boda;
    LNElasticRect *jieting;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pink.png"]];
    [self loadViews];
    
    return self;
}

-(void)setType:(int)type
{
    _type = type;
    if (animationView) {
        [animationView removeFromSuperview];
        [self loadAnimationView];
    }
}

-(void)loadViews
{
    [self loadTitleView];
    
    [self loadAnimationView];
}


-(void)loadTitleView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 290, 70)];
    [self addSubview:titleView];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.alpha = 0.1;
    
    labelUp = [[LNAnimationNumber alloc]initWithFrame:CGRectMake(15, 20, 290, 30)];
    [self addSubview:labelUp];
    labelUp.font = [UIFont fontWithName:@"Arial" size:14];
    labelUp.textColor = [UIColor whiteColor];
    labelUp.textAlignment = NSTextAlignmentCenter;
    labelUp.foreString = @"共通话了";
    labelUp.followString = @"分钟";
    labelUp.number = [YearBillUserInfo getCallTimes] + [YearBillUserInfo getAnswerTimes];
    labelUp.numberColor = UIColorFromRGB(TITLE_GREEN);
    labelUp.numberFont = [UIFont fontWithName:@"Arial" size:22];
    [labelUp showInitContent];
    
    labelDown = [[LNAnimationNumber02 alloc]initWithFrame:CGRectMake(15, 50, 290, 30)];
    [self addSubview:labelDown];
    labelDown.font = [UIFont fontWithName:@"Arial" size:14];
    labelDown.textColor = [UIColor whiteColor];
    labelDown.textAlignment = NSTextAlignmentCenter;
    labelDown.foreString = @"拨打";
    labelDown.midString = @"分钟，接听";
    labelDown.followString = @"分钟";
    labelDown.number = [YearBillUserInfo getCallTimes];
    labelDown.number02 = [YearBillUserInfo getAnswerTimes];
    labelDown.numberColor = UIColorFromRGB(TITLE_ORANGE);
    labelDown.numberFont = [UIFont fontWithName:@"Arial" size:14];
    [labelDown showInitContent];
}


-(void)loadAnimationView
{
    
    
    int detH;
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        detH = 0;
    }else{
        detH = 50;
    }
    
    animationView = [[UIView alloc]initWithFrame:CGRectMake(15, 90, 290, self.frame.size.height - 90 - 40)];
    [self addSubview:animationView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, animationView.frame.size.height - 30, 290, 30)];
    [animationView addSubview:label];
    label.textColor = [UIColor whiteColor];
    
    UIImageView *ph = [[UIImageView alloc]initWithFrame:CGRectMake(74, 20 + detH, 142, 241)];
    [animationView addSubview:ph];
    ph.image = [UIImage imageNamed:@"msg_mobile"];
    
    UIImageView *star01 = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10 + detH, 10, 10)];
    [animationView addSubview:star01];
    star01.image = [UIImage imageNamed:@"star_pink"];
    
    UIImageView *star02 = [[UIImageView alloc]initWithFrame:CGRectMake(270, 30 + detH, 16, 16)];
    [animationView addSubview:star02];
    star02.image = [UIImage imageNamed:@"star_pink"];
    
    UIImageView *star03 = [[UIImageView alloc]initWithFrame:CGRectMake(230, 250 + detH, 14, 14)];
    [animationView addSubview:star03];
    star03.image = [UIImage imageNamed:@"star_pink"];
    
    UIImageView *star04 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200 + detH, 14, 14)];
    [animationView addSubview:star04];
    star04.image = [UIImage imageNamed:@"star_pink"];
    
    
    jieting = [[LNElasticRect alloc]initWithFrame:CGRectMake(125, 230 + detH, 40, 70)];
    [animationView addSubview:jieting];
    jieting.backgroundColor = UIColorFromRGB(JD_GREEN);
    UILabel *bodaLaebel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 40, 20)];
    [jieting.footView addSubview:bodaLaebel];
    bodaLaebel.text = @"接听";
    bodaLaebel.font = [UIFont fontWithName:@"Arial" size:14];
    bodaLaebel.textColor = UIColorFromRGB(COMMON_PURPLE);
    bodaLaebel.textAlignment = NSTextAlignmentCenter;
    UIImageView *a = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [jieting.headView addSubview:a];
    a.image = [UIImage imageNamed:@"tel_come"];
    
    
    boda = [[LNElasticRect alloc]initWithFrame:CGRectMake(205, 230  + detH, 40, 70)];
    [animationView addSubview:boda];
    boda.backgroundColor = UIColorFromRGB(JD_BLUE);
    UILabel *jietingLaebel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 40, 20)];
    [boda.footView addSubview:jietingLaebel];
    jietingLaebel.text = @"拨打";
    jietingLaebel.font = [UIFont fontWithName:@"Arial" size:14];
    jietingLaebel.textColor = UIColorFromRGB(COMMON_PURPLE);
    jietingLaebel.textAlignment = NSTextAlignmentCenter;
    UIImageView *b = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [boda.headView addSubview:b];
    b.image = [UIImage imageNamed:@"tel_go"];
    
    
    if (/*接听*/_type == 1) {
        label.text = @"接听大于拨打，原来我这么受欢迎。";
        [jieting setAnimationHeight:140];
    }else if (/*拨打*/_type == 2){
        label.text = @"拨打大于接听，请叫我电话小达人";
        [boda setAnimationHeight:140];
    }else if (/*相等*/_type == 3){
        label.text = @"拨打等于接听，奇葩的不可思议";
        [jieting setAnimationHeight:140];
        [boda setAnimationHeight:140];
    }
}



-(void)startAnimation
{
    [labelUp startAnimation];
    [labelDown startAnimation];
    [jieting startAnimation];
    [boda startAnimation];
}

@end




    
    
    
    
    
    
    
