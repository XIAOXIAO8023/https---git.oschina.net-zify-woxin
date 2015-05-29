//
//  MyMobileServiceYNBusinessRecommendVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-4-30.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBusinessRecommendVC.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNBusinessRecommendVC ()

@end

@implementation MyMobileServiceYNBusinessRecommendVC

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
    self.title = @"猜你喜欢";
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.backgroundColor = [UIColor clearColor];
    homeScrollView.delegate = self;
    homeScrollView.showsVerticalScrollIndicator = NO;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [self.view addSubview:homeScrollView];
    
    //显示推荐信息详情
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [label setNumberOfLines:0];  //必须是这组值
    //获取推荐信息详情
    NSString *sBusiInfo = [[MyMobileServiceYNParam getBusinessRecommendDic] objectForKey:@"CAMPN_CONTENT"];
    CGSize size = CGSizeMake(300,2000);
    UIFont *font = [UIFont fontWithName:appTypeFace size:15];
    CGSize labelsize = [sBusiInfo sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    label.frame = CGRectMake(10,10,labelsize.width,labelsize.height);
    label.backgroundColor = [UIColor clearColor];
//    label.textColor = ;
    label.text = sBusiInfo;
    label.font = font;
    [homeScrollView addSubview:label];
    
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 10+label.frame.size.height+10, SCREEN_WIDTH, 46)];
    buttonView.backgroundColor = [UIColor clearColor];
    [homeScrollView addSubview:buttonView];
    
    UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    agreeButton.frame = CGRectMake(20, 0, 80, 44);
    agreeButton.tag = BUTTON_TAG + 1;
    agreeButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:15.0];
    agreeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    agreeButton.titleLabel.textColor =[UIColor whiteColor];
    [agreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image1 =[self createImageWithColor:UIColorFromRGB(rgbValueTitleBlue)];
    [agreeButton setBackgroundImage:image1 forState:UIControlStateNormal];
    [agreeButton setTitle:@"同意开通" forState:UIControlStateNormal];
    
    [agreeButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:agreeButton];
    [buttonView addSubview:agreeButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.frame = CGRectMake(120, 0, 80, 44);
    cancelButton.tag = BUTTON_TAG + 2;
    cancelButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:15.0];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    cancelButton.titleLabel.textColor =[UIColor whiteColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image2 =[self createImageWithColor:UIColorFromRGB(rgbValueTitleBlue)];
    [cancelButton setBackgroundImage:image2 forState:UIControlStateNormal];
    [cancelButton setTitle:@"拒绝开通" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:cancelButton];
    [buttonView addSubview:cancelButton];
    
    UIButton *thinkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    thinkButton.frame = CGRectMake(220, 0, 80, 44);
    thinkButton.tag = BUTTON_TAG + 3;
    thinkButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:15.0];
    thinkButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    thinkButton.titleLabel.textColor =[UIColor whiteColor];
    [thinkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image3 =[self createImageWithColor:UIColorFromRGB(rgbValueTitleBlue)];
    [thinkButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [thinkButton setTitle:@"我考虑下" forState:UIControlStateNormal];
    [thinkButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:thinkButton];
    [buttonView addSubview:thinkButton];
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


-(IBAction)buttonPressed:(id)sender
{
    UIButton *button=(UIButton *) sender;
    int buttonTag = button.tag;

    
    //点击后进行推荐业务办理、拒绝、考虑
    requestBeanDic=[httpRequest getHttpPostParamData:@"HandleTouchSale"];
    [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [requestBeanDic setObject:@"T02" forKey:@"EXEC_CHL"];
    if ((BUTTON_TAG+1)==buttonTag) {//同意开通
        [HUD showTextHUDWithVC:self.navigationController.view];
        [requestBeanDic setObject:@"1" forKey:@"RESULT"];
        pressedButtoTag = @"1";
    }else if ((BUTTON_TAG+2)==buttonTag)//拒绝开通
    {
        [requestBeanDic setObject:@"2" forKey:@"RESULT"];
        pressedButtoTag = @"2";
    }else if ((BUTTON_TAG+3)==buttonTag)//我考虑下
    {
        [requestBeanDic setObject:@"3" forKey:@"RESULT"];
        pressedButtoTag = @"3";
    }
    [requestBeanDic setObject:[[MyMobileServiceYNParam getBusinessRecommendDic]objectForKey:@"CAMPN_CODE"] forKey:@"CAMPN_CODE"];
    [requestBeanDic setObject:[[MyMobileServiceYNParam getBusinessRecommendDic]objectForKey:@"ELEMENT_TYPE"] forKey:@"ELEMENT_TYPE_CODE_1"];
    [requestBeanDic setObject:[[MyMobileServiceYNParam getBusinessRecommendDic]objectForKey:@"ELEMENT_ID"] forKey:@"ELEMENT_ID_1"];
    [requestBeanDic setObject:[[MyMobileServiceYNParam getBusinessRecommendDic]objectForKey:@"PREVALUEV4"] forKey:@"ELEMENT_TYPE_CODE_2"];
    [requestBeanDic setObject:[[MyMobileServiceYNParam getBusinessRecommendDic]objectForKey:@"PREVALUEV3"] forKey:@"ELEMENT_ID_2"];
    [httpRequest startAsynchronous:@"currentMonthCost" requestParamData:requestBeanDic viewController:self];
    
//    [self backButtonPressed];
    
    //直接返回
    if ((BUTTON_TAG+2)==buttonTag)//拒绝开通
    {
        [self backButtonPressed];
    }else if ((BUTTON_TAG+3)==buttonTag)//我考虑下
    {
        [self backButtonPressed];
    }

}

-(void)backButtonPressed{
    if(HUD){
        [HUD removeHUD];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-- 为了防止程序异常，需要手动清除代理，在此方法里面进行清除
-(void)dealloc {
    [httpRequest setRequestDelegatNil];
}

#pragma mark---ASIHTTPRequestDelegate
//返回成功
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if ([pressedButtoTag isEqualToString:@"1"]) {
        NSData *jsonData =[request responseData];
        DebugNSLog(@"%@",[request responseString]);
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic = [array objectAtIndex:0];
        if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
            //提示办理成功
            NSString *returnMessage = @"办理成功！";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG+1;
            [alertView show];
        }
        else{
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
//返回失败
-(void)requestFailed:(ASIHTTPRequest *)request
{
    if ([pressedButtoTag isEqualToString:@"1"]) {
        NSError *error = [request error];
        DebugNSLog(@"requestFailed%@",error);
        NSString *returnMessage = [returnMessageDeal returnMessage:@"" andreturnMessage:@""];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG_RETURN+2;
        [alertView show];
    }
    
    if(HUD){
        [HUD removeHUD];
    }
    
}

#pragma mark  -- AlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (ALERTVIEW_TAG + 1 == alertView.tag)
    {//办理成功
        [self backButtonPressed];
    }
    else if (ALERTVIEW_TAG_RETURN + 1 == alertView.tag)
    {//办理失败
        [self backButtonPressed];
    }
    else if (ALERTVIEW_TAG_RETURN + 2 == alertView.tag)
    {//调用失败
        [self backButtonPressed];
    }
    
}

@end
