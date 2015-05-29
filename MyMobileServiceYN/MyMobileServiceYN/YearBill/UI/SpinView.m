//
//  SpinView.m
//  YearBill
//
//  Created by 陆楠 on 15/2/9.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "SpinView.h"

@implementation SpinView
{
    CGFloat kAngle;
}

-(instancetype)init
{
    self = [super init];
    
    _speed = 0.3f;
    kAngle = 0;
    _spin = YES;
    [self animation];
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    _speed = 10.0f;
    kAngle = 0;
    _spin = YES;
    [self animation];
    
    return self;
}

-(void)animation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAnimation.duration = _speed;
    rotationAnimation.RepeatCount = 999;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}

-(void)stopSpin
{
    [self.layer removeAnimationForKey:@"Rotation"];
}

@end
