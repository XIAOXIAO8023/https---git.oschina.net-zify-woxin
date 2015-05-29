//
//  PNChartDelegate.h
//  PNChartDemo
//
//  Created by  on 13-12-11.
//  Copyright (c) 2013年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PNChartDelegate <NSObject>

/**
 * When user click on the chart line
 *
 */
- (void)userClickedOnLinePoint:(CGPoint )point lineIndex:(NSInteger)lineIndex;

/**
 * When user click on the chart line key point
 *
 */
- (void)userClickedOnLineKeyPoint:(CGPoint )point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex;


@end
