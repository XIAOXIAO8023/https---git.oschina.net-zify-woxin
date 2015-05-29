//
//  MyMobileServiceYNLeftMenuVC.h
//  MyMobileServiceYN
//
//  Created by 陆楠 on 14/12/3.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalDef.h"
#import "MyMobileServiceYNParam.h"

@interface MyMobileServiceYNLeftMenuVC : UIViewController
{
    UIView *didLogView;
    UIView *notLogView;
    UIScrollView *menuScrollView;
}

@property (nonatomic, copy) UILabel *telLabel;
@property (nonatomic, copy) UILabel *nameLabel;
@property (nonatomic, copy) UILabel *moneyLabel;
@property (nonatomic, copy) UILabel *scoreLabel;
@property (nonatomic) UILabel *colorLabel;

@end
