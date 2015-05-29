//
//  DesEncrypt.h
//  MyMobileServiceYN
//
//  Created by zhaol on 14/12/10.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesEncrypt : NSObject
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;//加密
- (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key;//解密
@end
