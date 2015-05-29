//
//  SnowView.h
//  YearBill
//
//  Created by 陆楠 on 15/2/9.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpinView.h"

@interface SnowView : SpinView
{
    CGFloat _scale;//雪花的透明度，尽量使雪花多样化一点
}

// 初始化，其中scale是View缩小的百分比
- (instancetype)initWithFrame:(CGRect)frame formScale:(CGFloat)scale;

// 开始自定义动画
-(void)startAnimation;

@end
