//
//  MyMobileServiceYNParam.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-2-25.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNParam.h"

//登录前用户参数
static NSString *gPattern = @"ios";
//static NSString *gVersion = @"1.0.0.040303";//版本号
static NSString *gVersion = @"0.8.0";//版本号

static BOOL gIsRemberPassWord = NO;//是否记住密码
static BOOL gIsAutoLogin = YES;//是否自动登录
//static NSString *gUserPhoneNumber = @"13887268707";//用户手机号码
static NSString *gUserPassWord = @"";//客服密码
static BOOL gIsDynamicPW = NO; //是否动态密码登录

//登录后用户参数  包括用户信息等
static BOOL gIsLogin = NO;//是否登录
static NSDate *gLoginUpdateDate = nil;//最新登陆状态更新时间
static NSString *gSerialNumber = @"";//登录成功后设定，目前为测试需要写死
static NSString *gDESSerialNumber = @"";//登录成功后设定，DES加密过的手机号
static NSString *gVipTag = @"";
static NSString *gBrandCode = @"";
static NSString *gCustName = @"";
static NSString *gCityCode=@"";
static NSString *gPsptID=@"";
static NSString *gIsHuiDuVersion=@"1";//默认设置为非灰度
static NSString *gUserId = @"";

static NSDictionary *gCurrentMonthCostDic;
static NSDictionary *gCurrentCostDic;
static NSArray *gCurrentCostArray;
static NSArray *gBannerArray;
static NSArray *gBusinessInfoArray;

//手机支付，商户号
static NSString *gMerc = @"888009948140347";
static NSString *gPayUrl = @"https://p.10086.cn/payment/wuxian_center.jsp?merc=";

//猜你喜欢业务推荐数据
static NSDictionary *gBusinessRecommendDic;



@implementation MyMobileServiceYNParam

+(NSString *)getPattern //
{
    return gPattern;
}

