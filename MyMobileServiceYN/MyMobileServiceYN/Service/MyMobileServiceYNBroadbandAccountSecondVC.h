//
//  MyMobileServiceYNBroadbandAccountSecondVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-1.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface MyMobileServiceYNBroadbandAccountSecondVC : MyMobileServiceYNBaseVC<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>{
    NSMutableArray *singlePackageArray;
    NSMutableArray *marketingPackageArray;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSString *busiCode;
    NSMutableDictionary *selectedTypeRow;
    UIScrollView *packageTypeScrollView;
    UIButton *nextButton;
}

@property (nonatomic ,strong) NSMutableDictionary *broadBandDic;

@end
