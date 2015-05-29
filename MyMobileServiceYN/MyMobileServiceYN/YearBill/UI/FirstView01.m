//
//  FirstView01.m
//  YearBill
//
//  Created by 陆楠 on 15/2/10.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "FirstView01.h"
#import "SnowView.h"

@implementation FirstView01
{
    UIView *snowView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pink.png"]];
    
    [self fallSnow];
    
    [self addThanksView];
    
    [self addSeasonView];
    
    return self;
}


#pragma -
#pragma 开始下雪
- (void)fallSnow
{
    _isSnowing = YES;
    [self snowingInView:self withSpeed:2 target:self];
}

- (void)snowingInView:(UIView *)view withSpeed:(CGFloat)speed target:(id)target
{
    NSLog(@"start snowing...");
    
    snowView = [[UIView alloc]initWithFrame:CGRectZero];
    [view addSubview:snowView];
    
    CGFloat duration = 1.0f / speed;
    snowTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:target selector:@selector(addSnowInView:) userInfo:snowView repeats:YES];
    
}

- (void)addSnowInView:(NSTimer *)timer
{
//    NSLog(@"add a snow...");
    UIView *v = [timer userInfo];
    
    int randomX = arc4random() % 320;
    int randomY = arc4random() % 50;
    
    SnowView *s = [[SnowView alloc]initWithFrame:CGRectMake(randomX, randomY, 30, 30) formScale:(arc4random() % 10) / 10.0f];
    [v addSubview:s];
        if (arc4random() % 2) {
            s.image = [UIImage imageNamed:@"xuehua_1.png"];
        }else{
    s.image = [UIImage imageNamed:@"xuehua_2.png"];
        }
    [s startAnimation];
}

#pragma -
#pragma 添加感恩图片
-(void)addThanksView
{
    UIImageView *thks = [[UIImageView alloc]initWithFrame:CGRectMake(40, ([[UIScreen mainScreen] bounds].size.height - 64) * 1 / 4, 240, 112.5)];
    [self addSubview:thks];
    thks.image = [UIImage imageNamed:@"ganen.png"];
}



-(void)stopSnow
{
    _isSnowing = NO;
    if (snowTimer) {
        NSLog(@"stop snowing...");
        [snowTimer invalidate];
        snowTimer = nil;
        if (snowView) {
            [snowView removeFromSuperview];
            snowView = nil;
        }
    }
}

-(void)addSeasonView
{
    UIImageView *season = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 185, 320, 185)];
    [self addSubview:season];
    season.image = [UIImage imageNamed:@"foot_dong"];
}


@end
