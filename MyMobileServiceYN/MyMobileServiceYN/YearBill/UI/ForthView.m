//
//  ForthView.m
//  YearBill
//
//  Created by 陆楠 on 15/3/13.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "ForthView.h"
#import "LNAnimationNumber.h"
#import "SpinView.h"
#import "LNAnimationUtils.h"
#import "YBColorDef.h"
#import "YearBillUserInfo.h"

@implementation ForthView
{
    LNAnimationNumber *labelUp;
    LNAnimationNumber *labelDown;
    UIView *animationView;
    
    UIView *yan;
    UIImageView *yan1;
    UIImageView *yan2;
    UIImageView *yan3;
    
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
    labelUp.foreString = @"共用了流量";
    labelUp.followString = @"M";
    labelUp.number = [YearBillUserInfo getTotalFlow];
    labelUp.numberColor = UIColorFromRGB(TITLE_GREEN);
    labelUp.numberFont = [UIFont fontWithName:@"Arial" size:22];
    [labelUp showInitContent];
    
    labelDown = [[LNAnimationNumber alloc]initWithFrame:CGRectMake(15, 50, 290, 30)];
    [self addSubview:labelDown];
    labelDown.font = [UIFont fontWithName:@"Arial" size:14];
    labelDown.textColor = [UIColor whiteColor];
    labelDown.textAlignment = NSTextAlignmentCenter;
    labelDown.foreString = @"月均流量";
    labelDown.followString = @"M";
    labelDown.number = [YearBillUserInfo getAverageFlow];
    labelDown.specialCharacters = @"";
    labelDown.numberColor = UIColorFromRGB(TITLE_ORANGE);
    labelDown.numberFont = [UIFont fontWithName:@"Arial" size:22];
    [labelDown showInitContent];
    
}

-(void)startAnimation
{
    [labelUp startAnimation];
    [labelDown startAnimation];
    
    if (_type == 1) {
        [self shangWuAnimation];
    }else if (_type == 4){
        [self wanShangAnimation];
    }else if (_type == 7){
        [self YuanShiRenAnimation];
    }
}

-(void)loadAnimationView
{
    
    animationView = [[UIView alloc]initWithFrame:CGRectMake(15, 85, 290, self.frame.size.height - 90 - 40)];
    [self addSubview:animationView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, animationView.frame.size.height - 30, 290, 50)];
    [animationView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;
    
    UIImageView *z = [[UIImageView alloc]initWithFrame:CGRectMake(60, 20, 20, 20)];
    z.image = [UIImage imageNamed:@"icon_clock"];
    [animationView addSubview:z];
    
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(80, 24, 240, 12)];
    [animationView addSubview:l];
    l.textColor = UIColorFromRGB(COMMON_PURPLE);
    l.font = [UIFont fontWithName:@"Arial" size:12];
    
    if (/*上午*/_type == 1) {
        label.text = @"好吧~~我真的很闲哟~";
        l.text = @"上网时间段集中在上午8-12点";
        [self loadShangWuAni];
    }else if (/*中午*/_type == 2){
        label.text = @"喝杯淡淡苦香咖啡，享受美丽午后时光";
        l.text = @"上网时间段集中在中午12-14点";
        [self loadXiaWuAni];
    }else if (/*下午*/_type == 3){
        label.text = @"喝杯淡淡苦香咖啡，享受美丽午后时光";
        l.text = @"上网时间段集中在下午14-18点";
        [self loadXiaWuAni];
    }else if (/*晚上*/_type == 4){
        label.text = @"聊聊个信，看看资讯，生活有点意思！";
        l.text = @"上网时间段集中在晚上18-22点";
        [self loadWanShangAni];
    }else if (/*深夜*/_type == 5){
        label.text = @"良好作息对身体很重要，适当早些休息才好！";
        l.text = @"上网时间段集中在深夜22-2点";
        [self loadShenYeAni];
    }else if (/*深夜*/_type == 6){
        label.text = @"良好作息对身体很重要，适当早些休息才好！";
        [self loadShenYeAni];
        l.text = @"上网时间段集中在凌晨3-8点";
    }else if (_type == 7){
        label.text = @"原始人的节奏哦~竟然没有使用流量";
        [self loadShenYeAni];
        l.text = @"上网时间段集中在史前侏罗纪";
    }
}

