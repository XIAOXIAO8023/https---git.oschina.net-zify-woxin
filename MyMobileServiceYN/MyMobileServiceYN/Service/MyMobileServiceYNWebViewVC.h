//
//  MyMobileServiceYNWebViewVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-3-30.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"

@interface MyMobileServiceYNWebViewVC : MyMobileServiceYNBaseVC<UIWebViewDelegate>{
    UIWebView *anWebView;
}

@property (nonatomic, strong) NSString *webUrlString;

@end
