//
//  ZLProgressView.m
//  MyMobileServiceYN
//
//  Created by zhaol on 14/12/3.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "ZLProgressView.h"

@implementation ZLProgressView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)loadProgress:(float)progress{
    [self initBaseInfo:progress];
    UIView *progressTintView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width * _progress, self.frame.size.height)];
    progressTintView.userInteractionEnabled = NO;
    progressTintView.backgroundColor = _progressTintColor;
    [self addSubview:progressTintView];
    self.clipsToBounds = YES;
    self.backgroundColor = _trackTintColor;
}
-(void)initBaseInfo:(float)progress{
    if(progress < 0){
        _progress = 0;
    }else if(progress > 1){
        _progress = 1;
    }else{
        _progress = progress;
    }
    if(_progressTintColor == nil){_progressTintColor = [UIColor clearColor];}
    if(_trackTintColor == nil){_trackTintColor = [UIColor clearColor];}
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
