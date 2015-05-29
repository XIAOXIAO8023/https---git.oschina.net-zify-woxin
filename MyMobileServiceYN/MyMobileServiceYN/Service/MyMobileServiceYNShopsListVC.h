//
//  MyMobileServiceYNShopsListVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-9.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"
#import "TMQuiltView.h"

@interface MyMobileServiceYNShopsListVC : MyMobileServiceYNBaseVC<TMQuiltViewDataSource,TMQuiltViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ASIHTTPRequestDelegate>{
    MyMobileServiceYNHttpRequest *httpRequest;
    
    UIView *backSelectShopsLocationView;
    NSInteger selectShopsLocationRow;
    UILabel *selectShopsLocationLabel;
    
    NSMutableArray *shopsArray;
    NSMutableArray *shopLocationArray;
    
    TMQuiltView *shopsQuiltView;
    
}

@end
