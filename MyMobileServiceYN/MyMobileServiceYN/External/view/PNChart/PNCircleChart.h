//
//  PNCircleChart.h
//  PNChartDemo
//
//  Created by  on 13-11-30.
//  Copyright (c) 2013年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNColor.h"


#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface PNCircleChart : UIView

-(void)strokeChart;
- (id)initWithFrame:(CGRect)frame andTotal:(NSNumber *)total andCurrent:(NSNumber *)current;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) NSNumber * total;
@property (nonatomic, strong) NSNumber * current;
@property (nonatomic, strong) NSNumber * lineWidth;

@property(nonatomic,strong) CAShapeLayer * circle;
@property(nonatomic,strong) CAShapeLayer * circleBG;

@end
