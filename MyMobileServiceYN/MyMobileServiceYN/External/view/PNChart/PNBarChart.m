//
//  PNBarChart.m
//  PNChartDemo
//
//  Created by  on 11/7/13.
//  Copyright (c) 2013年 . All rights reserved.
//

#import "PNBarChart.h"
#import "PNColor.h"
#import "PNChartLabel.h"
#import "PNBar.h"
#import "GlobalDef.h"

@interface PNBarChart() {
    NSMutableArray* _bars;
    NSMutableArray* _labels;
    NSMutableArray* _nubLabels;
}

- (UIColor *)barColorAtIndex:(NSUInteger)index;
@end

@implementation PNBarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds   = YES;
        _showLabel           = YES;
//        _barBackgroundColor  = PNLightGrey;
        _barBackgroundColor  = [UIColor clearColor];
        _labels              = [NSMutableArray array];
        _bars                = [NSMutableArray array];
    }

    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];

    _xLabelWidth = (self.frame.size.width - chartMargin*2)/[_yValues count];
}

//Y轴数据转换成INT，并排序，设置Y轴最大数
-(void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    for (NSString * valueString in yLabels) {
        NSInteger value = [valueString integerValue];
        if (value > max) {
            max = value;
        }

    }

    //Min value for Y label
    if (max < 5) {
        max = 5;
    }

    _yValueMax = (int)max;
}

//设置X轴名称
-(void)setXLabels:(NSArray *)xLabels
{
    [self viewCleanupForCollection:_labels];
    _xLabels = xLabels;

    if (_showLabel) {
        _xLabelWidth = (self.frame.size.width - chartMargin*2)/[xLabels count];

        for(int index = 0; index < xLabels.count; index++)
        {
            NSString* labelText = xLabels[index];
            PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake((index *  _xLabelWidth + chartMargin), self.frame.size.height - 30.0, _xLabelWidth, 20.0)];
            [label setTextAlignment:NSTextAlignmentCenter];
            label.text = labelText;
            [_labels addObject:label];
            [self addSubview:label];
        }
    }
}

-(void)setStrokeColor:(UIColor *)strokeColor
{
	_strokeColor = strokeColor;
}

-(void)strokeChart
{
    [self viewCleanupForCollection:_bars];
    CGFloat chartCavanHeight = self.frame.size.height - chartMargin * 2 - 40.0;
    NSInteger index = 0;

    for (NSString * valueString in _yValues) {
        float value = [valueString floatValue];

        float grade = (float)value / (float)_yValueMax;
        PNBar * bar;
        if (_showLabel) {
            bar = [[PNBar alloc] initWithFrame:CGRectMake((index *  _xLabelWidth + chartMargin + _xLabelWidth * 0.25), self.frame.size.height - chartCavanHeight - 30.0, _xLabelWidth * 0.5, chartCavanHeight)];
        }else{
            bar = [[PNBar alloc] initWithFrame:CGRectMake((index *  _xLabelWidth + chartMargin + _xLabelWidth * 0.25), self.frame.size.height - chartCavanHeight , _xLabelWidth * 0.6, chartCavanHeight)];
        }
        bar.backgroundColor = _barBackgroundColor;
//        bar.backgroundColor = [UIColor clearColor];
        bar.barColor = [self barColorAtIndex:index];
        bar.grade = grade;
        [_bars addObject:bar];
        [self addSubview:bar];

        index += 1;
    }
}

//--------------------------------------------------------------------------------

//横向柱状态，沿用竖向的XY轴。相当于原来的90°都转向
-(void)setYValuesForHorizontal:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabelsForHorizontal:yValues];
    
    _xLabelWidth = (self.frame.size.height - chartMargin*2)/[_yValues count];
}

//Y轴数据转换成INT，并排序，设置Y轴最大数
-(void)setYLabelsForHorizontal:(NSArray *)yLabels
{
    NSInteger max = 0;
    for (NSString * valueString in yLabels) {
        NSInteger value = [valueString integerValue];
        if (value > max) {
            max = value;
        }
        
    }
    
    //Min value for Y label
    if (max < 5) {
        max = 5;
    }
    
    _yValueMax = (int)max;
}

