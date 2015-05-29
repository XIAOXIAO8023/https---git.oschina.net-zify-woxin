//
//  PNBar.h
//  PNChartDemo
//
//  Created by  on 11/7/13.
//  Copyright (c) 2013年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PNBar : UIView

@property (nonatomic) float grade;

@property (nonatomic) float horizontalGrade;

@property (nonatomic) float percentageGrade;

@property (nonatomic,strong) CAShapeLayer * chartLine;

@property (nonatomic, strong) UIColor * barColor;

@property (nonatomic, strong) UIColor *borderColor;

-(void)rollBack;

@end
