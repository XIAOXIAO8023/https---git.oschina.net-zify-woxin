//
//  SixthView.h
//  YearBill
//
//  Created by 陆楠 on 15/3/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PushViewDelegate <NSObject>

-(void)pushuViewFromSixView:(UIButton *)btn;

@end

@interface SixthView : UIView

-(void)startAnimation;

@property id<PushViewDelegate>pushViewDelegate;

@end


