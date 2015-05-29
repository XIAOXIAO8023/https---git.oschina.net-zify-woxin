//
//  FirstView01.h
//  YearBill
//
//  Created by 陆楠 on 15/2/10.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstView01 : UIView
{
    NSTimer *snowTimer;
}

@property (nonatomic, assign) BOOL isSnowing;

- (void)fallSnow;

- (void)stopSnow;
@end
