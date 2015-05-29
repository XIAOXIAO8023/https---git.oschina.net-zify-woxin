//
//  SecondView.h
//  YearBill
//
//  Created by 陆楠 on 15/2/28.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView ()

@end

@interface SecondView : UIView
{
    UIButton *de;
}

@property (nonatomic, assign)int type;

- (void)startAnimation;

-(void)setType:(int)type;
@end
