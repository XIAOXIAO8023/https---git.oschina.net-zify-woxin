//
//  MyMobileServiceYNGprsPackageInfo.h
//  MyMobileServiceYN
//
//  Created by Michelle on 14-3-13.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@class MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNGprsPackageInfo : UIView<ASIHTTPRequestDelegate,UIScrollViewDelegate>
{
    NSArray *monthlyPackage;
    NSArray *upshiftPackage;
    NSArray *refuelPackage;
    NSArray *leisurePackage;
    
    NSDictionary *monthly1;
    NSDictionary *monthly2;
    NSDictionary *monthly3;
    
    NSDictionary *upshift1;
    NSDictionary *upshift2;
    NSDictionary *upshift3;
    
    NSDictionary *refuel1;
    NSDictionary *refuel2;
    NSDictionary *refuel3;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    UIViewController *VC;
    NSDictionary *touchedPackage;
    
}

-(void)setView:(NSMutableDictionary *)dic withViewController:(UIViewController *)viewcontroller withNsmutableArray: (NSMutableArray *)elementID;
@property NSString *busicode;

@end
