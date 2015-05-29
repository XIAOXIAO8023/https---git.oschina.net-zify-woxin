//
//  SixthView.m
//  YearBill
//
//  Created by 陆楠 on 15/3/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "SixthView.h"
#import "LNAnimationUtils.h"


@implementation SixthView
{
    NSMutableArray *arr;
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
    UILabel *a = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, 290, 30)];
    [self addSubview:a];
    a.text = @"据说，这三个家伙很火哦~";
    a.textColor = [UIColor whiteColor];
    a.textAlignment = NSTextAlignmentCenter;
    
    UIButton *x = [[UIButton alloc]initWithFrame:CGRectMake(30, 130, 60, 100)];
//    [self addSubview:x];
    UIImageView *x1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    x1.image = [UIImage imageNamed:@"icon_heshengho"];
    [x addSubview:x1];
    UILabel *x2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 60, 20)];
    [x addSubview:x2];
    x2.text = @"和生活";
    x2.textColor = [UIColor whiteColor];
    x2.textAlignment = NSTextAlignmentCenter;
    x.tag = 200;
    [x addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *y = [[UIButton alloc]initWithFrame:CGRectMake(130, 130, 60, 100)];
//    [self addSubview:y];
    UIImageView *y1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    y1.image = [UIImage imageNamed:@"icon_hegame"];
    [y addSubview:y1];
    UILabel *y2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 60, 20)];
    [y addSubview:y2];
    y2.text = @"和游戏";
    y2.textColor = [UIColor whiteColor];
    y2.textAlignment = NSTextAlignmentCenter;
    y.tag = 201;
    [y addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *z = [[UIButton alloc]initWithFrame:CGRectMake(230, 130, 60, 100)];
//    [self addSubview:z];
    UIImageView *z1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    z1.image = [UIImage imageNamed:@"icon_hetv"];
    [z addSubview:z1];
    UILabel *z2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 60, 20)];
    [z addSubview:z2];
    z2.text = @"和视频";
    z2.textColor = [UIColor whiteColor];
    z2.textAlignment = NSTextAlignmentCenter;
    z.tag = 202;
    [z addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    arr = [[NSMutableArray alloc]initWithObjects:x,y,z, nil];
    
    
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(70, self.frame.size.height - 96, 180, 96)];
    [self addSubview:bt];
    [bt setBackgroundImage:[UIImage imageNamed:@"wytuchao"] forState:UIControlStateNormal];
    [bt setTitle:@"我要吐槽" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    bt.tag = 203;
}

-(void)startAnimation
{
    UIButton *b1 = (UIButton *)[arr objectAtIndex:0];
    UIButton *b2 = (UIButton *)[arr objectAtIndex:1];
    UIButton *b3 = (UIButton *)[arr objectAtIndex:2];
    
    [b1 removeFromSuperview];
    [b2 removeFromSuperview];
    [b3 removeFromSuperview];
    
    [self addSubview:b1];
    b1.frame = CGRectMake(30, 130, 60, 100);
    [LNAnimationUtils view:[arr objectAtIndex:0]
            fallWithHeight:60
                    inTime:0.5f
                completion:^{
                    [self addSubview:b2];
                    b2.frame = CGRectMake(130, 130, 60, 100);
                    [LNAnimationUtils view:[arr objectAtIndex:1]
                            fallWithHeight:60
                                    inTime:0.5f
                                completion:^{
                                    [self addSubview:b3];
                                    b3.frame = CGRectMake(230, 130, 60, 100);
                                    [LNAnimationUtils view:[arr objectAtIndex:2]
                                            fallWithHeight:60
                                                    inTime:0.5f
                                                completion:nil];
                                }];
                }];
}

-(void)btnPressed:(UIButton *)btn
{
    if (btn.tag == 200) {
        NSLog(@"和生活...");
    }else if (btn.tag == 201){
        NSLog(@"和游戏...");
    }else if (btn.tag == 202){
        NSLog(@"和视频");
    }else if (btn.tag == 203){
        NSLog(@"我要吐槽...");
    }
    [_pushViewDelegate pushuViewFromSixView:btn];
}

@end






