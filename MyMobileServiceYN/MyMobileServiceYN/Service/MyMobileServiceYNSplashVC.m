//
//  MyMobileServiceYNSplashVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-5.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNSplashVC.h"

#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNRootVC.h"
#import "LNSideViewController.h"
#import "MyMobileServiceYNHomeVC.h"
#import "MyMobileServiceYNLeftMenuVC.h"
#import "MyMobileServiceYNUserGuideVC.h"
#import "RESideMenu.h"
#import "MyMobileServiceYNRightSideMenuVC.h"
#import "MyMobileServiceYNTabbarServiceVC.h"
#import "MyMobileServiceYNAgglomerationVC.h"
#import "MarketVC.h"
#import "DateDeal.h"
#import "DialogInfo.h"
#import "OpenUDID.h"
#import "CookieUtil.h"
#import "GlobalDef.h"

#import "AISRDApiRequest.h"
@implementation UIImageView (ap)

- (void)setAnchorPoint:(CGPoint)anchorPoint
{
    CGPoint oldOrigin = self.frame.origin;
    self.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = self.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    self.center = CGPointMake (self.center.x - transition.x, self.center.y - transition.y);
}

@end



@interface MyMobileServiceYNSplashVC ()

@end

@implementation MyMobileServiceYNSplashVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self appOpenAnimation];
}

//开机动画
-(void)appOpenAnimation{
        //IOS7下面标题栏为白色，需要修正
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bgImage.image = [UIImage imageNamed:@"bg_1960"];
    [self.view addSubview:bgImage];
    
    UIImageView *bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 783, 577)];
    bigImage.image = [UIImage imageNamed:@"zzc_pink"];
    
    UIImageView *and = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
    and.image = [UIImage imageNamed:@"and_yuan"];
    
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        bigImage.frame = CGRectMake(-292.5, -395.5, 783, 577);
        and.center = CGPointMake(108, 142);
        [bigImage setAnchorPoint:CGPointMake(401.0 / 783, 536.5 / 577)];
    }else{
        bigImage.frame = CGRectMake(-292.5, -361.5, 783, 577);
        and.center = CGPointMake(108, 176);
        [bigImage setAnchorPoint:CGPointMake(401.0 / 783, 536.5 / 577)];
    }
    [self.view addSubview:bigImage];
    [self.view addSubview:and];
    
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.removedOnCompletion = YES;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.beginTime = CACurrentMediaTime() +0.5f;
    
    [bigImage.layer addAnimation:rotationAnimation forKey:@"Ratation"];
}

