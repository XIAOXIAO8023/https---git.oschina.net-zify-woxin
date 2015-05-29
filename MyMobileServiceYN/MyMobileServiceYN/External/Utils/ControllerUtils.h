//
//  ControllerUtils.h
//  MyMobileServiceYN
//
//  Created by 陆楠 on 15/3/27.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketVC.h"

@interface ControllerUtils : NSObject

+ (UINavigationController *)findViewControllerWithSourceView:(UIView *)sourceView;

+ (MarketVC *)findMarketVCWithSourceView:(UIView *)sourceView;

@end
