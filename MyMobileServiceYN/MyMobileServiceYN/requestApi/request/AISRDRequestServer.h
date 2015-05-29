//
//  AISRDRequestServer.h
//  JFProject150506
//
//  Created by mouxiaochun on 15/5/6.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AISRDRequest;
@interface AISRDRequestServer : NSObject
+(void)requestServer:(AISRDRequest *)request;
@end
