//
//  MyMobileServiceYNTabbarServiceVC.m
//  MyMobileServiceYN
//
//  Created by zhang on 15/4/2.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNTabbarServiceVC.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNLoginVC.h"
#import "GlobalDef.h"
#import "DialogInfo.h"
#import "MyMobileServiceYNWebViewVC.h"
#import "MyMobileServiceYNCurrentExpenseVC.h"//实时话费
#import "MyMobileServiceYNPackageOverDetailInfoVC.h"//套餐余量
#import "MyMobileServiceYNGprsQueryVC.h"//流量查询
#import "MyMobileServiceYNBillInfoVC.h"//我的账单
#import "MyMobileServiceYNDataProductListVC.h"//业务办理
#import "MyMobileServiceYNPackagesServiceVC.h"//套餐变更

#import "MyMobileServiceYNOrderGprsVC.h"//流量订购


#import "MyMobileServiceYNRechargeVC.h"//充值

#define BUTTON_WIDTH (SCREEN_WIDTH/4)
#define LINE_WIDTH ((120.0/320.0)*SCREEN_WIDTH)
@interface MyMobileServiceYNTabbarServiceVC ()

@end

@implementation MyMobileServiceYNTabbarServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadMainScrollView];
}

-(void)loadMainScrollView{
    mainScrollViewHeight = 0;
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT)];
    mainScrollView.backgroundColor = [UIColor whiteColor];
    
    //查询部分
    
    
    UILabel *queryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    queryLabel.text = @"查询";
    queryLabel.font = [UIFont fontWithName:appTypeFace size:14];
    queryLabel.textColor = UIColorFromRGB(rgbValueDeepGrey);
    float queryLabelWidth = [queryLabel.text sizeWithFont:queryLabel.font].width;
    queryLabel.frame = CGRectMake(0, 0, queryLabelWidth, 20);
    queryLabel.center = CGPointMake(SCREEN_WIDTH/2, 35);
    //
    queryLabel.backgroundColor = [UIColor clearColor];
    //
    mainScrollViewHeight += 50;
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10,mainScrollViewHeight-15, LINE_WIDTH, 2)];
    lineLabel1.backgroundColor = UIColorFromRGB(rgbValueBgGrey);
    [mainScrollView addSubview:lineLabel1];
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-10-LINE_WIDTH,mainScrollViewHeight-15, LINE_WIDTH, 2)];
    lineLabel2.backgroundColor = UIColorFromRGB(rgbValueBgGrey);
    [mainScrollView addSubview:lineLabel2];

    
    [mainScrollView addSubview:queryLabel];
    
    float queryViewHeight = 0;
    NSString *queryPlistPath = [[NSBundle mainBundle]pathForResource:@"queryButton" ofType:@"plist"];
    queryBtnArray = [[NSArray alloc]initWithContentsOfFile:queryPlistPath];
    
    UIView *queryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, queryViewHeight)];
    for (int i = 0; i < queryBtnArray.count; i++) {
        UIButton *queryBtn = [self buttonWithQuery:[queryBtnArray objectAtIndex:i]];
        queryBtn.frame = CGRectMake(BUTTON_WIDTH*(i), 0, BUTTON_WIDTH, BUTTON_WIDTH);
        queryBtn.tag = BUTTON_TAG + 100 +i;
        [queryBtn addTarget:self action:@selector(queryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [queryView addSubview:queryBtn];
        if ((i%4)==3||i==(queryBtnArray.count-1)) {
            queryViewHeight += BUTTON_WIDTH;
        }
    }
    queryView.backgroundColor = [UIColor clearColor];

    queryView.frame = CGRectMake(0, mainScrollViewHeight, SCREEN_WIDTH, queryViewHeight);
    mainScrollViewHeight += queryViewHeight;
    [mainScrollView addSubview:queryView];
    
    
    
    //办理部分
    UILabel *handleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    handleLabel.text = @"办理";
    handleLabel.font = [UIFont fontWithName:appTypeFace size:14];
    handleLabel.textColor = UIColorFromRGB(rgbValueDeepGrey);
    float handleLabelWidth = [handleLabel.text sizeWithFont:handleLabel.font].width;
    //
    handleLabel.backgroundColor = [UIColor clearColor];
    //
    handleLabel.frame = CGRectMake(0, 0, handleLabelWidth, 20);
    handleLabel.center = CGPointMake(SCREEN_WIDTH/2,mainScrollViewHeight+35);
    mainScrollViewHeight += 50;
    
    UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(10,mainScrollViewHeight-15, LINE_WIDTH, 2)];
    lineLabel3.backgroundColor = UIColorFromRGB(rgbValueBgGrey);
    [mainScrollView addSubview:lineLabel3];
    UILabel *lineLabel4= [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-10-LINE_WIDTH,mainScrollViewHeight-15, LINE_WIDTH, 2)];
    lineLabel4.backgroundColor = UIColorFromRGB(rgbValueBgGrey);
    [mainScrollView addSubview:lineLabel4];
    
    [mainScrollView addSubview:handleLabel];
    
    
    float handleViewHeight = 0;
    NSString *handlePlistPath = [[NSBundle mainBundle]pathForResource:@"handleButton" ofType:@"plist"];
    handleBtnArray = [[NSArray alloc]initWithContentsOfFile:handlePlistPath];
    
    UIView *handleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, handleViewHeight)];
    for (int i = 0; i < handleBtnArray.count; i++) {
        UIButton *handleBtn = [self buttonWithHandle:[handleBtnArray objectAtIndex:i]];
        handleBtn.frame = CGRectMake(BUTTON_WIDTH*(i%4), handleViewHeight, BUTTON_WIDTH, BUTTON_WIDTH);
        handleBtn.backgroundColor = [UIColor clearColor];
        handleBtn.tag = BUTTON_TAG + 200 +i;
        if ((i%4)==3||i==(handleBtnArray.count-1)) {
            handleViewHeight += BUTTON_WIDTH;
        }
        [handleBtn addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [handleView addSubview:handleBtn];
       
    }
    handleView.backgroundColor = [UIColor clearColor];
    handleView.frame = CGRectMake(0, mainScrollViewHeight, SCREEN_WIDTH, handleViewHeight);
    mainScrollViewHeight += handleViewHeight;
    [mainScrollView addSubview:handleView];
    
    
    
    UILabel *rechargeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    rechargeLabel.text = @"充值";
    rechargeLabel.font = [UIFont fontWithName:appTypeFace size:14];
    rechargeLabel.textColor = UIColorFromRGB(rgbValueDeepGrey);
    float rechargeLabelWidth = [rechargeLabel.text sizeWithFont:rechargeLabel.font].width;
    rechargeLabel.frame = CGRectMake(0, 0, rechargeLabelWidth, 20);
    rechargeLabel.center = CGPointMake(SCREEN_WIDTH/2,mainScrollViewHeight+35);
    mainScrollViewHeight += 50;
    
    UILabel *lineLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(10,mainScrollViewHeight-15, LINE_WIDTH, 2)];
    lineLabel5.backgroundColor = UIColorFromRGB(rgbValueBgGrey);
    [mainScrollView addSubview:lineLabel5];
    UILabel *lineLabel6= [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-10-LINE_WIDTH,mainScrollViewHeight-15, LINE_WIDTH, 2)];
    lineLabel6.backgroundColor = UIColorFromRGB(rgbValueBgGrey);
    [mainScrollView addSubview:lineLabel6];
    
    [mainScrollView addSubview:rechargeLabel];
    
    //充值 view
    UIView *rechargeView = [[UIView alloc]initWithFrame:CGRectMake(0, mainScrollViewHeight, SCREEN_WIDTH, BUTTON_WIDTH)];
    UIButton *rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_WIDTH)];
    rechargeBtn.backgroundColor = [UIColor clearColor];
    
    UIImageView *iconView = [UIImageView new];
    iconView.frame = CGRectMake(0, 0, 44, 44);
    iconView.image = [UIImage imageNamed:@"service_button_70"];
    iconView.center = CGPointMake(BUTTON_WIDTH/2, iconView.center.y);
    [rechargeBtn addSubview:iconView];
    
    UILabel *title = [UILabel new];
    title.frame = CGRectMake(0, iconView.frame.origin.y+iconView.frame.size.height, BUTTON_WIDTH, 20);
    title.backgroundColor = [UIColor clearColor];
    title.text = @"充值";
    title.textColor = UIColorFromRGB(rgbValueLightGrey);
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:appTypeFace size:12];
    [rechargeBtn addSubview:title];
    [rechargeBtn addTarget:self action:@selector(rechargeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [rechargeView addSubview:rechargeBtn];
    [mainScrollView addSubview:rechargeView];
    
    
    mainScrollViewHeight += rechargeView.frame.size.height + TabBar_HEIGHT;
    mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT);
    mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, mainScrollViewHeight);
    
    
    [self.view addSubview:mainScrollView];
    
    
}

