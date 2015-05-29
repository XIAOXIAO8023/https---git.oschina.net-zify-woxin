//
//  PNBarChart.h
//  PNChartDemo
//
//  Created by  on 11/7/13.
//  Copyright (c) 2013年 . All rights reserved.
//

#import <UIKit/UIKit.h>

#define chartMargin     10
#define xLabelMargin    15
#define yLabelMargin    15
#define yLabelHeight    11

@interface PNBarChart : UIView

/**
 * This method will call and stroke the line in animation
 */

-(void)strokeChart;

@property (strong, nonatomic) NSArray * xLabels;

@property (strong, nonatomic) NSArray * yLabels;

@property (strong, nonatomic) NSArray * yValues;

@property (nonatomic) CGFloat xLabelWidth;

@property (nonatomic) int yValueMax;

@property (nonatomic, strong) UIColor * strokeColor;

@property (nonatomic, strong) NSArray * strokeColors;

@property (nonatomic, strong) UIColor * barBackgroundColor;

@property (nonatomic) BOOL showLabel;



-(void)setYValuesForHorizontal:(NSArray *)yValues;
-(void)setXLabelsForHorizontal:(NSArray *)xLabels;
-(void)strokeChartForHorizontal;

@property (nonatomic) int perValueMax;
@property (nonatomic) int perValue;
-(void)strokeChartForPercentage;
-(void)setPerValue:(int)perValue PerValueMax:(int)perValueMax;

@end
