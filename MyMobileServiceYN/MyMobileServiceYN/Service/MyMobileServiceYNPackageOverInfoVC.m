//
//  MyMobileServiceYNPackageOverInfoVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNPackageOverInfoVC.h"
#import "GlobalDef.h"
#import "PNChart.h"
#import "MyMobileServiceYNOverInfo.h"
#import "MyMobileServiceYNPackageOverDetailInfoVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "DateDeal.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNOrderGprsVC.h"
#import "MyMobileServiceYNPackageOverDetailInfoVC.h"
#import "DialogInfo.h"

@interface MyMobileServiceYNPackageOverInfoVC ()

@end

@implementation MyMobileServiceYNPackageOverInfoVC

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
    self.title= @"套餐汇总";
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    
//    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
//    homeScrollView.delegate = self;
//    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
//    [homeScrollView setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:homeScrollView];
    
    homeTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20) style:UITableViewStylePlain];
    homeTableView.delegate=self;
    homeTableView.dataSource=self;
    //判断当前ios版本是否小于5.0 小于5.0只需要设置背景为空白，大于等于5.0需要同时设置view为空
    if ( [[UIDevice currentDevice].systemVersion floatValue] < 5.0){
        
        homeTableView.backgroundColor=[UIColor clearColor];
    }
    else{
        // use this mehod on ios6
        homeTableView.backgroundColor=[UIColor clearColor];
        homeTableView.backgroundView = nil;
    }
    [self.view addSubview:homeTableView];
    
    //开始获取用户信息
    [HUD showTextHUDWithVC:self.navigationController.view];
    
    //套餐余量查询
    requestBeanDic=[httpRequest getHttpPostParamData:@"queryUserAmount"];
    [requestBeanDic setObject:[DateDeal getYearMonthNow] forKey:@"BCYC_ID"];
    [requestBeanDic setObject:@"0" forKey:@"REMOVE_TAG"];
    [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [httpRequest startAsynchronous:@"queryUserAmount" requestParamData:requestBeanDic viewController:self];
    

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
    NSArray *cookies = [requestBean responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[requestBean responseData];
    DebugNSLog(@"%@",[requestBean responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
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
        
        totleArray = [[NSMutableArray alloc]init];
        
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
        
        if (isGrps) {
            NSString *balance = @"";
            NSString *highFee = @"";
            NSString *value = @"";
            for (int i = 0; i<gprsArray.count; i++) {
                NSDictionary *dic = [gprsArray objectAtIndex:i];
                long long j = [balance longLongValue];
                j += [[dic objectForKey:@"BALANCE"] longLongValue];
                balance = [NSString stringWithFormat:@"%lld",j];
                
                long long k = [highFee longLongValue];
                k += [[dic objectForKey:@"HIGH_FEE"] longLongValue];
                highFee = [NSString stringWithFormat:@"%lld",k];
                
                long long l = [value longLongValue];
                l += [[dic objectForKey:@"VALUE"] longLongValue];
                value = [NSString stringWithFormat:@"%lld",l];
                
            }
            
            long long k = [highFee longLongValue];
            k = (k/1024)/1024;
            highFee = [NSString stringWithFormat:@"%lld",k];
            
            long long l = [value longLongValue];
            l = (l/1024)/1024;
            value = [NSString stringWithFormat:@"%lld",l];
            
            long long j = k - l;
            balance = [NSString stringWithFormat:@"%lld",j];
            
            NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
            [mdic setObject:balance forKey:@"BALANCE"];
            [mdic setObject:highFee forKey:@"HIGH_FEE"];
            [mdic setObject:value forKey:@"VALUE"];
            [mdic setObject:@"gprs" forKey:@"TYPE"];
            
            [totleArray addObject:mdic];
        }
        
        if (isCall) {
            NSString *balance = @"";
            NSString *highFee = @"";
            NSString *value = @"";
            for (int i = 0; i<callArray.count; i++) {
                NSDictionary *dic = [callArray objectAtIndex:i];
                NSInteger j = [balance integerValue];
                j += [[dic objectForKey:@"BALANCE"] integerValue];
                balance = [NSString stringWithFormat:@"%d",j];
                
                NSInteger k = [highFee integerValue];
                k += [[dic objectForKey:@"HIGH_FEE"] integerValue];
                highFee = [NSString stringWithFormat:@"%d",k];
                
                NSInteger l = [value integerValue];
                l += [[dic objectForKey:@"VALUE"] integerValue];
                value = [NSString stringWithFormat:@"%d",l];
            }
            NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
            [mdic setObject:balance forKey:@"BALANCE"];
            [mdic setObject:highFee forKey:@"HIGH_FEE"];
            [mdic setObject:value forKey:@"VALUE"];
            [mdic setObject:@"call" forKey:@"TYPE"];
            
            [totleArray addObject:mdic];
        }
        
        if (isSms) {
            NSString *balance = @"";
            NSString *highFee = @"";
            NSString *value = @"";
            for (int i = 0; i<smsArray.count; i++) {
                NSDictionary *dic = [smsArray objectAtIndex:i];
                NSInteger j = [balance integerValue];
                j += [[dic objectForKey:@"BALANCE"] integerValue];
                balance = [NSString stringWithFormat:@"%d",j];
                
                NSInteger k = [highFee integerValue];
                k += [[dic objectForKey:@"HIGH_FEE"] integerValue];
                highFee = [NSString stringWithFormat:@"%d",k];
                
                NSInteger l = [value integerValue];
                l += [[dic objectForKey:@"VALUE"] integerValue];
                value = [NSString stringWithFormat:@"%d",l];
            }
            NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
            [mdic setObject:balance forKey:@"BALANCE"];
            [mdic setObject:highFee forKey:@"HIGH_FEE"];
            [mdic setObject:value forKey:@"VALUE"];
            [mdic setObject:@"sms" forKey:@"TYPE"];
            
            [totleArray addObject:mdic];
        }
        
        if (isMsms) {
            NSString *balance = @"";
            NSString *highFee = @"";
            NSString *value = @"";
            for (int i = 0; i<mSmsArray.count; i++) {
                NSDictionary *dic = [mSmsArray objectAtIndex:i];
                NSInteger j = [balance integerValue];
                j += [[dic objectForKey:@"BALANCE"] integerValue];
                balance = [NSString stringWithFormat:@"%d",j];
                
                NSInteger k = [highFee integerValue];
                k += [[dic objectForKey:@"HIGH_FEE"] integerValue];
                highFee = [NSString stringWithFormat:@"%d",k];
                
                NSInteger l = [value integerValue];
                l += [[dic objectForKey:@"VALUE"] integerValue];
                value = [NSString stringWithFormat:@"%d",l];
            }
            NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
            [mdic setObject:balance forKey:@"BALANCE"];
            [mdic setObject:highFee forKey:@"HIGH_FEE"];
            [mdic setObject:value forKey:@"VALUE"];
            [mdic setObject:@"msms" forKey:@"TYPE"];
            
            [totleArray addObject:mdic];
        }
        
        if (isWlan) {
            NSString *balance = @"";
            NSString *highFee = @"";
            NSString *value = @"";
            for (int i = 0; i<wlanArray.count; i++) {
                NSDictionary *dic = [wlanArray objectAtIndex:i];
                NSInteger j = [balance integerValue];
                j += [[dic objectForKey:@"BALANCE"] integerValue];
                balance = [NSString stringWithFormat:@"%d",j];
                
                NSInteger k = [highFee integerValue];
                k += [[dic objectForKey:@"HIGH_FEE"] integerValue];
                highFee = [NSString stringWithFormat:@"%d",k];
                
                NSInteger l = [value integerValue];
                l += [[dic objectForKey:@"VALUE"] integerValue];
                value = [NSString stringWithFormat:@"%d",l];
            }
            NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
            [mdic setObject:balance forKey:@"BALANCE"];
            [mdic setObject:highFee forKey:@"HIGH_FEE"];
            [mdic setObject:value forKey:@"VALUE"];
            [mdic setObject:@"wlan" forKey:@"TYPE"];
            
            [totleArray addObject:mdic];
        }
        
        if (isWlanM) {
            NSString *balance = @"";
            NSString *highFee = @"";
            NSString *value = @"";
            for (int i = 0; i<wlanMArray.count; i++) {
                NSDictionary *dic = [wlanMArray objectAtIndex:i];
                long long j = [balance longLongValue];
                j += [[dic objectForKey:@"BALANCE"] longLongValue];
                balance = [NSString stringWithFormat:@"%lld",j];
                
                long long k = [highFee longLongValue];
                k += [[dic objectForKey:@"HIGH_FEE"] longLongValue];
                highFee = [NSString stringWithFormat:@"%lld",k];
                
                long long l = [value longLongValue];
                l += [[dic objectForKey:@"VALUE"] longLongValue];
                value = [NSString stringWithFormat:@"%lld",l];
                
            }
            
            long long k = [highFee longLongValue];
            k = (k/1024)/1024;
            highFee = [NSString stringWithFormat:@"%lld",k];
            
            long long l = [value longLongValue];
            l = (l/1024)/1024;
            value = [NSString stringWithFormat:@"%lld",l];
            
            long long j = k - l;
            balance = [NSString stringWithFormat:@"%lld",j];
            
            NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
            [mdic setObject:balance forKey:@"BALANCE"];
            [mdic setObject:highFee forKey:@"HIGH_FEE"];
            [mdic setObject:value forKey:@"VALUE"];
            [mdic setObject:@"wlanM" forKey:@"TYPE"];
            
            [totleArray addObject:mdic];
        }
        
        
//        UIView *feeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
//        feeView.backgroundColor = UIColorFromRGB(rgbValue_feeBg);
//        
//        UIView *feeView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 80)];
//        //当月话费和话费余额
//        UILabel *monthFeeNameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH/2, 20)];
//        monthFeeNameLable.textAlignment = NSTextAlignmentCenter;
//        monthFeeNameLable.backgroundColor = [UIColor clearColor];
//        monthFeeNameLable.textColor = [UIColor lightGrayColor];
//        monthFeeNameLable.text = @"当月话费(元)";
//        monthFeeNameLable.font = [UIFont fontWithName:appTypeFace size:15.0];
//        [feeView1 addSubview:monthFeeNameLable];
//        UILabel *totalLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH/2, 40)];
//        totalLable.textAlignment = NSTextAlignmentCenter;
//        totalLable.backgroundColor = [UIColor clearColor];
//        totalLable.textColor = [UIColor lightGrayColor];
//        totalLable.text = @"2888.00";
//        totalLable.font = [UIFont fontWithName:appTypeFace size:28.0];
//        [feeView1 addSubview:totalLable];
//        [feeView addSubview:feeView1];
//        
//        
//        UIView *feeView2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 80)];
//        UILabel *useNameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH/2, 20)];
//        useNameLable.textAlignment = NSTextAlignmentCenter;
//        useNameLable.backgroundColor = [UIColor clearColor];
//        useNameLable.textColor = [UIColor lightGrayColor];
//        useNameLable.text = @"话费余额(元)";
//        useNameLable.font = [UIFont fontWithName:appTypeFace size:15.0];
//        [feeView2 addSubview:useNameLable];
//        UILabel *useLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH/2, 40)];
//        useLable.textAlignment = NSTextAlignmentCenter;
//        useLable.backgroundColor = [UIColor clearColor];
//        useLable.textColor = [UIColor lightGrayColor];
//        useLable.text = @"1888.00";
//        useLable.font = [UIFont fontWithName:appTypeFace size:28.0];
//        [feeView2 addSubview:useLable];
//        [feeView addSubview:feeView2];
//        [homeScrollView addSubview: feeView];
        
        
        
        if (totleArray.count<=0) {
            //没有账单
            UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH -40, 60)];
            promptLabel.backgroundColor = [UIColor clearColor];
            promptLabel.textAlignment = NSTextAlignmentCenter;
            promptLabel.text = @"没有查询到相关信息！";
            [homeScrollView addSubview:promptLabel];
        }
//        else
//        {
//            UIButton *overInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            overInfoButton.frame = CGRectMake(20, 20+overInfoView.frame.size.height, SCREEN_WIDTH -40, 44);
//            overInfoButton.backgroundColor = [UIColor redColor];
//            overInfoButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:25.0];
//            overInfoButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//            [overInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            UIImage *image =[self createImageWithColor:UIColorFromRGB(rgbValueButtonGreen)];
//            [overInfoButton setBackgroundImage:image forState:UIControlStateNormal];
//            [overInfoButton setTitle:@"查看套餐余量详情" forState:UIControlStateNormal];
//            [overInfoButton addTarget:self action:@selector(overInfoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [homeScrollView addSubview:overInfoButton];
//            
//            homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 20+overInfoView.frame.size.height+overInfoButton.frame.size.height +20);
//        }
        [homeTableView reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return totleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSInteger i=[indexPath section];
    
    UIView *cellBackView = [[UIView alloc] init];
    cellBackView.backgroundColor = [UIColor whiteColor];
    [cell setBackgroundView:cellBackView];
    
    UIView *lineUp=[[UIView alloc]initWithFrame:CGRectMake((cell.frame.size.width-SCREEN_WIDTH)/2, 0, SCREEN_WIDTH, 0.5)];
    lineUp.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_line);
    [cell.contentView addSubview:lineUp];
    
    MyMobileServiceYNOverInfo *gprsOverInfo = [[MyMobileServiceYNOverInfo alloc]initWithFrame:CGRectMake((cell.frame.size.width-SCREEN_WIDTH), 0.5, SCREEN_WIDTH, 120)];
    gprsOverInfo.backgroundColor = [UIColor whiteColor];
    if ([[[totleArray objectAtIndex:i] objectForKey:@"TYPE"] isEqualToString:@"call"]) {
        [gprsOverInfo setOverInfoView:PackageElementsTypeCall andTotal:[[[totleArray objectAtIndex:i] objectForKey:@"HIGH_FEE"] integerValue] andCurrent:[[[totleArray objectAtIndex:i] objectForKey:@"VALUE"] integerValue] ];
    }else if ([[[totleArray objectAtIndex:i] objectForKey:@"TYPE"] isEqualToString:@"gprs"]) {
        [gprsOverInfo setOverInfoView:PackageElementsTypeGprs andTotal:[[[totleArray objectAtIndex:i] objectForKey:@"HIGH_FEE"] integerValue] andCurrent:[[[totleArray objectAtIndex:i] objectForKey:@"VALUE"] integerValue] ];
    }else if ([[[totleArray objectAtIndex:i] objectForKey:@"TYPE"] isEqualToString:@"sms"]) {
        [gprsOverInfo setOverInfoView:PackageElementsTypeSms andTotal:[[[totleArray objectAtIndex:i] objectForKey:@"HIGH_FEE"] integerValue] andCurrent:[[[totleArray objectAtIndex:i] objectForKey:@"VALUE"] integerValue] ];
    }else if ([[[totleArray objectAtIndex:i] objectForKey:@"TYPE"] isEqualToString:@"msms"]) {
        [gprsOverInfo setOverInfoView:PackageElementsTypeMsms andTotal:[[[totleArray objectAtIndex:i] objectForKey:@"HIGH_FEE"] integerValue] andCurrent:[[[totleArray objectAtIndex:i] objectForKey:@"VALUE"] integerValue] ];
    }else if ([[[totleArray objectAtIndex:i] objectForKey:@"TYPE"] isEqualToString:@"wlan"]) {
        [gprsOverInfo setOverInfoView:PackageElementsTypeWlan andTotal:[[[totleArray objectAtIndex:i] objectForKey:@"HIGH_FEE"] integerValue] andCurrent:[[[totleArray objectAtIndex:i] objectForKey:@"VALUE"] integerValue] ];
    }else if ([[[totleArray objectAtIndex:i] objectForKey:@"TYPE"] isEqualToString:@"wlanM"]) {
        [gprsOverInfo setOverInfoView:PackageElementsTypeWlanM andTotal:[[[totleArray objectAtIndex:i] objectForKey:@"HIGH_FEE"] integerValue] andCurrent:[[[totleArray objectAtIndex:i] objectForKey:@"VALUE"] integerValue] ];
    }
    [cell.contentView addSubview:gprsOverInfo];
    
    UIView *lineDown=[[UIView alloc]initWithFrame:CGRectMake((cell.frame.size.width-SCREEN_WIDTH), 119.5, SCREEN_WIDTH, 0.5)];
    lineDown.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_line);
    [cell.contentView addSubview:lineDown];
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
//    cell.contentView.backgroundColor= [UIColor whiteColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    MyMobileServiceYNPackageOverDetailInfoVC *packageOverDetailInfoVC=[[MyMobileServiceYNPackageOverDetailInfoVC alloc]init];
    [self.navigationController pushViewController:packageOverDetailInfoVC animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    headerView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    
    UILabel *headerLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 40)];
    headerLabel.backgroundColor = [UIColor clearColor];
    if ([[[totleArray objectAtIndex:section] objectForKey:@"TYPE"] isEqualToString:@"call"]) {
        headerLabel.text=@"语音通话";
    }else if ([[[totleArray objectAtIndex:section] objectForKey:@"TYPE"] isEqualToString:@"gprs"]) {
        headerLabel.text=@"上网流量";
        
        UIButton *gprsButton=[[UIButton alloc]initWithFrame:CGRectMake(190, 0, 120, 40)];
        gprsButton.backgroundColor=[UIColor clearColor];
        [gprsButton setTitle:@"逛逛流量加油站>>" forState:UIControlStateNormal];
        [gprsButton setTitleColor:UIColorFromRGB(rgbValue_overInfoOrange) forState:UIControlStateNormal];
        gprsButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:14];
        [gprsButton addTarget:self action:@selector(toGprsInfoVC) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:gprsButton];
    }else if ([[[totleArray objectAtIndex:section] objectForKey:@"TYPE"] isEqualToString:@"sms"]) {
        headerLabel.text=@"短信";
    }else if ([[[totleArray objectAtIndex:section] objectForKey:@"TYPE"] isEqualToString:@"msms"]) {
        headerLabel.text=@"彩信";
    }else if ([[[totleArray objectAtIndex:section] objectForKey:@"TYPE"] isEqualToString:@"wlan"]) {
        headerLabel.text=@"WLAN(分钟)";
    }else if ([[[totleArray objectAtIndex:section] objectForKey:@"TYPE"] isEqualToString:@"wlanM"]) {
        headerLabel.text=@"WLAN(M)";
    }
    headerLabel.textColor=UIColorFromRGB(rgbValue_packageInfo_headerLabel);
    headerLabel.font=[UIFont fontWithName:appTypeFace size:18];
    [headerView addSubview:headerLabel];
    
    return headerView;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.5)];
    footerView.backgroundColor=[UIColor clearColor];
    
    return footerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [httpRequest setRequestDelegatNil];
}

-(void)toGprsInfoVC{
    if ([MyMobileServiceYNParam getIsDynamicPW]) {//如果是动态密码登录，不允许使用，提示用户重新登录
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info_other delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG;
        [alertView show];
    }else
    {
        MyMobileServiceYNOrderGprsVC *orderGprsVC=[[MyMobileServiceYNOrderGprsVC alloc]init];
        [self.navigationController pushViewController:orderGprsVC animated:YES];
    }
}

-(void)overInfoButton:(id)sender
{
    MyMobileServiceYNPackageOverDetailInfoVC *detailInfoVC = [[MyMobileServiceYNPackageOverDetailInfoVC alloc]init];
    [self.navigationController pushViewController:detailInfoVC animated:YES];
}

@end
