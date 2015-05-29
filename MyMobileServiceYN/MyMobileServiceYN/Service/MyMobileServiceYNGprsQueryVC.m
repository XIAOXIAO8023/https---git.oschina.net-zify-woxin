//
//  MyMobileServiceYNGprsQueryVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-6.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNGprsQueryVC.h"
#import "GlobalDef.h"
#import "PercentageBar.h"
#import "PNChart.h"
#import "MyMobileServiceYNPackageDetailInfo.h"
#import "MyMobileServiceYNPackageDetailInfoGauges.h"
#import "DateDeal.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNOrderGprsVC.h"
#import "DialogInfo.h"

@interface MyMobileServiceYNGprsQueryVC ()

@end

@implementation MyMobileServiceYNGprsQueryVC

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
    self.title = @"流量查询";
    
    //右侧边栏
//    UIButton *sideRightMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    sideRightMenuButton.frame = CGRectMake(0, 0, 60, 35);
//    [sideRightMenuButton setBackgroundColor:[UIColor clearColor]];
//    [sideRightMenuButton setTitle:@"加流量" forState:UIControlStateNormal];
//    sideRightMenuButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:18];
//    [sideRightMenuButton addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:sideRightMenuButton];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.delegate = self;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [self.view addSubview:homeScrollView];
    
    //开始获取用户信息
    [HUD showTextHUDWithVC:self.navigationController.view];
    
    NSMutableString *billCycle=[[NSMutableString alloc]init];
    if ([DateDeal getMonth]<10) {
        [billCycle appendString:[NSString stringWithFormat:@"%ld0%ld",(long)[DateDeal getYear],(long)[DateDeal getMonth]]];
    }else
    {
        [billCycle appendString:[NSString stringWithFormat:@"%ld%ld",(long)[DateDeal getYear],(long)[DateDeal getMonth]]];
    }
    DebugNSLog(@"%@",billCycle);
    
    //套餐余量查询
    requestBeanDic=[httpRequest getHttpPostParamData:@"queryUserAmount"];
    [requestBeanDic setObject:billCycle forKey:@"BCYC_ID"];
    [requestBeanDic setObject:@"0" forKey:@"REMOVE_TAG"];
    [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [httpRequest startAsynchronous:@"queryUserAmount" requestParamData:requestBeanDic viewController:self];
}

-(void)loadHomeScrollView{
    float homeScrollViewHeight = 0;
    
    float height = 190;
    NSArray *temp = gprsArray;
    height += 80*gprsArray.count;
    
    MyMobileServiceYNPackageDetailInfoGauges *gprsDetailInfo=[[MyMobileServiceYNPackageDetailInfoGauges alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    [gprsDetailInfo setPackageDetailInfoView:PackageElementsTypeGprs andDetailInfo:temp];
    [homeScrollView addSubview:gprsDetailInfo]; 
    
//    height+=10;
//    UIButton *choosePackageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    choosePackageButton.frame = CGRectMake(10, height, SCREEN_WIDTH -20, 44);
//    //    choosePackageButton.backgroundColor = [UIColor redColor];
//    choosePackageButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:25.0];
//    choosePackageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [choosePackageButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
//    //    [choosePackageButton setBackgroundColor:UIColorFromRGB(rgbVaelu_gprsQueryButtonBg)];
//    UIImage *image =[self createImageWithColor:UIColorFromRGB(rgbValueButtonGreen)];
//    [choosePackageButton setBackgroundImage:image forState:UIControlStateNormal];
//    [choosePackageButton setTitle:@"逛逛流量加油站" forState:UIControlStateNormal];
//    [choosePackageButton addTarget:self action:@selector(choosePackageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self setButtonBorder:choosePackageButton];
//    [homeScrollView addSubview:choosePackageButton];
//    height+=choosePackageButton.frame.size.height;
    
    height+=10;
    UILabel *prom=[[UILabel alloc]initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-20, 20)];
    prom.text=@"注意：详细数据以月结实际账单为准。";
    prom.textColor=UIColorFromRGB(rgbValueLightGrey);
    prom.font=[UIFont fontWithName:appTypeFace size:14];
    [homeScrollView addSubview:prom];
    
    [homeScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, height+40)];
}

- (UIImage*) createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)rightButtonPressed{
    if ([MyMobileServiceYNParam getIsDynamicPW]) {//如果是动态密码登录，不允许使用，提示用户重新登录
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info_other delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG;
        [alertView show];
    }else
    {
        MyMobileServiceYNOrderGprsVC *orderGprs=[[MyMobileServiceYNOrderGprsVC alloc]init];
        [self.navigationController pushViewController:orderGprs animated:YES];
    }
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate methods
- (void)requestFinished:(ASIHTTPRequest *)requestBean
{
    NSArray *cookies = [requestBean responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[requestBean responseData];
    DebugNSLog(@"%@",[requestBean responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        //进行数据解析拼组
        
        gprsArray =[[NSMutableArray alloc]init];
        
        for (int i = 0; i<array.count; i++) {
            NSDictionary *dic1 = [array objectAtIndex:i];
            if ([[dic1 objectForKey:@"ITEM_TYPE"]isEqualToString:@"优惠GPRS流量（M）"]) {
                [gprsArray addObject:dic1];
            }
        }
        
        [self loadHomeScrollView];
    }else{
        if ([@"1620" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]])//超时
        {
//            NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//            alertView.tag = ALERTVIEW_TAG_RETURN+10;
//            [alertView show];
            httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
           NSString *busiCode = @"HQSM_IntegralQryAcctInfos";
            NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
            [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [requestParamData setObject:@"HQSM_IntegralQryAcctInfos" forKey:@"intf_code"];
            [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
        }else
        {
            NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG_RETURN+1;
            [alertView show];
        }
    }
    if(HUD){
        [HUD removeHUD];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)requestBean
{
    NSError *error = [requestBean error];
    DebugNSLog(@"----------2---------%@",error);
    NSString *returnMessage = [returnMessageDeal returnMessage:@"" andreturnMessage:@""];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN+2;
    [alertView show];
    if(HUD){
        [HUD removeHUD];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [httpRequest setRequestDelegatNil];
}

-(void)choosePackageButtonPressed:(id)sender
{
    if ([MyMobileServiceYNParam getIsDynamicPW]) {//如果是动态密码登录，不允许使用，提示用户重新登录
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info_other delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG;
        [alertView show];
    }else
    {
        MyMobileServiceYNOrderGprsVC *orderGprsVC = [[MyMobileServiceYNOrderGprsVC alloc]init];
        [self.navigationController pushViewController:orderGprsVC animated:YES];
    }
}

@end
