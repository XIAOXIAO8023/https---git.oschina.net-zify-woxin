//
//  SnowView.m
//  YearBill
//
//  Created by 陆楠 on 15/2/9.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "SnowView.h"

@implementation SnowView

-(instancetype)initWithFrame:(CGRect)frame formScale:(CGFloat)scale
{
    _scale = scale;
    
    if (_scale < 0.7f) {
        _scale = 0.7f;//雪花的透明度
    }
    
    CGRect mFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.height * _scale, frame.size.width * _scale);
    
    self = [super initWithFrame:mFrame];
    
    self.alpha = _scale;
    
    return self;
}

-(void)startAnimation
{
    [UIView animateWithDuration:3.0f
                    animations:^(void){
                        self.alpha = _scale / 2;
                        self.center = CGPointMake(self.frame.origin.x - 30, self.frame.origin.y + 130);
                    }
                    completion:^(BOOL isFinished){
                        [UIView animateWithDuration:3.0f
                                        animations:^(void){
                                            self.alpha = 0.0f;
                                            self.center = CGPointMake(self.frame.origin.x + 30, self.frame.origin.y + 130);
                                        }
                                        completion:^(BOOL isFinished){
                                            [self stopSpin];
                                            [self removeFromSuperview];
                                        }];
                                }
     ];
}


-(void)dealloc
{
//    NSLog(@"delloc a snow...");
}

@end
