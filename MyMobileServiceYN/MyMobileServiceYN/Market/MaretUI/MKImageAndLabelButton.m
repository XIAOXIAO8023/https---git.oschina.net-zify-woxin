//
//  MKImageAndLabelButton.m
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "MKImageAndLabelButton.h"

@implementation MKImageAndLabelButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContent];
    
    return self;
}

-(void)loadContent
{
    image = [[UIImageView alloc]initWithFrame:CGRectMake(30, 7.5f, 25, 25)];
    [self addSubview:image];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 100, self.frame.size.height)];
    [self addSubview:_label];
    _label.font = [UIFont fontWithName:@"Arial" size:14];
    _label.textColor = [UIColor grayColor];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _label.text = _title;
}

-(void)setTitleImage:(UIImage *)titleImage
{
    _titleImage = titleImage;
    image.image = _titleImage;
}


@end
