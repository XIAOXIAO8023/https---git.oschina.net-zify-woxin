//
//  SecondView.m
//  YearBill
//
//  Created by 陆楠 on 15/2/28.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "SecondView.h"
#import "LNAnimationNumber.h"
#import "TELDetailView.h"
#import "LNAnimationUtils.h"
#import "YBColorDef.h"
#import "YearBillUserInfo.h"

@interface UIImageView (ap)

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;

@end

@implementation UIImageView (ap)

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

@end


@implementation SecondView
{
    LNAnimationNumber *labelUp;
    LNAnimationNumber *labelDown;
    
    UIView *animationView;
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
    
    [self addDetailBtn];
    
    [self loadAnimationView];
    
}

-(void)loadTitleView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 290, 70)];
    [self addSubview:titleView];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.alpha = 0.1;
    
    NSDictionary *most = [YearBillUserInfo getMostCostDic];
    
    labelUp = [[LNAnimationNumber alloc]initWithFrame:CGRectMake(15, 20, 290, 30)];
    [self addSubview:labelUp];
    labelUp.font = [UIFont fontWithName:@"Arial" size:14];
    labelUp.textColor = [UIColor whiteColor];
    labelUp.textAlignment = NSTextAlignmentCenter;
    labelUp.foreString = @"共消费了";
    labelUp.followString = @"元";
    labelUp.number = [YearBillUserInfo getTotalCost];
    labelUp.numberColor = UIColorFromRGB(TITLE_GREEN);
    labelUp.numberFont = [UIFont fontWithName:@"Arial" size:22];
    [labelUp showInitContent];
    
    labelDown = [[LNAnimationNumber alloc]initWithFrame:CGRectMake(15, 50, 290, 30)];
    [self addSubview:labelDown];
    labelDown.font = [UIFont fontWithName:@"Arial" size:14];
    labelDown.textColor = [UIColor whiteColor];
    labelDown.textAlignment = NSTextAlignmentCenter;
    labelDown.foreString = @"其中";
    labelDown.followString = [NSString stringWithFormat:@"用于%@",[YearBillUserInfo getMostCost]];
    labelDown.number = ((NSString *)[most objectForKey:@"cost"]).floatValue / [YearBillUserInfo getTotalCost] *100;
    labelDown.specialCharacters = @"%";
    labelDown.numberColor = UIColorFromRGB(TITLE_ORANGE);
    labelDown.numberFont = [UIFont fontWithName:@"Arial" size:22];
    [labelDown showInitContent];
    
}

-(void)startAnimation
{
    [labelUp startAnimation];
    [labelDown startAnimation];
    if (_type == 1) {
        
    }else if (_type == 2){
        [self DuanXinAnimation];
    }else if (_type == 3){
        [self TaoCanAnimation];
    }else if (_type == 4){
        [self ShangWangAnimation];
    }else if (_type == 5){
        [self QiTaAnimation];
    }
    
    
}


-(void)loadAnimationView
{
    
    animationView = [[UIView alloc]initWithFrame:CGRectMake(15, 90, 290, self.frame.size.height - 90 - 40)];
    [self addSubview:animationView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, animationView.frame.size.height - 30, 290, 50)];
    [animationView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;
    
    if (/*电话*/_type == 1) {
        [self loadDianHuaAni];
        label.text = @"短信、语音、都不如电话来的直接";
    }else if (/*短信*/_type == 2){
        [self loadDuanxinAni];
        label.text = @"难道您就是传说中的拇指神哥？";
    }else if (/*套餐*/_type == 3){
        [self loadTaoCanAni];
        label.text = @"不超支、不超额、您的预算刚刚好";
    }else if (/*上网*/_type == 4){
        [self loadShangWangAni];
        label.text = @"聊微信~玩APP~看视频~\n咱一个也不能少";
    }else if (/*其它*/_type == 5){
        [self loadQiTaAni];
        label.text = @"增值、物联网业务到底哪里好，你竟然离不了";
    }
    
    [self bringSubviewToFront:de];
}

#pragma -
#pragma 电话

