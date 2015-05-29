//
//  MyMobileServiceYNBillInfoVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-6.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBillInfoVC.h"
#import "PNChart.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNBillTrendVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNParam.h"
#import "DateDeal.h"

#define BUSICODE @"queryCustBillNew"
@interface MyMobileServiceYNBillInfoVC ()

@end

@implementation MyMobileServiceYNBillInfoVC

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
    self.title = @"我的账单";
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    
    billAllInfoArray = [[NSMutableArray alloc]init];
    //初始化返回记录数为0，没返回一次增加一，如果有一次失败则提示接口异常，并返回上一页
    cycleNum = 0;
    
//    //右侧边栏
//    UIButton *rightNavBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    UIImage *imgRaw=[UIImage imageNamed: @"frame_discount"];
//    rightNavBarButton.frame = CGRectMake(0, 0, 35, 35);
//    [rightNavBarButton setBackgroundColor:[UIColor clearColor]];
//    [rightNavBarButton setImage:[UIImage imageNamed: @"frame_zst"] forState:UIControlStateNormal];
//    [rightNavBarButton setImage:[UIImage imageNamed: @"frame_zst"] forState:UIControlStateHighlighted];
//    [rightNavBarButton addTarget:self action:@selector(rightNavBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    //后退按钮
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightNavBarButton];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    //手势左右滑动（上下的不处理）
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.delegate = self;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [self.view addSubview:homeScrollView];
    
    NSArray *cycle = [DateDeal getYearMonthSixBefore];
    DebugNSLog(@"cycle：%@",cycle);
    
    //账单查询
    [HUD showTextHUDWithVC:self.navigationController.view];
    
    for (NSDictionary *infoDic in cycle) {
        requestBeanDic = [httpRequest getHttpPostParamData:BUSICODE];
        [requestBeanDic setObject:infoDic forKey:@"START_CYCLE_ID"];
        [requestBeanDic setObject:infoDic forKey:@"END_CYCLE_ID"];
        [requestBeanDic setObject:@"0" forKey:@"NEED_APPENDIX"];
        [requestBeanDic setObject:@"1" forKey:@"X_CHOICE_TAG"];
        [requestBeanDic setObject:@"1" forKey:@"MANAGE_TAG"];
        [requestBeanDic setObject:@"1" forKey:@"RSRV_STR1"];
        [requestBeanDic setObject:@"0" forKey:@"SMS_TYPE"];
        [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [httpRequest startAsynchronous:BUSICODE requestParamData:requestBeanDic viewController:self];
    }
//    for (int i=0; i<cycle.count; i++) {
//        requestBeanDic=[httpRequest getHttpPostParamData:@"queryCustBill"];
//        [requestBeanDic setObject:[cycle objectAtIndex:i] forKey:@"START_CYCLE_ID"];
//        [requestBeanDic setObject:[cycle objectAtIndex:i] forKey:@"END_CYCLE_ID"];
//        [requestBeanDic setObject:@"0" forKey:@"NEED_APPENDIX"];
//        [requestBeanDic setObject:@"1" forKey:@"X_CHOICE_TAG"];
//        [requestBeanDic setObject:@"1" forKey:@"MANAGE_TAG"];
//        [requestBeanDic setObject:@"1" forKey:@"RSRV_STR1"];
//        [requestBeanDic setObject:@"0" forKey:@"SMS_TYPE"];
//        [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
//        [httpRequest startAsynchronous:@"queryCustBill" requestParamData:requestBeanDic viewController:self];
//    }
    
//    sixMonthButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    sixMonthButton.frame = CGRectMake(10, 10+pressedView.frame.size.height +billAmountView.frame.size.height + barChart.frame.size.height + 10, 300, 44);
//    sixMonthButton.backgroundColor = [UIColor clearColor];
//    UIImage *image =[self createImageWithColor:UIColorFromRGB(rgbValue_gprsQueryButtonBg)];
//    [sixMonthButton setBackgroundImage:image forState:UIControlStateNormal];
//    [sixMonthButton setTitle:@"近6个月账单走势图" forState:UIControlStateNormal];
//    [sixMonthButton addTarget:self action:@selector(sixMonthButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [homeScrollView addSubview:sixMonthButton];
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

#pragma mark -
#pragma mark ASIHTTPRequestDelegate methods
- (void)requestFinished:(ASIHTTPRequest *)requestBean
{
    cycleNum += 1;
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[requestBean responseData]
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    DebugNSLog(@"%@",array);
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        if ([[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {
            
        }else{
            //先用字段SPECIAL_FLAG区分大类： 1表示是大类  0表示是小类
            //在SPECIAL_FLAG==1的情况下： 在用字段INTEGRATE_ITEM_CODE判断是哪些大类项，判断规如下：
            //1:套餐及固定费用 2:语音通信费 3:上网费 4:短彩信费 5:自有增值业务 6:代收费业务费用 7:其他费用
            //展示金额为优惠后金额：FEE 减去 A_DISCNT
            //账单总额：各个大类项优惠后金额相加；
            
            float iTaoCan = 0;
            float iYuYin = 0;
            float iShangWang = 0;
            float iDuanXin = 0;
            float iZengZhi = 0;
            float iDaiShou = 0;
            float iQiTa = 0;
            float iTotle =0;
            
            for (int i=0; i<array.count; i++) {
                NSDictionary *tempDic = [array objectAtIndex:i];
                
                NSString *specialFlag = [tempDic objectForKey:@"SPECIAL_FLAG"];
                NSInteger integrateItemCode = [[tempDic objectForKey:@"INTEGRATE_ITEM_CODE"]integerValue];
                CGFloat fee = [[tempDic objectForKey:@"FEE"] floatValue];
                
                if ([@"1" isEqualToString:specialFlag]) {
                    switch (integrateItemCode) {
                        case 1:
                            iTaoCan += fee;
                            if (iTaoCan < 0) iTaoCan = 0;
                            break;
                        case 2:
                            iYuYin += fee;
                            if (iYuYin < 0) iYuYin = 0;
                            break;
                        case 3:
                            iShangWang += fee;
                            if (iShangWang < 0) iShangWang = 0;
                            break;
                        case 4:
                            iDuanXin += fee;
                            if (iDuanXin < 0) iDuanXin = 0;
                            break;
                        case 5:
                            iZengZhi += fee;
                            if (iZengZhi < 0) iZengZhi = 0;
                            break;
                        case 6:
                            iDaiShou += fee;
                            if (iDaiShou < 0) iDaiShou = 0;
                            break;
                        case 7:
                            iQiTa += fee;
                            if (iQiTa < 0) iQiTa = 0;
                            break;
                        default:
                            break;
                    }
                }
                iTotle = iTaoCan+iYuYin+iShangWang+iDuanXin+iZengZhi+iDaiShou+iQiTa;
            }
            
            NSMutableDictionary *billDic = [[NSMutableDictionary alloc]init];
            NSString *sTaoCan = [NSString stringWithFormat:@"%.2f",iTaoCan];
            [billDic setObject:sTaoCan forKey:@"TaoCan"];
            NSString *sYuYin = [NSString stringWithFormat:@"%.2f",iYuYin];
            [billDic setObject:sYuYin forKey:@"YuYin"];
            NSString *sShangWang = [NSString stringWithFormat:@"%.2f",iShangWang];
            [billDic setObject:sShangWang forKey:@"ShangWang"];
            NSString *sDuanXin = [NSString stringWithFormat:@"%.2f",iDuanXin];
            [billDic setObject:sDuanXin forKey:@"DuanXin"];
            NSString *sZengZhi = [NSString stringWithFormat:@"%.2f",iZengZhi];
            [billDic setObject:sZengZhi forKey:@"ZengZhi"];
            NSString *sDaiShou = [NSString stringWithFormat:@"%.2f",iDaiShou];
            [billDic setObject:sDaiShou forKey:@"DaiShou"];
            NSString *sQiTa = [NSString stringWithFormat:@"%.2f",iQiTa];
            [billDic setObject:sQiTa forKey:@"QiTa"];
            
            NSString *sTotel = [NSString stringWithFormat:@"%.2f",iTotle];
            [billDic setObject:sTotel forKey:@"Totle"];
            
            [billDic setObject:[dic objectForKey:@"CYCLE_ID"] forKey:@"CycleId"];
            [billAllInfoArray addObject:billDic];
            
        }
        if (cycleNum >5) {
            [self drawBillInfoView];
        }
    }else{
        if ([@"1620" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]])//超时
        {
            if(!onlyAlertView.isVisible){
                NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
                onlyAlertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                onlyAlertView.tag = ALERTVIEW_TAG_RETURN+10;
                //[onlyAlertView show];
                httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
               NSString *busiCode = @"HQSM_IntegralQryAcctInfos";
                NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
                [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
                [requestParamData setObject:@"HQSM_IntegralQryAcctInfos" forKey:@"intf_code"];
                [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
            }
        }else
        {
            if(!onlyAlertView.isVisible){
                NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
                onlyAlertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                onlyAlertView.tag = ALERTVIEW_TAG_RETURN+1;
                [onlyAlertView show];
            }
        }
    }
    if(HUD){
        if (cycleNum >=5) {
            [HUD removeHUD];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)requestBean
{
    //弹出提示，并关闭页面，返回上一级
    NSError *error = [requestBean error];
    DebugNSLog(@"----------2---------%@",error);
    NSString *returnMessage = [returnMessageDeal returnMessage:@"" andreturnMessage:@""];
    if(!onlyAlertView.isVisible){
        onlyAlertView= [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        onlyAlertView.tag = ALERTVIEW_TAG_RETURN+2;
        [onlyAlertView show];
    }
    if(HUD){
        [HUD removeHUD];
    }
}

-(void)drawBillInfoView
{
    //初始化月份显示区域
    pressedView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    pressedView.backgroundColor = UIColorFromRGB(rgbValueGreyBg);
    
    titleArray = [DateDeal getYearMonthSixBefore];
    NSMutableArray *arrayTemp1 = [[NSMutableArray alloc]init];
    
    for (int i=0; i<titleArray.count; i++) {
        BOOL isIn = NO;
        for (int j=0; j<billAllInfoArray.count; j++) {
            if ([[[billAllInfoArray objectAtIndex:j]objectForKey:@"CycleId"]isEqualToString:[titleArray objectAtIndex:i]]) {
                isIn = YES;
                break;
            }
        }
        if (isIn) {
            [arrayTemp1 addObject:[titleArray objectAtIndex:i]];
        }
    }
    
    titleArray = arrayTemp1;
    DebugNSLog(@"%@",titleArray);
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i=0; i<titleArray.count; i++) {
        NSString *string = [[titleArray objectAtIndex:i] substringFromIndex:4];
        string = [NSString stringWithFormat:@"%@月",string];
        [array addObject:string];
    }
    
    buttonTitleArray = array;
    if (buttonTitleArray.count ==0) {
        //没有账单
        UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH -40, 60)];
        promptLabel.backgroundColor = [UIColor clearColor];
        promptLabel.textAlignment = NSTextAlignmentCenter;
        promptLabel.text = @"没有查询到相关账单信息！";
        [homeScrollView addSubview:promptLabel];
        
    }else
    {
        buttonId = buttonTitleArray.count-1;
        if (buttonTitleArray.count ==1) {
            //左中右，三个按钮，中间的字体突出
            leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(0, 0, 80, 44);
            leftButton.tag = BUTTON_TAG + 1;
            leftButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:13.0];
            //    leftButton.userInteractionEnabled = NO;//禁止按钮点击
            leftButton.enabled = NO;//禁止按钮点击
            leftButton.titleLabel.textColor = UIColorFromRGB(rgbValue_buttonNameGray);
            leftButton.titleLabel.textAlignment = NSTextAlignmentLeft;
            [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [leftButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [pressedView addSubview:leftButton];
        }else
        {
            //左中右，三个按钮，中间的字体突出
            leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(0, 0, 80, 44);
            leftButton.tag = BUTTON_TAG + 1;
            leftButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:13.0];
            //    leftButton.userInteractionEnabled = NO;//禁止按钮点击
            leftButton.enabled = YES;//禁止按钮点击
            leftButton.titleLabel.textColor = UIColorFromRGB(rgbValue_buttonNameGray);
            leftButton.titleLabel.textAlignment = NSTextAlignmentLeft;
            [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [leftButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [pressedView addSubview:leftButton];
        }
        
        
        centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        centerButton.frame = CGRectMake(90, 0, 140, 44);
        centerButton.tag = BUTTON_TAG + 2;
        centerButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:25.0];
//        centerButton.userInteractionEnabled = NO;//禁止按钮点击
        centerButton.enabled = NO;//禁止按钮点击
        //    centerButton.titleLabel.textColor = [UIColor lightGrayColor];
//        centerButton.titleLabel.textColor = UIColorFromRGB(rgbValueBlue);
        [centerButton setTitleColor:UIColorFromRGB(rgbValueBlue) forState:UIControlStateNormal];
        [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
        //    [centerButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [pressedView addSubview:centerButton];
        
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(240, 0, 80, 44);
        rightButton.tag = BUTTON_TAG + 3;
        rightButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:13.0];
        //    rightButton.userInteractionEnabled = NO;//禁止按钮点击
        rightButton.enabled = NO;//禁止按钮点击
        rightButton.titleLabel.textColor = UIColorFromRGB(rgbValue_buttonNameGray);
        rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        //    [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [pressedView addSubview:rightButton];
        
        [homeScrollView addSubview:pressedView];
        
        DetailScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, pressedView.frame.size.height, SCREEN_WIDTH, 400)];
        DetailScrollView.delegate = self;
        DetailScrollView.showsHorizontalScrollIndicator = NO;//水平
        DetailScrollView.showsVerticalScrollIndicator = NO;//垂直
        DetailScrollView.scrollEnabled = NO;
        DetailScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*buttonTitleArray.count, 300);
        [DetailScrollView setBackgroundColor:[UIColor whiteColor]];
        [DetailScrollView setContentOffset:CGPointMake((buttonId)*SCREEN_WIDTH, 0) animated:YES];
        DetailScrollView.bouncesZoom = NO;
        
        [homeScrollView addSubview:DetailScrollView];
        
        //循环调用6次，每次根据返回判断并设置显示
        for (int k =0; k<billAllInfoArray.count; k++) {
            
            int iSequence = 0;
            
            for (int j = 0; j<titleArray.count; j++) {
                if ([[[billAllInfoArray objectAtIndex:k]objectForKey:@"CycleId"] isEqualToString:[titleArray objectAtIndex:j]]) {
                    iSequence = j;
                }
            }
            
            UIView *billAmountView =  [[UIView alloc]initWithFrame:CGRectMake(0+SCREEN_WIDTH*iSequence, 0, SCREEN_WIDTH, 90)];
            billAmountView.backgroundColor=UIColorFromRGB(rgbValueGreyBg);
            UILabel *billLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 40)];
            billLabel.font = [UIFont fontWithName:appTypeFace size:16.0];
            billLabel.textAlignment = NSTextAlignmentLeft;
            billLabel.textColor=[UIColor lightGrayColor];
            billLabel.text = @"账单总额(元)";
            billLabel.backgroundColor = [UIColor clearColor];
            [billAmountView addSubview:billLabel];
            
            UILabel *billInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 180, 80)];
            billInfoLabel.font = [UIFont fontWithName:appTypeFace size:40.0];
//            billInfoLabel.textAlignment = NSTextAlignmentCenter;
            float f1 = [[[billAllInfoArray objectAtIndex:k] objectForKey:@"Totle"] floatValue];
            float f2 = f1/100;
            billInfoLabel.text = [NSString stringWithFormat:@"%.2f",f2];
            billInfoLabel.textColor = UIColorFromRGB(rgbValueButtonGreen);
            billInfoLabel.backgroundColor = [UIColor clearColor];
            [billAmountView addSubview:billInfoLabel];
            
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, billAmountView.frame.size.height-1, SCREEN_WIDTH, 1)];
            line2.backgroundColor = [UIColor lightGrayColor];
            [billAmountView addSubview:line2];
            
            [DetailScrollView addSubview:billAmountView];
            
            barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(10+SCREEN_WIDTH*iSequence, 10+billAmountView.frame.size.height, SCREEN_WIDTH-20, 30*7)];
            barChart.backgroundColor = [UIColor clearColor];
            barChart.barBackgroundColor =[UIColor clearColor];
            [barChart setXLabelsForHorizontal:@[@"固定套餐",@"语音通话",@"上网流量",@"短彩信",@"增值业务",@"代收",@"其他"]];
            barChart.layer.borderWidth = 0;
            NSMutableArray *arrayTemp = [[NSMutableArray alloc]init];
            [arrayTemp addObject:[[billAllInfoArray objectAtIndex:k] objectForKey:@"TaoCan"]];
            [arrayTemp addObject:[[billAllInfoArray objectAtIndex:k] objectForKey:@"YuYin"]];
            [arrayTemp addObject:[[billAllInfoArray objectAtIndex:k] objectForKey:@"ShangWang"]];
            [arrayTemp addObject:[[billAllInfoArray objectAtIndex:k] objectForKey:@"DuanXin"]];
            [arrayTemp addObject:[[billAllInfoArray objectAtIndex:k] objectForKey:@"ZengZhi"]];
            [arrayTemp addObject:[[billAllInfoArray objectAtIndex:k] objectForKey:@"DaiShou"]];
            [arrayTemp addObject:[[billAllInfoArray objectAtIndex:k] objectForKey:@"QiTa"]];
            
            [barChart setYValuesForHorizontal:arrayTemp];
            barChart.strokeColor = UIColorFromRGB(rgbValue_BillInfoBarBg);
            [barChart strokeChartForHorizontal];
            [DetailScrollView addSubview:barChart];
            
            if(billAllInfoArray.count-1==k){
                UILabel *prom=[[UILabel alloc]initWithFrame:CGRectMake(10+SCREEN_WIDTH*k, barChart.frame.origin.y+210+5, SCREEN_WIDTH-20, 20)];
                prom.text=@"注意：详细数据以月结实际账单为准。";
                prom.textColor=UIColorFromRGB(rgbValueLightGrey);
                prom.font=[UIFont fontWithName:appTypeFace size:14];
                [DetailScrollView addSubview:prom];
            }
        }
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

