//
//  LNSideViewController.m
//  LNSideViewController
//
//  Created by 陆楠 on 14/12/1.
//  Copyright (c) 2014年 lunan. All rights reserved.
//

#import "LNSideViewController.h"
#import "MyMobileServiceYNHttpRequest.h"


@interface LNSideViewController ()
{//http相关
    MyMobileServiceYNHttpRequest *httpRequest;
    NSString *busiCode;
    NSString *downLoadUrl;
}
@end

@implementation LNSideViewController

-(instancetype)initWithLeftSideView:(UIViewController *)leftSideView contentView:(UIViewController *)contentView scale:(CGFloat)scale backgroundImage:(UIImage *)backgroundImage
{
    self = [super init];
    _leftSideView = leftSideView;//
    _contentView = contentView;
    _scale = scale;
    _rightGap = 100.0f;
    if (backgroundImage) {
        _backgroundImage = backgroundImage;
    }else{
        UIView *tp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        tp.backgroundColor = [UIColor whiteColor];
        _backgroundImage = (UIImage *)tp;
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    _scale = 0.8f;
    _rightGap = 100.0f;
    UIView *tp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    tp.backgroundColor = [UIColor whiteColor];
    _backgroundImage = (UIImage *)tp;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    httpRequest=[[MyMobileServiceYNHttpRequest alloc]init];
    //最底层view
    rootView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    rootView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    rootView.tag = VIEW_TAG + 1;
    //<--背景图片放缩
    UIImage *image = _backgroundImage;
    CGFloat capWidth = image.size.width / 2;
    CGFloat capHeight = image.size.height / 2;
    UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:stretchableImage];
    imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    imageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    imageView.tag = IMAGE_TAG + 1;
    [rootView addSubview:imageView];
    [self.view addSubview:rootView];
    //------------>
    //主scrollview，在上面添加侧滑view和主页view
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)];
    mainScrollView.contentSize = CGSizeMake(2*[UIScreen mainScreen].bounds.size.width - _rightGap, [UIScreen mainScreen].bounds.size.height);
    [mainScrollView setBounces:NO];
    [mainScrollView setScrollEnabled:NO];
    [mainScrollView setDirectionalLockEnabled:YES];
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.delegate = self;
    mainScrollView.tag = VIEW_TAG + 211;
    [self.view addSubview:mainScrollView];
    
    
    
    if (!_contentView) {
        _contentView.view = [[UIView alloc]init];
        [_contentView.view setBackgroundColor:[UIColor grayColor]];
    }
    _contentView.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - _rightGap, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //if you need a navigationViewController
    _contentNav = [[UINavigationController alloc]initWithRootViewController:_contentView];
    _contentNav.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - _rightGap, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_contentNav.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:appTypeFace size:18.0], UITextAttributeFont,nil]];
    [self initTheme];
    
    
    [mainScrollView addSubview:_contentNav.view];
    [mainScrollView addSubview:_contentView.view];
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _contentNav.view.frame.size.width, _contentNav.view.frame.size.height)];
    clearView.backgroundColor = [UIColor clearColor];
    clearView.tag = 100;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [clearView addGestureRecognizer:tapGestureRecognizer];
    _contentNav.navigationBar.tintColor = [UIColor grayColor];
    [_contentNav.view addSubview:clearView];
    [clearView setHidden:YES];
    
    if (!_leftSideView) {
        _leftSideView.view = [[UIView alloc]init];
    }
    _leftSideView.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - _rightGap, [UIScreen mainScreen].bounds.size.height);
    [_leftSideView.view setBackgroundColor:[UIColor clearColor]];
    [_leftSideView.view setClipsToBounds:YES];
    _leftSideView.view.transform = CGAffineTransformMakeScale(_scale ,_scale);
    [mainScrollView addSubview:_leftSideView.view];
    
    [mainScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width - _rightGap, 0) animated:YES];
    [mainScrollView setDecelerationRate:0.1f];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftMenuButtonPressed:) name:@"Notification_LeftMenuButtonPressed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftButtonPressed:) name:@"Notification_LeftButtonPressed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeThemeColor:) name:@"changeThemeColor" object:nil];
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{//屏蔽右侧主view，防止意外点击 
    if (mainScrollView.contentOffset.x < ([UIScreen mainScreen].bounds.size.width - _rightGap) / 2)
    {
        [mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [[_contentNav.view viewWithTag:100] setHidden:NO];
        [_contentNav.view bringSubviewToFront:[_contentNav.view viewWithTag:100]];
    }else{
        [mainScrollView setContentOffset:CGPointMake(([UIScreen mainScreen].bounds.size.width - _rightGap), 0) animated:YES];
        [[_contentNav.view viewWithTag:100] setHidden:YES];
        [_contentNav.view sendSubviewToBack:[_contentNav.view viewWithTag:100]];
    }
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f",mainScrollView.contentOffset.x);
    if (scrollView.tag == VIEW_TAG + 211) {
        CGFloat scale = (([UIScreen mainScreen].bounds.size.width - _rightGap) - mainScrollView.contentOffset.x) / ([UIScreen mainScreen].bounds.size.width - _rightGap) * (1.0 - _scale);
        _leftSideView.view.frame = CGRectMake(mainScrollView.contentOffset.x - 180 * (1.0 - _scale - scale), [UIScreen mainScreen].bounds.size.height * _scale / 2 * (1.0 - _scale - scale), ([UIScreen mainScreen].bounds.size.width - _rightGap) * scale * 5 + 180 * (1.0 - _scale - scale) + [UIScreen mainScreen].bounds.size.width * scale / 2, _leftSideView.view.frame.size.height);
        _leftSideView.view.alpha = 0.8 + scale;
        _contentNav.view.transform = CGAffineTransformMakeScale(1.0 - scale,1.0 - scale);
        _leftSideView.view.transform = CGAffineTransformMakeScale(_scale + scale,_scale + scale);
    }
}



//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    [scrollView setContentOffset:scrollView.contentOffset animated:NO];
////    [NSThread sleepForTimeInterval:0.1];
//    if (mainScrollView.contentOffset.x < ([UIScreen mainScreen].bounds.size.width - _rightGap) / 2)
//    {
//        [mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//        [_contentNav.view bringSubviewToFront:[_contentNav.view viewWithTag:100]];
//    }else{
//        [mainScrollView setContentOffset:CGPointMake(([UIScreen mainScreen].bounds.size.width - _rightGap), 0) animated:YES];
//        [[_contentNav.view viewWithTag:100] setHidden:YES];
//        [_contentNav.view sendSubviewToBack:[_contentNav.view viewWithTag:100]];
//    }
//}


-(void)handleTap:(UITapGestureRecognizer*)paramSender
{
    NSLog(@"i'm taped");
    if (mainScrollView.contentOffset.x <= 3) {
        [mainScrollView setContentOffset:CGPointMake(([UIScreen mainScreen].bounds.size.width - _rightGap), 0) animated:YES];
        [[_contentNav.view viewWithTag:100] setHidden:YES];
        [_contentNav.view sendSubviewToBack:[_contentNav.view viewWithTag:100]];
    }
}


-(void)leftMenuButtonPressed:(NSNotification*) notification
{
    [_leftSideView.view setUserInteractionEnabled:NO];
    NSMutableDictionary *dic=(NSMutableDictionary *)[notification object];
    if([[dic objectForKey:@"Operate"] isEqualToString:@"customService"]){
        if ([MyMobileServiceYNParam getIsLogin]) {
            MyMobileServiceYNCustomerServiceVC *supportVC=[[MyMobileServiceYNCustomerServiceVC alloc]init];
            [_contentNav popToRootViewControllerAnimated:NO];
            [_contentNav pushViewController:supportVC animated:NO];
        }else{
            MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
            [self presentModalViewController:login animated:YES];
        }
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"aboutUs"]){
        MyMobileServiceYNAboutUSVC *aboutUsVC=[[MyMobileServiceYNAboutUSVC alloc]init];
        [_contentNav popToRootViewControllerAnimated:NO];
        [_contentNav pushViewController:aboutUsVC animated:NO];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"themeSet"]){
        MyMobileServiceYNChangeThemeVC *changeThemeVC=[[MyMobileServiceYNChangeThemeVC alloc]init];
        [_contentNav popToRootViewControllerAnimated:NO];
        [_contentNav pushViewController:changeThemeVC animated:NO];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"recommendApp"]){
        MyMobileServiceYNAppRecommendVC *appRecommend = [[MyMobileServiceYNAppRecommendVC alloc]init];
        [_contentNav pushViewController:appRecommend animated:NO];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"login"]){
        MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
        [self presentModalViewController:login animated:YES];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"charge"]){
        MyMobileServiceYNRechargeVC *chargeVC=[[MyMobileServiceYNRechargeVC alloc]init];
        [_contentNav popToRootViewControllerAnimated:NO];
        [_contentNav pushViewController:chargeVC animated:NO];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"checkVersion"]){
        [HUD showTextHUDWithVC:self.view];
        busiCode = @"checkVersion";
        NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
        [requestParamData setObject:[MyMobileServiceYNParam getVersion] forKey:@"version"];
        [requestParamData setObject:[MyMobileServiceYNParam getPattern] forKey:@"pattern"];
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:[MyMobileServiceYNParam getCityCode] forKey:@"EPARCHY_CODE"];
        [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"deLog"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logOut" object:nil];
    }
    
    
    
