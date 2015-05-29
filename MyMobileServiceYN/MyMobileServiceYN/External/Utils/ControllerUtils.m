//
//  ControllerUtils.m
//  MyMobileServiceYN
//
//  Created by 陆楠 on 15/3/27.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import "ControllerUtils.h"

@implementation ControllerUtils


+ (UINavigationController *)findViewControllerWithSourceView:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UINavigationController class]]) {
            break;
        }
    }
    return target;
}

+ (MarketVC *)findMarketVCWithSourceView:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[MarketVC class]]) {
            break;
        }
    }
    return target;
}

@end
