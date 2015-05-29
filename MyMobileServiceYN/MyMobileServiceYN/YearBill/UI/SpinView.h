//
//  SpinView.h
//  YearBill
//
//  Created by 陆楠 on 15/2/9.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinView : UIImageView
{
    NSTimer *spinTimer;
}

// 每转10角度所需要的时间
@property (nonatomic, assign) CGFloat speed;

@property (nonatomic, assign) BOOL spin;

-(instancetype)init;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)stopSpin;

@end