//    [NSThread sleepForTimeInterval:0.1];
    [mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH - _rightGap, 0) animated:YES];
    [_contentNav.view sendSubviewToBack:[_contentNav.view viewWithTag:100]];
    
//    [NSThread sleepForTimeInterval:0.2];
    [_leftSideView.view setUserInteractionEnabled:YES];
}


-(void)leftButtonPressed:(NSNotification*) notification
{
    [mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [[_contentNav.view viewWithTag:100] setHidden:NO];
    [_contentNav.view bringSubviewToFront:[_contentNav.view viewWithTag:100]];
}

-(void)changeThemeColor:(NSNotification *)notification
{
    NSLog(@"执行到了的");
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"currentTheme.plist"];
    NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    if ([notification.object isEqualToString:@"red"]) {
        [(UIImageView *)[[self.view viewWithTag:VIEW_TAG + 1]viewWithTag:IMAGE_TAG + 1] setImage:[UIImage imageNamed:@"box_menubg_red"]];
        [currentTheme setObject:@"red" forKey:@"currentTheme"];
    }else if ([notification.object isEqualToString:@"blue"]){
        [(UIImageView *)[[self.view viewWithTag:VIEW_TAG + 1]viewWithTag:IMAGE_TAG + 1] setImage:[UIImage imageNamed:@"box_menubg_blue"]];
        [currentTheme setObject:@"blue" forKey:@"currentTheme"];
    }else if ([notification.object isEqualToString:@"green"]){
        [(UIImageView *)[[self.view viewWithTag:VIEW_TAG + 1]viewWithTag:IMAGE_TAG + 1] setImage:[UIImage imageNamed:@"box_menubg_green"]];
        [currentTheme setObject:@"green" forKey:@"currentTheme"];
    }else if ([notification.object isEqualToString:@"pueple"]){
        [(UIImageView *)[[self.view viewWithTag:VIEW_TAG + 1]viewWithTag:IMAGE_TAG + 1] setImage:[UIImage imageNamed:@"box_menubg_pink"]];
        [currentTheme setObject:@"pueple" forKey:@"currentTheme"];
    }
    
    //输入写入
    [currentTheme writeToFile:filename atomically:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeView_changeThemeColor" object:nil];
}


-(void)initTheme
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"currentTheme.plist"];
    NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"red"]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [_contentNav.navigationBar setBarTintColor:UIColorFromRGB(rgbValue_Theme_red)];
        }else{
            [_contentNav.navigationBar setTintColor:UIColorFromRGB(rgbValue_Theme_red)];
        }
    }else if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"blue"]){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [_contentNav.navigationBar setBarTintColor:UIColorFromRGB(rgbValue_Theme_blue)];
        }else{
            [_contentNav.navigationBar setTintColor:UIColorFromRGB(rgbValue_Theme_blue)];
        }
    }else if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"green"]){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [_contentNav.navigationBar setBarTintColor:UIColorFromRGB(rgbValue_Theme_green)];
        }else{
            [_contentNav.navigationBar setTintColor:UIColorFromRGB(rgbValue_Theme_green)];
        }
    }else if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"pueple"]){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [_contentNav.navigationBar setBarTintColor:UIColorFromRGB(rgbValue_Theme_pueple)];
        }else{
            [_contentNav.navigationBar setTintColor:UIColorFromRGB(rgbValue_Theme_pueple)];
        }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
