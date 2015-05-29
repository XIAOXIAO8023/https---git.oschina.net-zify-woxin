//
//  ViewUtils.m
//  JuTuanHuiYN
//
//  Created by 陆楠 on 14/12/15.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "ViewUtils.h"

@implementation ViewUtils


//创建纯色UIImage
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  改变view的高度
 *
 *  @param view   视图
 *  @param height 更新后高度
 *
 *  @return 更新后的视图
 */
+(BOOL)updateView:(UIView*)view byHeight:(float) height{
    if (view==nil) {
        return NO;
    }
    CGRect rect = view.frame;
    rect.size.height = height;
    view.frame = rect;
    return YES;
}

@end

