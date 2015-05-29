//
//  MyMobileServiceYNLeftMenuVC.m
//  MyMobileServiceYN
//
//  Created by 陆楠 on 14/12/3.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNLeftMenuVC.h"
#import "MyMobileServiceYNAboutUSVC.h"
#import "RESideMenu.h"
#import "CommonUtils.h"

#define fHeight 46

@interface MyMobileServiceYNLeftMenuVC ()<UIAlertViewDelegate>

@end

@implementation MyMobileServiceYNLeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    didLogView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 210, 200)];
    [didLogView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:didLogView];
    int temp = 60;
    _telLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, temp, 200, 30)];
    _telLabel.backgroundColor = [UIColor clearColor];
    _telLabel.textColor = [UIColor whiteColor];
    if (![MyMobileServiceYNParam getIsLogin]) {
        _telLabel.text = @"-";
    }else{
        _telLabel.text = [MyMobileServiceYNParam getSerialNumber];
    }
    _telLabel.font = [UIFont fontWithName:appTypeFace size:15];
    [didLogView addSubview:_telLabel];
    temp += 30;
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, temp, 200, 30)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont fontWithName:appTypeFace size:13];
    
    NSString *greeting = nil;
    NSDateFormatter *timec = [[NSDateFormatter alloc]init];
    [timec setDateFormat:@"HH"];
    NSString *hour = [timec stringFromDate:[NSDate date]];
    if (hour.intValue <= 12) {
        greeting = @"上午好";
    }else if (hour.intValue <= 18){
        greeting = @"下午好";
    }else{
        greeting = @"晚上好";
    }
    
    if (![MyMobileServiceYNParam getIsLogin]) {
        _nameLabel.text = @"亲爱哒，快登录下嘛~";
    }else{
        _nameLabel.text = [NSString stringWithFormat:@"亲爱的%@，%@~",[MyMobileServiceYNParam getCustName],greeting];
    }
    [didLogView addSubview:_nameLabel];
    temp += 30;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, temp, 90, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"我的余额(元)：";
    label.font = [UIFont fontWithName:appTypeFace size:13];
    [didLogView addSubview:label];
    _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, temp, 50, 30)];
    _moneyLabel.backgroundColor = [UIColor clearColor];
    _moneyLabel.font = [UIFont fontWithName:appTypeFace size:13];
    _moneyLabel.text = @"0.00";
    [didLogView addSubview:_moneyLabel];
    UIButton *chargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chargeBtn.frame = CGRectMake(160, temp + 5, 50, 20);
    [chargeBtn.layer setCornerRadius:chargeBtn.frame.size.height/2];
    chargeBtn.backgroundColor = UIColorFromRGB(rgbValue_Theme_green);
    [chargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    chargeBtn.tag = BUTTON_TAG + 100;
    [chargeBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    chargeBtn.titleLabel.font = [UIFont fontWithName:appTypeFace size:13];
    [didLogView addSubview:chargeBtn];

    temp += 30;
    
    _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, temp, 200, 30)];
    _scoreLabel.backgroundColor = [UIColor clearColor];
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.font = [UIFont fontWithName:appTypeFace size:13];
    _scoreLabel.text = @"当前积分：0";
    [didLogView addSubview:_scoreLabel];
    temp += 30;
    
    _colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, temp, SCREEN_WIDTH, 1)];
