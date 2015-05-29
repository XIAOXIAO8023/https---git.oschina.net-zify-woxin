//
//  MyMobileServiceYNHttpRequest.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-5.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIFormDataRequest;

@interface MyMobileServiceYNHttpRequest : NSObject
{
    ASIFormDataRequest *request;
}

//-(void)initWithViewController:(UIViewController *)viewController;

-(void)setRequestDelegatNil;//为了防止程序异常，主动设置delegat为Nil

//获取http请求共用数据paramData
-(NSMutableDictionary *)getHttpPostParamData:(NSString *)busiCode;
-(void)startAsynchronous:(NSString *)busiCode requestParamData:(NSMutableDictionary *)requestParamData viewController:(UIViewController *)viewController;


@end
