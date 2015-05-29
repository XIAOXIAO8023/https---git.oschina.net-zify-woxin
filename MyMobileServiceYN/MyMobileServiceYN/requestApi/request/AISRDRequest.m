//
//  JFRequest.m
//  CMCC-JiFen
//
//  Created by mouxiaochun on 15/4/28.
//  Copyright (c) 2015年 MacMini. All rights reserved.
//

#import "AISRDRequest.h"
#import <objc/runtime.h>
#import "AISRDRequestServer.h"
#import <UIKit/UIKit.h>
#import "NSString+MD5Addition.h"
#import "FileManager.h"
#import "AISRDParser.h"
#import "ConfigSystem.h"

#import "WDCrypto.h"
static NSString * key_UpdatedFromServer = @"key_UpdatedFromServer";

@interface AISRDRequest ()
{
    
    AISRDCompletionBlock _block;
  
    BOOL _isUpdatedFromServer;
}
@end

@implementation AISRDRequest
+(instancetype)startWithRequestType:(AISRDRequestType)type
                           function:busicode
                              param:(NSDictionary *)param
                              block:(AISRDCompletionBlock)block{
    return [[[self class] alloc] initWithRequestType:type
                                            function:busicode
                                               param:param
                                               block:block];
}

-(instancetype)initWithRequestType:(AISRDRequestType)type
                          function:(NSString *)busicode
                             param:(NSDictionary *)param
                             block:(AISRDCompletionBlock)block{

    if (self = [super init]) {
        
        self.requestType = type;
      
        //配置请求参数
        [self configParams:param busicode:busicode];
        //保存block
        _block = [block copy];
        //获取服务端数据
        [AISRDRequestServer requestServer:self];
    }
    return self;
    
}

#pragma mark -- 添加基本参数
-(void)configParams:(NSDictionary *)param busicode:(NSString *)busicode{
    [self configParams:param busicode:busicode needEncrypt:NO];
}

-(void)configParams:(NSDictionary *)param busicode:(NSString *)busicode needEncrypt:(BOOL)needEncrypt{

    NSMutableDictionary *busiParam = [ConfigSystem busicodeParams:busicode];
    if ([param isKindOfClass:[NSDictionary class]]) {
        [busiParam setValuesForKeysWithDictionary:param];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:busiParam options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonParam = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 
    if (needEncrypt) {
        //加密处理--->
        NSString *key = @"";
        //加密后的param
        jsonParam = [WDCrypto DESEncryptWithBase64:jsonParam key:key];
        //加密后的key
        NSString *deskey = [WDCrypto RSAEncryptData:key keyPath:nil];
        //加密结束<---
        
        _params = @{@"paramdata":jsonParam,@"key":deskey};
    }else{
        _params = @{@"paramdata":jsonParam};
    }
}

+(NSDictionary *)basedParams{
    NSMutableDictionary *paramData = [[NSMutableDictionary alloc]init];
    // [paramData setObject:gUserPhoneNumber forKey:@"userMobile"];
    [paramData setObject:@"2.4.1" forKey:@"version"];
    [paramData setObject:@"ios" forKey:@"pattern"];
    [paramData setObject:@"" forKey:@"token"];
    [paramData setObject:@"" forKey:@"mobileProvince"];
    return paramData;
}

//获取手机型号
+(NSString *)mobileModel{
    static NSString* model = nil;
    if (!model) {
        model = [[UIDevice currentDevice] model];
        model = [model stringByAppendingString: [[UIDevice currentDevice] systemVersion]];
    }
    return model;
}
#pragma mark --- 执行blocks
-(void)excuteBlock{
    if (_block) {
        _block(_success,_message,self.isUpdatedFromServer);
        if (!_isRetainBlock) _block = nil;
    }
}


-(void)excuteBlockWithObject:(id)object{
    if (_block) {
        _block(_success,object,self.isUpdatedFromServer);
        if (!_isRetainBlock) _block = nil;
    }
}

-(void)updatedFromServer{

    objc_setAssociatedObject(self, (__bridge const void *)(key_UpdatedFromServer), [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isUpdatedFromServer{
    NSNumber *updated = objc_getAssociatedObject(self, (__bridge const void *)(key_UpdatedFromServer));
    return [updated boolValue];
    
}
#pragma mark --  getter && setter
/**
 *  需要获取缓存数据
 */
-(void)cache{
    NSString *param = [self.params description];
    NSString *url = [SERVER_URL stringByAppendingPathComponent:param];
    NSString *key = [url stringFromMD5];
    id object = [FileManager objectForKey:key];
    
    _isRetainBlock = YES;//缓存后，应该继续保存block
    
    [AISRDParser parserJFRequest:self result:object data:nil];
}


/**
 *  需要保存缓存数据
 */
-(void)needCache:(NSData *)responseData
{

    NSString *param = [self.params description];
    NSString *url = [SERVER_URL stringByAppendingPathComponent:param];
    NSString *key = [url stringFromMD5];
    
    [FileManager setObject:responseData forKey:key];
    
}


@end
