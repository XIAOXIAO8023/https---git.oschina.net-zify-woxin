//
//  MKImageAndLabelButton.h
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKImageAndLabelButton : UIButton
{
    UIImageView *image;
}

@property (nonatomic, retain, readonly) UILabel *label;

@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) UIImage *titleImage;

@end
