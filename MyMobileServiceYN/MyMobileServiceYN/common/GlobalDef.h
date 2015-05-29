//
//  GlobalDef.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-2-25.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#ifndef MyMobileServiceYN_GlobalDef_h
#define MyMobileServiceYN_GlobalDef_h

#define NavigationBar_HEIGHT 44
#define TabBar_HEIGHT 49
#define StatusBar_HEIGHT 20
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define M_PI   3.14159265358979323846264338327950288

//设置TAG起始值
#define VIEW_TAG 10000
#define TEXTFIELD_TAG 10500
#define LABEL_TAG 10600
#define BUTTON_TAG 10700
#define SWITCH_TAG 11000
#define TABLE_TAG 11500
#define TABLECELL_TAG 12000
#define IMAGE_TAG 13000
#define ALERTVIEW_TAG 14000
#define ALERTVIEW_TAG_RETURN 14200
#define SCROLLVIEW_TAG 15000

//定义颜色，rgbValue为颜色编码
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//菜单
#define rgbValue_menuChangesList_title 0x6495ED
//基础控制类
#define rgbValue_baseBg 0xfafff4
//navbar
//#define rgbValue_navBarBg 0x00cee9
#define rgbValue_navBarBg 0x0088C9
//登录
#define rgbValue_loginName 0xd3d3d3
#define rgbValue_autoLogin 0x666666
#define rgbValue_clearButtonBg 0xbebebe
#define rgbValue_loginButtonBg 0x018cc4
#define rgbValue_loginBox 0xebebeb

//首页
#define rgbValue_userInfoBg 0xe3efd3
#define rgbColor_userInfoScrollViewBg 0xF7F7F7

//套餐详细信息页面类
#define rgbValue_packageDetailInfoSurplusBg1 0x7fe7cd
#define rgbValue_packageDetailInfoSurplusBg 0x9acce1
#define rgbValue_packageDetailInfoPromptText 0x469481
#define rgbValue_packageDetailInfoTotal 0x767676
#define rgbValue_packageDetailInfoTotalText 0x76bd11
//-----码表
#define rgbValue_OdometerFrame 0xdad8d8
#define rgbValue_OdometerFrameBg 0xf8f8f8
#define rgbValue_OdometerContent 0x7fe7ce
#define rgbValue_OdometerNeedle 0xf68e0b

//GPRS流量查询
#define rgbValue_gprsQueryButtonBg 0x81da28

//MyMobileServiceYNOverInfo  余量展示页面类
//#define rgbValue_overInfoText 0xffffff
#define rgbValue_overInfoBule 0x24ddd3
#define rgbValue_overInfoGreen 0xb8e359
#define rgbValue_overInfoYellow 0xffba34
#define rgbValue_overInfoOrange 0xffae00

//套餐汇总
#define rgbValue_packageInfo_headerViewBG 0xf0f0f0
#define rgbValue_packageInfo_line 0xc8c7cc
#define rgbValue_packageInfo_headerLabel 0x202020
#define rgbValue_packageInfo_headerNav 0xff7903
#define rgbValue_packageInfo_headerNav 0xff7903

//套餐余量查询
#define rgbValue_buttonNameBlack 0x767676
#define rgbValue_buttonNameGray 0xbcbbb
#define rgbValue_valueBg 0xabe115

//充值
#define rgbValue_blockBg 0x80da28
#define rgbValue_blockNameBg 0x767676
#define rgbValue_blockValueBg 0x656665
#define rgbValue_cellBg 0xfcfcfc
#define rgbValue_segmentPayBg 0xedeef0
#define rgbValue_buttonBg 0x80da28

//我的账单
#define rgbValue_BillInfoBarBg 0x9bd3ea

//流量订购
#define rgbValue_circleBg 0x9acde2
#define rgbValue_backColor 0xefeff4
#define rgbValue_scrollLine 0xb2b2b2
#define rgbValue_titleName 0x202020
#define rgbValue_backColorBottom 0xf4f4f4
#define rgbValue_titlePrompt 0xc2c2c2
#define rgbValue_scrollLine2 0xc6c6c6

//实时话费
#define rgbValue_greenDiamond 0x80da28
#define rgbValue_orangeNumber 0xff9b00
#define rgbValue_grayBackground 0xedeef0
#define rgbValue_grayLine 0xe2e2e2

//宽带
#define rgbValue_broadBand_textfieldBackGround 0xfafafa
#define rgbValue_broadBand_textfieldText 0x9b9b9b
#define rgbValue_broadBand_noButtonBg 0xc7c7c7

//公用颜色
#define rgbValueDeepGrey 0x464646 //深灰色字（黑色）
#define rgbValueLightGrey 0xa6a6a6 //浅灰色字辅助
#define rgbValuePromptGrey 0xc2c2c2 //提示用语灰色字
#define rgbValueBgGrey 0xeceeef //背景灰色
#define rgbValueTitleBlue 0x00cee9 //title蓝
#define rgbValueBlue 0x9acce1 //辅助蓝
#define rgbValueButtonGreen 0x80da28 //绿色按钮
#define rgbValueGreyBg 0xedeef0 //灰色背景
#define rgbValueLineGrey 0xe2e2e2 //白底灰色线
#define rgbValueBaiYan 0xf5f5f5 //白烟色

//字体
#define appTypeFace @"Arial"  //正常字体
#define appTypeFaceBold @"Arial-BoldMT" //粗体

//新浪微博
#define kSinaAppKey         @"260907024"
#define kSinaRedirectURI    @"http://www.sina.com"

//微信
#define kWeChatAppId        @"wx9abda317f232099f"

//4种主题颜色
#define rgbValue_Theme_blue 0x0087d0
#define rgbValue_Theme_red 0xe43a3d
#define rgbValue_Theme_green 0x8fc320
#define rgbValue_Theme_pueple 0x8b0686

#endif
/**
 主题颜色
 */
typedef enum : NSUInteger {
    GlobalThemeColorRed,//红色
    GlobalThemeColorBlue,//蓝色
    GlobalThemeColorGreen,//绿色
    GlobalThemeColorPueple//紫色
} GlobalThemeColor;
