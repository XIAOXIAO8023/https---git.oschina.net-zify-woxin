//
//  MyMobileServiceYNAgglomerationVC.h
//  MyMobileServiceYN
//
//  Created by XIAO on 15/4/17.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMobileServiceYNAgglomerationVC : UIViewController<UIPageViewControllerDelegate,UIScrollViewDelegate>
{
    float changeHeight;//记录高度；
    
    UIScrollView *_scrollView;//底层scrollView
    UIScrollView *bannerScrollView;//广告
    UIPageControl *hPageControl;
}

@end
