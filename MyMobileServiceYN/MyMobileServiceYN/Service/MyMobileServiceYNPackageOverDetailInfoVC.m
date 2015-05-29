//
//  MyMobileServiceYNPackageOverDetailInfoVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNPackageOverDetailInfoVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNPackageDetailInfo.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNMBProgressHUD.h"
#import "DateDeal.h"
#import "MyMobileServiceYNParam.h"

@interface MyMobileServiceYNPackageOverDetailInfoVC ()

@end

@implementation MyMobileServiceYNPackageOverDetailInfoVC

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
    
    self.title= @"套餐余量";
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    
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
    homeScrollView.scrollEnabled = NO;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [homeScrollView setBackgroundColor:[UIColor whiteColor]];
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

#pragma mark -
#pragma mark ASIHTTPRequestDelegate methods
- (void)requestFinished:(ASIHTTPRequest *)requestBean
{
    NSArray *cookies = [requestBean responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[requestBean responseData];
    DebugNSLog(@"%@",[requestBean responseString]);
    array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        [self dataAnalysis];
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
            
            
            NSMutableString *billCycle=[[NSMutableString alloc]init];
            if ([DateDeal getMonth]<10) {
                [billCycle appendString:[NSString stringWithFormat:@"%ld0%ld",(long)[DateDeal getYear],(long)[DateDeal getMonth]]];
            }else
            {
                [billCycle appendString:[NSString stringWithFormat:@"%ld%ld",(long)[DateDeal getYear],(long)[DateDeal getMonth]]];
            }

            //套餐余量查询
            requestBeanDic=[httpRequest getHttpPostParamData:@"queryUserAmount"];
            [requestBeanDic setObject:billCycle forKey:@"BCYC_ID"];
            [requestBeanDic setObject:@"0" forKey:@"REMOVE_TAG"];
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [httpRequest startAsynchronous:@"queryUserAmount" requestParamData:requestBeanDic viewController:self];
//            [self dataAnalysis];
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
-(void)dataAnalysis{
    //进行数据解析拼组
    //判断是否存在对应的优惠信息
    BOOL isCall = NO;
    BOOL isGrps = NO;
    BOOL isSms = NO;
    BOOL isMsms = NO;
    BOOL isWlan = NO;
    BOOL isWlanM = NO;
    
    NSMutableArray *callArray =[[NSMutableArray alloc]init];
    NSMutableArray *gprsArray =[[NSMutableArray alloc]init];
    NSMutableArray *smsArray =[[NSMutableArray alloc]init];
    NSMutableArray *mSmsArray =[[NSMutableArray alloc]init];
    NSMutableArray *wlanArray =[[NSMutableArray alloc]init];
    NSMutableArray *wlanMArray =[[NSMutableArray alloc]init];
    
    for (int i = 0; i<array.count; i++) {
        NSDictionary *dic1 = [array objectAtIndex:i];
        if ([[dic1 objectForKey:@"ITEM_TYPE"]isEqualToString:@"优惠分钟数（分钟）"]) {
            isCall = YES;
            [callArray addObject:dic1];
        }
        else if ([[dic1 objectForKey:@"ITEM_TYPE"]isEqualToString:@"优惠GPRS流量（M）"]) {
            isGrps = YES;
            [gprsArray addObject:dic1];
        }
        else if ([[dic1 objectForKey:@"ITEM_TYPE"]isEqualToString:@"优惠短信条数（条）"]) {
            isSms = YES;
            [smsArray addObject:dic1];
        }
        else if ([[dic1 objectForKey:@"ITEM_TYPE"]isEqualToString:@"优惠彩信条数（条）"]) {
            isMsms = YES;
            [mSmsArray addObject:dic1];
        }
        else if ([[dic1 objectForKey:@"ITEM_TYPE"]isEqualToString:@"优惠WLAN时长（分钟）"]) {
            isWlan = YES;
            [wlanArray addObject:dic1];
        }
        else if ([[dic1 objectForKey:@"ITEM_TYPE"]isEqualToString:@"优惠WLAN流量（M）"]) {
            isWlanM = YES;
            [wlanMArray addObject:dic1];
        }
    }
    
    buttonTitleArray = [[NSMutableArray alloc]init];
    
    if (isGrps) {
        [buttonTitleArray addObject:@"上网流量"];
    }
    
    if (isCall) {
        [buttonTitleArray addObject:@"语音通话"];
    }
    
    if (isSms) {
        [buttonTitleArray addObject:@"短信"];
    }
    
    if (isMsms) {
        [buttonTitleArray addObject:@"彩信"];
    }
    
    if (isWlan) {
        [buttonTitleArray addObject:@"WLAN(分钟)"];
    }
    
    if (isWlanM) {
        [buttonTitleArray addObject:@"WLAN(M)"];
    }
    
    if (buttonTitleArray.count ==0) {
        //没有账单
        UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH -40, 60)];
        promptLabel.backgroundColor = [UIColor clearColor];
        promptLabel.textAlignment = NSTextAlignmentCenter;
        promptLabel.text = @"没有查询到相关信息！";
        [homeScrollView addSubview:promptLabel];
        
    }else
    {
        UIView *pressedView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        pressedView.backgroundColor = [UIColor clearColor];
        buttonId = 0;
        if (buttonTitleArray.count >0) {
            //左中右，三个按钮，中间的字体突出
            leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(0, 0, 80, 44);
            leftButton.tag = BUTTON_TAG + 1;
            leftButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:13.0];
            //    leftButton.userInteractionEnabled = NO;//禁止按钮点击
            leftButton.enabled = NO;//禁止按钮点击
            leftButton.titleLabel.textColor = [UIColor lightGrayColor];
            leftButton.titleLabel.textAlignment = NSTextAlignmentLeft;
            [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            //    [leftButton setTitle:@"短彩信" forState:UIControlStateNormal];
            [leftButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [pressedView addSubview:leftButton];
            
            centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
            centerButton.frame = CGRectMake(90, 0, 140, 44);
            centerButton.tag = BUTTON_TAG + 2;
            centerButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:25.0];
            centerButton.userInteractionEnabled = NO;//禁止按钮点击
            //    centerButton.enabled = NO;//禁止按钮点击
            //    centerButton.titleLabel.textColor = [UIColor lightGrayColor];
            centerButton.titleLabel.textColor = UIColorFromRGB(rgbValue_buttonNameBlack);
            [centerButton setTitleColor:UIColorFromRGB(rgbValue_buttonNameBlack) forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
            [centerButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [pressedView addSubview:centerButton];
            
            rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
            rightButton.frame = CGRectMake(240, 0, 80, 44);
            rightButton.tag = BUTTON_TAG + 3;
            rightButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:13.0];
            //    rightButton.userInteractionEnabled = NO;//禁止按钮点击
            //    rightButton.enabled = NO;//禁止按钮点击
            rightButton.titleLabel.textColor = [UIColor lightGrayColor];
            leftButton.titleLabel.textAlignment = NSTextAlignmentRight;
            [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            if (buttonTitleArray.count > 1) {
                [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
            }
            else
            {
                rightButton.enabled = YES;//禁止按钮点击
            }
            [rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [pressedView addSubview:rightButton];
            
            [homeScrollView addSubview:pressedView];
            
            DetailScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, pressedView.frame.size.height, SCREEN_WIDTH, homeScrollView.frame.size.height - pressedView.frame.size.height)];
            DetailScrollView.delegate = self;
            DetailScrollView.showsHorizontalScrollIndicator = NO;//水平
            DetailScrollView.showsVerticalScrollIndicator = NO;//垂直
            DetailScrollView.scrollEnabled = NO;
            DetailScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*buttonTitleArray.count, homeScrollView.frame.size.height - pressedView.frame.size.height);
            [DetailScrollView setBackgroundColor:[UIColor whiteColor]];
            
            for (int i=0; i<buttonTitleArray.count;i++) {
                float height = 260;
                NSArray *temp;
                MyMobileServiceYNPackageDetailInfo *gprsDetailInfo=[[MyMobileServiceYNPackageDetailInfo alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
                
                
                if ([[buttonTitleArray objectAtIndex:i] isEqualToString:@"语音通话"]) {
                    height += 80*callArray.count;
                    temp = callArray;
                    [gprsDetailInfo setPackageDetailInfoView:PackageElementsTypeCall andDetailInfo:temp andPage:i];
                }else if ([[buttonTitleArray objectAtIndex:i] isEqualToString:@"上网流量"]) {
                    height += 80*gprsArray.count;
                    temp = gprsArray;
                    [gprsDetailInfo setPackageDetailInfoView:PackageElementsTypeGprs andDetailInfo:temp andPage:i];
                }else if ([[buttonTitleArray objectAtIndex:i] isEqualToString:@"短信"]) {
                    height += 80*smsArray.count;
                    temp = smsArray;
                    [gprsDetailInfo setPackageDetailInfoView:PackageElementsTypeSms andDetailInfo:temp andPage:i];
                }else if ([[buttonTitleArray objectAtIndex:i] isEqualToString:@"彩信"]) {
                    height += 80*mSmsArray.count;
                    temp = mSmsArray;
                    [gprsDetailInfo setPackageDetailInfoView:PackageElementsTypeMsms andDetailInfo:temp andPage:i];
                }else if ([[buttonTitleArray objectAtIndex:i] isEqualToString:@"WLAN(分钟)"]) {
                    height += 80*wlanArray.count;
                    temp = wlanArray;
                    [gprsDetailInfo setPackageDetailInfoView:PackageElementsTypeWlan andDetailInfo:temp andPage:i];
                }else if ([[buttonTitleArray objectAtIndex:i] isEqualToString:@"WLAN(M)"]) {
                    height += 80*wlanMArray.count;
                    temp = wlanMArray;
                    [gprsDetailInfo setPackageDetailInfoView:PackageElementsTypeWlanM andDetailInfo:temp andPage:i];
                }
                
                gprsDetailInfo.frame =CGRectMake(0, 0, SCREEN_WIDTH, height);
                
                DebugNSLog(@"%@",temp);
                
                UIScrollView *scrollViewTemp = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, homeScrollView.frame.size.height - pressedView.frame.size.height)];
                scrollViewTemp.delegate = self;
                scrollViewTemp.showsHorizontalScrollIndicator = NO;//水平
                scrollViewTemp.showsVerticalScrollIndicator = NO;//垂直
                scrollViewTemp.alwaysBounceHorizontal = NO;
                //        scrollViewTemp = NO;
                scrollViewTemp.contentSize = CGSizeMake(0, gprsDetailInfo.frame.size.height);
                [scrollViewTemp setBackgroundColor:[UIColor whiteColor]];
                [scrollViewTemp addSubview:gprsDetailInfo];
                [DetailScrollView addSubview:scrollViewTemp];
            }
            
            [homeScrollView addSubview:DetailScrollView];
        }
        
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

-(void)buttonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (BUTTON_TAG +1 == button.tag) {//左按钮
        DebugNSLog(@"pressed 1");
        buttonId -= 1;
        
        if (0 ==buttonId) {
            [leftButton setTitle:@"" forState:UIControlStateNormal];
            leftButton.enabled = NO;//禁止按钮点击
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
            [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
            rightButton.enabled = YES;//禁止按钮点击
        }else if ((buttonId >0) &&(buttonId < (buttonTitleArray.count-2))) {
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
            [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
        }else if (buttonTitleArray.count-2 == buttonId) {
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
            [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
             rightButton.enabled = YES;//禁止按钮点击
        }
        [DetailScrollView setContentOffset:CGPointMake((buttonId)*SCREEN_WIDTH, 0) animated:YES];
        
        DetailScrollView.bouncesZoom = NO;
        
    }
    
    if (BUTTON_TAG +2 == button.tag) {//中按钮
        DebugNSLog(@"pressed 2");
    }
    
    if (BUTTON_TAG +3 == button.tag) {//右按钮
        buttonId += 1;
        if (buttonId == buttonTitleArray.count-1) {
            leftButton.enabled = YES;//禁止按钮点击
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
            [rightButton setTitle:@"" forState:UIControlStateNormal];
            rightButton.enabled = NO;//禁止按钮点击
        }else if ((buttonId >1) &&(buttonId < (buttonTitleArray.count-1))) {
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
            [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
        }else if (1==buttonId) {
            leftButton.enabled = YES;//禁止按钮点击
            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
            [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
        }
//        else if (buttonTitleArray.count-1 == buttonId ) {
//            [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
//            [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
//            [rightButton setTitle:@"" forState:UIControlStateNormal];
//            rightButton.enabled = NO;//禁止按钮点击
//        }
        
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
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
                [rightButton setTitle:@"" forState:UIControlStateNormal];
                rightButton.enabled = NO;//禁止按钮点击
            }else if ((buttonId >1) &&(buttonId < (buttonTitleArray.count-1))) {
                [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
                [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
            }else if (1==buttonId) {
                leftButton.enabled = YES;//禁止按钮点击
                [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
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
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
                [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
                rightButton.enabled = YES;//禁止按钮点击
            }else if ((buttonId >0) &&(buttonId < (buttonTitleArray.count-2))) {
                [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
                [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
            }else if (buttonTitleArray.count-2 == buttonId) {
                [leftButton setTitle:[buttonTitleArray objectAtIndex:buttonId-1] forState:UIControlStateNormal];
                [centerButton setTitle:[buttonTitleArray objectAtIndex:buttonId] forState:UIControlStateNormal];
                [rightButton setTitle:[buttonTitleArray objectAtIndex:buttonId+1] forState:UIControlStateNormal];
                rightButton.enabled = YES;//禁止按钮点击
            }
            [DetailScrollView setContentOffset:CGPointMake((buttonId)*SCREEN_WIDTH, 0) animated:YES];
            
            DetailScrollView.bouncesZoom = NO;        }
        
    }
    
}

@end
