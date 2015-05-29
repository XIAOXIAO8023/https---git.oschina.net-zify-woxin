//
//  PercentageBar.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "PercentageBar.h"
#import "PNColor.h"
#import "PNChartLabel.h"
#import "PNBar.h"
#import "GlobalDef.h"

@implementation PercentageBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds   = YES;
        _showLabel           = YES;
//        _barBackgroundColor  = PNLightGrey;
//        _barBackgroundColor  = [UIColor clearColor];
    }
    return self;
}

-(void)setStrokeColor:(UIColor *)strokeColor
{
	_strokeColor = strokeColor;
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
        PNBar * bar;
        if (_showLabel) {
            bar = [[PNBar alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height - 15)];
        }else{
            bar = [[PNBar alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height - 15)];
        }
        bar.backgroundColor = _barBackgroundColor;
        bar.barColor = _strokeColor;
        bar.borderColor = _strokeColor;
        bar.percentageGrade = grade;
//        perBar = bar;
    [self addSubview:bar];
    
//    UILabel *minLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, self.frame.size.height/3)];
//    minLabel.textAlignment = NSTextAlignmentRight;
//    minLabel.backgroundColor = [UIColor clearColor];
//    minLabel.text = @"0";
//    minLabel.font = [UIFont fontWithName:appTypeFace size:12.0];
//    [self addSubview:minLabel];
//    
//    UILabel *maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-100, 0, 100, self.frame.size.height/3)];
//    maxLabel.textAlignment = NSTextAlignmentRight;
//    maxLabel.backgroundColor = [UIColor clearColor];
//    maxLabel.text = [NSString stringWithFormat:@"%d",_perValueMax];
//    maxLabel.font = [UIFont fontWithName:appTypeFace size:12.0];
//    [self addSubview:maxLabel];
    
    float realLabelX;
    if (grade<0.05) {
        realLabelX = 0;
    }else if (grade>0.9) {
        realLabelX = self.frame.size.width -40;
    }else
    {
        realLabelX = (self.frame.size.width)*grade -20;
    }
    UILabel *realLabel = [[UILabel alloc]initWithFrame:CGRectMake(realLabelX, (self.frame.size.height/3)*2, 40, self.frame.size.height/3)];
    if (grade<0.05) {
        realLabel.textAlignment = NSTextAlignmentLeft;
    }else if (grade>0.9) {
        realLabel.textAlignment = NSTextAlignmentRight;
    }else
    {
        realLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    realLabel.backgroundColor = [UIColor clearColor];
    realLabel.text = [NSString stringWithFormat:@"%d",_perValue];
    realLabel.textColor = [UIColor lightGrayColor];
    realLabel.font = [UIFont fontWithName:appTypeFace size:12.0];
    [self addSubview:realLabel];
    
}

//- (void)viewCleanupForCollection:(PNBar *)bar
//{
//    [bar removeFromSuperview];
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
