//
//  MyMobileServiceYNOverInfo.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    PackageElementsTypeNone = 0,           // no button type
    PackageElementsTypeGprs,
    PackageElementsTypeCall,
    PackageElementsTypeSms,
    PackageElementsTypeMsms,
    PackageElementsTypeWlan,
    PackageElementsTypeWlanM
} PackageElementsType;

@interface MyMobileServiceYNOverInfo : UIView

- (void)setOverInfoView:(PackageElementsType) type andTotal:(NSInteger)total andCurrent:(NSInteger)current;

@end
