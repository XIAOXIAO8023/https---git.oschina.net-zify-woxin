//
//  MyMobileServiceYNViewController.m
//  MyMobileServiceYN
//
//  Created by Michelle on 14-3-11.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNCurrentExpenseVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNCurrentExpense.h"
#import "MyMobileServiceYNRechargeVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNParam.h"
#import "DateDeal.h"
#import "MyMobileServiceYNBillInfoVC.h"
#import "MyMobileServiceYNCurrentExpenseDetailVC.h"

@interface MyMobileServiceYNCurrentExpenseVC ()

@end

@implementation MyMobileServiceYNCurrentExpenseVC

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
    self.title = @"实时话费";
    requestTime = 0;
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+120);
    scrollView.backgroundColor = [UIColor clearColor];
    //scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];

    busiCode = @"currentCost";
    [HUD showTextHUDWithVC:self.navigationController.view];
    requestBeanDic=[httpRequest getHttpPostParamData:@"currentCost"];
    [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [httpRequest startAsynchronous:@"currentCost" requestParamData:requestBeanDic viewController:self];
    
}
//
-(void) toRecharge
{
    MyMobileServiceYNRechargeVC *rechargeVC = [[MyMobileServiceYNRechargeVC alloc]init];
    [self.navigationController pushViewController:rechargeVC animated:YES];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [httpRequest setRequestDelegatNil];
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate methods
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[request responseData];
    DebugNSLog(@"%@",[request responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){

        if ([busiCode isEqualToString:@"currentCost"]) {
            [MyMobileServiceYNParam setCurrentCostDic:dic];
            [MyMobileServiceYNParam setCurrentCostArray:array];
            
            requestTime +=1;
            busiCode = @"queryDetailLog";
            
            requestBeanDic=[httpRequest getHttpPostParamData:@"queryDetailLog"];
//            NSString *month = [DateDeal getYearMonthNow];
            [requestBeanDic setObject:@"0" forKey:@"MONTH"];
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [httpRequest startAsynchronous:@"queryDetailLog" requestParamData:requestBeanDic viewController:self];
        }else
        {
            DetailArray = array;
            
            float height = 5;
            //当月话费
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30, height, SCREEN_WIDTH, 40)];
            label2.text = @" 当月话费(元)";
            label2.backgroundColor = [UIColor clearColor];
            label2.textAlignment = UITextAlignmentLeft;
            label2.textColor = UIColorFromRGB(rgbValue_buttonNameBlack);
            label2.font = [UIFont fontWithName:appTypeFace size:22];
            [scrollView addSubview:label2];
            
            UILabel *labelDiomand1 = [[UILabel alloc]initWithFrame:CGRectMake(10, height+10, 10, 20)];
            labelDiomand1.backgroundColor = UIColorFromRGB(rgbValue_greenDiamond);
            [scrollView addSubview:labelDiomand1];
            
            height = height + 40;
            
            UILabel *data1 = [[UILabel alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 80)];
            float num2 = [[[MyMobileServiceYNParam getCurrentMonthCostDic] objectForKey:@"RSRV_NUM2"]floatValue]/100;
            float num1 = [[[MyMobileServiceYNParam getCurrentMonthCostDic] objectForKey:@"RSRV_NUM1"]floatValue]/100;
            data1.text = [NSString stringWithFormat:@"%.2f",(float)(num2-num1)];
            data1.backgroundColor = [UIColor clearColor];
            data1.textColor = UIColorFromRGB(rgbValue_orangeNumber);
            data1.textAlignment = UITextAlignmentCenter;
            data1.font = [UIFont fontWithName:appTypeFace size:40];
            [scrollView addSubview:data1];
            height = height + 80;
            
            UIButton *billButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
            billButton.backgroundColor=[UIColor clearColor];
            [billButton addTarget:self action:@selector(toBillInfo) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:billButton];
            
            UIView *viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 1)];
            viewLine1.backgroundColor = UIColorFromRGB(rgbValue_grayBackground);
            [scrollView addSubview:viewLine1];
            
            //话费余额
            height = height +30;
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:@" 账户余额(元)" forKey:@"label"];
            float num3 = [[[MyMobileServiceYNParam getCurrentCostDic] objectForKey:@"ALL_BALANCE"]floatValue]/100 + [[[MyMobileServiceYNParam getCurrentCostDic] objectForKey:@"FREEZE_FEE"]floatValue]/100;
            [dic setObject:[NSString stringWithFormat:@"%.2f",num3] forKey:@"data"];
            [dic setObject:@"可用话费" forKey:@"label1"];
            [dic setObject:@"" forKey:@"label2"];
            [dic setObject:@"预存未返还" forKey:@"label3"];
            float ALL_BALANCE = [[[MyMobileServiceYNParam getCurrentCostDic] objectForKey:@"ALL_BALANCE"]floatValue]/100;
            [dic setObject:[NSString stringWithFormat:@"%.2f",ALL_BALANCE] forKey:@"data1"];
            [dic setObject:@"" forKey:@"data2"];
            float FREEZE_FEE = [[[MyMobileServiceYNParam getCurrentCostDic] objectForKey:@"FREEZE_FEE"]floatValue]/100;
            [dic setObject:[NSString stringWithFormat:@"%.2f",FREEZE_FEE] forKey:@"data3"];
            
            MyMobileServiceYNCurrentExpense *test1 =[[MyMobileServiceYNCurrentExpense alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 120)];
            
            [test1 setUIViewforCurrentExpense:dic];
            [scrollView addSubview:test1];
            
            height = height + 120;
            
            //本期入帐
            
            //根据详细信息获取汇总信息并展示
            NSString *jiaofei= @"0";
            NSString *zengsong= @"0";
            NSString *fanhuan= @"0";
            NSString *zonge = @"0";
            
            int j = [[[array objectAtIndex:0] objectForKey:@"NEW_RECV_FEE"] intValue];
            jiaofei = [NSString stringWithFormat:@"%.2f",(float)j/100];

            int k = [[[array objectAtIndex:0] objectForKey:@"NEW_PRESENT_FEE"] intValue];
            zengsong = [NSString stringWithFormat:@"%.2f",(float)k/100];
            
            int l = [[[array objectAtIndex:0] objectForKey:@"NEW_CASH_DIVIDED_FEE"] intValue];
            int m = [[[array objectAtIndex:0] objectForKey:@"NEW_PRESENT_DIVIDED_FEE"] intValue];
            
            if (l<0) {
                l = 0-l;
            }
            if (m<0) {
                m = 0-m;
            }
            
            fanhuan = [NSString stringWithFormat:@"%.2f",(float)(l+m)/100];
            
            zonge = [NSString stringWithFormat:@"%.2f",(float)(j+k+l+m)/100];
            
            height = height +40;
            [dic setObject:@" 近3个月入帐(元)" forKey:@"label"];
            [dic setObject:zonge forKey:@"data"];
            [dic setObject:@"缴费" forKey:@"label1"];
            [dic setObject:@"赠送" forKey:@"label2"];
            [dic setObject:@"返还" forKey:@"label3"];
            [dic setObject:jiaofei forKey:@"data1"];
            [dic setObject:zengsong forKey:@"data2"];
            [dic setObject:fanhuan forKey:@"data3"];
            
            MyMobileServiceYNCurrentExpense *test2 = [[MyMobileServiceYNCurrentExpense alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 120)];
            [test2 setUIViewforCurrentExpense:dic];
            [scrollView addSubview:test2];
            
            height = height + 120;
            
            //查看更多明细
            height = height +20;
            UIButton *buttonDetail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            buttonDetail.frame = CGRectMake(20, height+20, SCREEN_WIDTH -40, 44);
            [buttonDetail setTitle:@"近3个月话费明细" forState:UIControlStateNormal];
            buttonDetail.titleLabel.font = [UIFont fontWithName:appTypeFace size:25];
            buttonDetail.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            UIImage *buttonDetailImage = [self createImageWithColor:UIColorFromRGB(rgbValueTitleBlue)];
            [buttonDetail setBackgroundImage:buttonDetailImage forState:UIControlStateNormal];
            [buttonDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [buttonDetail addTarget:self action:@selector(buttonDetailPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self setButtonBorder:buttonDetail];
            [scrollView addSubview:buttonDetail];
            
            //话费充值
            height = height +44;
            UIButton *buttonRecharge = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            buttonRecharge.frame = CGRectMake(20, height+44, SCREEN_WIDTH -40, 44);
            [buttonRecharge setTitle:@"充值" forState:UIControlStateNormal];
            buttonRecharge.titleLabel.font = [UIFont fontWithName:appTypeFace size:25];
            buttonRecharge.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            UIImage *buttonRechargeImage = [self createImageWithColor:UIColorFromRGB(rgbValueTitleBlue)];
            [buttonRecharge setBackgroundImage:buttonRechargeImage forState:UIControlStateNormal];
            [buttonRecharge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [buttonRecharge addTarget:self action:@selector(toRecharge) forControlEvents:UIControlEventTouchUpInside];
            [self setButtonBorder:buttonRecharge];
            [scrollView addSubview:buttonRecharge];
            
            requestTime +=1;
        }
        
    }else if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"2"]){
        if(HUD){
            [HUD removeHUD];
        }
        if ([busiCode isEqualToString:@"queryDetailLog"]) {
            float height = 5;
            //当月话费
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30, height, SCREEN_WIDTH, 40)];
            label2.text = @" 当月话费(元)";
            label2.backgroundColor = [UIColor clearColor];
            label2.textAlignment = UITextAlignmentLeft;
            label2.textColor = UIColorFromRGB(rgbValue_buttonNameBlack);
            label2.font = [UIFont fontWithName:appTypeFace size:22];
            [scrollView addSubview:label2];
            
            UILabel *labelDiomand1 = [[UILabel alloc]initWithFrame:CGRectMake(10, height+10, 10, 20)];
            labelDiomand1.backgroundColor = UIColorFromRGB(rgbValue_greenDiamond);
            [scrollView addSubview:labelDiomand1];
            
            height = height + 40;
            
            UILabel *data1 = [[UILabel alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 80)];
            float num2 = [[[MyMobileServiceYNParam getCurrentMonthCostDic] objectForKey:@"RSRV_NUM2"]floatValue]/100;
            float num1 = [[[MyMobileServiceYNParam getCurrentMonthCostDic] objectForKey:@"RSRV_NUM1"]floatValue]/100;
            data1.text = [NSString stringWithFormat:@"%.2f",(float)(num2-num1)];
            data1.backgroundColor = [UIColor clearColor];
            data1.textColor = UIColorFromRGB(rgbValue_orangeNumber);
            data1.textAlignment = UITextAlignmentCenter;
            data1.font = [UIFont fontWithName:appTypeFace size:40];
            [scrollView addSubview:data1];
            height = height + 80;
            
            UIButton *billButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
            billButton.backgroundColor=[UIColor clearColor];
            [billButton addTarget:self action:@selector(toBillInfo) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:billButton];
            
            UIView *viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 1)];
            viewLine1.backgroundColor = UIColorFromRGB(rgbValue_grayBackground);
            [scrollView addSubview:viewLine1];
            
            //话费余额
            height = height +30;
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:@" 账户余额(元)" forKey:@"label"];
            float num3 = [[[MyMobileServiceYNParam getCurrentCostDic] objectForKey:@"ALL_BALANCE"]floatValue]/100 + [[[MyMobileServiceYNParam getCurrentCostDic] objectForKey:@"FREEZE_FEE"]floatValue]/100;
            [dic setObject:[NSString stringWithFormat:@"%.2f",num3] forKey:@"data"];
            [dic setObject:@"可用话费" forKey:@"label1"];
            [dic setObject:@"" forKey:@"label2"];
            [dic setObject:@"预存未返还" forKey:@"label3"];
            float ALL_BALANCE = [[[MyMobileServiceYNParam getCurrentCostDic] objectForKey:@"ALL_BALANCE"]floatValue]/100;
            [dic setObject:[NSString stringWithFormat:@"%.2f",ALL_BALANCE] forKey:@"data1"];
            [dic setObject:@"" forKey:@"data2"];
            float FREEZE_FEE = [[[MyMobileServiceYNParam getCurrentCostDic] objectForKey:@"FREEZE_FEE"]floatValue]/100;
            [dic setObject:[NSString stringWithFormat:@"%.2f",FREEZE_FEE] forKey:@"data3"];
            
            MyMobileServiceYNCurrentExpense *test1 =[[MyMobileServiceYNCurrentExpense alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 120)];
            
            [test1 setUIViewforCurrentExpense:dic];
            [scrollView addSubview:test1];
            
            height = height + 120;
            
            //话费充值
