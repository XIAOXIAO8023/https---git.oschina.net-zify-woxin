//
//  FirstView.h
//  YearBill
//
//  Created by 陆楠 on 15/2/11.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FirstView01;
@class FirstView02;

@interface UILabel ()

@end

@interface FirstView : UIView
{
    FirstView01 *view_01;
    FirstView02 *view_02;
}

- (void)fallSnow;

- (void)stopSnow;

@end
