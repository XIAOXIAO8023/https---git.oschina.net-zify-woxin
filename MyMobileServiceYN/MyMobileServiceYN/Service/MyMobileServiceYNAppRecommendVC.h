//
//  MyMobileServiceYNAppRecommendVC.h
//  MyMobileServiceYN
//
//  Created by 陆楠 on 14/12/10.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNAppRecommendVC : MyMobileServiceYNBaseVC<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mainTableView;
    NSMutableArray *infoArray;
}
@end
