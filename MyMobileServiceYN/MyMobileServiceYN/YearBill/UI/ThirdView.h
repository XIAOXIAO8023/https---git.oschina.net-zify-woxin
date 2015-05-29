//
//  ThirdView.h
//  YearBill
//
//  Created by 陆楠 on 15/3/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdView : UIView
{
    UIView *animationView;
}

@property (nonatomic ,assign) int type;

-(void)startAnimation;

@end