#pragma -
#pragma 上午
-(void)loadShangWuAni
{
    SpinView *s = [[SpinView alloc]initWithFrame:CGRectMake(210, 60, 30, 30)];
    [animationView addSubview:s];
    s.image = [UIImage imageNamed:@"sun"];
    
    UIImageView *y = [[UIImageView alloc]initWithFrame:CGRectMake(210, 80, 25, 13)];
    [animationView addSubview:y];
    y.image = [UIImage imageNamed:@"yun_2"];
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, y.frame.origin.x, y.frame.origin.y);
    CGPathAddLineToPoint(path, NULL, y.frame.origin.x + 50, y.frame.origin.y);
    CGPathAddLineToPoint(path, NULL, y.frame.origin.x, y.frame.origin.y);
    
    CAKeyframeAnimation *m = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    m.path=path;
    m.removedOnCompletion=NO;
    m.fillMode=kCAFillModeForwards;
    m.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    m.autoreverses=NO;
    m.repeatCount = 999;
    m.duration=30.0f;
    [y.layer addAnimation:m forKey:@"mo"];
    
    
    UIImageView *zz = [[UIImageView alloc]initWithFrame:CGRectMake(64, 200, 162, 63)];
    [animationView addSubview:zz];
    zz.image = [UIImage imageNamed:@"sw_yzzz"];
    
    
    UIImageView *yz1 = [[UIImageView alloc]initWithFrame:CGRectMake(8, 175, 61, 90)];
    [animationView addSubview:yz1];
    yz1.image = [UIImage imageNamed:@"sw_yzleft"];
    yz1.tag = 101;
    
    UIImageView *yz2 = [[UIImageView alloc]initWithFrame:CGRectMake(225, 173, 62, 90)];
    [animationView addSubview:yz2];
    yz2.image = [UIImage imageNamed:@"sw_yzright"];
    yz2.tag = 102;
    
    UIImageView *r1 = [[UIImageView alloc]initWithFrame:CGRectMake(25, 128, 79, 134)];
    [animationView addSubview:r1];
    r1.image = [UIImage imageNamed:@"sw_peopleleft"];
    r1.tag = 103;
    
    UIImageView *r2 = [[UIImageView alloc]initWithFrame:CGRectMake(179, 119, 84, 139)];
    [animationView addSubview:r2];
    r2.image = [UIImage imageNamed:@"sw_peopleright"];
    r2.tag = 104;
}

-(void)shangWuAnimation
{
    UIImageView *yz1 = (UIImageView *)[animationView viewWithTag:101];
    UIImageView *yz2 = (UIImageView *)[animationView viewWithTag:102];
    UIImageView *r1 = (UIImageView *)[animationView viewWithTag:103];
    UIImageView *r2 = (UIImageView *)[animationView viewWithTag:104];
    
    yz1.frame = CGRectMake(yz1.frame.origin.x - 100, yz1.frame.origin.y, yz1.frame.size.width, yz1.frame.size.height);
    yz2.frame = CGRectMake(yz2.frame.origin.x + 100, yz2.frame.origin.y, yz2.frame.size.width, yz2.frame.size.height);
    r1.alpha = 0.0f;
    r2.alpha = 0.0f;
    
    [UIView animateWithDuration:0.6f
                     animations:^{
                         yz1.frame = CGRectMake(yz1.frame.origin.x + 100, yz1.frame.origin.y, yz1.frame.size.width, yz1.frame.size.height);
                     }];
    
    [UIView animateWithDuration:0.6f
                          delay:0.1f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         yz2.frame = CGRectMake(yz2.frame.origin.x - 100, yz2.frame.origin.y, yz2.frame.size.width, yz2.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0f
                                          animations:^{
                                              r1.alpha = 1.0f;
                                          }];
                         [UIView animateWithDuration:2.0f
                                               delay:0.1f
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              r2.alpha = 1.0f;
                                          }
                                          completion:nil];
                     }];
}




#pragma -
#pragma 中午
-(void)loadZhongWuAni
{
    
}




