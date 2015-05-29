//
//  MarketMoreVC.h
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZNSegmentedControl.h"
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"
#import "MyMobileServiceYNHttpRequest.h"
@class PackageButton;

@interface MarketMoreVC : MyMobileServiceYNBaseVC<DZNSegmentedControlDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>
{
    UIButton *selectedVtn;
    
    UIImageView *title;
    
    DZNSegmentedControl *segmentV;
    
    UIView *contentView;
    
    UIScrollView *scroll;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    
    NSString *busiCode;
    
    PackageButton *currentB;
}

@property (nonatomic, retain) NSArray *packageArry;

@end



