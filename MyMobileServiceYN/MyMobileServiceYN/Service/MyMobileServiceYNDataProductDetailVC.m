//
//  MyMobileServiceYNDataProductDetailVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-21.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNDataProductDetailVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNParam.h"

@interface MyMobileServiceYNDataProductDetailVC ()

@end

@implementation MyMobileServiceYNDataProductDetailVC
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
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.delegate = self;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [self.view addSubview:homeScrollView];
    
    [HUD showTextHUDWithVC:self.navigationController.view];
    
    if ([[_productDetail objectForKey:@"SelectItem"] isEqualToString:@"BaseProductList"]) {//基础业务查询
        busiCode = @"GetProductInfo";
        isOrder = NO;
        requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
        [requestBeanDic setObject:@"S" forKey:@"ELEMENT_TYPE_CODE"];
        [requestBeanDic setObject:@"00" forKey:@"PRODUCT_MODE"];
        [requestBeanDic setObject:@"" forKey:@"GET_MODE"];
        [requestBeanDic setObject:[_productDetail objectForKey:@"BusiServiceId"] forKey:@"ELEMENT_ID"];
        [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
    }else//梦网查询
    {
        busiCode = @"dreamNetIncreQuery";
        isOrder = NO;
        requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
        [requestBeanDic setObject:@"00" forKey:@"DEAL_TAG"];
        [requestBeanDic setObject:@"0" forKey:@"REMOVE_TAG"];
//        [requestBeanDic setObject:@"1" forKey:@"TAG_CHAR"];
        [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
    }
    
    //设置业务介绍区域,并设定初始区域
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    detailView.backgroundColor = [UIColor clearColor];
    [homeScrollView addSubview:detailView];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[_productDetail objectForKey:@"BusiLogoName"]]];
    logoImageView.frame = CGRectMake(140, 10, 40, 40);
    [detailView addSubview:logoImageView];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH-20, 170)];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor = UIColorFromRGB(rgbValueDeepGrey);
    detailLabel.numberOfLines = 0;//多行
    detailLabel.text = [_productDetail objectForKey:@"BusiDesc"];
    [detailView addSubview:detailLabel];
    
//    UILabel *importantNoticelabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];//必须是这组值,这个frame是初设的，没关系，后面还会重新设置其size。
//    [importantNoticelabel setNumberOfLines:0];  //必须是这组值
//    NSMutableString *sImportantNotice = [[NSMutableString alloc]initWithFormat:@"重要提示:"];
//    [sImportantNotice appendString:[_giftDetailInfoDict objectForKey:@"importantDesc"]];
//    CGSize size = CGSizeMake(300,2000);
//    UIFont *font = [UIFont systemFontOfSize:12];
//    CGSize labelsize = [sImportantNotice sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//    importantNoticelabel.frame = CGRectMake(10, 50+valueView.frame.size.height+10+userValueName.frame.size.height+cityView.frame.size.height+gradeView.frame.size.height, labelsize.width, labelsize.height );
//    importantNoticelabel.backgroundColor = [UIColor clearColor];
//    importantNoticelabel.textColor = COLOR_JFMALL_GIFTDETAIL_GIFTINFO_TEXTCOLOR;
//    importantNoticelabel.text = sImportantNotice;
//    importantNoticelabel.font = font;
//    [_giftInfoView addSubview:importantNoticelabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 239, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [detailView addSubview:line];
    
    
    UILabel *feeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, detailView.frame.size.height+10, SCREEN_WIDTH-40, 30)];
    feeLabel.backgroundColor = [UIColor clearColor];
    feeLabel.textColor = UIColorFromRGB(rgbValueDeepGrey);
    feeLabel.numberOfLines = 1;
    feeLabel.textAlignment = NSTextAlignmentLeft;
    feeLabel.text = [NSString stringWithFormat:@"资费：%@",[_productDetail objectForKey:@"BusiFee"]];
    [homeScrollView addSubview:feeLabel];
    
    UILabel *orderStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, detailView.frame.size.height+10+feeLabel.frame.size.height, SCREEN_WIDTH-40, 30)];
    orderStatusLabel.tag = LABEL_TAG + 1;
    orderStatusLabel.backgroundColor = [UIColor clearColor];
    orderStatusLabel.textColor = UIColorFromRGB(rgbValueDeepGrey);
    orderStatusLabel.numberOfLines = 1;
    orderStatusLabel.textAlignment = NSTextAlignmentLeft;
