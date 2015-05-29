//
//  WaterBallView.m
//  CMClient
//
//  Created by zhaol on 14-10-10.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "WaterBallView.h"


@implementation WaterBallView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        a = 1.5;
        b = 0;
        jia = NO;
        first = YES;
        
//        _currentWaterColor = [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
//        _currentLinePointY = frame.size.height/2;
//
//        _firstLinePointY = frame.size.height;
        
        waveTimer = [NSTimer scheduledTimerWithTimeInterval:0.03
                                                     target:self
                                                   selector:@selector(animateWave)
                                                   userInfo:nil
                                                    repeats:YES];
        thisViewSize=CGSizeMake(frame.size.width, frame.size.height);
    }
    return self;
}

//设置水的颜色
-(void)setCurrentWaterColor:(UIColor*) waterColor
{
    _currentWaterColor = waterColor;
}
//重新加载水波
-(void)reloadWater:(float)currentLinePointY
{
    first = YES;
    _firstLinePointY = self.frame.size.height;
    _currentLinePointY = currentLinePointY;
    
}

-(void)animateWave
{
//    if (jia) {
//        a += 0.01;
//    }else{
//        a -= 0.01;
//    }
//    
//    
//    if (a<=0.5) {
//        jia = YES;
//    }
//    
//    if (a>=1) {
//        jia = NO;
//    }
    a=0.5;
    
    b+=0.1;
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // 创建Quartz上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 创建一个
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    //设置线的宽度为1
    CGContextSetLineWidth(context, 1);
    //设置填充的颜色
    CGContextSetFillColorWithColor(context, [_currentWaterColor CGColor]);
    
    float y=_currentLinePointY;
    float z = _currentLinePointY;
    
    if (first) {
        _firstLinePointY -= 4;
        if (_firstLinePointY <= _currentLinePointY) {
            first = NO;
            _firstLinePointY=_currentLinePointY;
        }
        z=_firstLinePointY;
    }else{
        z=_currentLinePointY;
    }
    
    // 调用CGPathMoveToPoint来开启一个子Path
    CGPathMoveToPoint(path, NULL, 0, y);
    
    for(float x=0;x<=self.frame.size.width;x++){
        y= a * sin( x/180*M_PI + 4*b/M_PI ) * 5 + z;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, self.frame.size.width, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, z);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
//    CGContextDrawPath(context, kCGPathStroke);
    //water2
    CIColor *ciColor=[CIColor colorWithCGColor:_currentWaterColor.CGColor];
    CGContextSetRGBFillColor(context, ciColor.red, ciColor.green, ciColor.blue, 0.4);
    CGMutablePathRef path_2 = CGPathCreateMutable();
    CGPathMoveToPoint(path_2, NULL, 0, y);
    
    for(float x=0;x<=self.frame.size.width;x++){
        y= a * sin( x/180*M_PI + 4*b/M_PI + 8) * 5 + z;
        CGPathAddLineToPoint(path_2, nil, x, y);
    }
    CGPathAddLineToPoint(path_2, nil, self.frame.size.width, rect.size.height);
    CGPathAddLineToPoint(path_2, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path_2, nil, 0, z);

    CGContextAddPath(context, path_2);
    CGContextFillPath(context);
    
    //画背景
    CGMutablePathRef path2 = CGPathCreateMutable();
    
    //设置线的宽度为2
    //    CGContextSetLineWidth(context,2);
    //设置填充的颜色
    CGContextSetFillColorWithColor(context, [_circleOuterColor CGColor]);
    
    //圆
    CGPathAddEllipseInRect(path2, nil, CGRectMake(1.5, 1.5, thisViewSize.width-3, thisViewSize.height-3));
    CGPathMoveToPoint(path2, nil, 0, 0);
    CGPathAddLineToPoint(path2, nil, thisViewSize.width, 0);
    CGPathAddLineToPoint(path2, nil, thisViewSize.width, thisViewSize.height);
    CGPathAddLineToPoint(path2, nil, 0, thisViewSize.height);
    //
    CGContextAddPath(context, path2);
    //    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathEOFill);
    
    //画圆圈的线条
    CGMutablePathRef path3 = CGPathCreateMutable();
    
    //设置线的宽度为2
    int lineWith=3;
    CGContextSetLineWidth(context,lineWith);
    CGContextSetStrokeColorWithColor(context, [_circleLineColor CGColor]);
    //圆
    CGPathAddEllipseInRect(path3, nil, CGRectMake(1.5, 1.5, thisViewSize.width-3, thisViewSize.height-3));
    //
    CGContextAddPath(context, path3);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    CGPathRelease(path2);
    CGPathRelease(path3);
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
@end