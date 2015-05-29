//
//  MyMobileServiceYNBaseVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-2-25.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBaseVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNBaseVC ()

@end

@implementation MyMobileServiceYNBaseVC

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.tabBarController.edgesForExtendedLayout = UIRectEdgeNone;
        self.tabBarController.extendedLayoutIncludesOpaqueBars = NO;
        self.tabBarController.modalPresentationCapturesStatusBarAppearance = NO;
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    #endif
    
    HUD=[[MyMobileServiceYNMBProgressHUD alloc]init];
    returnMessageDeal=[[ReturnMessageDeal alloc]init];
    
    //左侧边菜单栏
    UIButton *sideMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage *imgRaw=[UIImage imageNamed: @"frame_discount"];
    sideMenuButton.frame = CGRectMake(0, 0, 35, 35);
    [sideMenuButton setBackgroundColor:[UIColor clearColor]];
    [sideMenuButton setImage:[UIImage imageNamed: @"frame_back"] forState:UIControlStateNormal];
    [sideMenuButton setImage:[UIImage imageNamed: @"frame_back"] forState:UIControlStateHighlighted];
    [sideMenuButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //后退按钮
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:sideMenuButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
}

//设置圆角
-(void)setButtonBorder:(UIButton *)button{
    [button.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [button.layer setBorderWidth:2.0];  //边框宽度
    [button.layer setCornerRadius:3.0f]; //边框弧度
    [button.layer setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)presentWebVC:(UIViewController *)webVC animated:(BOOL)animated{
    if (webVC!=nil){
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController: webVC];
        //设置nav bar 颜色
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath = [paths objectAtIndex:0];
        NSString *filename=[plistPath stringByAppendingPathComponent:@"currentTheme.plist"];
        NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
        
        UIColor *color = nil;
        
        if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"red"]) {
            color = UIColorFromRGB(rgbValue_Theme_red);
        }else if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"green"]){
            color = UIColorFromRGB(rgbValue_Theme_green);
        }else if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"pueple"]){
            color = UIColorFromRGB(rgbValue_Theme_pueple);
        }else{
            color = UIColorFromRGB(rgbValue_Theme_blue);
        }
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [[UINavigationBar appearance] setBarTintColor:color];
        }else{
            [[UINavigationBar appearance] setTintColor:color];
        }
        [nav.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:appTypeFace size:18.0], UITextAttributeFont,nil]];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
@end
