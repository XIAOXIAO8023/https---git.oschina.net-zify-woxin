//
//  FifthView.m
//  YearBill
//
//  Created by 陆楠 on 15/3/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "FifthView.h"

@implementation FifthView
{
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
        [self loadTitleView];
    }
}

-(void)loadViews
{
    [self loadTitleView];
}

-(void)loadTitleView
{
    
    animationView = [[UIView alloc]initWithFrame:CGRectMake(15, 90, 290, self.frame.size.height - 90 - 40)];
    [self addSubview:animationView];
    
    UILabel *a = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 75, 30)];
    [self addSubview:a];
    a.text = @"原来我是";
    a.textColor = [UIColor whiteColor];
    a.font = [UIFont fontWithName:@"Arial" size:16];
    
    UILabel *b = [[UILabel alloc]initWithFrame:CGRectMake(140, 30, 210, 30)];
    [self addSubview:b];
    b.textColor = [UIColor orangeColor];
    b.font = [UIFont fontWithName:@"Arial" size:20];
    
    UIImageView *ani = [[UIImageView alloc]initWithFrame:CGRectMake(55, 65, 180, 180)];
    [animationView addSubview:ani];
    ani.tag = 100;
    
    UILabel *c = [[UILabel alloc]initWithFrame:CGRectMake(15, animationView.frame.size.height - 60, 260, 70)];
    [animationView addSubview:c];
    c.textColor = [UIColor whiteColor];
    c.numberOfLines = 0;
    c.lineBreakMode = UILineBreakModeWordWrap;
    c.textAlignment = NSTextAlignmentCenter;
    
    if (/*神*/_type == 1) {
        ani.image = [UIImage imageNamed:@"xx_shen"];
        b.text = [NSString stringWithFormat:@"%@",@"神一样的存在"];
        c.text = @"站在巅峰，风景无限好啊！来，膜拜我吧，哈哈哈";
    }else if (/*土豪*/_type == 2){
        ani.image = [UIImage imageNamed:@"xx_tuhao"];
        b.text = [NSString stringWithFormat:@"%@",@"土豪"];
        c.text = @"土豪感觉，就是分分钟都可称王的爽快感~~";
    }else if (/*精英*/_type == 3){
        ani.image = [UIImage imageNamed:@"xx_jingying"];
        b.text = [NSString stringWithFormat:@"%@",@"精英一族"];
        c.text = @"作为站在高处的那么一小部分人，怎么会不得意？要低调低调，成为精英中的战斗机才是最重要的!";
    }else if (/*梦想家*/_type == 4){
        ani.image = [UIImage imageNamed:@"xx_xxmxj"];
        b.text = [NSString stringWithFormat:@"%@",@"小小梦想家"];
        c.text = @"梦想还是要有的，万一哪天实现了呢?";
    }
}

-(void)startAnimation
{
    UIImageView *a = (UIImageView *)[animationView viewWithTag:100];
    
    a.alpha = 0.0f;
    
    [UIView animateWithDuration:2.0f animations:^{
        a.alpha = 1.0f;
    }];
}

@end
