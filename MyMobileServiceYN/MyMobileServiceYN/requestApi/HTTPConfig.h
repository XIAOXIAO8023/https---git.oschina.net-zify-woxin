//
//  JFConfig.h
//  CMCC-JiFen
//
//  Created by mouxiaochun on 15/4/28.
//  Copyright (c) 2015年 MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USE_TEST_ENV   0    //测试环境
#define USE_WWW_ENV    1    //正式上线的环境
#define USE_LOCAL_ENV  0    // 本地测试

 
#if USE_WWW_ENV
#define SERVER_URL @"http://218.202.0.168:8090/WSReceiver"
#define SERVER_HTTPS_URL @""
#define IMAGE_URL @""

#elif USE_TEST_ENV
#define SERVER_URL @"http://10.173.148.176:7001/t/WSReceiver"
#define SERVER_HTTPS_URL @""
#define IMAGE_URL @""

#elif USE_LOCAL_ENV
#define SERVER_URL @"http://192.168.123.1:8080/WSReceiver"
#define SERVER_HTTPS_URL @""
#define IMAGE_URL @""

#endif

//用户debug模式下打印日志
#define DEBUG_MODE

#ifdef DEBUG_MODE
#define DebugNSLog( format, ... ) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(format), ##__VA_ARGS__] )

#else
#define DebugNSLog( format, ... )
#endif

/**
 *  请求数据后的block
 *
 *  @param success 是否成功
 *  @param object  解析后的数据
 *  @param isUpdatedFromServer  YES为从服务端更新的最新数据，NO是从缓存中获取的数据
 *
 */
typedef void (^AISRDCompletionBlock)(BOOL success,id object, BOOL isUpdatedFromServer) ;

typedef enum AISRDRequestType{
    AISRDRequestTypeCommon,
    AISRDRequestTypeSycx,
    AISRDRequestTypeHqyhxx,
    AISRDRequestType_checkVersion,
    AISRDRequestType_loginCheckPWD,
    AISRDRequestType_queryBusinessInfo,
    AISRDRequestType_queryBanner
}AISRDRequestType;