-(void)loadDianHuaAni
{
    UIImageView *man = [[UIImageView alloc]initWithFrame:CGRectMake(30, animationView.frame.size.height / 5, 117 *1.1, 187.5 * 1.1)];
    [animationView addSubview:man];
    man.image = [UIImage imageNamed:@"telephone_ren"];
    
    UIImageView *bubble01 = [[UIImageView alloc]initWithFrame:CGRectMake(165, animationView.frame.size.height / 5 - 10, 16 * 1.5, 14.5 * 1.5)];
    [animationView addSubview:bubble01];
    bubble01.image = [UIImage imageNamed:@"pao_1"];
    
    
    UIImageView *bubble02 = [[UIImageView alloc]initWithFrame:CGRectMake(195, animationView.frame.size.height / 5 - 60, 72, 59)];
    [animationView addSubview:bubble02];
    bubble02.image = [UIImage imageNamed:@"pao_2"];
    
    
    CABasicAnimation* fadeAnimation1;
    fadeAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation1.fromValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation1.toValue = [NSNumber numberWithFloat: 1.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fadeAnimation1.duration = 2.0;
    fadeAnimation1.RepeatCount = 999;
    fadeAnimation1.fillMode = kCAFillModeForwards;
    [bubble01.layer addAnimation:fadeAnimation1 forKey:@"Fade1"];
    
    CABasicAnimation* fadeAnimation2;
    fadeAnimation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation2.fromValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation2.toValue = [NSNumber numberWithFloat: 1.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fadeAnimation2.duration = 2.0;
    fadeAnimation2.RepeatCount = 999;
    fadeAnimation2.fillMode = kCAFillModeForwards;
    fadeAnimation2.beginTime = CACurrentMediaTime()+0.5;
    [bubble02.layer addAnimation:fadeAnimation2 forKey:@"Fade2"];
    
}


-(void)addDetailBtn
{
    de = [[UIButton alloc]initWithFrame:CGRectMake(220, [[UIScreen mainScreen] bounds].size.height - 64 - 140, 73, 73)];
    [self addSubview:de];
    [de setBackgroundImage:[UIImage imageNamed:@"zdfb"] forState:UIControlStateNormal];
    [de setTitle:@"查看我的\n账单分布" forState:UIControlStateNormal];
    [de setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [de.titleLabel setNumberOfLines:2];
    [de.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [de.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12]];
    [de addTarget:self action:@selector(bringDeatilsView) forControlEvents:UIControlEventTouchUpInside];
}

-(void)bringDeatilsView
{
    NSLog(@"弹出账单分布...");
    
    TELDetailView *del = [[TELDetailView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height)];
    [self.window addSubview:del];
    [LNAnimationUtils view:del showWithType:LNAnimationUtilsShowTypeFrom0Percent options:UIViewAnimationOptionCurveEaseInOut inTime:1.0f completion:nil];
}

#pragma -
#pragma 短信

-(void)loadDuanxinAni
{
    int detH;
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        detH = 0;
    }else{
        detH = 50;
    }
    
    UIImageView *mz = [[UIImageView alloc]initWithFrame:CGRectMake(91, 100 + detH, 108.5, 141)];
    [animationView addSubview:mz];
    mz.image = [UIImage imageNamed:@"msg_mz"];
    mz.tag = 100;
    
    
    UIImageView *ph = [[UIImageView alloc]initWithFrame:CGRectMake(74, 20 + detH, 142, 241)];
    [animationView addSubview:ph];
    ph.image = [UIImage imageNamed:@"msg_mobile"];
    ph.tag = 101;
    
    
    UIView *smss = [[UIView alloc]initWithFrame:CGRectMake(10, 100 + detH, 270, 50)];
    [animationView addSubview:smss];
    smss.tag = 102;
    
    UIImageView *sms1 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 33.5, 39)];
    [smss addSubview:sms1];
    sms1.image = [UIImage imageNamed:@"msg_1"];
    
    UIImageView *sms2 = [[UIImageView alloc]initWithFrame:CGRectMake(120, 18, 47.5, 45)];
    [smss addSubview:sms2];
    sms2.image = [UIImage imageNamed:@"msg_2"];
    
    
    UIImageView *sms3 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 15, 39, 31.5)];
    [smss addSubview:sms3];
    sms3.image = [UIImage imageNamed:@"msg_3"];
    
    UIImageView *sms4 = [[UIImageView alloc]initWithFrame:CGRectMake(25, 90, 29.5, 21.5)];
    [smss addSubview:sms4];
    sms4.image = [UIImage imageNamed:@"msg_4"];
    
    UIImageView *sms5 = [[UIImageView alloc]initWithFrame:CGRectMake(45, 80, 19, 18)];
    [smss addSubview:sms5];
    sms5.image = [UIImage imageNamed:@"msg_7"];
    
    UIImageView *sms6 = [[UIImageView alloc]initWithFrame:CGRectMake(125, 80, 25, 21.5)];
    [smss addSubview:sms6];
    sms6.image = [UIImage imageNamed:@"msg_5"];
    
    UIImageView *sms7 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 85, 32, 41)];
    [smss addSubview:sms7];
    sms7.image = [UIImage imageNamed:@"msg_6"];
    
    smss.alpha = 0;
}

