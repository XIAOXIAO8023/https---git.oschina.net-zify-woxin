//
//  LNAnimationNumber02.h
//  YearBill
//
//  Created by 陆楠 on 15/3/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNAnimationNumber.h"


//typedef enum{
//    numberOfDecimalPlacesZero = 0,
//    numberOfDecimalPlacesOne = 1,
//    numberOfDecimalPlacesTwo = 2
//}numberOfDecimalPlaces;

@interface LNAnimationNumber02 : UILabel
{
    BOOL isMultColor;//多色？
}

@property (nonatomic, assign) CGFloat number;//label中最终的数字

@property (nonatomic, assign) CGFloat number02;

@property (nonatomic, assign) NSTimeInterval duration;//数字跳变的总时间

@property (nonatomic, assign) numberOfDecimalPlaces numberOfDecimalPlaces;//小数点后位数

@property (nonatomic, retain) NSString *specialCharacters;//后缀的特殊字符，默认是无特殊字符

@property (nonatomic, retain) UIColor *numberColor;

@property (nonatomic, retain) UIFont *numberFont;

@property (nonatomic, retain) NSString *foreString;

@property (nonatomic, retain) NSString *followString;

@property (nonatomic, retain) NSString *midString;

//设置数字的总大小以及跳变的时间
- (void)setNumber:(CGFloat)number number02:(CGFloat)number02 withDuration:(NSTimeInterval)duration;

- (void)showInitContent;

//开始数字的跳动
- (void)startAnimation;

- (void)setFont:(UIFont *)font textColor:(UIColor *)color range:(NSRange)range;

@end

