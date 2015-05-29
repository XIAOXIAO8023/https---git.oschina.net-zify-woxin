//
//  MyMobileServiceYNCustComplainHistoryQueryVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface MyMobileServiceYNCustComplainHistoryQueryVC : MyMobileServiceYNBaseVC<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ASIHTTPRequestDelegate>{
    
    UIScrollView *homeScrollView;
    MyMobileServiceYNHttpRequest *httpRequest;
    UITapGestureRecognizer *tapGR;
    
    NSMutableArray *complainTypeArray;
    UIView *backComplainTypeView;
    UILabel *selectComplainTypeLabel;
    NSInteger selectComplainTypeRow;
    
    
    UIView *backStartTimeView;
    UIView *backEndTimeView;
    
    UILabel *startTimeLabel;
    UILabel *endTimeLabel;
    
    NSDate *startDate;
    NSDate *endDate;
}

@end
