//
//  MyMobileServiceYNGprsOderInfoVC.h
//  MyMobileServiceYN
//
//  Created by Michelle on 14-4-1.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "MyMobileServiceYNBaseVC.h"

@class MyMobileServiceYNHttpRequest;

@interface MyMobileServiceYNGprsOderInfoVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>
{
    UIScrollView *detailScroll;
    
    UILabel *currentPackageTitle;
    UILabel *changePackageTip;
    UILabel *changeNameTitle;
    UILabel *changeNameInfo;
    UILabel *changePriceTitle;
    UILabel *changePriceInfo;
    UILabel *changeFlowTitle;
    UILabel *changeFlowInfo;
    UILabel *changeEffectTimeTitle;
    UILabel *changeEffectTimeInfo;
    UILabel *changeUseTimeTitle;
    UILabel *changeUseTimeInfo;
    UILabel *changeChargeTypeTitle;
    UILabel *changeChargeTypeInfo;
    UILabel *orderPackageTip;
    UILabel *orderPackageRule;
    
    NSInteger orderListHeight;
    NSInteger changeTitleWidth;
    NSInteger changeInfoWidth;
    NSInteger changeInfoXPosition;
    //NSInteger pressedTag;
    
    UIButton *confirmChange;
    
    NSString *orderPackageString;
    NSString *orderElementId;
    NSString *busiCode;
    NSString *orderLevel;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    NSMutableDictionary *requestBeanDic;
    //NSMutableArray *array;
    //NSDictionary *dic;
    
}

-(void)setCurrentPackage:(NSMutableArray *)array;
-(void)setNewPackageDetail:(NSDictionary *)dic withTagString: (NSString *)orderTag;
@property BOOL isOpen;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSDictionary *dic;
@property NSInteger pressedTag;

@end
