//
//  LiuLiangMiaoShaView.m
//  MyMobileServiceYN
//
//  Created by 陆楠 on 15/1/6.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import "LiuLiangMiaoShaView.h"
#import "GlobalDef.h"

@implementation LiuLiangMiaoShaView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 70)];
    self.backgroundColor = [UIColor whiteColor];
    [self loadTitleView];
    [self loadTimeView];
    [self loadImageButton];
    return self;
}

-(void)loadTitleView
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 30)];
    [self addSubview:_titleLabel];
    [_titleLabel setFont:[UIFont fontWithName:appTypeFaceBold size:15]];
    _titleLabel.text = @"流量一天秒8次";
}

-(void)loadTimeView
{
    _time = @"00:00";
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - 150, 5, 100, 20)];
    [self addSubview:name];
    [name setFont:[UIFont fontWithName:appTypeFace size:13]];
    name.text = @"距本次秒杀：";
    [name setTextAlignment:NSTextAlignmentRight];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width, 5, 50, 20)];
    [self addSubview:_timeLabel];
    _timeLabel.text = _time;
    [_timeLabel setFont:[UIFont fontWithName:appTypeFace size:13]];
    [_timeLabel setTextColor:[UIColor redColor]];
    [_timeLabel setTextAlignment:NSTextAlignmentCenter];
}

-(void)loadImageButton
{
    _imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, 40)];
    [self addSubview:_imageButton];
}

@end