-(void)DuanXinAnimation
{
    int detH;
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        detH = 0;
    }else{
        detH = 50;
    }
    
    UIImageView *mz = (UIImageView *)[self viewWithTag:100];
    UIView *smss = (UIView *)[self viewWithTag:102];
    smss.frame = CGRectMake(10, 100+ detH, 270, 50);
    smss.alpha = 0;
    [mz setAnchorPoint:CGPointMake(0.5, 1.5) forView:mz];
    
    
    
    CABasicAnimation* rotationAnimation1;
    rotationAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation1.toValue = [NSNumber numberWithFloat: M_PI * -0.02 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation1.duration = 0.2;
    rotationAnimation1.RepeatCount = 1;
    rotationAnimation1.removedOnCompletion = NO;
    rotationAnimation1.fillMode = kCAFillModeForwards;
    [mz.layer addAnimation:rotationAnimation1 forKey:@"Rotation1"];
    
    CABasicAnimation* rotationAnimation2;
    rotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation2.toValue = [NSNumber numberWithFloat: M_PI * 0.04 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation2.duration = 0.4;
    rotationAnimation2.RepeatCount = 1;
    rotationAnimation2.removedOnCompletion = NO;
    rotationAnimation2.fillMode = kCAFillModeForwards;
    rotationAnimation2.beginTime = CACurrentMediaTime() + 0.2;
    [mz.layer addAnimation:rotationAnimation2 forKey:@"Rotation2"];
    
    CABasicAnimation* rotationAnimation3;
    rotationAnimation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation3.toValue = [NSNumber numberWithFloat: M_PI * -0.04 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation3.duration = 0.4;
    rotationAnimation3.RepeatCount = 1;
    rotationAnimation3.removedOnCompletion = NO;
    rotationAnimation3.fillMode = kCAFillModeForwards;
    rotationAnimation3.beginTime = CACurrentMediaTime() + 0.6;
    [mz.layer addAnimation:rotationAnimation3 forKey:@"Rotation3"];
    
    CABasicAnimation* rotationAnimation4;
    rotationAnimation4 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation4.toValue = [NSNumber numberWithFloat: M_PI * 0.04 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation4.duration = 0.4;
    rotationAnimation4.RepeatCount = 1;
    rotationAnimation4.removedOnCompletion = NO;
    rotationAnimation4.fillMode = kCAFillModeForwards;
    rotationAnimation4.beginTime = CACurrentMediaTime() + 1.0;
    [mz.layer addAnimation:rotationAnimation4 forKey:@"Rotation4"];
    
    CABasicAnimation* rotationAnimation5;
    rotationAnimation5 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation5.toValue = [NSNumber numberWithFloat: M_PI * -0.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation5.duration = 0.2;
    rotationAnimation5.RepeatCount = 1;
    rotationAnimation5.removedOnCompletion = NO;
    rotationAnimation5.fillMode = kCAFillModeForwards;
    rotationAnimation5.beginTime = CACurrentMediaTime() + 1.2;
    [mz.layer addAnimation:rotationAnimation5 forKey:@"Rotation5"];
    
    [UIView animateWithDuration:2.0f animations:^{
        smss.frame = CGRectMake(smss.frame.origin.x, smss.frame.origin.y - 100, smss.frame.size.width, smss.frame.size.height) ;
        smss.alpha = 1;
    } completion:^(BOOL finished) {
        [mz setAnchorPoint:CGPointMake(0.5, 0.5) forView:mz];
    }];
}

#pragma - 
#pragma 上网

-(void)loadShangWangAni
{
    UIImageView *p = [[UIImageView alloc]initWithFrame:CGRectMake(92.5, 75, 105, 185)];
    [animationView addSubview:p];
    p.image = [UIImage imageNamed:@"sw_mobile"];
    
    UIImageView *s1 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 10, 10)];
    [animationView addSubview:s1];
    s1.image = [UIImage imageNamed:@"star_pink"];
    
    UIImageView *s2 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 230, 8, 8)];
    [animationView addSubview:s2];
    s2.image = [UIImage imageNamed:@"star_swyellow"];
    
    UIImageView *s3 = [[UIImageView alloc]initWithFrame:CGRectMake(250, 70, 10, 10)];
    [animationView addSubview:s3];
    s3.image = [UIImage imageNamed:@"star_swyellow"];
    
    UIImageView *s4 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 250, 10, 10)];
    [animationView addSubview:s4];
    s4.image = [UIImage imageNamed:@"star_pink"];
    
    UIImageView *a1 = [[UIImageView alloc]initWithFrame:CGRectMake(110, 25, 50, 51)];
    [animationView addSubview:a1];
    a1.image = [UIImage imageNamed:@"sw_weixin"];
    a1.tag = 401;
    
    UIImageView *a2 = [[UIImageView alloc]initWithFrame:CGRectMake(45, 105, 52, 53)];
    [animationView addSubview:a2];
    a2.image = [UIImage imageNamed:@"sw_shiping"];
    a2.tag = 402;
    
    UIImageView *a3 = [[UIImageView alloc]initWithFrame:CGRectMake(175, 85, 52, 53)];
    [animationView addSubview:a3];
    a3.image = [UIImage imageNamed:@"sw_sina"];
    a3.tag = 403;
}
-(void)ShangWangAnimation
{
    UIImageView *a1 = (UIImageView *)[animationView viewWithTag:401];
    UIImageView *a2 = (UIImageView *)[animationView viewWithTag:402];
    UIImageView *a3 = (UIImageView *)[animationView viewWithTag:403];
    
    a1.transform = CGAffineTransformMakeScale(0.001f ,0.001f);
    a2.transform = CGAffineTransformMakeScale(0.001f ,0.001f);
    a3.transform = CGAffineTransformMakeScale(0.001f ,0.001f);
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         a1.transform = CGAffineTransformMakeScale(1.0f ,1.0f);
                     }];
    
    [UIView animateWithDuration:0.5f
                          delay:0.3f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         a2.transform = CGAffineTransformMakeScale(1.0f ,1.0f);
                     }
                     completion:nil];
    
    [UIView animateWithDuration:0.5f
                          delay:0.4f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         a3.transform = CGAffineTransformMakeScale(1.0f ,1.0f);
                     }
                     completion:nil];
}

