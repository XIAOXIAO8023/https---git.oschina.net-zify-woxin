//
//  NDAboutVC.m
//  YearBill
//
//  Created by 陆楠 on 15/3/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "NDAboutVC.h"
#import "YBColorDef.h"
#import "YearBillUserInfo.h"

@interface NDAboutVC ()

@end

@implementation NDAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"免责声明";
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pink.png"]];
    
    [self loadContent];
}


-(void)loadContent
{
    UILabel *a = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 30)];
    [self.view addSubview:a];
    a.text = @"查询周期：";
    a.textColor = [UIColor yellowColor];
    a.font = [UIFont fontWithName:@"Arial" size:16];
    
    UILabel *timel = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 300, 30)];
    [self.view addSubview:timel];
    timel.text = [YearBillUserInfo getQueryCode];
    timel.textColor = [UIColor whiteColor];
    timel.font = [UIFont fontWithName:@"Arial" size:15];
    
    UIView *bv = [[UIView alloc]initWithFrame:CGRectMake(0, 75, 320, 0.5)];
    [self.view addSubview:bv];
    bv.backgroundColor = UIColorFromRGB(COMMON_PURPLE);
    
    UILabel *b = [[UILabel alloc]initWithFrame:CGRectMake(10, 85, 300, 30)];
    [self.view addSubview:b];
    b.text = @"免责声明：";
    b.textColor = [UIColor yellowColor];
    b.font = [UIFont fontWithName:@"Arial" size:16];
    
    UILabel *b1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 300, 90)];
    [self.view addSubview:b1];
    b1.text = @"1、本账单中展示数据来源于云南移动系统统计，仅供参考，云南移动不对内容准确性与真实性做任何承认和保证。";
    b1.numberOfLines = 0;
    b1.lineBreakMode = UILineBreakModeWordWrap;
    b1.textColor = [UIColor whiteColor];
    b1.font = [UIFont fontWithName:@"Arial" size:14];
    
    UILabel *b2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 175, 300, 90)];
    [self.view addSubview:b2];
    b2.text = @"2、您承诺遵守国家法律法规及各种社会公共利益或公共道德。因您的违法行为或/及您查看本账单与第三方产生纠纷的一切后果与责任，由您独立承担。";
    b2.numberOfLines = 0;
    b2.lineBreakMode = UILineBreakModeWordWrap;
    b2.textColor = [UIColor whiteColor];
    b2.font = [UIFont fontWithName:@"Arial" size:14];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
