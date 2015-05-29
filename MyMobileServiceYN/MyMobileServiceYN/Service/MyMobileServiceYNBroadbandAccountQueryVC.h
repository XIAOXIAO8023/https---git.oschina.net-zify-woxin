//
//  MyMobileServiceYNBroadbandAccountQueryVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-4.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface MyMobileServiceYNBroadbandAccountQueryVC : MyMobileServiceYNBaseVC<ASIHTTPRequestDelegate,UITextFieldDelegate>{
    MyMobileServiceYNHttpRequest *httpRequest;
    UIScrollView *homeScrollView;
    UITapGestureRecognizer *tapGR;
}

@property (nonatomic,strong) NSString *resID;

@end
