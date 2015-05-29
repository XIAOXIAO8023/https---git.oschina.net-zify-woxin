//
//  MyMobileServiceYNRootVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-5.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"

@class MyMobileServiceYNHomeVC,MyMobileServiceYNLeftSideMenuVC,MyMobileServiceYNRightSideMenuVC;

@interface MyMobileServiceYNRootVC : MyMobileServiceYNBaseVC<UIActionSheetDelegate>

//@property(nonatomic, strong) MyMobileServiceYNHomeVC *centerController;
@property(nonatomic, strong) UINavigationController *centerController;
@property(nonatomic, strong) MyMobileServiceYNRightSideMenuVC *rightController;
@property(nonatomic, strong) MyMobileServiceYNLeftSideMenuVC *leftController;

@end