//    _colorLabel.backgroundColor = UIColorFromRGB(rgbValue_Theme_blue);
    [self initColorLabel];
    [self.view addSubview:_colorLabel];
    temp += 1;
    
    
    
    notLogView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 200)];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 180, 30)];
    label1.textColor = [UIColor whiteColor];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"亲爱哒，快登录下嘛~";
    [notLogView addSubview:label1];
    UIButton *logBtn = [[UIButton alloc]initWithFrame:CGRectMake(180, 75, 50, 20)];
    [logBtn.layer setCornerRadius:chargeBtn.frame.size.height/2];
    logBtn.backgroundColor = UIColorFromRGB(rgbValue_Theme_green);
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logBtn setTitle:@"登录" forState:UIControlStateNormal];
    logBtn.tag = BUTTON_TAG + 101;
    [logBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    logBtn.titleLabel.font = [UIFont fontWithName:appTypeFace size:13];
    [notLogView addSubview:logBtn];
    [self.view addSubview:notLogView];

    
//    NSArray *logoArray = [NSArray arrayWithObjects:@"boxmenu_vie",@"icon_10086",@"icon_about",@"icon_zt",@"icon_exit",nil];
//    NSArray *menuArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"当前版本V%@",[MyMobileServiceYNParam getVersion]],@"在线客服",@"关于我们",@"主题设置",@"退出登录",nil];
    NSArray *logoArray = [NSArray arrayWithObjects:@"icon_10086",@"icon_about",@"icon_zt",@"icon_exit",nil];
    NSArray *menuArray = [NSArray arrayWithObjects:@"在线客服",@"关于我们",@"主题设置",@"退出登录", nil];
    
    menuScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, temp, 200, SCREEN_HEIGHT - temp - 70)];
    menuScrollView.backgroundColor = [UIColor clearColor];
    menuScrollView.contentSize = CGSizeMake(200, menuArray.count * fHeight);
    menuScrollView.showsVerticalScrollIndicator = NO;
    for (int i=0; i<menuArray.count; i++) {
        UIView *menuView = [[UIView alloc]initWithFrame:CGRectMake(0, i*fHeight, 200, fHeight)];
        menuView.backgroundColor = [UIColor clearColor];
        menuView.tag = VIEW_TAG + i + 1;
        [menuScrollView addSubview:menuView];
        
        UIImageView *logoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[logoArray objectAtIndex:i]]];
        logoImage.frame = CGRectMake(8, 8, 30, 30);
        [menuView addSubview:logoImage];
        
        UILabel *menuNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(46, 0, 120, fHeight)];
        menuNameLabel.backgroundColor = [UIColor clearColor];
        menuNameLabel.textAlignment = NSTextAlignmentLeft;
        menuNameLabel.font = [UIFont fontWithName:appTypeFace size:16];
        menuNameLabel.text = [menuArray objectAtIndex:i];
        menuNameLabel.textColor = [UIColor whiteColor];
        menuNameLabel.lineBreakMode = UILineBreakModeWordWrap;
        menuNameLabel.numberOfLines = 0;
        [menuView addSubview:menuNameLabel];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, menuView.frame.size.width, menuView.frame.size.height)];
        button.tag = BUTTON_TAG +i +1;
        button.backgroundColor = [UIColor clearColor];
        //        [button setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:button];
    }
    [self.view addSubview:menuScrollView];
    
    
    
    if (![MyMobileServiceYNParam getIsLogin]) {
        [notLogView setHidden:NO];
        [didLogView setHidden:YES];
        menuScrollView.frame = CGRectMake(10, 121, 200, SCREEN_HEIGHT - 120 - 70);
        _colorLabel.frame = CGRectMake(0, 120, SCREEN_WIDTH, 1);
        UIView *view = (UIView *)[menuScrollView viewWithTag:VIEW_TAG + 5];
        [view setHidden:YES];
    }else{
        [notLogView setHidden:YES];
        [didLogView setHidden:NO];
        UIView *view = (UIView *)[menuScrollView viewWithTag:VIEW_TAG + 5];
        [view setHidden:YES];
    }
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLeftMenuInfo:) name:@"toSetLeftMenuInfo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeThemeColor:) name:@"changeThemeColor" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:@"logOut" object:nil];
}