#pragma -
#pragma 套餐

-(void)loadTaoCanAni
{
    UIImageView *jz = [[UIImageView alloc]initWithFrame:CGRectMake(92, 40, 108, 226)];
    [animationView addSubview:jz];
    jz.image = [UIImage imageNamed:@"tc_pz"];
    
    UIImageView *v1 = [[UIImageView alloc]initWithFrame:CGRectMake(70, 90, 64, 37)];
    [animationView addSubview:v1];
    v1.image = [UIImage imageNamed:@"tc_pmsg"];
    v1.tag = 201;
    
    UIImageView *v2 = [[UIImageView alloc]initWithFrame:CGRectMake(70, 150, 64, 37)];
    [animationView addSubview:v2];
    v2.image = [UIImage imageNamed:@"tc_p2"];
    v2.tag = 202;
    
    UIImageView *v3 = [[UIImageView alloc]initWithFrame:CGRectMake(70, 205, 50, 45)];
    [animationView addSubview:v3];
    v3.image = [UIImage imageNamed:@"tc_p1"];
    v3.tag = 203;
    
    v1.alpha = 0;
    v2.alpha = 0;
    v3.alpha = 0;
}

-(void)TaoCanAnimation
{
    UIImageView *v1 = (UIImageView *)[animationView viewWithTag:201];
    UIImageView *v2 = (UIImageView *)[animationView viewWithTag:202];
    UIImageView *v3 = (UIImageView *)[animationView viewWithTag:203];
    v1.alpha = 0;
    v2.alpha = 0;
    v3.alpha = 0;
    
    v1.frame = CGRectMake(70, 90, 64, 37);
    v2.frame = CGRectMake(70, 150, 64, 37);
    v3.frame = CGRectMake(70, 205, 50, 45);
    
    [UIView animateWithDuration:1.0f
                     animations:^{
                         v1.frame = CGRectMake(v1.frame.origin.x + 44, v1.frame.origin.y, v1.frame.size.width, v1.frame.size.height);
                         v1.alpha = 1;
                     }
                     completion:nil];
    [UIView animateWithDuration:1.0f delay:0.2f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         v2.frame = CGRectMake(v2.frame.origin.x + 44, v2.frame.origin.y, v2.frame.size.width, v2.frame.size.height);
                         v2.alpha = 1;
                     }
                     completion:nil];
    [UIView animateWithDuration:1.0f delay:0.4f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         v3.frame = CGRectMake(v3.frame.origin.x + 50, v3.frame.origin.y, v3.frame.size.width, v3.frame.size.height);
                         v3.alpha = 1;
                     }
                     completion:nil];
}

