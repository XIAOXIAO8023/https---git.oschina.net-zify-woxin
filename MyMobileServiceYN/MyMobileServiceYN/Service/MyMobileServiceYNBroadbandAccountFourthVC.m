//
//  MyMobileServiceYNBroadbandAccountFourthVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-4-1.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBroadbandAccountFourthVC.h"
#import "MyMobileServiceYNStepCircleView.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNParam.h"

@interface MyMobileServiceYNBroadbandAccountFourthVC ()

@end

@implementation MyMobileServiceYNBroadbandAccountFourthVC
@synthesize broadBandDic = _broadBandDic;

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
    
    self.title=@"新装宽带";
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    
    
    UIView *firstView=[MyMobileServiceYNStepCircleView setStepView:4 withString:@"确认信息"];
    [self.view addSubview:firstView];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 88, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT-88-64)];
    homeScrollView.delegate = self;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT-88);
    [self.view addSubview:homeScrollView];
    
    UIView *addressView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
    addressView.backgroundColor=[UIColor clearColor];
    [homeScrollView addSubview:addressView];
    
    UILabel *addressNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 77.5, 44)];
    addressNameLabel.backgroundColor = [UIColor clearColor];
    addressNameLabel.text = @"安装地址:";
    addressNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
    addressNameLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
    [addressView addSubview:addressNameLabel];
    
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(87.5, 0, 212.5, 44)];
    address.backgroundColor = [UIColor clearColor];
    address.text = [NSString stringWithFormat:@"%@",[_broadBandDic objectForKey:@"RES_NAME"]];
    address.numberOfLines = 0;
    address.textColor=UIColorFromRGB(rgbValueDeepGrey);
    address.font = [UIFont fontWithName:appTypeFace size:18];
    [addressView addSubview:address];
    CGSize addressLabelSize=[address.text sizeWithFont:address.font constrainedToSize:CGSizeMake(212.5, 100) lineBreakMode:NSLineBreakByCharWrapping];
    if(addressLabelSize.height>25){
        address.frame=CGRectMake(87.5, 0, 212.5, addressLabelSize.height);
        addressView.frame=CGRectMake(0, 10, SCREEN_WIDTH, addressLabelSize.height);
        addressNameLabel.frame=CGRectMake(10, 0, 77.5, 25);
    }
    
    UIView *productView=[[UIView alloc]initWithFrame:CGRectMake(0, addressView.frame.size.height+20, SCREEN_WIDTH, 44)];
    productView.backgroundColor=[UIColor clearColor];
    [homeScrollView addSubview:productView];
    
    UILabel *productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 77.5, 44)];
    productNameLabel.backgroundColor = [UIColor clearColor];
    productNameLabel.text = @"宽带产品:";
    productNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
    productNameLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
    [productView addSubview:productNameLabel];
    
    UILabel *productLabel = [[UILabel alloc]initWithFrame:CGRectMake(87.5, 0, 212.5, 44)];
    productLabel.backgroundColor = [UIColor clearColor];
    productLabel.text = [[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"PRODUCT_NAME"];
    productLabel.font = [UIFont fontWithName:appTypeFace size:18];
    productLabel.numberOfLines = 0;
    productLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [productView addSubview:productLabel];
    CGSize productLabelSize=[productLabel.text sizeWithFont:productLabel.font constrainedToSize:CGSizeMake(212.5, 100) lineBreakMode:NSLineBreakByCharWrapping];
    if(productLabelSize.height>25){
        productLabel.frame=CGRectMake(87.5, 0, 212.5, productLabelSize.height);
        productView.frame=CGRectMake(0, addressView.frame.size.height+20, SCREEN_WIDTH, productLabelSize.height);
        productNameLabel.frame=CGRectMake(10, 0, 77.5, 25);
    }
    
    UILabel *serialNumberNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, productView.frame.origin.y+productView.frame.size.height, 77.5, 44)];
    serialNumberNameLabel.backgroundColor = [UIColor clearColor];
    serialNumberNameLabel.text = @"手机号码:";
    serialNumberNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
    serialNumberNameLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
    [homeScrollView addSubview:serialNumberNameLabel];
    
    UILabel *serialNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(87.5, productView.frame.origin.y+productView.frame.size.height, 212.5, 44)];
    serialNumberLabel.backgroundColor = [UIColor clearColor];
    serialNumberLabel.text = [MyMobileServiceYNParam getSerialNumber];
    serialNumberLabel.font = [UIFont fontWithName:appTypeFace size:20];
    serialNumberLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [homeScrollView addSubview:serialNumberLabel];
    
    UILabel *custNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, serialNumberLabel.frame.size.height+serialNumberLabel.frame.origin.y, 77.5, 44)];
    custNameLabel.backgroundColor = [UIColor clearColor];
    custNameLabel.text = @"客户姓名:";
    custNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
    custNameLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
    [homeScrollView addSubview:custNameLabel];
    
    UILabel *custName = [[UILabel alloc]initWithFrame:CGRectMake(87.5, serialNumberLabel.frame.size.height+serialNumberLabel.frame.origin.y, 212.5, 44)];
    custName.backgroundColor = [UIColor clearColor];
    custName.text = [_broadBandDic objectForKey:@"custName"];
    custName.font = [UIFont fontWithName:appTypeFace size:20];
    custName.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [homeScrollView addSubview:custName];
    
    UILabel *contactPhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, custNameLabel.frame.size.height+custNameLabel.frame.origin.y, 77.5, 44)];
    contactPhoneLabel.backgroundColor = [UIColor clearColor];
    contactPhoneLabel.text = @"联系电话:";
    contactPhoneLabel.font = [UIFont fontWithName:appTypeFace size:15];
    contactPhoneLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
    [homeScrollView addSubview:contactPhoneLabel];
    
    UILabel *contactPhone = [[UILabel alloc]initWithFrame:CGRectMake(87.5, custNameLabel.frame.size.height+custNameLabel.frame.origin.y, 212.5, 44)];
    contactPhone.backgroundColor = [UIColor clearColor];
    contactPhone.text = [_broadBandDic objectForKey:@"contactPhone"];
    contactPhone.font = [UIFont fontWithName:appTypeFace size:20];
    contactPhone.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [homeScrollView addSubview:contactPhone];
    
    UILabel *idNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, contactPhoneLabel.frame.size.height+contactPhoneLabel.frame.origin.y, 77.5, 44)];
    idNameLabel.backgroundColor = [UIColor clearColor];
    idNameLabel.text = @"证件类型:";
    idNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
    idNameLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
    [homeScrollView addSubview:idNameLabel];
    
    UILabel *idName = [[UILabel alloc]initWithFrame:CGRectMake(87.5, contactPhoneLabel.frame.size.height+contactPhoneLabel.frame.origin.y, 212.5, 44)];
    idName.backgroundColor = [UIColor clearColor];
    idName.text = @"身份证";
    idName.font = [UIFont fontWithName:appTypeFace size:20];
    idName.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [homeScrollView addSubview:idName];
    
    UILabel *idNumNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, idName.frame.size.height+idName.frame.origin.y, 77.5, 44)];
    idNumNameLabel.backgroundColor = [UIColor clearColor];
    idNumNameLabel.text = @"证件号码:";
    idNumNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
    idNumNameLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
    [homeScrollView addSubview:idNumNameLabel];
    
    UILabel *idNum = [[UILabel alloc]initWithFrame:CGRectMake(87.5, idName.frame.size.height+idName.frame.origin.y, 212.5, 44)];
    idNum.backgroundColor = [UIColor clearColor];
    idNum.text = [_broadBandDic objectForKey:@"idNumber"];
    idNum.font = [UIFont fontWithName:appTypeFace size:20];
    idNum.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [homeScrollView addSubview:idNum];
    
    [homeScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 44*7+20)];

    UIView *thirdView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-64, SCREEN_WIDTH, 64)];
    thirdView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    [self.view addSubview:thirdView];
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [thirdView addSubview:line];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 10, SCREEN_WIDTH-40, 44);
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont fontWithName:appTypeFace size:25];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image =[self createImageWithColor:UIColorFromRGB(rgbValueTitleBlue)];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:@"确认提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:button];
    [thirdView addSubview:button];
}

