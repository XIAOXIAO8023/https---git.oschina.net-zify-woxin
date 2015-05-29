//
//  MyMobileServiceYNIntroduceVC.h
//  MyMobileServiceYN
//
//  Created by yingmeng on 14-8-11.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrayPageControl.h"
#import "CycleScrollView.h"

@interface MyMobileServiceYNIntroduceVC : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    UIPageControl *pageControl;
}
//滚动视图对象
@property (retain,nonatomic) UIScrollView *scrollView;
@property (retain,nonatomic) UIPageControl *pageControl;

@end
