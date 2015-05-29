//
//  UserInfo.h
//  CMCC-JiFen
//  用户信息，保存了用户的基本信息，并且是单例的
//  Created by zhaol on 4/9/15.
//  Copyright (c) 2015 MacMini. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic,strong) NSString* userStatus;          //用户状态
@property (nonatomic,strong) NSString* userLevel;           //用户等级
@property (nonatomic,strong) NSString* mobileProvince;      //用户省别
@property (nonatomic,strong) NSString* mobileProvinceName;  //用户省别名字
@property (nonatomic,strong) NSString* userScore;           //用户当前可用积分
@property (nonatomic,strong) NSString* totalPoint;          //用户总积分
@property (nonatomic,strong) NSString* userMobile;          //用户手机号码
@property (nonatomic,strong) NSString* wareBrand;           //用户品牌及星级 0全球通 1神州行 2动感地带 05五星（钻）06五星（金）07五星08四星09三星10二星11一星12准星13未评级
@property (nonatomic,strong) NSString* userName;            //用户名
@property (nonatomic,strong) NSString* validateStartTime;   //用户可使用积分时间 YYYYMMDDHH24mmSS

@property (nonatomic,assign) BOOL isLogin;//是否登录
@property (nonatomic,strong) NSString* token;//token

+(UserInfo*)sharedInstance;

+(instancetype)userInfoWithDictionary:(NSDictionary*)dic;
+(void)setUserInfoWithNull;
+(void)setUserInfoByLoginSuccess:(NSDictionary*)dic;

@end
