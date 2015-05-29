//
//  MoveUtils.h
//  YearBill
//
//  Created by 陆楠 on 15/2/9.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MoveUtils : NSObject

// 使某一指定的View在特定的时间内从起始点平移到终点
+ (void)moveView:(UIView *)view to:(CGPoint)endPoint withDuration:(NSTimeInterval)duration completion:(void (^)(void))completion;


@end
