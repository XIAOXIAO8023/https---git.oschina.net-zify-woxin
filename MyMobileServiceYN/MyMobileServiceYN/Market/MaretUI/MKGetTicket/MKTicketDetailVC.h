//
//  MKTicketDetailVC.h
//  Market
//
//  Created by 陆楠 on 15/3/26.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"
#import "MyMobileServiceYNHttpRequest.h"


@protocol editViewDelegate <NSObject>

-(void)editViewButtonPressed:(NSDictionary *)info;

@end

@interface MKTicketDetailVC : MyMobileServiceYNBaseVC<editViewDelegate,ASIHTTPRequestDelegate>
{
    CGFloat pointPrice;
    
    CGFloat newPrice;
    
    CGFloat oldPrice;
    
    UIScrollView *mainScrollView;
    
    UIWindow *editWinwow;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    
    NSString *busiCode;
    
    NSString *payment;
    
    NSString *mendian;
    
    NSString *shuoming;
}

@property (nonatomic, retain) NSDictionary *infoDic;

@end


@interface editView : UIView<UITextFieldDelegate>
{
    UITextField *rmbT;
    UILabel *pointL;
    
    NSString *rmbS;
    
    UIButton *commitB;
    
    UILabel *psL;
    
    UILabel *titleL;
    BOOL isOK;
}

@property (nonatomic, retain) NSString *rmb;

@property (nonatomic, assign) CGFloat pointPrice;

@property (nonatomic, retain) id<editViewDelegate>delegate;

@property (nonatomic, retain) NSString *psString;

@property (nonatomic, retain) NSString *title;

@end