-(void)queryButtonAction:(id)sender{
    NSDictionary *queryBtnDic = [queryBtnArray objectAtIndex:[sender tag]-BUTTON_TAG-100];
    NSString *queryTitle = [queryBtnDic objectForKey:@"title"];
    if ([queryTitle isEqualToString:@"实时话费"]) {
        if ([MyMobileServiceYNParam getIsLogin]) {
            MyMobileServiceYNCurrentExpenseVC *currentExpenseVC = [[MyMobileServiceYNCurrentExpenseVC alloc]init];
            [self.navigationController pushViewController:currentExpenseVC animated:YES];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG;
            [alertView show];
        }
    }
    else if ([queryTitle isEqualToString:@"套餐余量"]){
        if ([MyMobileServiceYNParam getIsLogin]) {
            MyMobileServiceYNPackageOverDetailInfoVC *packageOverDetailInfoVC = [[MyMobileServiceYNPackageOverDetailInfoVC alloc]init];
            [self.navigationController pushViewController:packageOverDetailInfoVC animated:YES];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG;
            [alertView show];
        }
    }
    else if ([queryTitle isEqualToString:@"流量查询"]){
        if ([MyMobileServiceYNParam getIsLogin]) {
            MyMobileServiceYNGprsQueryVC *GprsQueryVC = [[MyMobileServiceYNGprsQueryVC alloc]init];
            [self.navigationController pushViewController:GprsQueryVC animated:YES];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG;
            [alertView show];
        }
    }
    else if ([queryTitle isEqualToString:@"我的账单"]){
        if ([MyMobileServiceYNParam getIsLogin]) {
            MyMobileServiceYNBillInfoVC *BillInfoVC = [[MyMobileServiceYNBillInfoVC alloc]init];
            [self.navigationController pushViewController:BillInfoVC animated:YES];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG;
            [alertView show];
        }
    }
}

