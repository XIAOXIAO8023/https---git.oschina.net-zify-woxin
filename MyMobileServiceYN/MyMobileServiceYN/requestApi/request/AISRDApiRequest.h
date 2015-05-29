//
//  JFMallApiRequest.h
//  JFProject150506
//
//  Created by mouxiaochun on 15/5/6.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTTPConfig.h"

@class AISRDRequest;

@interface AISRDApiRequest : NSObject
//首页查询
+(AISRDRequest *)sycx:(AISRDCompletionBlock)completionBlock;
//登陆后首页查询
+(AISRDRequest *)hqyhxx:(AISRDCompletionBlock)completionBlock;

//检查版本
+(AISRDRequest *)checkVersion:(AISRDCompletionBlock)completionBlock;
//登录检查密码
+(AISRDRequest *)loginCheckPWD:(AISRDCompletionBlock)completionBlock;
//BusinessInfo 包括首页火热活动和手机商城等
+(AISRDRequest *)queryBusinessInfo:(AISRDCompletionBlock)completionBlock;
//首页banner数据
+(AISRDRequest *)queryBanner:(AISRDCompletionBlock)completionBlock;
@end
