//
//  MyMobileServiceYNTabbarServiceVC.h
//  MyMobileServiceYN
//
//  Created by zhang on 15/4/2.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"

@interface MyMobileServiceYNTabbarServiceVC :MyMobileServiceYNBaseVC
{
    UIScrollView *mainScrollView;
    float mainScrollViewHeight;
    NSArray *queryBtnArray;
    NSArray *handleBtnArray;
}
@end
