//
//  LNSegment.m
//  Market
//
//  Created by 陆楠 on 15/3/24.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "LNSegment.h"

@implementation LNSegment

-(void)setTitleButtonArry:(NSArray *)titleButtonArry
{
    _titleButtonArry = titleButtonArry;
    if (itemView) {
        [itemView removeFromSuperview];
    }
    itemView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:itemView];
    itemView.layer.cornerRadius = self.layer.cornerRadius;
    
    CGFloat detW = self.frame.size.width / _titleButtonArry.count;
    CGFloat tmpW = 0;
    for (NSInteger i = 0; i < _titleButtonArry.count; i++) {
        UIButton *btn = [_titleButtonArry objectAtIndex:i];
        [itemView addSubview:btn];
        btn.frame = CGRectMake(tmpW, 0, detW, self.frame.size.height);
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        tmpW += detW;
        if (i == 0) {
            [btn setSelected:YES];
        }
    }
}

-(void)buttonPressed:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger index = btn.tag % 1000;
    [btn setSelected:YES];
    
    for (NSInteger i = 0; i < _titleButtonArry.count; i++) {
        if (i != index) {
            [[_titleButtonArry objectAtIndex:i] setSelected:NO];
        }
    }
    
    [self.delegate LNSegmentDidSelectAtIndex:index];
}

@end





