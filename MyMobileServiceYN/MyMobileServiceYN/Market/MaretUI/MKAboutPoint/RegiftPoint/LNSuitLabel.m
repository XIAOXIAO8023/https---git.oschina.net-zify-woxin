//
//  LNSuitLabel.m
//  Market
//
//  Created by 陆楠 on 15/3/26.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "LNSuitLabel.h"

@implementation LNSuitLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setDefaultSetting];
    
    return self;
}

-(void)setDefaultSetting
{
    self.numberOfLines = 0;
    self.lineBreakMode = UILineBreakModeWordWrap;
    self.font = [UIFont fontWithName:@"Arial" size:14];
}

-(void)setText:(NSString *)text
{
    CGSize size = CGSizeMake(self.frame.size.width,2000);
    CGSize labelsize = [text sizeWithFont:self.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, labelsize.height);
    [super setText:text];
}

@end
