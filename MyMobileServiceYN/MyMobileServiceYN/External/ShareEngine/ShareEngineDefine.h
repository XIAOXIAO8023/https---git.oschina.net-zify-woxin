//
//  ShareEngineDefine.h
//  CMClient
//
//  Created by Lee on 14-3-4.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#ifndef CMClient_ShareEngineDefine_h
#define CMClient_ShareEngineDefine_h

typedef enum
{
    sinaWeibo, //新浪微博
    weChat, //微信
    weChatFriend //微信朋友圈
}WeiboType;



#define AccessTokenKey      @"WeiBoAccessToken"
#define ExpirationDateKey   @"WeiBoExpirationDate"
#define ExpireTimeKey       @"WeiBoExpireTime"
#define UserIDKey           @"WeiBoUserID"
#define OpenIdKey           @"WeiBoOpenId"
#define OpenKeyKey          @"WeiBoOpenKey"
#define RefreshTokenKey     @"WeiBoRefreshToken"
#define NameKey             @"WeiBoName"
#define SSOAuthKey          @"WeiBoIsSSOAuth"

#endif

