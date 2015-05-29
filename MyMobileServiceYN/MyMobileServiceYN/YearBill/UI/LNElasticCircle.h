//
//  LNElasticCircle.h
//  YearBill
//
//  Created by 陆楠 on 15/2/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNElasticCircle : UIImageView

@property (nonatomic, retain ,readonly) UILabel *titleLabel;

@property (nonatomic, assign)CGFloat Diameter;

// 新增初始化方法，point为原点，diameter为直径
- (instancetype)initWithPoint:(CGPoint)point diameter:(CGFloat)diameter;

// 开始动画
- (void)startAnimation;

- (void)startAnimationWithComplection:(void (^)(void))completion;

-(void)startAnimationWithDelay:(NSTimeInterval)delay Complection:(void (^)(void))completion;

@end
