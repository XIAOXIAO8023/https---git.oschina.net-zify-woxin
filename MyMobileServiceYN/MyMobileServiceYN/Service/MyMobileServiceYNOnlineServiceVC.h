//
//  MyMobileServiceYNOnlineServiceVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-3-29.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface MyMobileServiceYNOnlineServiceVC : MyMobileServiceYNBaseVC<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,ASIHTTPRequestDelegate>{
    UITableView *onlineServiceTableView;
    UIView *editView;
    UITextView *messageTextView;
    NSMutableArray *messageArray;
    MyMobileServiceYNHttpRequest *httpRequest;
    CGFloat keyboardHeight;
    CGFloat editViewHeight;
    CGFloat tableViewContentOffSet;
}

@end
