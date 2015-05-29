//
//  LNElasticRect.h
//  YearBill
//
//  Created by 陆楠 on 15/2/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNElasticRect : UIView

@property (nonatomic, assign) CGFloat duration;//动画持续时间

@property (nonatomic, assign) CGFloat animationHeight;//动画拉升的高度

@property (nonatomic, retain, readonly) UIView *headView;//主view上面的view，方便扩展

@property (nonatomic, retain, readonly) UIView *footView;//主view下面的view，方便扩展

// 开始动画
- (void)startAnimation;



// 设置动画拉升的高度和所需要的时间，如果已设置frame，frame的height等价于此处的animationHeight
- (void)setAnimationHeight:(CGFloat)animationHeight withDuration:(NSTimeInterval)duration;

@end