+(NSString *)getVersion //获取版本号
{
    return gVersion;
}
+(void)setVersion:(NSString *)version //设置版本号
{
    gVersion = version;
}
+(BOOL)getIsRemberPassWord //获取是否记住密码
{
    return gIsRemberPassWord;
}
+(void)setIsRemberPassWord:(BOOL)isRemberPassWord //设置是否记住密码
{
    gIsRemberPassWord = isRemberPassWord;
}
+(BOOL)getIsAutoLogin //获取是否自动登录
{
    return gIsAutoLogin;
}
+(void)setIsAutoLogin:(BOOL)isAutoLogin //设置是否自动登录
{
    gIsAutoLogin = isAutoLogin;
}
+(NSString *)getSerialNumber//获取手机用户号码
{
    return gSerialNumber;
}
+(void)setSerialNumber:(NSString *)serialNumber //设置用户手机号码
{
    gSerialNumber = serialNumber;
}
+(NSString *)getVipTag//获取VIP标志
{
    return gVipTag;
}
+(void)setVipTag:(NSString *)vipTag //设置VIP标志
{
    gVipTag = vipTag;
}
+(NSString *)getBrandCode//获取品牌编码
{
    return gBrandCode;
}
+(NSString *)getBrandName//获取品牌编码
{
    if (![gBrandCode isEqualToString:@""]) {
        if ([gBrandCode isEqualToString:@"G001"]) {
            return @"全球通";
        }else if([gBrandCode isEqualToString:@"G010"]) {
            return @"动感地带";
        }else if([gBrandCode isEqualToString:@"G003"]) {
            return @"神州行";
        }else{
            return @"神州行";
        }
    }
    return gBrandCode;
}
+(void)setBrandCode:(NSString *)brandCode //设置品牌编码
{
    gBrandCode = brandCode;
}
+(NSString *)getCityName
{
    if (![gCityCode isEqualToString:@""]) {
        if ([gCityCode isEqualToString:@"0871"]) {
            return @"昆明";
        }else if([gCityCode isEqualToString:@"0883"]){
            return @"临沧";
        }else if([gCityCode isEqualToString:@"0874"]){
            return @"曲靖";
        }else if([gCityCode isEqualToString:@"0876"]){
            return @"文山";
        }else if([gCityCode isEqualToString:@"0692"]){
            return @"德宏";
        }else if([gCityCode isEqualToString:@"0887"]){
            return @"迪庆";
        }else if([gCityCode isEqualToString:@"0879"]){
            return @"普洱";
        }else if([gCityCode isEqualToString:@"0878"]){
            return @"楚雄";
        }else if([gCityCode isEqualToString:@"0877"]){
            return @"玉溪";
        }else if([gCityCode isEqualToString:@"0886"]){
            return @"怒江";
        }else if([gCityCode isEqualToString:@"0873"]){
            return @"红河";
        }else if([gCityCode isEqualToString:@"0888"]){
            return @"丽江";
        }else if([gCityCode isEqualToString:@"0870"]){
            return @"昭通";
        }else if([gCityCode isEqualToString:@"0691"]){
            return @"西双版纳";
        }else if([gCityCode isEqualToString:@"0875"]){
            return @"保山";
        }else if([gCityCode isEqualToString:@"0872"]){
            return @"大理";
        }
    }
    return gCityCode;
}
+(NSString *)getCityCode
{
    return gCityCode;
}
+(void)setCityCode:(NSString *)cityCode 
{
    gCityCode = cityCode;
}
+(NSString *)getCustName//获取客户名称
{
    return gCustName;
}
+(void)setCustName:(NSString *)custName //设置客户名称
{
    gCustName = custName;
}
+(NSString *)getPsptID
{
    return gPsptID;
}
+(void)setPsptID:(NSString *)psptID
{
    gPsptID = psptID;
}
+(NSString *)getIsHuiDuVersion
{
    return gIsHuiDuVersion;
}
+(void)setIsHuiDuVersion:(NSString *)isHuiDuVersion
{
    gIsHuiDuVersion = isHuiDuVersion;
}
+(NSString *)getUserPassWord//获取客服密码
{
    return gUserPassWord;
}
+(void)setUserPassWord:(NSString *)userPassWord //设置客服密码
{
    gUserPassWord = userPassWord;
}
+(BOOL)getIsLogin //获取是否登录
{
    return gIsLogin;
}
+(void)setIsLogin:(BOOL)isLogin //设置是否登录
{
    gIsLogin = isLogin;
}
+(NSDate *)getLoginUpdateDate //获取最后更新时间
{
    return gLoginUpdateDate;
}
+(void)setLoginUpdateDate:(NSDate *)loginUpdateDate //设置最后更新时间
{
    gLoginUpdateDate = loginUpdateDate;
}
+(NSString *)getMerc//获取手机支付商户号
{
    return gMerc;
}
+(NSString *)getPayUrl//获取手机支付请求链接
{
    return gPayUrl;
}
+(NSDictionary *)getCurrentMonthCostDic //获取当月话费
{
    return gCurrentMonthCostDic;
}
+(void)setCurrentMonthCostDic:(NSDictionary *)currentMonthCostDic //设置当月话费
{
    gCurrentMonthCostDic = currentMonthCostDic;
}
+(NSDictionary *)getCurrentCostDic //获取实时话费
{
    return gCurrentCostDic;
}
+(void)setCurrentCostDic:(NSDictionary *)currentCostDic //设置实时话费
{
    gCurrentCostDic = currentCostDic;
}
+(NSArray *)getCurrentCostArray //获取实时话费
{
    return gCurrentCostArray;
}
+(void)setCurrentCostArray:(NSArray *)currentCostArray //设置实时话费
{
    gCurrentCostArray = currentCostArray;
}
+(NSArray *)getBannerArray //获取banner
{
    return gBannerArray;
}
+(void)setBannerArray:(NSArray *)bannerArray //设置banner
{
    gBannerArray = bannerArray;
}
+(void)setNoUserInfo{
    gUserPassWord = @"";//客服密码
    gIsLogin = NO;//是否登录
    gLoginUpdateDate = nil;//最新登陆状态更新时间
    gSerialNumber = @"";//登录成功后设定，目前为测试需要写死
    gVipTag = @"";
    gBrandCode = @"";
    gCustName = @"";
    gCurrentMonthCostDic=nil;
    gCurrentCostDic=nil;
    gCurrentCostArray=nil;
}

+(NSDictionary *)getBusinessRecommendDic
{
    return gBusinessRecommendDic;
}

+(void)setBusinessRecommendDic:(NSDictionary *)businessRecommendDic
{
    gBusinessRecommendDic = businessRecommendDic;
}

+(BOOL)getIsDynamicPW //获取是否动态密码登录
{
    return gIsDynamicPW;
}
+(void)setIsDynamicPW:(BOOL)isDynamicPW //设置是否动态密码登录
{
    gIsDynamicPW = isDynamicPW;
}

+(void)setUserId:(NSString *)userid{
    gUserId = userid;
}
+(NSString *)getUserId{
    return gUserId;
}

/**
 *  获取BusinessInfo
 *
 *  @return <#return value description#>
 */
+(NSArray *)getBusinessInfoArray{
    return gBusinessInfoArray;
}
/**
 *  设置BusinessInfo
 *
 *  @param bannerArray <#bannerArray description#>
 */
+(void)setBusinessInfoArray:(NSArray *)businessInfoArray{
    gBusinessInfoArray = businessInfoArray;
}
/**
 *  //获取DES加密过的手机用户号码（接口返回的）
 *
 *  @return DES加密过的手机用户号码
 */
+(NSString *)getDESSerialNumber{
    return gDESSerialNumber;
}
/**
 *  //设置DES加密过的用户手机号码
 *
 *  @param serialNumber DES加密过的手机用户号码
 */
+(void)setDESSerialNumber:(NSString *)serialNumber{
    gDESSerialNumber = serialNumber;
}
@end
