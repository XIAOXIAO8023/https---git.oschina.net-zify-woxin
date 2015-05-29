//
//  MyMobileServiceYNPackageDetailInfoGauges.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-11.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNOverInfo.h"
#import "MSSimpleGauge.h"

@interface MyMobileServiceYNPackageDetailInfoGauges : UIView{
    UIColor *currThemeColor;
}

@property (nonatomic) MSSimpleGauge *minimalGauge;

- (void)setPackageDetailInfoView:(PackageElementsType) type andDetailInfo:(NSArray *)detailInfo;

@end
