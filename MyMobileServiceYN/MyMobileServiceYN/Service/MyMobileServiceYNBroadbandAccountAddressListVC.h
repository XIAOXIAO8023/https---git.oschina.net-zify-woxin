//
//  MyMobileServiceYNBroadbandAccountAddressListVC.h
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-12.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"

@interface MyMobileServiceYNBroadbandAccountAddressListVC : MyMobileServiceYNBaseVC<UITableViewDataSource,UITableViewDelegate>{
    UITableView *queryTableView;
}

@property (nonatomic,strong) NSArray *addressList;


@end
