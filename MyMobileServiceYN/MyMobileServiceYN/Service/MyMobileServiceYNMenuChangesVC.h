//
//  MyMobileServiceYNMenuChangesVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-3.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"

@interface MyMobileServiceYNMenuChangesVC : MyMobileServiceYNBaseVC<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *menuChangesTableView;  //
    
    NSString *menuListFielPath;
    NSMutableDictionary *menuListDicSandbox;
    NSMutableArray *menuListArray;
    
    NSMutableArray *menuSelectList;
    NSMutableArray *menuNoSelectList;
    
}

@end