//{ "ADDRESS_ID":"5,69,12375646,20981924", "STAND_ADDRESS":"大理巍山县大仓镇大仓基站无线宽带", "PAY_MONEY_CODE":"0", "CAMPN_ID":"2013091901000016", "PRODUCT_ID":"69900073", "PRODUCT_NAME":"宽带开户营销活动测试","PACKAGE_ID":"72900475", "WIDENET_PRODUCT_ID":"72100016", "WIDENET_PACKAGE_ID":"", "WIDENET_PRODUCT_MODE":"", "WIDENET_NET_TYPE":"1", "WIDENET_USER_TYPE":"0", "TRADE_STAFF_ID":"WFKM0262", "TRADE_DEPART_ID":"Z0872", "TRADE_CITY_CODE":"null", "ROUTE_EPARCHY_CODE":"0872"}

/*{
"WIDENET_PRODUCT_MODE" : "00",
"PSPT_ID" : "320114199154698745",
"PACKAGE_ID" : "69900474",
"mobileVersion" : "7.0.4",
"CAMPN_ID" : "2011122811011014",
"version" : "0.8.0",
"SERIAL_NUMBER" : "13887268707",
"WIDENET_PRODUCT_ID" : "69900073",
"STAND_ADDRESS" : "大理市康典佳园住宅小区回南京",
"PRODUCT_ID" : "69900073",
"pattern" : "ios",
"WIDENET_NET_TYPE" : "0",
"CUST_NAME" : "俊雅",
"CONTACT" : "俊雅",
"MODIFY_TAG" : "0",
"WIDENET_USER_TYPE" : "1",
"CONTACT_PHONE" : "13887268707",
"intf_code" : "MobileOpenNewIntf",
"mobileModel" : "iPhone7.0.4",
"autologin" : "0",
"staffid" : "13887268707",
"PSPT_TYPE_CODE" : "1",
"PAY_MONEY_CODE" : "1",
"WIDENET_PACKAGE_ID" : "69900073",
"PRODUCT_NAME" : "TD单模无线网卡营销活动",
"psd" : "ggh"
}*/
-(void)buttonPressed{
    [HUD showTextHUDWithVC:self.navigationController.view];
    
    NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:@"MobileOpenNewIntf"];
    [requestBeanDic setValue:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [requestBeanDic setValue:[_broadBandDic objectForKey:@"custName"] forKey:@"CUST_NAME"];
    [requestBeanDic setValue:@"1" forKey:@"PSPT_TYPE_CODE"];
    [requestBeanDic setValue:[_broadBandDic objectForKey:@"idNumber"] forKey:@"PSPT_ID"];
    [requestBeanDic setValue:[_broadBandDic objectForKey:@"custName"] forKey:@"CONTACT"];
    [requestBeanDic setValue:[MyMobileServiceYNParam getSerialNumber] forKey:@"CONTACT_PHONE"];
    [requestBeanDic setValue:[_broadBandDic objectForKey:@"RES_ID"] forKey:@"ADDRESS_ID"];//只传填写部分（及楼栋单元信息）
    [requestBeanDic setValue:[_broadBandDic objectForKey:@"RES_NAME"] forKey:@"STAND_ADDRESS"];//装机地址
    [requestBeanDic setValue:@"0" forKey:@"PAY_MONEY_CODE"];//支付类型0：现金1：支票2：挂账
    [requestBeanDic setValue:@"02" forKey:@"PAY_TYPE"];//付费类型  01:先付费02：后付费
    //营销活动
    if ([[_broadBandDic objectForKey:@"productType"]isEqualToString:@"2"]) {
        [requestBeanDic setValue:[[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"CAMPN_ID"] forKey:@"CAMPN_ID"];
        [requestBeanDic setValue:[[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"PRODUCT_ID"] forKey:@"PRODUCT_ID"];
        [requestBeanDic setValue:[[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"PRODUCT_NAME"] forKey:@"PRODUCT_NAME"];
        [requestBeanDic setValue:[[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"PACKAGE_ID"] forKey:@"PACKAGE_ID"];
        [requestBeanDic setValue:@"" forKey:@"WIDENET_PRODUCT_ID"];
        [requestBeanDic setValue:@"" forKey:@"WIDENET_PACKAGE_ID"];
        [requestBeanDic setValue:[[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"FEE"] forKey:@"ADVANCED_PAY"];
        [requestBeanDic setValue:[[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"FEE"] forKey:@"MONEY"];
        
    }else //productType = 1
    {
        [requestBeanDic setValue:@"" forKey:@"CAMPN_ID"];
        [requestBeanDic setValue:@"" forKey:@"PRODUCT_ID"];
        [requestBeanDic setValue:@"" forKey:@"PRODUCT_NAME"];
        [requestBeanDic setValue:@"" forKey:@"PACKAGE_ID"];
        [requestBeanDic setValue:[[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"PRODUCT_ID"] forKey:@"WIDENET_PRODUCT_ID"];
        [requestBeanDic setValue:[[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"PRODUCT_ID"] forKey:@"WIDENET_PACKAGE_ID"];
        [requestBeanDic setValue:[[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"FEE"] forKey:@"ADVANCED_PAY"];
        [requestBeanDic setValue:[[_broadBandDic objectForKey:@"productInfo"] objectForKey:@"FEE"] forKey:@"MONEY"];
    }
    [requestBeanDic setValue:@"0" forKey:@"MODIFY_TAG"];
    [requestBeanDic setValue:@"00" forKey:@"WIDENET_PRODUCT_MODE"];
    [requestBeanDic setValue:@"1" forKey:@"WIDENET_NET_TYPE"];//宽带用户类型 0：农村无线宽带1：城市有线宽带2：光宇宽带
    [requestBeanDic setValue:@"0" forKey:@"WIDENET_USER_TYPE"];//网络归属  0：移动1:铁通2：广电
    [requestBeanDic setValue:@"0" forKey:@"FEE"];//安装费用 没有，后付费传0
//    [requestBeanDic setValue:@"0" forKey:@"ADVANCED_PAY"];//营销活动费用 没有，后付费传0
//    [requestBeanDic setValue:@"0" forKey:@"MONEY"];//安装费和活动费用总和 没有，后付费传0
    
    [httpRequest startAsynchronous:@"MobileOpenNewIntf" requestParamData:requestBeanDic viewController:self];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[request responseData];
    DebugNSLog(@"%@",[request responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        NSString *returnMessage = @"新装宽带办理成功!";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG_RETURN+3;
        [alertView show];
        
    }
    else{
        NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG_RETURN+1;
        [alertView show];
    }
    if(HUD){
        [HUD removeHUD];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    DebugNSLog(@"------------requestFailed------------------");
    NSError *error = [request error];
    DebugNSLog(@"----------2---------%@",error);
    NSString *returnMessage = [returnMessageDeal returnMessage:@"网络异常" andreturnMessage:@""];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN+2;
    [alertView show];
    if(HUD){
        [HUD removeHUD];
    }
    
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

#pragma mark  -- AlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    DebugNSLog(@"test buttonIndex:%i",buttonIndex);
    if (ALERTVIEW_TAG_RETURN+3 == alertView.tag)
    {//宽带办理成功，返回首页
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


@end
