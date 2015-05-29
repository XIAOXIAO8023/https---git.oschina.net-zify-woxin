//
//  CookieUtil.h
//  MyMobileServiceYN
//
//  Created by CRMac on 5/28/15.
//  Copyright (c) 2015 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookieUtil : NSObject

+ (NSString *)cookieValueWithKey:(NSString *)key;
+ (void)deleteCookieWithKey:(NSString *)key;

@end
