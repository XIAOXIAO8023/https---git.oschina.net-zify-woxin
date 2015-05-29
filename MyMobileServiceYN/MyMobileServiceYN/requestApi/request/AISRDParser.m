//
//  AISRDParser.m
//  JFProject150506
//
//  Created by mouxiaochun on 15/5/6.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "AISRDParser.h"
#import "AISRDRequest.h"
@implementation AISRDParser

+(void)parserJFRequest:(AISRDRequest*)request result:(id)result data:(NSData *)responseData{

    switch (request.requestType) {
            
        case AISRDRequestTypeSycx:
        {
            
            id retInfo = [result objectForKey:@"retInfo"];

            request.success = YES;
            
            [request excuteBlockWithObject:retInfo];
            
            if (responseData) {
                //缓存数据
                [request needCache:responseData];
            }
           
        }
            break;
        case AISRDRequestTypeHqyhxx:{
            
            id retInfo = [result objectForKey:@"retInfo"];
            
            request.success = YES;

            [request excuteBlockWithObject:retInfo];
            
            if (responseData) {
                //缓存数据
                [request needCache:responseData];
            }

        }
            break;
        case AISRDRequestTypeCommon:{
            //公共方法,提供给js接口调用,请求成功返回retInfo里的数据
            id retInfo = [result objectForKey:@"retInfo"];
            [request excuteBlockWithObject:retInfo];
            if (responseData) {
                //缓存数据
                [request needCache:responseData];
            }
        }
            break;
            
        case AISRDRequestType_checkVersion:{
            [request excuteBlockWithObject:result];
            if (responseData) {
                //缓存数据
                [request needCache:responseData];
            }
        }
            break;
        case AISRDRequestType_loginCheckPWD:{
            [request excuteBlockWithObject:result];
            if (responseData) {
                    //缓存数据
                [request needCache:responseData];
            }
        }
            break;
        case AISRDRequestType_queryBusinessInfo:{
            [request excuteBlockWithObject:result];
            if (responseData) {
                    //缓存数据
                [request needCache:responseData];
            }
        }
            break;
        case AISRDRequestType_queryBanner:{
            [request excuteBlockWithObject:result];
            if (responseData) {
                    //缓存数据
                [request needCache:responseData];
            }
        }
            break;
        default:
            
            break;
    }
}
@end
