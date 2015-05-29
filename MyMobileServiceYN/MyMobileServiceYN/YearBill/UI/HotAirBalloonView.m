//
//  HotAirBalloonView.m
//  YearBill
//
//  Created by 陆楠 on 15/2/10.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "HotAirBalloonView.h"

@implementation HotAirBalloonView


-(void)startAnimation
{
    [UIView animateWithDuration:3.0f
                     animations:^(void){
                         self.center = CGPointMake(self.frame.origin.x - 15, self.frame.origin.y - 120);
                     }
                     completion:^(BOOL isFinished){
                         [UIView animateWithDuration:3.0f
                                          animations:^(void){
                                              self.center = CGPointMake(self.frame.origin.x + 30, self.frame.origin.y - 120);
                                          }
                                          completion:^(BOOL isFinished){
                                              [self removeFromSuperview];
                                          }];
                     }
     ];
}



@end
