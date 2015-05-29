//
//  MyMobileServiceYNAdslReservationVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-22.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "LeeSegmentedControl.h"

@interface MyMobileServiceYNAdslReservationVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,UITextViewDelegate,LeeSegmentedControlDelegate>
{
    UIScrollView *homeScrollView;
}

@end
