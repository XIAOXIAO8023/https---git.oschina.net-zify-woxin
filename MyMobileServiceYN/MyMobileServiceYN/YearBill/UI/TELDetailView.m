//
//  TELDetailView.m
//  YearBill
//
//  Created by 陆楠 on 15/3/11.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "TELDetailView.h"
#import "LNElasticCircle.h"
#import "LNAnimationUtils.h"
#import "YBColorDef.h"
#import "YearBillUserInfo.h"

@implementation TELDetailView

-(instancetype)init
{
    self = [super init];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pink.png"]];
    
    [self loadViews];
    
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pink.png"]];
    
    [self loadViews];
    
    return self;
}

-(void)loadViews
{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 320, 40)];
    [self addSubview:title];
    [title setTextAlignment:NSTextAlignmentCenter];
    title.text = @"话费去向";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Arial" size:20];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(loadPops) userInfo:nil repeats:NO];
    
    UILabel *foot = [[UILabel alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 80, 320, 15)];
    [self addSubview:foot];
    [foot setTextAlignment:NSTextAlignmentCenter];
    foot.text = [NSString stringWithFormat:@"查询周期: %@",[YearBillUserInfo getQueryCode]];
    foot.textColor = [UIColor whiteColor];
    foot.font = [UIFont fontWithName:@"Arial" size:16];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(killSelf)];
    [self addGestureRecognizer:tap];
    
}


-(void)loadPops
{
    NSArray *arr = [YearBillUserInfo getCostArry];
    
    NSLog(@"弹泡泡");
    pop1 = [[LNElasticCircle alloc]initWithFrame:CGRectMake(45, 130, 105, 105)];
    [self addSubview:pop1];
    pop1.backgroundColor = UIColorFromRGB(BILL_YELLOW);
    pop1.titleLabel.textColor = [UIColor whiteColor];
    pop1.titleLabel.text = [NSString stringWithFormat:@"%@\n%.2f%@",[[arr objectAtIndex:0] objectForKey:@"name"],((NSString *)[[arr objectAtIndex:0] objectForKey:@"cost"]).floatValue / [YearBillUserInfo getTotalCost]*100,@"%"];
    pop1.titleLabel.numberOfLines = 2;
    pop1.titleLabel.textAlignment = NSTextAlignmentCenter;
    pop1.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//    [pop1 startAnimation];
    
    pop2 = [[LNElasticCircle alloc]initWithFrame:CGRectMake(180, 150, 80, 80)];
    [self addSubview:pop2];
    pop2.backgroundColor = UIColorFromRGB(BILL_BLUE);
    pop2.titleLabel.textColor = [UIColor whiteColor];
    pop2.titleLabel.text = [NSString stringWithFormat:@"%@\n%.2f%@",[[arr objectAtIndex:1] objectForKey:@"name"],((NSString *)[[arr objectAtIndex:1] objectForKey:@"cost"]).floatValue / [YearBillUserInfo getTotalCost]*100,@"%"];
    pop2.titleLabel.numberOfLines = 2;
    pop2.titleLabel.textAlignment = NSTextAlignmentCenter;
    pop2.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
//    [pop2 startAnimation];
    
    pop3 = [[LNElasticCircle alloc]initWithFrame:CGRectMake(155, 238, 75, 75)];
    [self addSubview:pop3];
    pop3.backgroundColor = UIColorFromRGB(BILL_ORANGE);
    pop3.titleLabel.textColor = [UIColor whiteColor];
    pop3.titleLabel.text = [NSString stringWithFormat:@"%@\n%.2f%@",[[arr objectAtIndex:2] objectForKey:@"name"],((NSString *)[[arr objectAtIndex:2] objectForKey:@"cost"]).floatValue / [YearBillUserInfo getTotalCost]*100,@"%"];
    pop3.titleLabel.numberOfLines = 2;
    pop3.titleLabel.textAlignment = NSTextAlignmentCenter;
    pop3.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
//    [pop3 startAnimation];
    
    
    pop4 = [[LNElasticCircle alloc]initWithFrame:CGRectMake(35, 280, 60, 60)];
    [self addSubview:pop4];
    pop4.backgroundColor = UIColorFromRGB(BILL_PURPLE);;
    pop4.titleLabel.textColor = [UIColor whiteColor];
    pop4.titleLabel.text = [NSString stringWithFormat:@"%@\n%.2f%@",[[arr objectAtIndex:3] objectForKey:@"name"],((NSString *)[[arr objectAtIndex:3] objectForKey:@"cost"]).floatValue / [YearBillUserInfo getTotalCost]*100,@"%"];
    pop4.titleLabel.numberOfLines = 2;
    pop4.titleLabel.textAlignment = NSTextAlignmentCenter;
    pop4.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
//    [pop4 startAnimation];
    
    pop5 = [[LNElasticCircle alloc]initWithFrame:CGRectMake(210, 330, 50, 50)];
    [self addSubview:pop5];
    pop5.backgroundColor = UIColorFromRGB(BILL_YELLOW);
    pop5.titleLabel.textColor = [UIColor whiteColor];
    pop5.titleLabel.text = [NSString stringWithFormat:@"%@\n%.2f%@",[[arr objectAtIndex:4] objectForKey:@"name"],((NSString *)[[arr objectAtIndex:4] objectForKey:@"cost"]).floatValue / [YearBillUserInfo getTotalCost]*100,@"%"];
    pop5.titleLabel.numberOfLines = 2;
    pop5.titleLabel.textAlignment = NSTextAlignmentCenter;
    pop5.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
//    [pop5 startAnimation];
    
    [pop1 startAnimation];
    [pop5 startAnimation];
    
    [pop2 startAnimationWithDelay:0.2f Complection:nil];
    [pop4 startAnimationWithDelay:0.2f Complection:nil];
    
    [pop3 startAnimationWithDelay:0.4f Complection:nil];
    
    

}

-(void)killSelf
{
    [LNAnimationUtils view:self fadeWithType:LNAnimationUtilsFadeTypeShrinkAndFade options:UIViewAnimationOptionCurveEaseInOut inTime:1.0f completion:^{
        [self removeFromSuperview];
    }];
}


@end













