//
//  MoveUtils.m
//  YearBill
//
//  Created by 陆楠 on 15/2/9.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "MoveUtils.h"
#import "SnowView.h"

@implementation MoveUtils

+(void)moveView:(UIView *)view to:(CGPoint)endPoint withDuration:(NSTimeInterval)duration completion:(void (^)(void))completion;
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.frame = CGRectMake(endPoint.x, endPoint.y, view.frame.size.width, view.frame.size.height);
    [UIView commitAnimations];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(completion != nil){
            completion();
        }
    });
}


@end









