//
//  RPRuleV.m
//  Market
//
//  Created by 陆楠 on 15/3/26.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "RPRuleV.h"
#import "LNSuitLabel.h"
#import "LNAnimationUtils.h"
#import "GlobalDef.h"

@implementation RPRuleV

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContentV];
    
    return self;
}


-(void)loadContentV
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, 320, self.frame.size.height - 50)];
    [self addSubview:scroll];
    
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(110, 20, 100, 20)];
//    [self addSubview:title];
//    title.text = @"规则";
//    title.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *titleI = [[UIImageView alloc]initWithFrame:CGRectMake(40, 20, 240, 40)];
    [self addSubview:titleI];
    titleI.image = [UIImage imageNamed:@"rule-title"];
    
    UIImageView *footI = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 35, self.frame.size.width, 35)];
    [self addSubview:footI];
    footI.image = [UIImage imageNamed:@"rule-foot"];
    
//    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(260, 15, 30, 30)];
//    [self addSubview:closeBtn];
//    closeBtn.backgroundColor = [UIColor purpleColor];
//    [closeBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *ge = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonPressed:)];
    [self addGestureRecognizer:ge];
    
    
    LNSuitLabel *Q1 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(20, 20, 280, 20)];
    [scroll addSubview:Q1];
    Q1.text = @"1-Q:所有客户都可以转吗？";
    
    LNSuitLabel *A1 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(32, Q1.frame.origin.y + Q1.frame.size.height + 5, 270, 20)];
    [scroll addSubview:A1];
    A1.text = @"A:只有入网满6个月的客户才能转。";
    A1.textColor = UIColorFromRGB(0x595959);
    
    LNSuitLabel *Q2 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(20, A1.frame.origin.y + A1.frame.size.height + 20, 280, 20)];
    [scroll addSubview:Q2];
    Q2.text = @"2-Q:可以转给任意客户吗？";
    
    LNSuitLabel *A2 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(32, Q2.frame.origin.y + Q2.frame.size.height + 5, 270, 20)];
    [scroll addSubview:A2];
    A2.text = @"A:只可以转给本省的移动客户。";
    A2.textColor = UIColorFromRGB(0x595959);
    
    LNSuitLabel *Q3 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(20, A2.frame.origin.y + A2.frame.size.height + 20, 280, 20)];
    [scroll addSubview:Q3];
    Q3.text = @"3-Q:最高可以转多少积分呢？";
    
    LNSuitLabel *A3 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(32, Q3.frame.origin.y + Q3.frame.size.height + 5, 270, 20)];
    [scroll addSubview:A3];
    A3.text = @"A:每位客户每月转赠总积分不能超过2万上限。";
    A3.textColor = UIColorFromRGB(0x595959);
    
    LNSuitLabel *Q4 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(20, A3.frame.origin.y + A3.frame.size.height + 20, 280, 20)];
    [scroll addSubview:Q4];
    Q4.text = @"4-Q:受让人接受积分转赠转入的积分值有限制吗？";
    
    LNSuitLabel *A4 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(32, Q4.frame.origin.y + Q4.frame.size.height + 5, 270, 20)];
    [scroll addSubview:A4];
    A4.text = @"A:每月最多只能接受积分转赠转入2万积分";
    A4.textColor = UIColorFromRGB(0x595959);
    
    LNSuitLabel *Q5 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(20, A4.frame.origin.y + A4.frame.size.height + 20, 280, 20)];
    [scroll addSubview:Q5];
    Q5.text = @"5-Q:转赠后积分的类型和有效期会变吗？";
    
    LNSuitLabel *A5 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(32, Q5.frame.origin.y + Q5.frame.size.height + 5, 270, 20)];
    [scroll addSubview:A5];
    A5.text = @"A:不会。";
    A5.textColor = UIColorFromRGB(0x595959);
    
    scroll.contentSize = CGSizeMake(self.frame.size.width, A5.frame.origin.y + A5.frame.size.height + 5);
    
}


-(void)buttonPressed:(id)sender
{
    [LNAnimationUtils view:self
              fadeWithType:LNAnimationUtilsFadeTypePressFlat
                   options:UIViewAnimationOptionCurveEaseIn
                    inTime:0.3f
                completion:^{
                    [self removeFromSuperview];
                }];
}

@end







