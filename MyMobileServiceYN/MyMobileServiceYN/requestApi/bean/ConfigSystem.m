//
//  ConfigSystem.m
//  JFProject150506
//
//  Created by mouxiaochun on 15/5/6.
//  Copyright (c) 2015年 mouxiaochun. All rights reserved.
//

#import "ConfigSystem.h"
#import "UserInfo.h"
#import "MyMobileServiceYNParam.h"

@interface ConfigSystem ()
{
    BOOL _login;
}
@end

@implementation ConfigSystem
/**
 *  获取系统单例
 *
 *  @return system
 */
+(ConfigSystem *)defaultSystem{
    static ConfigSystem *system = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        system = [[[self class] alloc] init];
    });
    return system;
}


-(instancetype)init{
    
    self = [super init];
    if (self) {

    }
    return self;
}

+(BOOL)hasLogin{

    return [[ConfigSystem defaultSystem] isLogin];
}

-(BOOL)isLogin{
    return NO;
}

+(NSDictionary *)loginParams{

    return [[ConfigSystem defaultSystem] loginParams];
}

-(NSDictionary *)loginParams{

    NSMutableDictionary *params = nil;
    params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"flag"];

    return params;
}

+(NSMutableDictionary *)busicodeParams:(NSString *)busiCode
{
    return [[ConfigSystem defaultSystem] busicodeParams:busiCode];
}

-(NSMutableDictionary *)busicodeParams:(NSString *)busiCode{
    static NSString *mobileVersion,*mobileModel;
    if (!mobileVersion) {
        mobileVersion = [[UIDevice currentDevice] systemVersion];
    }
    if(!mobileModel){
        mobileModel = [[[UIDevice currentDevice] model] stringByAppendingString:mobileVersion];
    }

    NSMutableDictionary *paramData = [[NSMutableDictionary alloc]init];
    [paramData setObject:busiCode forKey:@"intf_code"];
    [paramData setObject:[MyMobileServiceYNParam getVersion] forKey:@"version"];
    [paramData setObject:[MyMobileServiceYNParam getPattern] forKey:@"pattern"];
    [paramData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"staffid"];
    [paramData setObject:[MyMobileServiceYNParam getUserPassWord] forKey:@"psd"];
    [paramData setObject:[MyMobileServiceYNParam getCityCode] forKey:@"eparchyCode"];
    [paramData setObject:mobileModel forKey:@"mobileModel"];
    [paramData setObject:mobileVersion forKey:@"mobileVersion"];
    [paramData setObject:@"iOS" forKey:@"Platform"];
    if([MyMobileServiceYNParam getIsAutoLogin]){
        [paramData setObject:@"0" forKey:@"autologin"];
    }else{
        [paramData setObject:@"-1" forKey:@"autologin"];
    }
    if ([MyMobileServiceYNParam getIsDynamicPW]) {
        [paramData setObject:@"1" forKey:@"loginType"];
    }else{
        [paramData setObject:@"0" forKey:@"loginType"];
    }
    return paramData;
}

- (UIViewController *)findViewController
{
        UIViewController *result = nil;
    
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        if (window.windowLevel != UIWindowLevelNormal)
        {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow * tmpWin in windows)
            {
                if (tmpWin.windowLevel == UIWindowLevelNormal)
                {
                    window = tmpWin;
                    break;
                }
            }
        }
        
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            result = nextResponder;
        else
            result = window.rootViewController;
 
    if ([result isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)result;
        
        return navController.visibleViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        return result;
    }
    UITabBarController *tabbar = (UITabBarController *)result;
    UINavigationController *navController =  [tabbar viewControllers ][0];
 
    return navController.visibleViewController;
    
}
@end
