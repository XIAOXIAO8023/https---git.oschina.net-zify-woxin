//
//  AnimationUtils.m
//  YearBill
//
//  Created by 陆楠 on 15/2/28.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "LNAnimationUtils.h"

@implementation LNAnimationUtils

+(void)view:(UIView *)view fadeWithDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 0.0f;
    }];
}

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

+ (void)view:(UIView *)view fallWithHeight:(CGFloat)height inTime:(NSTimeInterval)time completion:(void (^)(void))completion
{
    [UIView animateWithDuration:time * 2 / 5
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + height, view.frame.size.width, view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:time / 5
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - height / 3, view.frame.size.width, view.frame.size.height);
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:time / 5
                                                                    delay:0.0f
                                                                  options:UIViewAnimationOptionCurveEaseIn
                                                               animations:^{
                                                                   view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + height / 3, view.frame.size.width, view.frame.size.height);
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [UIView animateWithDuration:time / 10
                                                                                         delay:0.0f
                                                                                       options:UIViewAnimationOptionCurveEaseOut
                                                                                    animations:^{
                                                                                        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - height / 9, view.frame.size.width, view.frame.size.height);
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        [UIView animateWithDuration:time / 10
                                                                                                              delay:0.0f
                                                                                                            options:UIViewAnimationOptionCurveEaseIn
                                                                                                         animations:^{
                                                                                                             view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + height / 9, view.frame.size.width, view.frame.size.height);
                                                                                                         }
                                                                                                         completion:^(BOOL finished){if (completion){
                                                                                            completion();
                                                                                        }
                                                                                                         }
                                                                                         ];
                                                                                    }
                                                                    ];
                                                               }
                                               ];
                                          }
                          ];
                     }
    ];
}

+ (void)view:(UIView *)view fadeWithType:(LNAnimationUtilsFadeType)type inTime:(NSTimeInterval)time completion:(void (^)(void))completion
{
    [self view:view fadeWithType:type options:UIViewAnimationOptionCurveEaseIn inTime:time completion:completion];
}

+ (void)view:(UIView *)view fadeWithType:(LNAnimationUtilsFadeType)type options:(UIViewAnimationOptions)options inTime:(NSTimeInterval)time completion:(void (^)(void))completion
{
    void (^animationBlock)() = nil;
    switch (type) {
        case LNAnimationUtilsFadeTypeFade:{
            animationBlock = ^(){
                view.alpha = 0.0f;
            };
            break;
        }
        case LNAnimationUtilsFadeTypeShrink:{
            animationBlock = ^(){
                view.transform = CGAffineTransformMakeScale(0.001f ,0.001f);
            };
            break;
        }
        case LNAnimationUtilsFadeTypeShrinkAndFade:{
            animationBlock = ^(){
                view.alpha = 0.0f;
                view.transform = CGAffineTransformMakeScale(0.001f ,0.001f);
            };
            break;
        }
        case LNAnimationUtilsFadeTypePressFlat:{
            animationBlock = ^(){
                view.transform = CGAffineTransformMakeScale(1.0f ,0.001f);
            };
            break;
        }
        default:
            break;
    }
    
    [UIView animateWithDuration:time
                     animations:^{
                         animationBlock();
                     }
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion();
                         }
                     }
     ];
}

+(void)view:(UIView *)view showWithType:(LNAnimationUtilsShowType)type options:(UIViewAnimationOptions)options inTime:(NSTimeInterval)time completion:(void (^)(void))completion
{
    if (view.hidden) {
        [view setHidden:NO];
    }
    
    void (^animationBlock)() = nil;
    switch (type) {
        case LNAnimationUtilsShowTypeFrom70Percent:{
            view.alpha = 0.3f;
            view.transform = CGAffineTransformMakeScale(0.7f ,0.7f);
            animationBlock = ^(){
                view.alpha = 1.0f;
                view.transform = CGAffineTransformMakeScale(1.0f ,1.0f);
            };
            break;
        }
        case LNAnimationUtilsShowTypeFrom0Percent:{
            view.alpha = 0.3f;
            view.transform = CGAffineTransformMakeScale(0.001f ,0.001f);
            animationBlock = ^(){
                view.alpha = 1.0f;
                view.transform = CGAffineTransformMakeScale(1.0f ,1.0f);
            };
        }
        default:
            break;
    }
    
    [UIView animateWithDuration:time
                     animations:^{
                         animationBlock();
                     }
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion();
                         }
                     }
     ];
}

@end