//设置X轴名称
-(void)setXLabelsForHorizontal:(NSArray *)xLabels
{
    [self viewCleanupForCollection:_labels];
    _xLabels = xLabels;
    
    if (_showLabel) {
//        _xLabelWidth = 60.0;
        CGFloat xLabelHeight=(self.frame.size.height - chartMargin*2)/[xLabels count];
        
        for(int index = 0; index < xLabels.count; index++)
        {
            NSString* labelText = xLabels[index];
            PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(0, (index *  xLabelHeight + chartMargin), 60.0, xLabelHeight)];
            [label setTextAlignment:NSTextAlignmentRight];
            label.text = labelText;
            label.font = [UIFont fontWithName:appTypeFace size:15.0];
            [_labels addObject:label];

            [self addSubview:label];
        }
    }
}

-(void)strokeChartForHorizontal
{
    [self viewCleanupForCollection:_bars];
    [self viewCleanupForCollection:_nubLabels];
//    CGFloat chartCavanHeight = self.frame.size.height - chartMargin * 2 - 40.0;
    CGFloat chartCavanWidth = self.frame.size.width  - 120.0;
    
    NSInteger index = 0;

    for (NSString * valueString in _yValues) {
        float value = [valueString floatValue];
        float grade = (float)value / (float)_yValueMax;
        PNBar * bar;
        if (_showLabel) {
            bar = [[PNBar alloc] initWithFrame:CGRectMake(60, (index *  _xLabelWidth + chartMargin + _xLabelWidth * 0.25), chartCavanWidth, _xLabelWidth * 0.5)];
        }else{
            bar = [[PNBar alloc] initWithFrame:CGRectMake(60, (index *  _xLabelWidth + chartMargin + _xLabelWidth * 0.25), chartCavanWidth, _xLabelWidth * 0.6)];
        }
        bar.backgroundColor = _barBackgroundColor;
        //        bar.backgroundColor = [UIColor clearColor];
        bar.barColor = [self barColorAtIndex:index];
        bar.horizontalGrade = grade;
        bar.layer.borderColor = [UIColor clearColor].CGColor;
        [bar.layer setCornerRadius:0];
        [_bars addObject:bar];
        [self addSubview:bar];
        
        //添加每条BAR后面的数值
        PNChartLabel * numlabel = [[PNChartLabel alloc] initWithFrame:CGRectMake(60+chartCavanWidth*grade, (index *  _xLabelWidth + chartMargin + _xLabelWidth * 0.25), 60.0, _xLabelWidth * 0.5)];
        [numlabel setTextAlignment:NSTextAlignmentLeft];
//        float f2 = value/100;
        if ((int)value ==0) {
            numlabel.text = @"0.00";
        }else
        {
            NSString *s1 =  [NSString stringWithFormat:@"%d",(int)value];
            float f1 = [s1 floatValue];
            float f2 = f1/100;
            NSString *s2 = [NSString stringWithFormat:@"%.2f",f2];
            NSString *numString = s2;
            numlabel.text = numString;
        }
        numlabel.font = [UIFont fontWithName:appTypeFace size:15.0];
        [_nubLabels addObject:numlabel];
        
        [self addSubview:numlabel];
        
        index += 1;
    }
}

-(void)setPerValue:(int)perValue PerValueMax:(int)perValueMax
{
    _perValue = perValue;
    _perValueMax = perValueMax;
}

-(void)strokeChartForPercentage
{
    //    [self viewCleanupForCollection:_bars];
    //    CGFloat chartCavanHeight = self.frame.size.height;
    //    NSInteger index = 0;
    
    //        float value = (float)_perValue;
    
        float grade = (float)_perValue / (float)_perValueMax;
//    float grade = 0.5;
    PNBar * bar;
    if (_showLabel) {
        bar = [[PNBar alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
    }else{
        bar = [[PNBar alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
    }
    bar.backgroundColor = _barBackgroundColor;
//    bar.barColor = _strokeColor;
    bar.percentageGrade = grade;
    //        perBar = bar;
    [self addSubview:bar];
}

- (void)viewCleanupForCollection:(NSMutableArray*)array
{
    if (array.count) {
        [array makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [array removeAllObjects];
    }
}

#pragma mark - Class extension methods

- (UIColor *)barColorAtIndex:(NSUInteger)index
{
    if ([self.strokeColors count] == [self.yValues count]) {
        return self.strokeColors[index];
    } else {
        return self.strokeColor;
    }
}

@end
