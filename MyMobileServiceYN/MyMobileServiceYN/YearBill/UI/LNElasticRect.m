//
//  LNElasticRect.m
//  YearBill
//
//  Created by 陆楠 on 15/2/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "LNElasticRect.h"

@implementation LNElasticRect
{
    CGFloat x;
    CGFloat y;
}

-(instancetype)init
{
    self = [super init];
    
    [self setDefaultSettings];
    
    return self;
}

/**
 * 设置的frame中的x，y是拉伸框的起点，height是拉升后的告高度。
 * 所以例如初始化frame（100，100，50，100），在动画执行结束后的矩形的frame是frame（100，0，50，100）
 **/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    _animationHeight = self.frame.size.height;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
    y = self.frame.origin.y;
    
    [self setDefaultSettings];
    
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
//    [self setDefaultSettings];
}

-(void)setDefaultSettings
{
    _duration = 1.0f;
    
    if (_headView) {
        [_headView removeFromSuperview];
        _headView = nil;
    }
    if (_footView) {
        [_footView removeFromSuperview];
        _footView = nil;
    }
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 - self.frame.size.width, self.frame.size.width, self.frame.size.width)];
    [self addSubview:_headView];
    
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 + self.frame.size.height, self.frame.size.width, self.frame.size.width)];
    [self addSubview:_footView];
}

-(void)setAnimationHeight:(CGFloat)animationHeight withDuration:(NSTimeInterval)duration
{
    _animationHeight = animationHeight;
    _duration = duration;
}

#pragma - 动画实现
-(void)startAnimation
{
    self.frame = CGRectMake(self.frame.origin.x, y , self.frame.size.width, 0);
    _headView.frame = CGRectMake(0, 0 - self.frame.size.width, self.frame.size.width, self.frame.size.width);
    _footView.frame =CGRectMake(0, 0 + self.frame.size.height, self.frame.size.width, self.frame.size.width);
    
    [UIView animateWithDuration:_duration animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0 - _animationHeight);
        if (_headView) {
            _headView.frame = CGRectMake(_headView.frame.origin.x, _headView.frame.origin.y, _headView.frame.size.width, _headView.frame.size.height);
        }
        if (_footView) {
            _footView.frame =CGRectMake(_footView.frame.origin.x, _footView.frame.origin.y + _animationHeight , _footView.frame.size.width, _footView.frame.size.height);
        }
    }];
}

@end