-(void)handleButtonAction:(id)sender{
    NSDictionary *handleBtnDic = [handleBtnArray objectAtIndex:[sender tag]-BUTTON_TAG-200];
    NSString *handleTitle = [handleBtnDic objectForKey:@"title"];
    NSString *url;
    if ([handleTitle isEqualToString:@"积分兑换"]) {
        url = @"http://jf.10086.cn/m";
    }
    else if ([handleTitle isEqualToString:@"宽带办理"]){
        url = @"http://wx.netvan.cn/mmc/app?service=page/BandIndex&listener=initPage";
    }
    if (url != nil) {
        MyMobileServiceYNWebViewVC *webVC = [[MyMobileServiceYNWebViewVC alloc]init];
        webVC.webUrlString = url;
        webVC.title = handleTitle;
        [self presentWebVC:webVC animated:YES];
    }
    else if ([handleTitle isEqualToString:@"业务办理"]){
        if ([MyMobileServiceYNParam getIsLogin]) {
            MyMobileServiceYNDataProductListVC *DataProductListVC = [[MyMobileServiceYNDataProductListVC alloc]init];
            [self.navigationController pushViewController:DataProductListVC animated:YES];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG;
            [alertView show];
        }
    }
    else if ([handleTitle isEqualToString:@"流量订购"]){
        if ([MyMobileServiceYNParam getIsLogin]) {
            MyMobileServiceYNOrderGprsVC *orderGprsVC = [[MyMobileServiceYNOrderGprsVC alloc]init];
            [self.navigationController pushViewController:orderGprsVC animated:YES];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG;
            [alertView show];
        }
    }else if ([handleTitle isEqualToString:@"套餐变更"]) {//套餐变更
        if ([MyMobileServiceYNParam getIsDynamicPW]) {//如果是动态密码登录，不允许使用，提示用户重新登录
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG;
            [alertView show];
        }else
        {
            MyMobileServiceYNPackagesServiceVC *packagesServiceVC=[[MyMobileServiceYNPackagesServiceVC alloc]init];
            [self.navigationController pushViewController:packagesServiceVC animated:YES];
        }
    }
    else if ([handleTitle isEqualToString:@"4G补卡登记"]){
        MyMobileServiceYNWebViewVC *webView = [[MyMobileServiceYNWebViewVC alloc]init];
        webView.webUrlString = @"http://218.202.0.179/mmc/app?service=page/WxQRCode&listener=initPage&CODE=SIGN4G&PNO=null";
        [self presentWebVC:webView animated:YES];
    }
}


