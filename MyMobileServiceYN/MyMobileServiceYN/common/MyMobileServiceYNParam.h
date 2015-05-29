//
//  MyMobileServiceYNParam.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-2-25.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMobileServiceYNParam : NSObject

+(NSString *)getPattern;
+(NSString *)getVersion; //获取版本号
+(void)setVersion:(NSString *)version; //设置版本号
+(BOOL)getIsRemberPassWord; //获取是否记住密码
+(void)setIsRemberPassWord:(BOOL)isRemberPassWord; //设置是否记住密码
+(BOOL)getIsAutoLogin; //获取是否自动登录
+(void)setIsAutoLogin:(BOOL)isAutoLogin;//设置是否自动登录
+(NSString *)getSerialNumber;//获取手机用户号码
+(void)setSerialNumber:(NSString *)serialNumber; //设置用户手机号码
+(NSString *)getDESSerialNumber;//获取DES加密过的手机用户号码（接口返回的）
+(void)setDESSerialNumber:(NSString *)serialNumber; //设置DES加密过的用户手机号码
+(NSString *)getVipTag;//VIP标志
+(void)setVipTag:(NSString *)vipTag;
+(NSString *)getBrandCode;//品牌编码
+(NSString *)getBrandName;//获取品牌编码
+(void)setBrandCode:(NSString *)brandCode;
+(NSString *)getCityCode;
+(NSString *)getCityName;
+(void)setCityCode:(NSString *)cityCode;
+(NSString *)getCustName;//获取客户名称
+(void)setCustName:(NSString *)custName; //设置客户名称
+(NSString *)getPsptID;
+(void)setPsptID:(NSString *)psptID;
+(NSString *)getIsHuiDuVersion;
+(void)setIsHuiDuVersion:(NSString *)isHuiDuVersion;
+(NSString *)getUserPassWord;//获取客服密码
+(void)setUserPassWord:(NSString *)userPassWord; //设置客服密码
+(BOOL)getIsLogin; //获取是否登录
+(void)setIsLogin:(BOOL)isLogin; //设置是否登录
+(NSDate *)getLoginUpdateDate; //获取最后更新时间
+(void)setLoginUpdateDate:(NSDate *)loginUpdateDate; //设置最后更新时间
+(NSString *)getMerc;//获取手机支付商户号
+(NSString *)getPayUrl;//获取手机支付请求链接
+(NSDictionary *)getCurrentMonthCostDic; //获取当月话费
+(void)setCurrentMonthCostDic:(NSDictionary *)currentMonthCostDic; //设置当月话费
+(NSDictionary *)getCurrentCostDic; //获取实时话费
+(void)setCurrentCostDic:(NSDictionary *)currentCostDic; //设置实时话费
+(NSArray *)getCurrentCostArray; //获取实时话费
+(void)setCurrentCostArray:(NSArray *)currentCostArray; //设置实时话费
+(NSArray *)getBannerArray;//获取banner
+(void)setBannerArray:(NSArray *)bannerArray; //设置banner
+(void)setNoUserInfo;
+(NSDictionary *)getBusinessRecommendDic;//获取猜你喜欢营销数据
+(void)setBusinessRecommendDic:(NSDictionary *)businessRecommendDic;//设置猜你喜欢营销数据
+(BOOL)getIsDynamicPW; //获取是否动态密码登录
+(void)setIsDynamicPW:(BOOL)isDynamicPW; //设置是否动态密码登录
+(void)setUserId:(NSString*)userid;//userid
+(NSString*)getUserId;//userid
+(NSArray *)getBusinessInfoArray;//获取BusinessInfo
+(void)setBusinessInfoArray:(NSArray *)businessInfoArray; //设置BusinessInfo
@end
