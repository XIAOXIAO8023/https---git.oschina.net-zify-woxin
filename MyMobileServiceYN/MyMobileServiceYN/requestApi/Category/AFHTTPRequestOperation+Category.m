//
//  AFHTTPRequestOperation+Category.m
//  JFProject150506
//
//  Created by mouxiaochun on 15/5/6.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "AFHTTPRequestOperation+Category.h"
#import <objc/runtime.h>

static NSString * key_AFNRquestType = @"key_AFNRquestType";

@implementation AFHTTPRequestOperation(Category)
-(void)setRequestType:(AISRDRequestType)type
{
    objc_setAssociatedObject(self, (__bridge const void *)(key_AFNRquestType), [NSNumber numberWithInteger:type], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(AISRDRequestType)getRequestType{

    NSNumber *style = objc_getAssociatedObject(self, (__bridge const void *)(key_AFNRquestType));
    return [style intValue];
}
@end