-(void)rechargeButtonAction{
    MyMobileServiceYNRechargeVC *rechargeVC = [[MyMobileServiceYNRechargeVC alloc]init];
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

-(UIButton *)buttonWithQuery:(NSDictionary *)queryBtnInfoDic{
    UIButton *queryBtn = [UIButton new];
    [queryBtn setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    [queryBtn setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateHighlighted];
    UIImageView *iconView = [UIImageView new];
    iconView.frame = CGRectMake(0, 0, 44, 44);
    iconView.image = [UIImage imageNamed:[queryBtnInfoDic objectForKey:@"icon"]];
    iconView.center = CGPointMake(BUTTON_WIDTH/2, BUTTON_WIDTH/2);
    [queryBtn addSubview:iconView];
    
    UILabel *title = [UILabel new];
    title.frame = CGRectMake(0, iconView.frame.origin.y+iconView.frame.size.height, BUTTON_WIDTH, 20);
    title.backgroundColor = [UIColor clearColor];
    title.text = [queryBtnInfoDic objectForKey:@"title"];
    title.textColor = UIColorFromRGB(rgbValueLightGrey);
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:appTypeFace size:12];
    [queryBtn addSubview:title];

    return queryBtn;
}

-(UIButton *)buttonWithHandle:(NSDictionary *)queryBtnInfoDic{
    UIButton *handleBtn = [UIButton new];
    [handleBtn setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    [handleBtn setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateHighlighted];
    UIImageView *iconView = [UIImageView new];
    iconView.frame = CGRectMake(0, 0,44,44);
    iconView.image = [UIImage imageNamed:[queryBtnInfoDic objectForKey:@"icon"]];
    iconView.center = CGPointMake(BUTTON_WIDTH/2, BUTTON_WIDTH/2);
    [handleBtn addSubview:iconView];
    
    UILabel *title = [UILabel new];
    title.frame = CGRectMake(0, iconView.frame.origin.y+iconView.frame.size.height, BUTTON_WIDTH, 20);
    title.backgroundColor = [UIColor clearColor];
    title.text = [queryBtnInfoDic objectForKey:@"title"];
    title.textColor = UIColorFromRGB(rgbValueLightGrey);
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:appTypeFace size:12];
    [handleBtn addSubview:title];
    
    return handleBtn;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==ALERTVIEW_TAG){//如果为动态密码登录，点击确定后跳转到登录界面，重新登录
        if(buttonIndex==1){
            MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
            [self presentModalViewController:login animated:YES];
        }
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
