//
//  MyMobileServiceYNRechargeVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-12.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "LeeSegmentedControl.h"
#import <MessageUI/MessageUI.h>

@interface MyMobileServiceYNRechargeVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,UITextFieldDelegate,LeeSegmentedControlDelegate,MFMessageComposeViewControllerDelegate>{
    UIScrollView *homeScrollView;
    UIView *rechargeView;
    
    BOOL isOnlinePayment; //是否在线支付交费
}


@end