- (void)viewDidAppear:(BOOL)animated {
    [self sendRequest_checkVersion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)MyMobileServiceYNHome{
    //如果用户设置自动登录，并且取到工号+密码，直接进入首页，如果为设置自动登录，进入登录页面
    if ([MyMobileServiceYNParam getIsAutoLogin]) {
        [AISRDApiRequest loginCheckPWD:^(BOOL success, id object, BOOL isUpdatedFromServer) {
            if (success) {
                if([[object objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
                    //只有当X_RECORDNUM返回不为0的时候，才有三户信息，正常登录，否则异常，不登录直接进入
                    if (![[object objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]){
                        //设置工号信息，及菜单
                        [MyMobileServiceYNParam setIsLogin:YES];//登录成功后设置为已登录
                        [MyMobileServiceYNParam setBrandCode:[object objectForKey:@"BRAND_CODE"]];
                        [MyMobileServiceYNParam setCityCode:[object objectForKey:@"EPARCHY_CODE"]];
                        [MyMobileServiceYNParam setVipTag:[object objectForKey:@"VIP_TAG"]];
                        [MyMobileServiceYNParam setCustName:[object objectForKey:@"CUST_NAME"]];
                        [MyMobileServiceYNParam setPsptID:[object objectForKey:@"PSPT_ID"]];
                        [MyMobileServiceYNParam setIsHuiDuVersion:[object objectForKey:@"GREP_LIMIT"]];
                        [MyMobileServiceYNParam setUserId:[object objectForKey:@"USER_ID"]];
                    }
                }
                [self sendRequest_QueryBusinessInfo];
            }else{
                [self toNextVC];
            }
        }];
    }else{
        [self sendRequest_QueryBusinessInfo];
    }
}

-(void)sendRequest_checkVersion{
    [AISRDApiRequest checkVersion:^(BOOL success, id object, BOOL isUpdatedFromServer) {
        NSDictionary *dic = (NSDictionary *)object;
        if (success) {
            if ([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
                NSTimer *timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(MyMobileServiceYNHome) userInfo:nil repeats:NO];
                    //使用NSRunLoopCommonModes模式，把timer加入到当前Run Loop中。
                [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            }else if ([@"1" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]]) {
                    //不是最新版本，不强制更新
                downLoadUrl=[dic objectForKey:@"newest-path"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"X_RESULTINFO"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新",nil];
                alertView.tag = ALERTVIEW_TAG_RETURN+10;
                [alertView show];
            }else if ([@"-1" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]]) {//不是最新版本，强制更新
                downLoadUrl=[dic objectForKey:@"newest-path"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"X_RESULTINFO"] delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"更新",nil];
                alertView.tag = ALERTVIEW_TAG_RETURN + 11;
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:CheckVersionFailed delegate:self cancelButtonTitle:@"确认退出" otherButtonTitles:nil,nil];
                alertView.tag = ALERTVIEW_TAG_RETURN + 15;
                [alertView show];
            }
        }else{
            [self showRequestFailedAlert];
        }
    }];
}

-(void)sendRequest_QueryBusinessInfo{
    [AISRDApiRequest queryBusinessInfo:^(BOOL success, id object, BOOL isUpdatedFromServer) {
        if (success) {
            if([[object objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
                if ([[object objectForKey:@"X_RESULTNUM"] integerValue]!=0){
                    NSArray *tempArray=[object objectForKey:@"X_RESULTINFO"];
                    [MyMobileServiceYNParam setBusinessInfoArray:tempArray];
                }
            }
            
            [self sendRequest_QueryBanner];
        }else{
            [self showRequestFailedAlert];
        }
    }];
}

-(void)sendRequest_QueryBanner{
    [AISRDApiRequest queryBanner:^(BOOL success, id object, BOOL isUpdatedFromServer) {
        if (success) {
            if([[object objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
                if ([[object objectForKey:@"X_RESULTNUM"] integerValue]!=0){
                    NSArray *tempArray=[object objectForKey:@"X_RESULTINFO"];
                    [MyMobileServiceYNParam setBannerArray:tempArray];
                }
            }
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
            	DebugNSLog(@"第一次启动");
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
                [[NSUserDefaults standardUserDefaults] setObject:[[OpenUDID value] substringWithRange:NSMakeRange(0, 32)] forKey:@"openUDID"];
                DebugNSLog(@"openUDID%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"openUDID"]);
                //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
                
                MyMobileServiceYNUserGuideVC *userGuideVC = [[MyMobileServiceYNUserGuideVC alloc] init];
                [self presentViewController:userGuideVC animated:YES completion:nil];
            }else{
                DebugNSLog(@"不是第一次启动");
                NSString *jsessionid = [CookieUtil cookieValueWithKey:@"JSESSIONID"];
                DebugNSLog(@"第一个%@",jsessionid);
                //tabbar 设置tabbarItem的图标以及字体
                MyMobileServiceYNHomeVC *home = [[MyMobileServiceYNHomeVC alloc]init];
                home.sessionID = jsessionid;
                home.title = @"云南移动";
                [home.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_icon_homeon"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_home"]];
                
                MyMobileServiceYNTabbarServiceVC *serviceVC = [[MyMobileServiceYNTabbarServiceVC alloc]init];
                serviceVC.title = @"服务";
                [serviceVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_icon_servon"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_servon"]];
                
                MarketVC *phoneM = [[MarketVC alloc]init];
                phoneM.title = @"商城";
                
                ////------------聚团惠
                //            [serviceVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_icon_servon"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_servon"]];
                //            MyMobileServiceYNAgglomerationVC *aggtiongVC = [[MyMobileServiceYNAgglomerationVC alloc]init];
                //            aggtiongVC.title = @"聚团惠";
                ////-----------------
                
                [phoneM.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_icon_storeon"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_store"]];
                MyMobileServiceYNLeftMenuVC *leftMenu = [[MyMobileServiceYNLeftMenuVC alloc]init];
                
                UITabBarController *tab = [[UITabBarController alloc]init];
                [tab setViewControllers:[NSArray arrayWithObjects:home,serviceVC,phoneM, nil]];
                tab.title = @"云南移动";
                tab.tabBar.selectedImageTintColor = [UIColor redColor];
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                    tab.tabBar.barTintColor = [UIColor colorWithWhite:1 alpha:0.8];
                }
                
                UINavigationController *_contentNav = [[UINavigationController alloc]initWithRootViewController:tab];
                
                [_contentNav.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:appTypeFace size:18.0], UITextAttributeFont,nil]];
                
                NSDictionary *themeDic = [self getAppThemeColor];
                UIColor *themeColor = [themeDic objectForKey:@"theme_color"];
                NSString *themeImage = [themeDic objectForKey:@"theme_image"];
                //设置主题颜色
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
                    [_contentNav.navigationBar setBarTintColor:themeColor];
                }else{
                    [_contentNav.navigationBar setTintColor:themeColor];
                }
                
                
                RESideMenu *root = [[RESideMenu alloc]initWithContentViewController:_contentNav leftMenuViewController:leftMenu rightMenuViewController:nil];
                [root setBackgroundImage:[UIImage imageNamed:themeImage]];
                    //设置跳转到页面的modalTransitionStyle，来设置切换动画，总共有四种
                root.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:root animated:YES completion:Nil];
            }
        }else{
            [self toNextVC];
        }
    }];
}

