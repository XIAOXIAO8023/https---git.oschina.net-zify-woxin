//
//  YearBillChannel.h
//  MyMobileServiceYN
//
//  Created by 陆楠 on 15/3/18.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@class MyMobileServiceYNHttpRequest;

@interface YearBillChannel : NSObject<ASIHTTPRequestDelegate>
{
    MyMobileServiceYNHttpRequest *httpRequest;
    
    NSString *busiCode;
}

-(void)sendYearBillRequestWithInfo:(NSDictionary *)dic viewController:(UIViewController *)vc;

@end
