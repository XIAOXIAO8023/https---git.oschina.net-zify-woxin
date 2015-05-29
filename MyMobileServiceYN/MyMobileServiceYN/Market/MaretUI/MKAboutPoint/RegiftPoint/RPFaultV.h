//
//  RPFailtV.h
//  Market
//
//  Created by 陆楠 on 15/3/25.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    RPFaultReasonLackAge,
    RPFaultReasonOverPoint,
    RPFaultReasonCommon
}RPFaultReason;

@interface RPFaultV : UIView
{
    UIImageView *imageV;//错误图片
    
    UILabel *reasonL;//原因
}

@property (nonatomic, assign) RPFaultReason faultReason;

@property (nonatomic, retain) NSString *commonReason;

@end
