//
//  PercentageBar.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNBar.h"

@class PNBar;

@interface PercentageBar : UIView
{
    PNBar *perBar;
}

-(void)strokeChartForPercentage;

@property (nonatomic, strong) UIColor * strokeColor;

@property (nonatomic, strong) NSArray * strokeColors;

@property (nonatomic, strong) UIColor * barBackgroundColor;

@property (nonatomic) BOOL showLabel;

@property (nonatomic) int perValueMax;

@property (nonatomic) int perValue;

-(void)setPerValue:(int)perValue PerValueMax:(int)perValueMax;



@end