#pragma -
#pragma 其它
-(void)loadQiTaAni
{
    UIImageView *tc = [[UIImageView alloc]initWithFrame:CGRectMake(70, 125 + (animationView.frame.size.height - 286), 150, 135)];
    [animationView addSubview:tc];
    tc.image = [UIImage imageNamed:@"other_buy"];
    tc.tag = 500;
    
    UIImageView *h1 = [[UIImageView alloc]initWithFrame:CGRectMake(137, 193 + (animationView.frame.size.height - 286), 32, 32)];
    [animationView addSubview:h1];
    h1.image = [UIImage imageNamed:@"other_qb"];
    h1.tag = 501;
    
    UIImageView *h2 = [[UIImageView alloc]initWithFrame:CGRectMake(103, 170 + (animationView.frame.size.height - 286), 40, 40)];
    [animationView addSubview:h2];
    h2.image = [UIImage imageNamed:@"other_tv"];
    h2.tag = 502;
    
    UIImageView *h3 = [[UIImageView alloc]initWithFrame:CGRectMake(102, 100 + (animationView.frame.size.height - 286), 92, 92)];
    [animationView addSubview:h3];
    h3.image = [UIImage imageNamed:@"other_book"];
    h3.tag = 503;
    
    UIImageView *q1 = [[UIImageView alloc]initWithFrame:CGRectMake(60, 30 + (animationView.frame.size.height - 286), 60, 108)];
    [animationView addSubview:q1];
    q1.image = [UIImage imageNamed:@"other_music"];
    q1.tag = 504;
    
    UIImageView *q2 = [[UIImageView alloc]initWithFrame:CGRectMake(170, 15 + (animationView.frame.size.height - 286), 60, 108)];
    [animationView addSubview:q2];
    q2.image = [UIImage imageNamed:@"other_game"];
    q2.tag = 505;
    
    
    [animationView bringSubviewToFront:tc];
}

