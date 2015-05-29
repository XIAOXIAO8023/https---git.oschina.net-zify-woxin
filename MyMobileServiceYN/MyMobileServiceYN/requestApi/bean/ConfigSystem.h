//
//  ConfigSystem.h
//  JFProject150506
//
//  Created by mouxiaochun on 15/5/6.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ConfigSystem : NSObject
/**
 *  获取系统单例
 *
 *  @return system
 */
+(ConfigSystem *)defaultSystem;

+(NSDictionary *)loginParams;

+(NSMutableDictionary *)busicodeParams:(NSString *)busiCode;
@end
