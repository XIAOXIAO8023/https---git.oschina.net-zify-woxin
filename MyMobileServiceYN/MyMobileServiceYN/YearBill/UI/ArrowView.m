//
//  ArrowView.m
//  YearBill
//
//  Created by 陆楠 on 15/3/3.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "ArrowView.h"

@implementation ArrowView



-(void)startAnimation
{
    static int arrowViewRepeatTimes = 99;
    
    if (arrowViewRepeatTimes == 0) {
        return;
    }else{
        [UIView animateWithDuration:1.5f
                         animations:^{
                             self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 20, self.frame.size.width, self.frame.size.height);
                             self.alpha = 0.3f;
                         }
                         completion:^(BOOL finished) {
                             arrowViewRepeatTimes --;
                             self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 20, self.frame.size.width, self.frame.size.height);
                             self.alpha = 1.0f;
                             [self startAnimation];
                         }
         ];
    }
}


@end
