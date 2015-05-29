//
//  MyMobileServiceYNOrderGprsVC.h
//  MyMobileServiceYN
//
//  Created by Michelle on 14-3-13.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "GrayPageControl.h"
#import "ASIHTTPRequest.h"

@class MyMobileServiceYNHttpRequest;


@interface MyMobileServiceYNOrderGprsVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>
{
    UIScrollView *homeScrollView;
    GrayPageControl *pageControl;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    NSString *busiCode;
    
    NSArray *monthlyPackage;
    NSArray *upshiftPackage;
    NSArray *refuelPackage;
    NSArray *leisurePackage;
    NSArray *otherPackage;
    
    //NSMutableArray *currentOderedPackage;
    
    NSString *sendElementID;
    //BOOL isOpen;
    NSString *elementID;
    
    NSMutableArray *elementIdArray;
    
}

-(void)showPackageDetail:(NSMutableDictionary *)alertDic withInteger: (NSInteger )alertTag;

@property NSInteger alertTag;
@property (nonatomic, strong)NSDictionary *alertDic;
@property NSString *sendTag;
@property BOOL isOpen;
@property (nonatomic,strong)NSMutableArray *currentOderedPackage;
@end
