//
//  TuCaoVC.h
//  YearBill
//
//  Created by 陆楠 on 15/3/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNParam.h"

@interface TuCaoVC : MyMobileServiceYNBaseVC<UITextViewDelegate,ASIHTTPRequestDelegate>
{
    UIScrollView *mainScrollView;
    
    NSArray *answersQ1;
    NSArray *answersQ2;
    
    int Q1answerID;
    int Q2answerID;
    NSString *Q1answer;
    NSString *Q2answer;
    
    UITextView *f;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    
    NSString *busiCode;
}

@end

@interface SelectBtn : UIButton
{
    UIButton *gouImageV;
}

@property (nonatomic , retain , readonly) UILabel *questionLabel;


@end