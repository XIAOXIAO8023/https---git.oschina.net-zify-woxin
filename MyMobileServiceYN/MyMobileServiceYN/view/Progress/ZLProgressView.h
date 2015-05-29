//
//  ZLProgressView.h
//  MyMobileServiceYN
//
//  Created by zhaol on 14/12/3.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLProgressView : UIView{
    float _progress;
}

@property(nonatomic, retain) UIColor* progressTintColor;
@property(nonatomic, retain) UIColor* trackTintColor;

-(void)loadProgress:(float)progress;
@end
