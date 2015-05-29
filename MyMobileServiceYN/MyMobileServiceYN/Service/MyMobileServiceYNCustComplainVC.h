//
//  MyMobileServiceYNCustComplainVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-6.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface MyMobileServiceYNCustComplainVC : MyMobileServiceYNBaseVC<UITextFieldDelegate,UITextViewDelegate,ASIHTTPRequestDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UIScrollView *homeScrollView;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    
    NSMutableArray *complainTypeArray;
    NSMutableArray *complainAddressArray;
    
    NSInteger selectComplainTypeRow;
    NSInteger selectComplainAddressRow;
    
    UIView *backComplainTypeView;
    UIView *backComplainAddressView;
    
    UILabel *selectComplainTypeLabel;
    UILabel *selectComplainAddressLabel;
    
    UITapGestureRecognizer *tapGR;
}

@end
