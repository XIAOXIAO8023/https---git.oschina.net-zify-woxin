//
//  MyMobileServiceYNLeftSideMenuVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-3.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNLeftSideMenuVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNParam.h"


#define fHeight 66

@interface MyMobileServiceYNLeftSideMenuVC ()

@end

@implementation MyMobileServiceYNLeftSideMenuVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title =@"左边菜单";
    busiCode=@"";
    httpRequest=[[MyMobileServiceYNHttpRequest alloc]init];
    
    //IOS7下面标题栏为白色，需要修正
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        [bgImgView setImage:[UIImage imageNamed:@"LeftSideMenu_bg7"]];
        [bgView addSubview:bgImgView];
        [bgView sendSubviewToBack:bgImgView];
        
        homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
        homeScrollView.delegate = self;
        homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-20);
        [bgView addSubview:homeScrollView];
        
        [self.view addSubview:bgView];
    }else{
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT - 20)];
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT - 20)];
        [bgImgView setImage:[UIImage imageNamed:@"LeftSideMenu_bg"]];
        [bgView addSubview:bgImgView];
        [bgView sendSubviewToBack:bgImgView];
        
        homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
        homeScrollView.delegate = self;
        homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-20);
        [bgView addSubview:homeScrollView];
        [self.view addSubview:bgView];
    }
    //
    NSArray *logoArray = [NSArray arrayWithObjects:@"boxmenu_home",@"boxmenu_vie",@"boxmenu_share",@"boxmenu_introduce",@"boxmenu_aboutus",nil];
    NSArray *menuArray = [NSArray arrayWithObjects:@"首页",@"检查更新",@"分享应用",@"新版介绍",@"关于",nil];
    
    //
    for (int i=0; i<menuArray.count; i++) {
        UIView *menuView = [[UIView alloc]initWithFrame:CGRectMake(0, i*fHeight, 200, fHeight)];
        menuView.backgroundColor = [UIColor clearColor];
        [homeScrollView addSubview:menuView];
        
        UIImageView *logoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[logoArray objectAtIndex:i]]];
        logoImage.frame = CGRectMake(18, 18, 30, 30);
        [menuView addSubview:logoImage];
        
        UILabel *menuNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(66, 0, 120, fHeight)];
        menuNameLabel.backgroundColor = [UIColor clearColor];
        menuNameLabel.textAlignment = NSTextAlignmentLeft;
        menuNameLabel.font = [UIFont fontWithName:appTypeFace size:20];
        menuNameLabel.text = [menuArray objectAtIndex:i];
        menuNameLabel.textColor = [UIColor whiteColor];
        [menuView addSubview:menuNameLabel];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, menuView.frame.size.width, menuView.frame.size.height)];
        button.tag = BUTTON_TAG +i;
        button.backgroundColor = [UIColor clearColor];
//        [button setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:button];
    }
    
}

-(void)buttonPressed:(id)sender
{
    UIButton *button = (UIButton *) sender;
    if (BUTTON_TAG == button.tag) {//
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"home" forKey:@"Operate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
    }
//    else if (BUTTON_TAG+1 == button.tag)
//    {
//        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
//        [dic setObject:@"support" forKey:@"Operate"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
//    }
    else if (BUTTON_TAG+1 == button.tag)
    {
        [HUD showTextHUDWithVC:self.view];
        
        busiCode = @"checkVersion";
        NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
        [requestParamData setObject:[MyMobileServiceYNParam getVersion] forKey:@"version"];
        [requestParamData setObject:[MyMobileServiceYNParam getPattern] forKey:@"pattern"];
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:[MyMobileServiceYNParam getCityCode] forKey:@"EPARCHY_CODE"];
        [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
    }
    else if (BUTTON_TAG+2 == button.tag)
    {
        //分享应用
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"share" forKey:@"Operate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
    }
    else if (BUTTON_TAG+3 == button.tag)
    {
        //新版介绍
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"introduce" forKey:@"Operate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
    }
    else if (BUTTON_TAG+4 == button.tag)
    {
        //关于
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"about" forKey:@"Operate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
    }
    else if (BUTTON_TAG+5 == button.tag)
    {
        
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    DebugNSLog(@"------------requestFinished------------------");
    NSData *jsonData = [request responseData];
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    DebugNSLog(@"%@",dic);
    if ([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"X_RESULTINFO"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG_RETURN + 12;
        [alertView show];
    }
    else if ([@"1" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]]) {//不是最新版本，不强制更新
        downLoadUrl=[dic objectForKey:@"newest-path"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"X_RESULTINFO"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新",nil];
        alertView.tag = ALERTVIEW_TAG_RETURN + 10;
        [alertView show];
    }
    else if ([@"-1" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]]) {//不是最新版本，强制更新
        downLoadUrl=[dic objectForKey:@"newest-path"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"X_RESULTINFO"] delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"更新",nil];
        alertView.tag = ALERTVIEW_TAG_RETURN + 11;
        [alertView show];
    }
    [HUD removeHUD];
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    DebugNSLog(@"------------requestFailed------------------");
    NSError *error = [request error];
    DebugNSLog(@"%@",error);
    [HUD removeHUD];
}

//根据被点击按钮的索引处理点击事件
//alertView起始为51
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    DebugNSLog(@"test buttonIndex:%i",buttonIndex);
    //alertView.tag== ALERTVIEW_TAG + 1 不强制更新
    if (ALERTVIEW_TAG_RETURN + 10 == alertView.tag) {
        
        if (0 == buttonIndex) {
  
        }
        else if (1 == buttonIndex) {
            //更新，跳转到appstore
            //方法一：根据应用的id打开appstore，并跳转到应用下载页面
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoadUrl]];
        }
        
    }else if (ALERTVIEW_TAG_RETURN + 11 == alertView.tag) {
        
        if (0 == buttonIndex) {
            //取消后退出
            exit(0);
        }
        else if (1 == buttonIndex) {
            //更新，跳转到appstore
            //去itunes中更新
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoadUrl]];
        }
    }else if (ALERTVIEW_TAG_RETURN + 12 == alertView.tag) {
        
        DebugNSLog(@"----------");
            //更新，跳转到appstore
            //去itunes中更新
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoadUrl]];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