//    orderStatusLabel.text = [NSString stringWithFormat:@"订购状态："];
    orderStatusLabel.text = [NSString stringWithFormat:@"订购状态：%@",@"未订购"];
    [homeScrollView addSubview:orderStatusLabel];
    
    UILabel *orderIndexLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, detailView.frame.size.height+10+feeLabel.frame.size.height+orderStatusLabel.frame.size.height, 90, 30)];
    orderIndexLabel.backgroundColor = [UIColor clearColor];
    orderIndexLabel.textColor = UIColorFromRGB(rgbValueDeepGrey);
    orderIndexLabel.numberOfLines = 1;
    orderIndexLabel.textAlignment = NSTextAlignmentLeft;
    orderIndexLabel.text = [NSString stringWithFormat:@"办理指数："];
    [homeScrollView addSubview:orderIndexLabel];
    
    UIView *levelView=[[UIView alloc]initWithFrame:CGRectMake(110, detailView.frame.size.height+10+feeLabel.frame.size.height+orderStatusLabel.frame.size.height, 190, 30)];
    levelView.backgroundColor=[UIColor clearColor];
    [homeScrollView addSubview:levelView];
    
    if([[_productDetail objectForKey:@"level"] isEqualToString:@"true"]){
        for(int i=0;i<5;i++){
            UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(20*i, 5, 20, 20)];
            [star setImage:[UIImage imageNamed: @"star_full.png"]];
            [levelView addSubview:star];
        }
    }else{
        for(int i=0;i<5;i++){
            if(i<4){
                UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(i*20, 5, 20, 20)];
                [star setImage:[UIImage imageNamed: @"star_full.png"]];
                [levelView addSubview:star];
            }else{
                UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(20*i, 5, 20, 20)];
                [star setImage:[UIImage imageNamed: @"star_empty.png"]];
                [levelView addSubview:star];
            }
            
        }
    }
    
    
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    orderButton.frame = CGRectMake(20, detailView.frame.size.height+10+feeLabel.frame.size.height+orderStatusLabel.frame.size.height + orderIndexLabel.frame.size.height + 20, SCREEN_WIDTH-40, 44);
    orderButton.tag = BUTTON_TAG + 1;
    orderButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:25.0];
    orderButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *buttonImage =[self createImageWithColor:UIColorFromRGB(rgbValueButtonGreen)];
    [orderButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [orderButton setTitle:@"办理" forState:UIControlStateNormal];
    [self setButtonBorder:orderButton];
    [orderButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [homeScrollView addSubview:orderButton];
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
        if ([busiCode isEqualToString:@"dreamNetIncreQuery"]) {//梦网查询
            if (![[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {
                for (int i=0; i<array.count; i++) {
                    NSDictionary *dict = [array objectAtIndex:i];
                    if ([[_productDetail objectForKey:@"BusiServiceId"] isEqualToString:[dict objectForKey:@"SERVICE_ID"]]) {
                        isOrder = YES;
                        UILabel *label = (UILabel *)[self.view viewWithTag:LABEL_TAG + 1];
                        label.text = [NSString stringWithFormat:@"订购状态：%@",@"已订购"];
                        
                        UIButton *button = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 1];
                        [button setTitle:@"退订" forState:UIControlStateNormal];
                        
                        if ([[dict objectForKey:@"SERVICE_ID"] isEqualToString:@"98002301"]) {//飞信不支持退订
                            button.enabled = NO;
                            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, 0, 0);
                        }
                        
                        break;
                    }
                }
            }else
            {
                //返回正确，但是无数据
            }
        }
        else if([busiCode isEqualToString:@"GetProductInfo"])//基础业务查询
        {
            if (![[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {
                if ([[dic objectForKey:@"X_EXISTFLAG"] isEqualToString:@"1"]) {//已订购
                    isOrder = YES;
                    UILabel *label = (UILabel *)[self.view viewWithTag:LABEL_TAG + 1];
                    label.text = [NSString stringWithFormat:@"订购状态：%@",@"已订购"];
                    
                    UIButton *button = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 1];
                    [button setTitle:@"退订" forState:UIControlStateNormal];
                }
            }
        }
        else//dreamNetIncreUnsubscribe 梦网退订或者订购
        {
            if (![[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {

                if (isOrder) {//已订购，则接受到取消订购的返回
                    isOrder = NO;
                    UILabel *label = (UILabel *)[self.view viewWithTag:LABEL_TAG + 1];
                    label.text = [NSString stringWithFormat:@"订购状态：%@",@"未订购"];
                    
                    UIButton *button = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 1];
                    [button setTitle:@"订购" forState:UIControlStateNormal];
                    
                    NSString *message =[NSString stringWithFormat:@"退订%@成功!",[_productDetail objectForKey:@"BusiName"]];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    [alertView show];

                }else
                {
                    isOrder = YES;
                    UILabel *label = (UILabel *)[self.view viewWithTag:LABEL_TAG + 1];
                    label.text = [NSString stringWithFormat:@"订购状态：%@",@"已订购"];
                    
                    UIButton *button = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 1];
                    [button setTitle:@"退订" forState:UIControlStateNormal];
                    
                    NSString *message =[NSString stringWithFormat:@"订购%@成功!",[_productDetail objectForKey:@"BusiName"]];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    [alertView show];

                }
            }

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
    if (isOrder) {//退订
        if ([[_productDetail objectForKey:@"SelectItem"] isEqualToString:@"BaseProductList"]) {
            NSString *message =[NSString stringWithFormat:@"亲，您正在退订%@业务，资费%@，确认办理吗？",[_productDetail objectForKey:@"BusiName"],[_productDetail objectForKey:@"BusiFee"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG+3;
            [alertView show];
        }else
        {
            NSString *message =[NSString stringWithFormat:@"亲，您正在退订%@业务，资费%@，确认办理吗？",[_productDetail objectForKey:@"BusiName"],[_productDetail objectForKey:@"BusiFee"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG+1;
            [alertView show];
        }
    }else//办理
    {
        if ([[_productDetail objectForKey:@"SelectItem"] isEqualToString:@"BaseProductList"]) {
            NSString *message =[NSString stringWithFormat:@"亲，您正在办理%@业务，资费%@，确认办理吗？",[_productDetail objectForKey:@"BusiName"],[_productDetail objectForKey:@"BusiFee"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG+4;
            [alertView show];
        }else
        {
            NSString *message =[NSString stringWithFormat:@"亲，您正在办理%@业务，资费%@，确认办理吗？",[_productDetail objectForKey:@"BusiName"],[_productDetail objectForKey:@"BusiFee"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG+2;
            [alertView show];
        }
    }
    
}

#pragma mark  -- AlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    DebugNSLog(@"test buttonIndex:%i",buttonIndex);
    if (ALERTVIEW_TAG + 1 == alertView.tag)
    {//退订
        if (buttonIndex == 1) {
            [HUD showTextHUDWithVC:self.navigationController.view];
            //梦网查询
            busiCode = @"dreamNetIncreUnsubscribe";
            
            requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiElementTypeCode"] forKey:@"SERVICE_TYPE"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiServiceId"] forKey:@"SERVICE_ID"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiBizTypeCode"] forKey:@"BIZ_TYPE_CODE"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiSpCode"] forKey:@"SP_CODE"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiBizCode"]forKey:@"BIZ_CODE"];
            [requestBeanDic setObject:@"07" forKey:@"OPER_CODE"];//服务订购取消
            [requestBeanDic setObject:@"02" forKey:@"OPR_SOURCE"];
            [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
        }
    }
    else if (ALERTVIEW_TAG + 2 == alertView.tag)
    {//办理
        if (buttonIndex == 1) {
            [HUD showTextHUDWithVC:self.navigationController.view];
            //梦网查询
            busiCode = @"dreamNetIncreUnsubscribe";
            requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiElementTypeCode"] forKey:@"SERVICE_TYPE"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiServiceId"] forKey:@"SERVICE_ID"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiBizTypeCode"] forKey:@"BIZ_TYPE_CODE"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiSpCode"] forKey:@"SP_CODE"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiBizCode"]forKey:@"BIZ_CODE"];
            [requestBeanDic setObject:@"06" forKey:@"OPER_CODE"];//服务办理
            [requestBeanDic setObject:@"02" forKey:@"OPR_SOURCE"];
            [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
        }
    }else if (ALERTVIEW_TAG + 3 == alertView.tag)//基础业务退订
    {
        if(buttonIndex==1){
            [HUD showTextHUDWithVC:self.navigationController.view];
            busiCode = @"ChangeElement";
            
            requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiElementTypeCode"] forKey:@"ELEMENT_TYPE_CODE"];
            [requestBeanDic setObject:@"1" forKey:@"MODIFY_TAG"];//退订
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiServiceId"] forKey:@"ELEMENT_ID"];
            [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
        }
    }else if (ALERTVIEW_TAG + 4 == alertView.tag)//基础业务办理
    {
        if(buttonIndex==1){
            [HUD showTextHUDWithVC:self.navigationController.view];
            busiCode = @"ChangeElement";
            requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiElementTypeCode"] forKey:@"ELEMENT_TYPE_CODE"];
            [requestBeanDic setObject:@"0" forKey:@"MODIFY_TAG"];//订购
            [requestBeanDic setObject:[_productDetail objectForKey:@"BusiServiceId"] forKey:@"ELEMENT_ID"];
            
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
