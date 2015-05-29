//
//  AISRDParser.h
//  JFProject150506
//
//  Created by mouxiaochun on 15/5/6.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPConfig.h"
@class AISRDRequest;
@interface AISRDParser : NSObject
+(void)parserJFRequest:(AISRDRequest *)request result:(id)result data:(NSData *)responseData;
@end
