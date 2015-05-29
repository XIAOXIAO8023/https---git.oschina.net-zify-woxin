//
//  MyMobileServiceYNMBProgressHUD.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-5.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MyMobileServiceYNMBProgressHUD : NSObject<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}

-(void)showTextHUDWithVC:(UIView *)view;
-(void)removeHUD;


@end
