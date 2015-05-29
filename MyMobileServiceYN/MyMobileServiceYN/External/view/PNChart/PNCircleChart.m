//
//  PNCircleChart.m
//  PNChartDemo
//
//  Created by  on 13-11-30.
//  Copyright (c) 2013年 . All rights reserved.
//

#import "PNCircleChart.h"
#import "UICountingLabel.h"

@interface PNCircleChart () {
    UICountingLabel *_gradeLabel;
}

@end

@implementation PNCircleChart

- (UIColor *)labelColor
{
    if (!_labelColor) {
        _labelColor = PNDeepGrey;
    }
    return _labelColor;
}


- (id)initWithFrame:(CGRect)frame andTotal:(NSNumber *)total andCurrent:(NSNumber *)current
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _total = total;
        _current = current;
        _strokeColor = PNFreshGreen;
        
        _lineWidth = [NSNumber numberWithFloat:10.0];
        UIBezierPath* circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x,self.center.y) radius:self.frame.size.height*0.5 startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(269.99) clockwise:YES];
        
        _circle               = [CAShapeLayer layer];
        _circle.path          = circlePath.CGPath;
        _circle.lineCap       = kCALineCapRound;
        _circle.fillColor     = [UIColor clearColor].CGColor;
        _circle.lineWidth     = [_lineWidth floatValue];
        _circle.zPosition     = 1;

        _circleBG             = [CAShapeLayer layer];
        _circleBG.path        = circlePath.CGPath;
        _circleBG.lineCap     = kCALineCapRound;
        _circleBG.fillColor   = [UIColor clearColor].CGColor;
        _circleBG.lineWidth   = [_lineWidth floatValue];
        _circleBG.strokeColor = PNLightYellow.CGColor;
        _circleBG.strokeEnd   = 1.0;
        _circleBG.zPosition   = -1;
        
        [self.layer addSublayer:_circle];
        [self.layer addSublayer:_circleBG];

		_gradeLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, 0, 50.0, 50.0)];
        
    }
    
    return self;
    
}

-(void)strokeChart
{
    //Add count label
    
    [_gradeLabel setTextAlignment:NSTextAlignmentCenter];
    [_gradeLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_gradeLabel setTextColor:self.labelColor];
    _gradeLabel.adjustsFontSizeToFitWidth=YES;
    [_gradeLabel setCenter:CGPointMake(self.center.x,self.center.y)];
    _gradeLabel.method = UILabelCountingMethodEaseInOut;
    _gradeLabel.format = @"%d%%";
   
    
    [self addSubview:_gradeLabel];
    
    //Add circle params
    
    _circle.lineWidth   = [_lineWidth floatValue];
    _circleBG.lineWidth = [_lineWidth floatValue];
    _circleBG.strokeEnd = 1.0;
    _circle.strokeColor = _strokeColor.CGColor;
    
    CGFloat pencent=[_current floatValue]/[_total floatValue];
    if(pencent>=1){
        pencent=1.0;
    }
    
    //Add Animation
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:pencent];
    [_circle addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _circle.strokeEnd   = pencent;
    
    [_gradeLabel countFrom:0 to:pencent*100 withDuration:1.0];
   
}

@end