-(void)buttonPressed:(id)sender
{
    UIButton *button = (UIButton *) sender;
//    if (BUTTON_TAG + 1 == button.tag) {//检测版本
//        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
//        [dic setObject:@"checkVersion" forKey:@"Operate"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
////        [self.sideMenuViewController hideMenuViewController];
//    }
     if (BUTTON_TAG+1 == button.tag)
    {
        //在线客服
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"customService" forKey:@"Operate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
        [self.sideMenuViewController hideMenuViewController];
    }
    else if (BUTTON_TAG+2 == button.tag)
    {
        //关于我们
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"aboutUs" forKey:@"Operate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
//        MyMobileServiceYNAboutUSVC *aboutUs = [[MyMobileServiceYNAboutUSVC alloc]init];
//        [self.sideMenuViewController.contentViewController.navigationController pushViewController:aboutUs animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    else if (BUTTON_TAG+3 == button.tag)
    {
        //主题设置
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"themeSet" forKey:@"Operate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
        [self.sideMenuViewController hideMenuViewController];
    }
    else if (BUTTON_TAG+4 == button.tag)
    {
//        //应用推荐
//        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
//        [dic setObject:@"recommendApp" forKey:@"Operate"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
        //退出登录
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"确定退出当前账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag=ALERTVIEW_TAG+50;
        [alertView show];
    }else if (BUTTON_TAG + 100 == button.tag){
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"charge" forKey:@"Operate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
        [self.sideMenuViewController hideMenuViewController];
        NSLog(@"------charge-------");
    }else if (BUTTON_TAG + 101 == button.tag){
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        NSLog(@"-----login-----");
        [dic setObject:@"login" forKey:@"Operate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    

}

-(void)setLeftMenuInfo:(NSNotification*) notification
{
    NSString *greeting = nil;
    NSDateFormatter *timec = [[NSDateFormatter alloc]init];
    [timec setDateFormat:@"HH"];
    NSString *hour = [timec stringFromDate:[NSDate date]];
    if (hour.intValue <= 12) {
        greeting = @"上午好";
    }else if (hour.intValue <= 18){
        greeting = @"下午好";
    }else{
        greeting = @"晚上好";
    }

    _telLabel.text = [MyMobileServiceYNParam getSerialNumber];
    _nameLabel.text = [NSString stringWithFormat:@"亲爱的%@，%@~",[MyMobileServiceYNParam getCustName],greeting];
    _moneyLabel.text = [NSString stringWithFormat:@"%0.2f",[[[MyMobileServiceYNParam getCurrentMonthCostDic] objectForKey:@"RSRV_NUM3"]floatValue]/100];
    if ([_moneyLabel.text floatValue] <= 10.0f) {
        _moneyLabel.textColor = [UIColor redColor];
    }else{
        _moneyLabel.textColor = [CommonUtils getCurrentThemeColor];
    }
    
    if (![notification.object isEqualToString:@""]) {
        _scoreLabel.text = [NSString stringWithFormat:@"我的积分：%@",notification.object];
    }else{
        _scoreLabel.text = [NSString stringWithFormat:@"我的积分：%@",@"0"];
    }
    _colorLabel.frame = CGRectMake(0, 200, SCREEN_WIDTH, 1);
    menuScrollView.frame = CGRectMake(10, 201, 200, SCREEN_HEIGHT - 120 - 70);
    [notLogView setHidden:YES];
    [didLogView setHidden:NO];
    UIView *view = (UIView *)[menuScrollView viewWithTag:VIEW_TAG + 5];
    [view setHidden:NO];
}

-(void)changeThemeColor:(NSNotification *)notification
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"currentTheme.plist"];
    NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    if ([notification.object isEqualToString:@"red"]) {
        [_colorLabel setBackgroundColor:UIColorFromRGB(rgbValue_Theme_red)];
        _moneyLabel.textColor = UIColorFromRGB(rgbValue_Theme_red);
        self.sideMenuViewController.backgroundImage = [UIImage imageNamed:@"box_menubg_red"];
        [currentTheme setObject:@"red" forKey:@"currentTheme"];
    }else if ([notification.object isEqualToString:@"blue"]){
        [_colorLabel setBackgroundColor:UIColorFromRGB(rgbValue_Theme_blue)];
        _moneyLabel.textColor = UIColorFromRGB(rgbValue_Theme_blue);
        self.sideMenuViewController.backgroundImage = [UIImage imageNamed:@"box_menubg_blue"];
        [currentTheme setObject:@"blue" forKey:@"currentTheme"];
    }else if ([notification.object isEqualToString:@"green"]){
        [_colorLabel setBackgroundColor:UIColorFromRGB(rgbValue_Theme_green)];
        _moneyLabel.textColor = UIColorFromRGB(rgbValue_Theme_green);
        self.sideMenuViewController.backgroundImage = [UIImage imageNamed:@"box_menubg_green"];
        [currentTheme setObject:@"green" forKey:@"currentTheme"];
    }else if ([notification.object isEqualToString:@"pueple"]){
        [_colorLabel setBackgroundColor:UIColorFromRGB(rgbValue_Theme_pueple)];
        _moneyLabel.textColor = UIColorFromRGB(rgbValue_Theme_pueple);
        self.sideMenuViewController.backgroundImage = [UIImage imageNamed:@"box_menubg_pink"];
        [currentTheme setObject:@"pueple" forKey:@"currentTheme"];
    }
    [currentTheme writeToFile:filename atomically:YES];
}

-(void)initColorLabel
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"currentTheme.plist"];
    NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    
    if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"red"]) {
        [_colorLabel setBackgroundColor:UIColorFromRGB(rgbValue_Theme_red)];
    }else if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"blue"]){
        [_colorLabel setBackgroundColor:UIColorFromRGB(rgbValue_Theme_blue)];
    }else if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"green"]){
        [_colorLabel setBackgroundColor:UIColorFromRGB(rgbValue_Theme_green)];
    }else if ([[currentTheme objectForKey:@"currentTheme"] isEqualToString:@"pueple"]){
        [_colorLabel setBackgroundColor:UIColorFromRGB(rgbValue_Theme_pueple)];
    }
}

-(void)logout:(NSNotification *)notification
{
    NSLog(@"111tuituitui");
    [notLogView setHidden:NO];
    [didLogView setHidden:YES];
    menuScrollView.frame = CGRectMake(10, 121, 200, SCREEN_HEIGHT - 120 - 70);
    _colorLabel.frame = CGRectMake(0, 120, SCREEN_WIDTH, 1);
    UIView *view = (UIView *)[menuScrollView viewWithTag:VIEW_TAG + 5];
    [view setHidden:YES];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"deLog" forKey:@"Operate"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftMenuButtonPressed" object:dic];
    }
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