-(void)rightNavBarButtonPressed:(id) sender
{
    MyMobileServiceYNBillTrendVC *billTrendVC = [[MyMobileServiceYNBillTrendVC alloc]init];
    
    [billTrendVC setCycleArray:titleArray];
    [billTrendVC setBillInfoArray:billAllInfoArray];
//    billTrendVC.cycleArray = buttonTitleArray;
//    billTrendVC.billInfoArray = billAllInfoArray;
    [self.navigationController pushViewController:billTrendVC animated:YES];
}

-(void)buttonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (BUTTON_TAG +1 == button.tag) {//左按钮
        buttonId -= 1;
        
        if (0 ==buttonId) {
            [leftButton setTitle:@"" forState:UIControlStateNormal];
            leftButton.enabled = NO;//禁止按钮点击
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
            [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
            rightButton.enabled = YES;//禁止按钮点击
        }else if ((buttonId >0) &&(buttonId < (buttonTitleArray.count-2))) {
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
            [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
        }else if (buttonTitleArray.count-2 == buttonId) {
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
            [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
            rightButton.enabled = YES;//禁止按钮点击
        }
        [DetailScrollView setContentOffset:CGPointMake((buttonId)*SCREEN_WIDTH, 0) animated:YES];
        
        DetailScrollView.bouncesZoom = NO;
    }
    
    if (BUTTON_TAG +2 == button.tag) {//中按钮
    }
    
    if (BUTTON_TAG +3 == button.tag) {//右按钮
        buttonId += 1;
        if (buttonId == buttonTitleArray.count-1) {
            leftButton.enabled = YES;//禁止按钮点击
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
            [rightButton setTitle:@"" forState:UIControlStateNormal];
            rightButton.enabled = NO;//禁止按钮点击
        }else if ((buttonId >1) &&(buttonId < (buttonTitleArray.count-1))) {
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
            [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
        }else if (1==buttonId) {
            leftButton.enabled = YES;//禁止按钮点击
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
            [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
        }
        [DetailScrollView setContentOffset:CGPointMake((buttonId)*SCREEN_WIDTH, 0) animated:YES];
        
        DetailScrollView.bouncesZoom = NO;
    }
}

//左右滑动手势响应
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    //往左滑
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        DebugNSLog(@"-----left--------");
        //先加载数据，再加载动画特效
        //        [self nextQuestion];
        //        self.view.frame = CGRectMake(320, 0, 320, 480);
        //        [UIViewbeginAnimations:@"animationID"context:nil];
        //        [UIViewsetAnimationDuration:0.3f];
        //        [UIViewsetAnimationCurve:UIViewAnimationCurveEaseInOut];
        //        [UIViewsetAnimationRepeatAutoreverses:NO];
        //        self.view.frame = CGRectMake(0, 0, 320, 480);
        //        [UIViewcommitAnimations];
        if (buttonId<buttonTitleArray.count-1) {
            buttonId += 1;
            if (buttonId == buttonTitleArray.count-1) {
                leftButton.enabled = YES;//禁止按钮点击
                [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
                [rightButton setTitle:@"" forState:UIControlStateNormal];
                rightButton.enabled = NO;//禁止按钮点击
            }else if ((buttonId >1) &&(buttonId < (buttonTitleArray.count-1))) {
                [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
                [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
            }else if (1==buttonId) {
                leftButton.enabled = YES;//禁止按钮点击
                [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
                [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
            }
            [DetailScrollView setContentOffset:CGPointMake((buttonId)*SCREEN_WIDTH, 0) animated:YES];
            
            DetailScrollView.bouncesZoom = NO;
        }
        
    }
    
    //如果往右滑
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        DebugNSLog(@"-----right--------");
        //        [self lastQuestion];
        //        self.view.frame = CGRectMake(-320, 0, 320, 480);
        //        [UIViewbeginAnimations:@"animationID"context:nil];
        //        [UIViewsetAnimationDuration:0.3f];
        //        [UIViewsetAnimationCurve:UIViewAnimationCurveEaseInOut];
        //        [UIViewsetAnimationRepeatAutoreverses:NO];
        //        self.view.frame = CGRectMake(0, 0, 320, 480);
        //        [UIViewcommitAnimations];
        if (buttonId>0) {
            buttonId -= 1;
            if (0 ==buttonId) {
                [leftButton setTitle:@"" forState:UIControlStateNormal];
                leftButton.enabled = NO;//禁止按钮点击
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
                [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
                rightButton.enabled = YES;//禁止按钮点击
            }else if ((buttonId >0) &&(buttonId < (buttonTitleArray.count-2))) {
                [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
                [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
            }else if (buttonTitleArray.count-2 == buttonId) {
                [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateDisabled];
                [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
                rightButton.enabled = YES;//禁止按钮点击
            }
            [DetailScrollView setContentOffset:CGPointMake((buttonId)*SCREEN_WIDTH, 0) animated:YES];
            
            DetailScrollView.bouncesZoom = NO;
        }
        
    }
    
}


@end