//            height = height +44;
            UIButton *buttonRecharge = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            buttonRecharge.frame = CGRectMake(20, height+44, SCREEN_WIDTH -40, 44);
            [buttonRecharge setTitle:@"充值" forState:UIControlStateNormal];
            buttonRecharge.titleLabel.font = [UIFont fontWithName:appTypeFace size:25];
            buttonRecharge.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            UIImage *buttonRechargeImage = [self createImageWithColor:UIColorFromRGB(rgbValueButtonGreen)];
            [buttonRecharge setBackgroundImage:buttonRechargeImage forState:UIControlStateNormal];
            [buttonRecharge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [buttonRecharge addTarget:self action:@selector(toRecharge) forControlEvents:UIControlEventTouchUpInside];
            [self setButtonBorder:buttonRecharge];
            [scrollView addSubview:buttonRecharge];
            
            scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
        }
    }
    else{
        if(HUD){
            [HUD removeHUD];
        }
        if ([@"1620" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]])//超时
        {
//            NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//            alertView.tag = ALERTVIEW_TAG_RETURN+10;
//            [alertView show];
            httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
            busiCode = @"HQSM_IntegralQryAcctInfos";
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
        if (requestTime ==2 ) {
            [HUD removeHUD];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    DebugNSLog(@"----------2---------%@",error);
    NSString *returnMessage = [returnMessageDeal returnMessage:@"" andreturnMessage:@""];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN+2;
    [alertView show];
    if(HUD){
        [HUD removeHUD];
    }
}

-(void)toBillInfo{
    MyMobileServiceYNBillInfoVC *billInfoVC=[[MyMobileServiceYNBillInfoVC alloc]init];
    [self.navigationController pushViewController:billInfoVC animated:YES];
}

-(void)buttonDetailPressed:(id)sender
{
    MyMobileServiceYNCurrentExpenseDetailVC *detailVC = [[MyMobileServiceYNCurrentExpenseDetailVC alloc]init];
    detailVC.DetailArray = DetailArray;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