-(void)showRequestFailedAlert{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:CheckVersionFailed delegate:self cancelButtonTitle:@"确认退出" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN + 15;
    [alertView show];
}

-(void)toNextVC{
    MyMobileServiceYNRootVC *root = [[MyMobileServiceYNRootVC alloc]init];
        //设置跳转到页面的modalTransitionStyle，来设置切换动画，总共有四种
    root.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:root animated:YES completion:Nil];
}

-(NSDictionary*)getAppThemeColor{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = paths[0];
    NSString *filename = [plistPath stringByAppendingPathComponent:@"currentTheme.plist"];
    NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSString *plistPath1 = [[NSBundle mainBundle] pathForResource:@"ThemeData" ofType:@"plist"];
    NSArray *themeData = [[NSArray alloc] initWithContentsOfFile:plistPath1];
    NSString *pic;
    for (int i = 0; i < themeData.count; i++) {
        if ([[currentTheme objectForKey:@"currentTheme"]isEqualToString:[[themeData objectAtIndex:i] objectForKey:@"color"]]) {
            pic = [[themeData objectAtIndex:i]objectForKey:@"picture"];
        }
    }
    
        //获取主题颜色
    UIColor *themeColor = UIColorFromRGB(rgbValue_Theme_red);//默认红色
    NSString *themeColorString = [currentTheme objectForKey:@"currentTheme"];
    if([@"red" isEqualToString:themeColorString]){
        themeColor = UIColorFromRGB(rgbValue_Theme_red);
    }else if([@"blue" isEqualToString:themeColorString]){
        themeColor = UIColorFromRGB(rgbValue_Theme_blue);
    }else if([@"green" isEqualToString:themeColorString]){
        themeColor = UIColorFromRGB(rgbValue_Theme_green);
    }else if([@"pueple" isEqualToString:themeColorString]){
        themeColor = UIColorFromRGB(rgbValue_Theme_pueple);
    }
    
    pic = pic?pic:@"";
    NSDictionary *themedic = [NSDictionary dictionaryWithObjectsAndKeys:pic,@"theme_image",themeColor,@"theme_color", nil];
    return themedic;
}

#pragma mark - AlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (ALERTVIEW_TAG_RETURN + 10 == alertView.tag) {
        if (0 == buttonIndex) {
            //取消后继续使用
            [self MyMobileServiceYNHome];
        }else if (1 == buttonIndex) {
            //更新，跳转到appstore
            //方法一：根据应用的id打开appstore，并跳转到应用下载页面
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoadUrl]];
        }
    }else if (ALERTVIEW_TAG_RETURN + 11 == alertView.tag) {
        if (0 == buttonIndex) {
            //取消后退出
            exit(0);
        }else if (1 == buttonIndex) {
            //更新，跳转到appstore
            //去itunes中更新
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoadUrl]];
        }
    }else if (ALERTVIEW_TAG_RETURN + 15 == alertView.tag){
    //检查版本失败，直接退出应用程序
        if (0 == buttonIndex) {
            //取消后退出
            exit(0);
        }
    }
}



@end
