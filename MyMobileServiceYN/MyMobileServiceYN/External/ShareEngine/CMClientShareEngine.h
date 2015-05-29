//
//  CMClientShareEngine.h
//  CMClient
//
//  Created by Lee on 14-3-4.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@interface CMClientShareEngine : NSObject<WXApiDelegate,WeiboSDKDelegate,WBHttpRequestDelegate>
{
    enum WXScene _scene;
}

-(void) sendTextContentToSinaWeibo:(NSString *)textMessage;//文字分享到新浪微博
- (void) sendLinkContentToSinaWeibo:(NSString *)title MessageDescription:(NSString *)description MessageImageName:(NSString *)imageName MessagePageUrl:(NSString *)pageUrl;//链接分享到新浪微博，imageName不带后缀，文件需要为（.jpg）
-(void) sendTextContentToWeChat:(NSString *)textMessage;//文字分享到微信
- (void) sendLinkContentToWeChat:(NSString *)title MessageDescription:(NSString *)description MessageImageName:(NSString *)imageName MessagePageUrl:(NSString *)pageUrl;//链接分享到微信，imageName带后缀，为.png


@end
