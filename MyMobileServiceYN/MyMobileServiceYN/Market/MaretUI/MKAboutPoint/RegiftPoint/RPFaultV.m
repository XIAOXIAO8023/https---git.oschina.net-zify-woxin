//
//  RPFailtV.m
//  Market
//
//  Created by 陆楠 on 15/3/25.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "RPFaultV.h"


@implementation RPFaultV

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContentV];
    
    return self;
}

-(void)loadContentV
{
    
    imageV = [[UIImageView alloc]initWithFrame:CGRectMake(60, self.frame.size.height * 0.16, 200, 200)];
    [self addSubview:imageV];
    
    reasonL = [[UILabel alloc]initWithFrame:CGRectMake(20, imageV.frame.origin.y + imageV.frame.size.height + 25, 280, 70)];
    [self addSubview:reasonL];
    reasonL.numberOfLines = 0;
    reasonL.lineBreakMode = UILineBreakModeWordWrap;
    reasonL.font = [UIFont fontWithName:@"Arial" size:14];
    reasonL.textAlignment = NSTextAlignmentCenter;
    
}

-(void)setFaultReason:(RPFaultReason)faultReason
{
    if (faultReason == RPFaultReasonLackAge) {
        imageV.image = [UIImage imageNamed:@""];
        NSString *alert =[NSString stringWithFormat:@"您的在网年龄为%d个月，需要达到6个月，才能进行积分转赠！",1];
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc]initWithString:alert];
        NSRange range1 = [alert rangeOfString:[NSString stringWithFormat:@"%d个月",1]];
        NSRange range2 = [alert rangeOfString:[NSString stringWithFormat:@"%d个月",6]];
        
        [s addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Arial" size:18]
                  range:range1];
        [s addAttribute:NSForegroundColorAttributeName
                  value:[UIColor orangeColor]
                  range:range1];
        
        [s addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Arial" size:18]
                  range:range2];
        [s addAttribute:NSForegroundColorAttributeName
                  value:[UIColor orangeColor]
                  range:range2];
        
        [reasonL setAttributedText:s];
    }else if (faultReason == RPFaultReasonOverPoint){
        imageV.image = [UIImage imageNamed:@""];
        NSString *alert =[NSString stringWithFormat:@"您当月转出的积分值已达到上限%d万，本月不能够继续转赠，下个月再转吧！",2];
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc]initWithString:alert];
        NSRange range1 = [alert rangeOfString:[NSString stringWithFormat:@"已达到上限%d万",2]];
        [s addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Arial" size:18]
                  range:range1];
        [s addAttribute:NSForegroundColorAttributeName
                  value:[UIColor orangeColor]
                  range:range1];
        [reasonL setAttributedText:s];
    }else if (faultReason == RPFaultReasonCommon){
        imageV.frame = CGRectMake(25, 70, 270, 144);
        imageV.image = [UIImage imageNamed:@"faild"];
    }
}

-(void)setCommonReason:(NSString *)commonReason
{
    _commonReason = commonReason;
    reasonL.text = _commonReason;
}

@end








