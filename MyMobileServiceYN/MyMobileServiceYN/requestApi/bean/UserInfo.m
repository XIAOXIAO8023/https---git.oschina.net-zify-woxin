//
//  UserInfo.m
//  CMCC-JiFen
//
//  Created by zhaol on 4/9/15.
//  Copyright (c) 2015 MacMini. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userLevel = @"";
        _userMobile = @"";
        _userName = @"";
        _userScore = @"";
        _userStatus = @"";
        _mobileProvince = @"";
        _mobileProvinceName = @"";
        _totalPoint = @"";
        _validateStartTime = @"";
        _wareBrand = @"";
        _isLogin = NO;
        _token = @"";
    }
    return self;
}

/**
 *  @author zhaoliang, 15-04-09 11:04:17
 *
 *  @brief  单例获取
 *
 *  @return <#return value description#>
 *
 *  @since <#version number#>
 */
+(UserInfo *)sharedInstance{
    static UserInfo *sharedUserInfoInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedUserInfoInstance = [[self alloc] init];
    });
    return sharedUserInfoInstance;
}

+(instancetype)userInfoWithDictionary:(NSDictionary*)dic{
    UserInfo* userInfo = [UserInfo sharedInstance];
    userInfo.isLogin = YES;
    userInfo.userLevel = [dic objectForKey:@"userLevel"];
    userInfo.userMobile = [dic objectForKey:@"userMobile"];
    userInfo.userName = [dic objectForKey:@"userName"];
    userInfo.userScore = [dic objectForKey:@"userScore"];
    userInfo.userStatus = [dic objectForKey:@"userStatus"];
    userInfo.mobileProvince = [dic objectForKey:@"mobileProvince"];
    userInfo.mobileProvinceName = [dic objectForKey:@"mobileProvinceName"];
    userInfo.totalPoint = [dic objectForKey:@"totalPoint"];
    userInfo.validateStartTime = [dic objectForKey:@"validateStartTime"];
    userInfo.wareBrand = [dic objectForKey:@"wareBrand"];
    return userInfo;
}

+(void)setUserInfoWithNull{
    UserInfo* userInfo = [UserInfo sharedInstance];
    userInfo.isLogin = NO;
    userInfo.userLevel = @"";
    userInfo.userMobile = @"";
    userInfo.userName = @"";
    userInfo.userScore = @"";
    userInfo.userStatus = @"";
    userInfo.mobileProvince = @"";
    userInfo.mobileProvinceName = @"";
    userInfo.totalPoint = @"";
    userInfo.validateStartTime = @"";
    userInfo.wareBrand = @"";
    userInfo.token = @"";
}

+(void)setUserInfoByLoginSuccess:(NSDictionary*)dic{
    UserInfo* userInfo = [UserInfo sharedInstance];
    userInfo.isLogin = YES;
    userInfo.userMobile = (NSString*)[dic objectForKey:@"USERNUMBER"];
    userInfo.token = (NSString*)[dic objectForKey:@"NEWTOKEN"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@", self.userLevel,self.userName];
}
@end
