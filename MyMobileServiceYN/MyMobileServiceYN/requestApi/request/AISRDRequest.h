//
//  JFRequest.h
//  CMCC-JiFen
//
//  Created by mouxiaochun on 15/4/28.
//  Copyright (c) 2015年 MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPConfig.h"
@interface AISRDRequest : NSObject
/**
 *  向服务端传递的参数
 */
@property (nonatomic, retain) NSDictionary *params;
/**
 *  请求方法类型,一个接口对应一个类型
 */
@property (nonatomic, assign) AISRDRequestType requestType;
/**
 *  服务端返回的提示
 */
@property (nonatomic, assign) NSString *message;
/**
 *  请求数据是否成功
 */
@property (nonatomic, assign) BOOL success;
//保留block
@property (nonatomic, assign) BOOL isRetainBlock;

@property (nonatomic, assign) BOOL isHttps;

+(instancetype)startWithRequestType:(AISRDRequestType)type
                           function:function
                              param:(NSDictionary *)param
                              block:(AISRDCompletionBlock)block;
//执行block
-(void)excuteBlockWithObject:(id)object;
-(void)excuteBlock;

#pragma mark -- setter && getter
/**
 *  需要获取缓存数据
 */
-(void)cache;

/**
 *  需要保存缓存数据
 */
-(void)needCache:(NSData *)responseData;

//标记数据是从服务端更新的最新数据
-(void)updatedFromServer;


@end