-(void)QiTaAnimation
{
    UIImageView *tc = (UIImageView *)[animationView viewWithTag:500];
    UIImageView *h1 = (UIImageView *)[animationView viewWithTag:501];
    UIImageView *h2 = (UIImageView *)[animationView viewWithTag:502];
    UIImageView *h3 = (UIImageView *)[animationView viewWithTag:503];
    UIImageView *q1 = (UIImageView *)[animationView viewWithTag:504];
    UIImageView *q2 = (UIImageView *)[animationView viewWithTag:505];
    
    h1.alpha = 0;
    h2.alpha = 0;
    h3.alpha = 0;
    q1.alpha = 0;
    q2.alpha = 0;
    
    tc.frame = CGRectMake(tc.frame.origin.x + 300, tc.frame.origin.y, tc.frame.size.width, tc.frame.size.height);
    h1.frame = CGRectMake(h1.frame.origin.x, h1.frame.origin.y - 40, h1.frame.size.width, h1.frame.size.height);
    h2.frame = CGRectMake(h2.frame.origin.x, h2.frame.origin.y - 40, h2.frame.size.width, h2.frame.size.height);
    h3.frame = CGRectMake(h3.frame.origin.x, h3.frame.origin.y - 40, h3.frame.size.width, h3.frame.size.height);
    q1.frame = CGRectMake(q1.frame.origin.x, q1.frame.origin.y - 40, q1.frame.size.width, q1.frame.size.height);
    q2.frame = CGRectMake(q2.frame.origin.x, q2.frame.origin.y - 40, q2.frame.size.width, q2.frame.size.height);
    
    
    [UIView animateWithDuration:0.7f
                     animations:^{
                         tc.frame = CGRectMake(tc.frame.origin.x - 300, tc.frame.origin.y, tc.frame.size.width, tc.frame.size.height);
                     }];
    
    
    
    [UIView animateWithDuration:0.3f
                          delay:0.7f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         h1.frame = CGRectMake(h1.frame.origin.x, h1.frame.origin.y + 20, h1.frame.size.width, h1.frame.size.height);
                         h1.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              h1.frame = CGRectMake(h1.frame.origin.x, h1.frame.origin.y + 20, h1.frame.size.width, h1.frame.size.height);
                                          }
                                          completion:nil];
                     }];
    
    [UIView animateWithDuration:0.3f
                          delay:0.9f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         h2.frame = CGRectMake(h2.frame.origin.x, h2.frame.origin.y + 20, h2.frame.size.width, h2.frame.size.height);
                         h2.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              h2.frame = CGRectMake(h2.frame.origin.x, h2.frame.origin.y + 20, h2.frame.size.width, h2.frame.size.height);
                                          }
                                          completion:nil];
                     }];
    
    [UIView animateWithDuration:0.3f
                          delay:1.1f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         h3.frame = CGRectMake(h3.frame.origin.x, h3.frame.origin.y + 20, h3.frame.size.width, h3.frame.size.height);
                         h3.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              h3.frame = CGRectMake(h3.frame.origin.x, h3.frame.origin.y + 20, h3.frame.size.width, h3.frame.size.height);
                                          }
                                          completion:nil];
                     }];
    
    [UIView animateWithDuration:0.3f
                          delay:1.3f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         q1.frame = CGRectMake(q1.frame.origin.x, q1.frame.origin.y + 20, q1.frame.size.width, q1.frame.size.height);
                         q1.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              q1.frame = CGRectMake(q1.frame.origin.x, q1.frame.origin.y + 20, q1.frame.size.width, q1.frame.size.height);
                                          }
                                          completion:nil];
                     }];
    
    [UIView animateWithDuration:0.3f
                          delay:1.5f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         q2.frame = CGRectMake(q2.frame.origin.x, q2.frame.origin.y + 20, q2.frame.size.width, q2.frame.size.height);
                         q2.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              q2.frame = CGRectMake(q2.frame.origin.x, q2.frame.origin.y + 20, q2.frame.size.width, q2.frame.size.height);
                                          }
                                          completion:nil];
                     }];
}

@end














