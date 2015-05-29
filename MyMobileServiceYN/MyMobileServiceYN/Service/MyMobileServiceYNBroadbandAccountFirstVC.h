//
//  MyMobileServiceYNBroadbandAccountFirstVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-1.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface MyMobileServiceYNBroadbandAccountFirstVC : MyMobileServiceYNBaseVC<ASIHTTPRequestDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>{
    
    UIButton *nextButton;
    MyMobileServiceYNHttpRequest *httpRequest;
    NSString *busiCode;
    UIScrollView *homeScrollView;
    
//    UITextField *detailTextfield;
    UILabel *addressLabel;
    
    UIButton *selectNeighbour;
    UIButton *selectAddress;
    UIButton *selectSection;
    UILabel *countrySelectedLabel;
    UILabel *neighbourSelectedLabel;
    UILabel *sectionSelectedLabel;
    
    NSMutableArray *countryArray;
    NSMutableArray *neighborArray;
    NSMutableArray *sectionArray;
    
    NSInteger selectCountryRow;
    NSInteger selectNeighborRow;
    NSInteger selectSectionRow;
    
    UIView *backgroundCountryView;
    UIView *backgroundNeighborView;
    UIView *backgroundSectionView;
    
    UIPickerView *selectCountryPicker;
    UIToolbar *selectCountryToolber;
    
    UIPickerView *selectNeighborPicker;
    UIToolbar *selectNeighborTooler;
    
    UIPickerView *selectSectionPicker;
    UIToolbar *selectSectionToolbar;
    
    NSDictionary *addressInfo;
    
    NSString *agentPhone;//施工队联系电话
}

@end
