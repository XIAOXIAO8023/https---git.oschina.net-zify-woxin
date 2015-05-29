//
//  RegiftPointVC.h
//  Market
//
//  Created by 陆楠 on 15/3/25.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "RPGiftPointV.h"

typedef enum {
    QualificationYes,
    QualificationOver,
    QualificationLack,
    QualificationOther
}Qualification;


@interface RegiftPointVC : MyMobileServiceYNBaseVC<ASIHTTPRequestDelegate,RPGiftPointVDelegate>
{
    NSInteger initType;
    
    Qualification type;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    
    NSString *busiCode;
    
    id commitInfo;
}

@end
