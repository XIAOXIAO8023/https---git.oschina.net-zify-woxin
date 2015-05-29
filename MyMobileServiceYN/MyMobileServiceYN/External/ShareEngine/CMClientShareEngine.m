//
//  CMClientShareEngine.m
//  CMClient
//
//  Created by Lee on 14-3-4.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "CMClientShareEngine.h"

@implementation CMClientShareEngine

//文字分享到新浪微博
-(void) sendTextContentToSinaWeibo:(NSString *)textMessage
{
    WBMessageObject *message = [WBMessageObject message];
    
    message.text = textMessage;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
//    request.userInfo 用户自定义发送的信息，可以省略
//    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    
    [WeiboSDK sendRequest:request];
}

//链接分享到新浪微博
- (void) sendLinkContentToSinaWeibo:(NSString *)title MessageDescription:(NSString *)description MessageImageName:(NSString *)imageName MessagePageUrl:(NSString *)pageUrl
{
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = title;
    webpage.description = description;
    webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"]];
    webpage.webpageUrl = pageUrl;
    message.mediaObject = webpage;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
//    request.userInfo 用户自定义发送的信息，可以省略
//    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    
    [WeiboSDK sendRequest:request];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = @"认证结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
//        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        
        [alert show];

    }
}

//微信
//onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
//-(void) onReq:(BaseReq*)req
//{
//    if([req isKindOfClass:[GetMessageFromWXReq class]])
//    {
//        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
//        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
//        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        alert.tag = 1000;
//        [alert show];
//    }
//    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
//    {
//        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
//        WXMediaMessage *msg = temp.message;
//        
//        //显示微信传过来的内容
//        WXAppExtendObject *obj = msg.mediaObject;
//        
//        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
//        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    else if([req isKindOfClass:[LaunchFromWXReq class]])
//    {
//        //从微信启动App
//        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
//        NSString *strMsg = @"这是从微信启动的消息";
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}

//如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//文字分享到微信
-(void) sendTextContentToWeChat:(NSString *)textMessage
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = textMessage;
    req.bText = YES;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

//链接分享到微信
- (void) sendLinkContentToWeChat:(NSString *)title MessageDescription:(NSString *)description MessageImageName:(NSString *)imageName MessagePageUrl:(NSString *)pageUrl
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:[UIImage imageNamed:imageName]];
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = pageUrl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

@end
