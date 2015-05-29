//
//  PackageButton.m
//  Market
//
//  Created by 陆楠 on 15/3/24.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "PackageButton.h"
#import "UIImageView+WebCache.h"
#import "GlobalDef.h"

@implementation PackageButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContentView];
    
    return self;
}

-(void)loadContentView
{
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 30)];
    [self addSubview:imageView];
    
    _JFtitle = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height, self.frame.size.width, 30)];
    [self addSubview:_JFtitle];
    _JFtitle.font = [UIFont fontWithName:@"Arial" size:14];
    _JFtitle.textAlignment = NSTextAlignmentCenter;
    _JFtitle.textColor = UIColorFromRGB(0xfc6b9f);
    self.clipsToBounds = YES;
}

-(void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl]
              placeholderImage:[UIImage imageNamed:@"ad_loading"]
                       options:SDWebImageProgressiveDownload];
}

-(void)setJifen:(NSString *)jifen
{
    _jifen = jifen;
    _JFtitle.text = [NSString stringWithFormat:@"%@积分",_jifen];
}

-(void)setPackageInfo:(NSDictionary *)packageInfo
{
    _packageInfo = packageInfo;
    self.imageUrl = [[packageInfo objectForKey:@"IMAGE_PATH"] stringByAppendingString:[packageInfo objectForKey:@"IMAGE_NAME"]];
    self.jifen = [packageInfo objectForKey:@"INTEGRAL_VALUE"];
}

@end









