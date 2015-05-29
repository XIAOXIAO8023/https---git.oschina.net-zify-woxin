//
//  MyMobileServiceYNUserGuideVCViewController.m
//  MyMobileServiceYN
//
//  Created by 陆楠 on 15/1/4.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNUserGuideVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNHomeVC.h"
#import "MyMobileServiceYNLeftMenuVC.h"
#import "LNSideViewController.h"
#import "RESideMenu.h"
#import "MarketVC.h"
#import "MyMobileServiceYNTabbarServiceVC.h"

@interface MyMobileServiceYNUserGuideVC ()<UIScrollViewDelegate>
{
    UIPageControl *pageCtrl;
    UIScrollView *mainScrollView;
    NSArray *picArr;
}

@end

@implementation MyMobileServiceYNUserGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
//    [self.view setUserInteractionEnabled:YES];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UserGuidePic"ofType:@"plist"];
    picArr = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@",picArr);
    
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:mainScrollView];
    [mainScrollView setDelegate:self];
    [mainScrollView setPagingEnabled:YES];
    [mainScrollView setShowsHorizontalScrollIndicator:NO];
    [mainScrollView setBounces:NO];
    
    [self loadPictures];
    
    pageCtrl = [[UIPageControl alloc]init];
    [pageCtrl setCenter:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 20)];
    [self.view addSubview:pageCtrl];
    [pageCtrl setNumberOfPages:picArr.count];
    [pageCtrl setCurrentPage:0];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPage = scrollView.contentOffset.x / SCREEN_WIDTH ;
    [pageCtrl setCurrentPage:currentPage];
}


-(void)loadPictures
{
    for (int i = 0; i < picArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [mainScrollView addSubview:imageView];
        [imageView setImage:[UIImage imageNamed:[picArr objectAtIndex:i]]];
    }
    [mainScrollView setContentSize:CGSizeMake(SCREEN_WIDTH * picArr.count, SCREEN_HEIGHT)];
    NSLog(@"%f",mainScrollView.contentSize.height);
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * (picArr.count - 1) + 110, SCREEN_HEIGHT - 100, 100, 40)];
    [mainScrollView addSubview:btn];
    [btn setTitle:@"立即体验" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(rgbValueBaiYan) forState:UIControlStateNormal];
    [btn.layer setBorderWidth:1];
    [btn.layer setBorderColor:UIColorFromRGB(rgbValueBaiYan).CGColor];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)btnPressed:(id)sender
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    NSString *filename=[plistPath stringByAppendingPathComponent:@"currentTheme.plist"];
    NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSString *plistPath1 = [[NSBundle mainBundle] pathForResource:@"ThemeData" ofType:@"plist"];
    NSArray *themeData = [[NSArray alloc] initWithContentsOfFile:plistPath1];
    NSString *pic;
    for (int i = 0; i < themeData.count; i++) {
        if ([[currentTheme objectForKey:@"currentTheme"]isEqualToString:[[themeData objectAtIndex:i] objectForKey:@"color"]]) {
            pic = [[themeData objectAtIndex:i]objectForKey:@"picture"];
        }
    }
    MyMobileServiceYNHomeVC *home = [[MyMobileServiceYNHomeVC alloc]init];
    home.title = @"云南移动";
    [home.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_icon_homeon"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_home"]];
    MyMobileServiceYNTabbarServiceVC *serviceVC = [[MyMobileServiceYNTabbarServiceVC alloc]init];
    serviceVC.title = @"服务";
    
    [serviceVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_icon_servon"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_servon"]];
    MarketVC *phoneM = [[MarketVC alloc]init];
    phoneM.title = @"商城";
    
    [phoneM.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_icon_storeon"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_store"]];
    MyMobileServiceYNLeftMenuVC *leftMenu = [[MyMobileServiceYNLeftMenuVC alloc]init];
    
    UITabBarController *tab = [[UITabBarController alloc]init];
    [tab setViewControllers:[NSArray arrayWithObjects:home,serviceVC,phoneM, nil]];
    tab.title = @"云南移动";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        tab.tabBar.barTintColor = [UIColor colorWithWhite:1 alpha:0.8];
    }
    
    
    UINavigationController *_contentNav = [[UINavigationController alloc]initWithRootViewController:tab];
    [_contentNav.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:appTypeFace size:18.0], UITextAttributeFont,nil]];
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
    RESideMenu *root = [[RESideMenu alloc]initWithContentViewController:_contentNav leftMenuViewController:leftMenu rightMenuViewController:nil];
    [root setBackgroundImage:[UIImage imageNamed:pic]];
    //设置跳转到页面的modalTransitionStyle，来设置切换动画，总共有四种
    root.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self presentViewController:root animated:NO completion:Nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
