//
//  MyMobileServiceYNPackagesServiceDetailVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-28.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNPackagesServiceDetailVC.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNPackagesServiceDetailVC ()

@end

@implementation MyMobileServiceYNPackagesServiceDetailVC

@synthesize productDetail=_productDetail;

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
    self.title = [_productDetail objectForKey:@"BusiName"];
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    packageViewHeight=0;
    packageViewCurrentHeight=0;
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.delegate = self;
    [self.view addSubview:homeScrollView];

    UIView *packageNameView = [[UIView alloc]init];
    packageNameView.backgroundColor = [UIColor clearColor];
    [self setView:packageNameView withTitle:@"套餐名称" withValue:[_productDetail objectForKey:@"BusiName"]];
    packageNameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, packageViewCurrentHeight);
    [homeScrollView addSubview:packageNameView];
    
    UIView *packageBrandView = [[UIView alloc]init];
    packageBrandView.backgroundColor = [UIColor clearColor];
    [self setView:packageBrandView withTitle:@"套餐支持品牌" withValue:[_productDetail objectForKey:@"BusiBrand"]];
    packageBrandView.frame=CGRectMake(0, packageViewHeight-packageViewCurrentHeight, SCREEN_WIDTH, packageViewCurrentHeight);
    [homeScrollView addSubview:packageBrandView];
    
    UIView *packageDescView = [[UIView alloc]init];
    packageDescView.backgroundColor = [UIColor clearColor];
    [self setView:packageDescView withTitle:@"套餐描述" withValue:[_productDetail objectForKey:@"BusiDesc"]];
    packageDescView.frame=CGRectMake(0, packageViewHeight-packageViewCurrentHeight, SCREEN_WIDTH, packageViewCurrentHeight);
    [homeScrollView addSubview:packageDescView];
    
    UIView *packageTakeEffectTypeView = [[UIView alloc]init];
    packageTakeEffectTypeView.backgroundColor = [UIColor clearColor];
    [self setView:packageTakeEffectTypeView withTitle:@"生效方式" withValue:[_productDetail objectForKey:@"BusiTakeEffectType"]];
    packageTakeEffectTypeView.frame=CGRectMake(0, packageViewHeight-packageViewCurrentHeight, SCREEN_WIDTH, packageViewCurrentHeight);
    [homeScrollView addSubview:packageTakeEffectTypeView];
    
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    orderButton.frame = CGRectMake(20, packageViewHeight+20, SCREEN_WIDTH-40, 44);
    orderButton.tag = BUTTON_TAG + 1;
    orderButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:25.0];
    orderButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *buttonImage =[self createImageWithColor:UIColorFromRGB(rgbValueTitleBlue)];
    [orderButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [orderButton setTitle:@"办理" forState:UIControlStateNormal];
    [self setButtonBorder:orderButton];
    [orderButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [homeScrollView addSubview:orderButton];
    
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, packageViewHeight+84);

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

-(void)setView:(UIView *)view withTitle:(NSString *)title withValue:(NSString *)value{
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.font=[UIFont fontWithName:appTypeFace size:18];
    titleLabel.textColor=UIColorFromRGB(rgbValue_packageDetailInfoTotal);
    titleLabel.text=title;
    [view addSubview:titleLabel];
    
    UILabel *valueLabel=[[UILabel alloc]init];
    valueLabel.backgroundColor=[UIColor clearColor];
    valueLabel.font=[UIFont fontWithName:appTypeFace size:16];
    valueLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    valueLabel.text=value;
    valueLabel.numberOfLines=0;
    [view addSubview:valueLabel];
    CGSize size=CGSizeMake(260, 2000);
    UIFont *font=[UIFont fontWithName:appTypeFace size:16];
    CGSize labelSize=[valueLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    valueLabel.frame=CGRectMake(20, 40, SCREEN_WIDTH-40, (NSInteger)labelSize.height+1);
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, (NSInteger)labelSize.height+54, SCREEN_WIDTH, 0.5)];
    line.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [view addSubview:line];
    
    packageViewCurrentHeight=(NSInteger)labelSize.height+55;
    packageViewHeight+=(NSInteger)labelSize.height+55;
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
        if (![[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {
            NSString *message =[NSString stringWithFormat:@"订购%@成功!",[_productDetail objectForKey:@"BusiName"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            [alertView show];
        }
    }else{//接口调用失败
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

-(void)buttonPressed:(id)sender
{
    NSString *message =[NSString stringWithFormat:@"亲，您正在办理%@业务，资费%@，确认办理吗？",[_productDetail objectForKey:@"BusiName"],[_productDetail objectForKey:@"BusiFee"]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
    alertView.tag = ALERTVIEW_TAG+4;
    [alertView show];
}

#pragma mark  -- AlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (ALERTVIEW_TAG + 4 == alertView.tag)//基础业务办理
    {
        if(buttonIndex==1){
            [HUD showTextHUDWithVC:self.navigationController.view];
            busiCode = @"ChangeElement";
            requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            
            if ([[_productDetail allKeys] containsObject:@"BusiServiceId2"]) {//判断是否包含BusiServiceId2字段
                NSArray *idArray = [NSArray arrayWithObjects:[_productDetail objectForKey:@"BusiServiceId"],[_productDetail objectForKey:@"BusiServiceId2"],nil];
                NSArray *codeArray = [NSArray arrayWithObjects:[_productDetail objectForKey:@"BusiElementTypeCode"],@"D",nil];
                NSArray *tagArray = [NSArray arrayWithObjects:@"2",@"0",nil];
                
                [requestBeanDic setObject:codeArray forKey:@"ELEMENT_TYPE_CODE"];
                [requestBeanDic setObject:tagArray forKey:@"MODIFY_TAG"];//订购
                [requestBeanDic setObject:idArray forKey:@"ELEMENT_ID"];
                
            }else{
                [requestBeanDic setObject:[_productDetail objectForKey:@"BusiElementTypeCode"] forKey:@"ELEMENT_TYPE_CODE"];
                [requestBeanDic setObject:@"2" forKey:@"MODIFY_TAG"];//订购
                [requestBeanDic setObject:[_productDetail objectForKey:@"BusiServiceId"] forKey:@"ELEMENT_ID"];
            }
            
            
            
            if ([[_productDetail objectForKey:@"BusiServiceId"] isEqualToString:@"64"]) {//话费余额提醒
                [requestBeanDic setObject:@"interval" forKey:@"ATTR_CODE"];
                [requestBeanDic setObject:@"10" forKey:@"ATTR_VALUE"];
                [requestBeanDic setObject:@"interval" forKey:@"RSRV_STR1"];
                [requestBeanDic setObject:@"10" forKey:@"RSRV_STR2"];
                
            }
            
            [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
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

@end
