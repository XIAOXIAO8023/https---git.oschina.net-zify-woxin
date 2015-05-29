//
//  LNElasticCircle.m
//  YearBill
//
//  Created by 陆楠 on 15/2/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "LNElasticCircle.h"

@implementation LNElasticCircle

#pragma - 初始化函数
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setDefaultSettings];
    
    return self;
}

-(instancetype)init
{
    self = [super init];
    
    [self setDefaultSettings];
    [self.layer setCornerRadius:self.frame.size.height / 2];
    
    return self;
}

-(instancetype)initWithPoint:(CGPoint)point diameter:(CGFloat)diameter
{
    CGFloat x = point.x - diameter / 2;
    CGFloat y = point.y - diameter / 2;
    
    self = [super initWithFrame:CGRectMake(x, y, diameter, diameter)];
    [self setDefaultSettings];
    
    return self;
}

-(void)setDefaultSettings
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height / 4, self.frame.size.width, self.frame.size.height / 2)];
        [self addSubview:_titleLabel];
    }
    [self.layer setCornerRadius:self.frame.size.height / 2];
    self.transform = CGAffineTransformMakeScale(0.0001 ,0.0001);
}

-(void)setDiameter:(CGFloat)Diameter
{
    _Diameter = Diameter;
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, Diameter, Diameter)];
    [self.layer setCornerRadius:_Diameter / 2];
}

-(void)startAnimation
{
    [self startAnimationWithComplection:nil];
}

-(void)startAnimationWithComplection:(void (^)(void))completion
{
    [self startAnimationWithDelay:0.0f Complection:completion];
}

-(void)startAnimationWithDelay:(NSTimeInterval)delay Complection:(void (^)(void))completion
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.35f
                         animations:^(void){
                             self.transform = CGAffineTransformMakeScale(1.1f ,1.1f);
                         }
         //                     completion:^(BOOL isFinished){
         //                         [UIView animateWithDuration:0.12f
         //                                          animations:^(void){
         //                                              self.transform = CGAffineTransformMakeScale(0.97f ,0.97f);
         //                                          }
         //                                          completion:^(BOOL isFinished){
         //                                              [UIView animateWithDuration:0.03f
         //                                                               animations:^(void){
         //                                                                   self.transform = CGAffineTransformMakeScale(1.0f ,1.0f);
         //                                                               }
                         completion:^(BOOL isFinished){
                             if (completion) {
                                 completion();
                             }
                             ////                                                               }];
                             //                                          }];
                             
                         }];
    });
}


@end







