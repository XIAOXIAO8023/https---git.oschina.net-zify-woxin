//
//  CookieUtil.m
//  MyMobileServiceYN
//
//  Created by CRMac on 5/28/15.
//  Copyright (c) 2015 asiainfo-linkage. All rights reserved.
//

#import "CookieUtil.h"

@implementation CookieUtil
//获取登陆请求成功后保存的cookies
+ (NSString *)cookieValueWithKey:(NSString *)key
{
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    if ([sharedHTTPCookieStorage cookieAcceptPolicy] != NSHTTPCookieAcceptPolicyAlways) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    }
    
//    NSArray         *cookies = [sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:@"http://192...."]];
	NSArray         *cookies = [sharedHTTPCookieStorage cookies];
    NSEnumerator    *enumerator = [cookies objectEnumerator];
    NSHTTPCookie    *cookie;
    while (cookie = [enumerator nextObject]) {
        if ([[cookie name] isEqualToString:key]) {
            return [NSString stringWithString:[[cookie value] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    return nil;
}


//删除cookies (key所对应的cookies)
///因为cookies保存在NSHTTPCookieStorage.cookies中.这里删除它里边的元素即可.
+ (void)deleteCookieWithKey:(NSString *)key
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookies = [NSArray arrayWithArray:[cookieJar cookies]];
    
    for (NSHTTPCookie *cookie in cookies) {
        if ([[cookie name] isEqualToString:key]) {
            [cookieJar deleteCookie:cookie];
        }
    }
}
@end
