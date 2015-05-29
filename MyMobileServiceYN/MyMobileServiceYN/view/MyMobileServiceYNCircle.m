//
//  MyMobileServiceYNCircle.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-13.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNCircle.h"
#import "GlobalDef.h"

@implementation MyMobileServiceYNCircle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setCircleBgColor:(UIColor *)color
{
    circleBgColor = color;
}

// 覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
//    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextFillRect(context, rect);
    
    CGContextSetFillColorWithColor(context, circleBgColor.CGColor);
    //填充圆，无边框
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, self.frame.size.height/2, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