#pragma -
#pragma 下午
-(void)loadXiaWuAni
{
    
    UIImageView *girl = [[UIImageView alloc]initWithFrame:CGRectMake(65, 120, 160, 145)];
    [animationView addSubview:girl];
    girl.image = [UIImage imageNamed:@"sw_girl"];
    
    yan = [[UIView alloc]initWithFrame:CGRectMake(30, 55, 10, 30)];
    [girl addSubview:yan];
    yan1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 4.5, 10)];
    [yan addSubview:yan1];
    yan1.alpha = 0;
    yan1.image = [UIImage imageNamed:@"sw_coffee1"];
    yan2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 4, 8, 25)];
    [yan addSubview:yan2];
    yan2.alpha = 0;
    yan2.image = [UIImage imageNamed:@"sw_coffee2"];
    yan3 = [[UIImageView alloc]initWithFrame:CGRectMake(4.5, 0, 3, 15)];
    [yan addSubview:yan3];
    yan2.alpha = 0;
    yan3.image = [UIImage imageNamed:@"sw_coffee3"];
    [self yanAnimation];
    
    SpinView *s = [[SpinView alloc]initWithFrame:CGRectMake(50, 70, 30, 30)];
    [animationView addSubview:s];
    s.image = [UIImage imageNamed:@"sun"];
    
    UIImageView *y = [[UIImageView alloc]initWithFrame:CGRectMake(50, 90, 25, 13)];
    [animationView addSubview:y];
    y.image = [UIImage imageNamed:@"yun_2"];
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, y.frame.origin.x, y.frame.origin.y);
    CGPathAddLineToPoint(path, NULL, y.frame.origin.x + 50, y.frame.origin.y);
    CGPathAddLineToPoint(path, NULL, y.frame.origin.x, y.frame.origin.y);
    
    CAKeyframeAnimation *m = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    m.path=path;
    m.removedOnCompletion=NO;
    m.fillMode=kCAFillModeForwards;
    m.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    m.autoreverses=NO;
    m.repeatCount = 999;
    m.duration=30.0f;
    [y.layer addAnimation:m forKey:@"mo"];
}

-(void)yanAnimation
{
    static int yanTimeSSS = 20;
    if (yanTimeSSS == 0) {
        return;
    }
    
    [UIView animateWithDuration:2.0f
                     animations:^{
                         yan1.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0f
                                          animations:^{
                                              yan2.alpha = 1.0f;
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:3.0f
                                                               animations:^{
                                                                   yan3.alpha = 1.0f;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   yanTimeSSS --;
                                                                   yan1.alpha = 0;
                                                                   yan2.alpha = 0;
                                                                   yan3.alpha = 0;
                                                                   [self yanAnimation];
                                                               }];
                                          }];
                     }];
}


#pragma -
#pragma 晚上
-(void)loadWanShangAni
{
    UIImageView *jz = [[UIImageView alloc]initWithFrame:CGRectMake(70, 120, 130, 130)];
    [animationView addSubview:jz];
    jz.image = [UIImage imageNamed:@"sw_diqiu"];
    
    UIImageView *a1 = [[UIImageView alloc]initWithFrame:CGRectMake(110, 105, 50, 51)];
    [animationView addSubview:a1];
    a1.image = [UIImage imageNamed:@"sw_weixin"];
    a1.tag = 401;
    
    UIImageView *a2 = [[UIImageView alloc]initWithFrame:CGRectMake(45, 165, 52, 53)];
    [animationView addSubview:a2];
    a2.image = [UIImage imageNamed:@"sw_shiping"];
    a2.tag = 402;
    
    UIImageView *a3 = [[UIImageView alloc]initWithFrame:CGRectMake(175, 145, 52, 53)];
    [animationView addSubview:a3];
    a3.image = [UIImage imageNamed:@"sw_sina"];
    a3.tag = 403;
    
}

-(void)wanShangAnimation
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
                     completion:nil];}

