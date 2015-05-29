//
//  AISRDRequestServer.m
//  JFProject150506
//
//  Created by mouxiaochun on 15/5/6.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "AISRDRequestServer.h"
#import "HTTPConfig.h"
#import "AISRDRequest.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation+Category.h"
#import "NSDictionary+Null.h"
#import "AISRDParser.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>


#define _AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES_ 1


@implementation AISRDRequestServer
+(void)requestServer:(AISRDRequest *)request{
    [self defaultRequest:request];
}


+(void)defaultRequest:(AISRDRequest *)request{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //url地址
    NSString *url = nil;
    if (request.isHttps) {
        url = SERVER_HTTPS_URL;
        manager.securityPolicy.allowInvalidCertificates = YES;
    }else{
		url = SERVER_URL;
    }

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",nil];
    
    
    AFHTTPRequestOperation *_operation = [manager POST:url
                                            parameters:request.params
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   NSLog(@"%@",responseObject);
                                                   [AISRDRequestServer resultHandler:request result:responseObject];
                                                   
                                               }
                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   
                                                   NSLog(@"%@",error);
                                                   [self errorHandler:request];
                                               }];
    
    [_operation setRequestType:request.requestType];
    
}

+ (void)configHttps{
    //AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    //  securityPolicy.allowInvalidCertificates = YES;
    [AFHTTPRequestOperationManager manager].securityPolicy.allowInvalidCertificates = YES;
}

#pragma mark ---

+(void)resultHandler:(AISRDRequest*)request result:(id)responseData{
    
    id object = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
//    id object = responseData;
    NSLog(@"%@",object);
    
    if ([object isKindOfClass:[NSArray class]]) {
        NSDictionary *dict = (NSDictionary*)object[0];
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            NSString *msg = [dict objectForKey:@"X_RESULTINFO"];
            request.message = msg;
            
            request.success = YES;
                //请求成功
            request.isRetainBlock = NO;
            [request updatedFromServer];
            
            [AISRDParser parserJFRequest:request result:dict data:responseData];
            return;
        }
    }
    
    [self errorHandler:request];
//    if ([object isKindOfClass:[NSDictionary class]]) {
//        NSString *msg = [object valueForKeyOfNSString:@"msg"];
//        request.message = msg;
//        BOOL isSuccess = [object valueForKeyOfBOOL:@"isSuccess"];
//        if (isSuccess) {
//            request.success = YES;
//            //请求成功
//            request.isRetainBlock = NO;
//            [request updatedFromServer];
//            
//            [AISRDParser parserJFRequest:request result:object data:responseData];
//        }else{
//            [self errorHandler:request];
//        }
//        NSLog(@"%@",msg);
//    }
    
}

+(void)errorHandler:(AISRDRequest *)request{
    request.success = NO;
    if (request.message.length == 0) {
        request.message = @"请求失败,请稍后再尝试!";
    }
    request.isRetainBlock = NO;
    [request updatedFromServer];
    [request excuteBlock];
}

@end
