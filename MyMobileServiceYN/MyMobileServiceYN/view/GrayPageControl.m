//
//  GrayPageControl.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-14.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "GrayPageControl.h"

@implementation GrayPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        activeImage = [UIImage imageNamed:@"dot_d"];
        inactiveImage = [UIImage imageNamed:@"dot_l"];
    }
    return self;
}

-(void) updateDots

{
//    for (int i=0; i<[self.subviews count]; i++) {
//        UIView* dot = [self.subviews objectAtIndex:i];
//        CGSize size;
//        size.height = 7;     //自定义圆点的大小
//        size.width = 7;      //自定义圆点的大小
//        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.width)];
//        if (i==self.currentPage)
//        {
//            if ([dot isKindOfClass:[UIImageView class]]) {
//                dot.image=activeImage;
//        }
//        else
//        {
//            if ([dot isKindOfClass:[UIImageView class]]) {
//                dot.image=inactiveImage;
//        }
//    }
    
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView* dotView = [self.subviews objectAtIndex:i];
        UIImageView* dot = nil;
        
        for (UIView* subview in dotView.subviews)
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                dot = (UIImageView*)subview;
                break;
            }
        }
        
        if (dot == nil)
        {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, dotView.frame.size.width, dotView.frame.size.height)];
            [dotView addSubview:dot];
        }
        
        if (i == self.currentPage)
        {
            if(activeImage)
                dot.image = activeImage;
        }
        else
        {
            if (inactiveImage)
                dot.image = inactiveImage;
        }
    }
}

-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
