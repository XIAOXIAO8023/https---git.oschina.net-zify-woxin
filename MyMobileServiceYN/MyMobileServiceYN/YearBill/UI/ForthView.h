//
//  ForthView.h
//  YearBill
//
//  Created by 陆楠 on 15/3/13.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForthView : UIView

@property (nonatomic , assign) int type;

-(void)startAnimation;

-(void)setType:(int)type;

@end
