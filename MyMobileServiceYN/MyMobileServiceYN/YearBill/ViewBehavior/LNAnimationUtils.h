//
//  AnimationUtils.h
//  YearBill
//
//  Created by 陆楠 on 15/2/28.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 @abstract 消失的类型
 @param LNAnimationUtilsFadeTypeFade 淡出消失
 @param LNAnimationUtilsFadeTypeShrink 缩小消失
 @param LNAnimationUtilsFadeTypeShrinkAndFade 缩小的同时淡出
 @param LNAnimationUtilsFadeTypePressFlat 整个view压扁消失
 */
typedef enum {
    LNAnimationUtilsFadeTypeFade,
    LNAnimationUtilsFadeTypeShrink,
    LNAnimationUtilsFadeTypeShrinkAndFade,
    LNAnimationUtilsFadeTypePressFlat
}LNAnimationUtilsFadeType;

typedef enum{
    LNAnimationUtilsShowTypeFrom70Percent,
    LNAnimationUtilsShowTypeFrom0Percent
}LNAnimationUtilsShowType;


@interface LNAnimationUtils : NSObject

/** 
 @abstract 使某一指定的view在特定的时间内消失
 @param view 被操作的view
 @param duration 整个view消失所用的时间
 */
+ (void)view:(UIView *)view fadeWithDuration:(NSTimeInterval)duration;

/** 
 @abstract 使某一指定的View在特定的时间内从起始点平移到终点
 @param view 被操作的view
 @param endPiont 最后的停留点
 @param duration 整个动画所用的时间
 @param completion 结束后的回调函数
 @discussion endPoint是指view左上角的点，而不是指view的center
 */
+ (void)moveView:(UIView *)view
              to:(CGPoint)endPoint
    withDuration:(NSTimeInterval)duration
      completion:(void (^)(void))completion;

/** 
 @abstract 使某一指定的View在特定的时间内下落一定高度
 @param view 被操作的view
 @param height 下落的高度
 @param time 整个下落过程所需要的时间
 @discussion 整个过程总共弹跳2次
 */
+ (void)view:(UIView *)view
fallWithHeight:(CGFloat)height
      inTime:(NSTimeInterval)time
  completion:(void (^)(void))completion;

/** 
 @abstract 使某一指定的View在特定的时间内按照指定方式消失
 @param view 被操作的view
 @param type 选择动画，见LNAnimationUtilsFadeType
 @param time 动画所持续的时间
 @param completion 动画结束后的回调函数
 @discussion type默认是EasyIn
 */
+ (void)view:(UIView *)view
fadeWithType:(LNAnimationUtilsFadeType)type
      inTime:(NSTimeInterval)time
  completion:(void (^)(void))completion;

/** 
 @abstract 使某一指定的View在特定的时间内按照指定方式消失并附带慢进慢出等动画选项
 @param options 动画选项
 @discussion type默认不再是EasyIn，而是自己手动选择
 */
+ (void)view:(UIView *)view
fadeWithType:(LNAnimationUtilsFadeType)type
     options:(UIViewAnimationOptions)options
      inTime:(NSTimeInterval)time
  completion:(void (^)(void))completion;

/**
 @abstract 使某一指定的View在特定的时间内按照指定方式显示
 @param view 被操作的view
 @param type 选择动画，见LNAnimationUtilsShowType
 @param options 动画选项
 @param time 动画所持续的时间
 @param completion 动画结束后的回调函数
 */
+ (void)view:(UIView *)view
showWithType:(LNAnimationUtilsShowType)type
     options:(UIViewAnimationOptions)options
      inTime:(NSTimeInterval)time
  completion:(void (^)(void))completion;

@end








