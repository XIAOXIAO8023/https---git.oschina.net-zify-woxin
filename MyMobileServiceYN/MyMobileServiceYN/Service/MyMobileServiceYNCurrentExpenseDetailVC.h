//
//  MyMobileServiceYNCurrentExpenseDetailVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-22.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"

@interface MyMobileServiceYNCurrentExpenseDetailVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate>
{
    UIScrollView *homeScrollView;
}

@property (retain,nonatomic)NSArray *DetailArray;

@end
