//
//  MyMobileServiceYNAppDelegate.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-2-25.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNAppDelegate.h"
#import "MyMobileServiceYNHomeVC.h"
#import "MyMobileServiceYNLeftSideMenuVC.h"
#import "MyMobileServiceYNRootVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNSplashVC.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"

@implementation MyMobileServiceYNAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    //新浪微博注册
//    [WeiboSDK enableDebugMode:YES];
//    [WeiboSDK registerApp:kSinaAppKey];
    
//    //微信注册
//    //    [WXApi registerApp:kWeChatAppKey];
//    [WXApi registerApp:kWeChatAppId withDescription:@"demo 2.0"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSLog(@"%f",[[UIScreen mainScreen] bounds].size.height);
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    //判断MyMobileServiceYNConfig.plist是否存在沙盒，如果存在判断是否存在工号和密码字段，并且判断值是否不为空。
    //不存在则复制到沙盒中。
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *configFielPath=[plistPath1 stringByAppendingPathComponent:@"MyMobileServiceYNConfig.plist"];
    DebugNSLog(@"%@",configFielPath);
    
    //判断文件是否存在沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:configFielPath]== NO ) {
        DebugNSLog(@"MyMobileServiceYNConfig.plist is not exists");
        //将plist文件 复制到沙盒中
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MyMobileServiceYNConfig"ofType:@"plist"];
        NSMutableDictionary *configDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        [configDic writeToFile:configFielPath atomically:YES];
    }else{
        DebugNSLog(@"MyMobileServiceYNConfig.plist is exists");
        //获取工号及密码，判断是否为空，不为空在赋值给
        NSMutableDictionary *dic = [[[NSMutableDictionary alloc] initWithContentsOfFile:configFielPath] objectForKey:@"UserInfo"];
        
        if ([dic objectForKey:@"UserPhoneNumber"]) {
            [MyMobileServiceYNParam setSerialNumber:[dic objectForKey:@"UserPhoneNumber"]];
        }
        if ([dic objectForKey:@"UserPassWord"]){
            [MyMobileServiceYNParam setUserPassWord:[dic objectForKey:@"UserPassWord"]];
        }
        if ([dic objectForKey:@"AutoLogin"]){
            [MyMobileServiceYNParam setIsAutoLogin:[[dic objectForKey:@"AutoLogin"] boolValue]];
        }
    }

//    MyMobileServiceYNRootVC *root = [[MyMobileServiceYNRootVC alloc]init];
    NSString *themePath=[plistPath1 stringByAppendingPathComponent:@"currentTheme.plist"];
    NSFileManager *fileManager1 = [NSFileManager defaultManager];
    if( [fileManager1 fileExistsAtPath:themePath]== NO ) {
        NSMutableDictionary *themeDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"blue",@"currentTheme", nil];
        NSLog(@"%@----",themeDic);
        [themeDic writeToFile:themePath atomically:YES];
    }
    
    //注册推送
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    [self initShareSDK];
    
    MyMobileServiceYNSplashVC *splash = [[MyMobileServiceYNSplashVC alloc]init];
    self.window.rootViewController = splash;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    //判断是否由远程消息通知触发应用程序启动
//    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil) {
//        //获取应用程序消息通知标记数（即小红圈中的数字）
//        int badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
//        if (badge>0) {
//            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
//            badge--;
//            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
//            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
//        }
//    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"go to background...");
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyMobileServiceYN" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyMobileServiceYN.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



//- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
//{
//    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
//    {
//        //获取分享返回信息
//        int result = response.statusCode;
////        WeiboSDKResponseStatusCodeSuccess               = 0,//成功
////        WeiboSDKResponseStatusCodeUserCancel            = -1,//用户取消发送
////        WeiboSDKResponseStatusCodeSentFail              = -2,//发送失败
////        WeiboSDKResponseStatusCodeAuthDeny              = -3,//授权失败
////        WeiboSDKResponseStatusCodeUserCancelInstall     = -4,//用户取消安装微博客户端
////        WeiboSDKResponseStatusCodeUnsupport             = -99,//不支持的请求
////        WeiboSDKResponseStatusCodeUnknown               = -100,
//        NSString *title = @"";
//        if (result == 0) {
//            title = @"分享应用到微博成功";
//        }
//        else if(result == -1){
//            title = @"用户取消发送";
//        }
//        else if(result == -2){
//            title = @"发送失败";
//        }
//        else if(result == -3){
//            title = @"授权失败";
//        }
//        else if(result == -4){
//            title = @"用户取消安装微博客户端";
//        }
//        else if(result == -99){
//            title = @"不支持的请求";
//        }
//        else if(result == -100){
//            title = @"未知的错误";
//        }
//        
////        @"响应状态: (int)response.statusCode
////        响应UserInfo数据: response.userInfo
////        原请求UserInfo数据: response.requestUserInfo
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:nil
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
//}


//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    NSLog(@"url:%@",url);
//    NSLog(@"url.absoluteString:%@",url.absoluteString);
////    if ([url.absoluteString hasPrefix:@"sina"])
//    //没有看到sina，暂时用wb代替
//    if ([url.absoluteString hasPrefix:@"wb"])
//    {
//        return [WeiboSDK handleOpenURL:url delegate:self];
//    }
//    else
//    {
//        return [WXApi handleOpenURL:url delegate:self];
//    }
//}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
//    NSLog(@"My token is:%@", token);
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSString *error_str = [NSString stringWithFormat: @"%@", error];
//    NSLog(@"Failed to get token, error:%@", error_str);
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[[userInfo objectForKey:@"aps"] objectForKey:@"badge"]intValue]];
    NSLog(@"%@",userInfo);
}


-(void)initShareSDK
{
    [ShareSDK registerApp:@"5fe9f698e9d7"];//字符串api20为您的ShareSDK的AppKey
    [ShareSDK connectSMS];
    
    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1103447734"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"1103447734"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
//    //添加微信应用 注册网址 http://open.weixin.qq.com
//    [ShareSDK connectWeChatWithAppId:@"wx6925ebcee526d05f"   //微信APPID
//                           appSecret:@"5e7d7085cf91a6a16465875890f2fac6"  //微信APPSecret
//                           wechatCls:[WXApi class]];
    
    [ShareSDK connectWeChatSessionWithAppId:@"wx6925ebcee526d05f"
                                  appSecret:@"5e7d7085cf91a6a16465875890f2fac6"
                                  wechatCls:[WXApi class]];
    
    [ShareSDK connectWeChatTimelineWithAppId:@"wx6925ebcee526d05f"
                                   appSecret:@"5e7d7085cf91a6a16465875890f2fac6"
                                   wechatCls:[WXApi class]];
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


@end