#pragma -
#pragma 深夜
-(void)loadShenYeAni
{
    UIImageView *s1 = [[UIImageView alloc]initWithFrame:CGRectMake(160, 50, 22, 15.5)];
    [animationView addSubview:s1];
    s1.image = [UIImage imageNamed:@"star_lx"];
    
    UIImageView *s2 = [[UIImageView alloc]initWithFrame:CGRectMake(230, 90, 17, 17)];
    [animationView addSubview:s2];
    s2.image = [UIImage imageNamed:@"star_sw"];
    
    UIImageView *s3 = [[UIImageView alloc]initWithFrame:CGRectMake(220, 250, 8, 8)];
    [animationView addSubview:s3];
    s3.image = [UIImage imageNamed:@"star_swpink1"];
    
    UIImageView *g = [[UIImageView alloc]initWithFrame:CGRectMake(65, 100, 160, 160)];
    [animationView addSubview:g];
    g.image = [UIImage imageNamed:@"sleep_girl"];
    
    CABasicAnimation *r1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    r1.toValue = [NSNumber numberWithFloat: M_PI * -0.05 ];
    r1.removedOnCompletion=NO;
    r1.duration = 2.0f;
    r1.fillMode=kCAFillModeForwards;
    CABasicAnimation *r2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    r2.toValue = [NSNumber numberWithFloat: M_PI * 0.05 ];
    r2.beginTime = 2.0f;
    r2.duration = 4.0f;
    r2.removedOnCompletion=NO;
    r2.fillMode=kCAFillModeForwards;
    CABasicAnimation *r3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    r3.toValue = [NSNumber numberWithFloat: M_PI * 0.0 ];
    r3.beginTime = 6.0f;
    r3.duration = 2.0f;
    r3.removedOnCompletion=NO;
    r3.fillMode=kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:r1, r2, r3,nil];
    group.repeatCount = 20;
    group.removedOnCompletion=NO;
    group.duration = 8.0f;
    group.fillMode=kCAFillModeForwards;
    [g.layer addAnimation:group forKey:@"rr"];
    
    UIImageView *s4 = [[UIImageView alloc]initWithFrame:CGRectMake(90, 100, 15.5, 17.5)];
    [animationView addSubview:s4];
    s4.image = [UIImage imageNamed:@"star_swpink"];
    CABasicAnimation *r4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    r4.toValue = [NSNumber numberWithFloat:0.0f];
    r4.removedOnCompletion=NO;
    r4.duration = 2.0f;
    r4.beginTime = 2.0f;
    r4.fillMode=kCAFillModeForwards;
    CABasicAnimation *r5 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    r5.toValue = [NSNumber numberWithFloat:1.0f];
    r5.removedOnCompletion=NO;
    r5.duration = 2.0f;
    r5.beginTime = 4.0f;
    r5.fillMode=kCAFillModeForwards;
    CAAnimationGroup *group2 = [CAAnimationGroup animation];
    group2.animations = [NSArray arrayWithObjects:r4, r5,nil];
    group2.repeatCount = 20;
    group2.removedOnCompletion=NO;
    group2.duration = 7.0f;
    group2.fillMode=kCAFillModeForwards;
    [s4.layer addAnimation:group2 forKey:@"rr2"];
    
    UIImageView *s5 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 260, 12, 12)];
    [animationView addSubview:s5];
    s5.image = [UIImage imageNamed:@"star_swyellow"];
    CABasicAnimation *r6 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    r6.toValue = [NSNumber numberWithFloat:0.0f];
    r6.removedOnCompletion=NO;
    r6.duration = 1.5f;
    r6.fillMode=kCAFillModeForwards;
    CABasicAnimation *r7 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    r7.toValue = [NSNumber numberWithFloat:1.0f];
    r7.removedOnCompletion=NO;
    r7.duration = 1.5f;
    r7.beginTime = 1.5f;
    r7.fillMode=kCAFillModeForwards;
    CAAnimationGroup *group3 = [CAAnimationGroup animation];
    group3.animations = [NSArray arrayWithObjects:r6, r7,nil];
    group3.repeatCount = 999;
    group3.removedOnCompletion=NO;
    group3.duration = 3.0f;
    group3.fillMode=kCAFillModeForwards;
    [s5.layer addAnimation:group3 forKey:@"rr3"];
    
    
}

#pragma -
#pragma 原始人
-(void)loadYuanShiRenAni
{
    UIImageView *ani = [[UIImageView alloc]initWithFrame:CGRectMake(55, 75, 180, 180)];
    [animationView addSubview:ani];
    ani.tag = 700;
    ani.image = [UIImage imageNamed:@"sw_nonet"];
}

-(void)YuanShiRenAnimation
{
    UIImageView *a = (UIImageView *)[animationView viewWithTag:700];
    
    
    a.alpha = 0.0f;
    
    [UIView animateWithDuration:2.0f animations:^{
        a.alpha = 1.0f;
    }];
}

@end




















