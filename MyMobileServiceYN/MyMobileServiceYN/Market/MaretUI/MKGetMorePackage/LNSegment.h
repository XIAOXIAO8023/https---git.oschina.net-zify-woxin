//
//  LNSegment.h
//  Market
//
//  Created by 陆楠 on 15/3/24.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LNSegmentDelegate <NSObject>

-(void)LNSegmentDidSelectAtIndex:(NSInteger)index;

@end


@interface LNSegment : UIView
{
    UIView *itemView;
}

@property (nonatomic, retain) NSArray *titleButtonArry;

@property (nonatomic, retain) id<LNSegmentDelegate>delegate;

@end
