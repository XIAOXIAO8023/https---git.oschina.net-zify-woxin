//
//  WaterBallView.h
//  CMClient
//
//  Created by zhaol on 14-10-10.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterBallView : UIView{
    UIColor* _currentWaterColor;
    
    float _currentLinePointY;
    float _firstLinePointY;
    
    float a;
    float b;
    
    BOOL jia;
    BOOL first;//首次进入
    NSTimer* waveTimer;
    
    CGSize thisViewSize;
}

-(void)setCurrentWaterColor:(UIColor*) waterColor; //水的颜色
-(void)reloadWater:(float)currentLinePointY; //水距离顶部的高度

@property (retain,nonatomic)UIColor *circleLineColor;//圆线的颜色
@property (retain,nonatomic)UIColor *circleOuterColor;//圆外的颜色
@end