//
//  PackageButton.h
//  Market
//
//  Created by 陆楠 on 15/3/24.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackageButton : UIButton
{
    UIImageView *imageView;
}

@property (nonatomic, retain) NSString *imageUrl; // 图片url

@property (nonatomic, retain) NSString *jifen; // 积分值

@property (nonatomic, retain, readonly) UILabel *JFtitle;

@property (nonatomic, retain) NSDictionary *packageInfo;

@end
