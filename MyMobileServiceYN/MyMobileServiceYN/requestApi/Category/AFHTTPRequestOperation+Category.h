//
//  AFHTTPRequestOperation+Category.h
//  JFProject150506
//
//  Created by mouxiaochun on 15/5/6.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "HTTPConfig.h"
@interface AFHTTPRequestOperation(Category)
-(void)setRequestType:(AISRDRequestType)type;
-(AISRDRequestType)getRequestType;
@end
