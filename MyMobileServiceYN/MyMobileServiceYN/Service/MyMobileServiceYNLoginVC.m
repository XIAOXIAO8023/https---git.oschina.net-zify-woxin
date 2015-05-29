//
//  MyMobileServiceYNLoginVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-5.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNLoginVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNMBProgressHUD.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"
#import "DialogInfo.h"
#import "MyMobileServiceYNRootVC.h"

@interface MyMobileServiceYNLoginVC ()

@end

@implementation MyMobileServiceYNLoginVC

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
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    
//    //进入登录页面，设置初始为客服密码登录
//    [MyMobileServiceYNParam setIsDynamicPW:NO];
    
    isDynamic = NO;
    
    //手势
	UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
	tapGR.cancelsTouchesInView=NO;
	[self.view addGestureRecognizer:tapGR];
    
    //IOS7下面标题栏为白色，需要修正
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
        [bgImgView setImage:[UIImage imageNamed:@"login_bg7"]];
        [bgView addSubview:bgImgView];
        [bgView sendSubviewToBack:bgImgView];
        loginView = [[UIView alloc]initWithFrame:CGRectMake(20, 20+10+44, 280, 190)];
        [bgView addSubview:loginView];
        [self.view addSubview:bgView];
    }else{
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT - 20)];
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT - 20)];
        [bgImgView setImage:[UIImage imageNamed:@"Login_bg"]];
        [bgView addSubview:bgImgView];
        [bgView sendSubviewToBack:bgImgView];
        loginView = [[UIView alloc]initWithFrame:CGRectMake(20, 10+44, 280, 190)];
        [bgView addSubview:loginView];
        [self.view addSubview:bgView];
    }
    
    //考虑到触摸键盘，建议登陆框放到上面去
    UIView *staffIdView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, 280, 1)];
    [staffIdView.layer setCornerRadius:0];
    [staffIdView.layer setBorderWidth:1];
    [staffIdView.layer setBorderColor:[UIColorFromRGB(rgbValue_loginBox) CGColor]];
    [staffIdView.layer setMasksToBounds:YES];
//    [staffIdView setBackgroundColor:[UIColor whiteColor]];
    
    
    UITextField *staffIdTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 280, 40)];
    [staffIdTextField setBorderStyle:UITextBorderStyleNone];
    [staffIdTextField setBackgroundColor:[UIColor clearColor]];
    staffIdTextField.tag = TEXTFIELD_TAG + 1;
    staffIdTextField.placeholder = @"手机号码";
    staffIdTextField.text = @"";
    //设置输入框内容的字体样式和大小
    staffIdTextField.font = [UIFont fontWithName:appTypeFace size:16.0f];
    //设置字体颜色
    staffIdTextField.textColor = [UIColor blackColor];
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    [staffIdTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    staffIdTextField.clearButtonMode = UITextFieldViewModeAlways;
    staffIdTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //每输入一个字符就变成点用语密码输入
    //    staffIdTextField.secureTextEntry = YES;
    //内容对齐方式
    //    staffIdTextField.textAlignment =
    staffIdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    staffIdTextField.keyboardType = UIKeyboardTypeNumberPad;
    //return键变成什么键
    staffIdTextField.returnKeyType =UIReturnKeyNext;
    staffIdTextField.delegate = self;
    [loginView addSubview:staffIdTextField];
    [loginView addSubview:staffIdView];
    
    UIView *pwView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, 280, 1)];
    [pwView.layer setCornerRadius:0];
    [pwView.layer setBorderWidth:1];
    [pwView.layer setBorderColor:[UIColorFromRGB(rgbValue_loginBox) CGColor]];
    [pwView.layer setMasksToBounds:YES];
    [pwView setBackgroundColor:[UIColor whiteColor]];
    
    UITextField *pwTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 40, 190, 40)];  //动态密码宽度改成190  280
    [pwTextField setBorderStyle:UITextBorderStyleNone];
    [pwTextField setBackgroundColor:[UIColor clearColor]];
    pwTextField.tag = TEXTFIELD_TAG + 2;
    pwTextField.placeholder = @"服务密码";
    pwTextField.text = @"";
    pwTextField.font = [UIFont fontWithName:appTypeFace size:16.0f];
    pwTextField.textColor = [UIColor blackColor];
    pwTextField.clearButtonMode = UITextFieldViewModeAlways;
    staffIdTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    pwTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    pwTextField.secureTextEntry = YES;
    pwTextField.keyboardType = UIKeyboardTypeNumberPad;
    pwTextField.returnKeyType = UIReturnKeyGo;
    pwTextField.delegate = self;
    [loginView addSubview:pwTextField];
    [loginView addSubview:pwView];
    
    //动态密码获取按钮，获取动态密码后，根据返回自填充
    UIButton *DynamicPWButton = [UIButton buttonWithType:UIButtonTypeCustom];
    DynamicPWButton.frame = CGRectMake(190, 45, 90, 30);
//    DynamicPWButton.frame = CGRectMake(190, 45, 0, 0);
//    DynamicPWButton.enabled = NO;
    DynamicPWButton.tag = BUTTON_TAG;
    DynamicPWButton.tintColor = UIColorFromRGB(rgbValueButtonGreen);
    [DynamicPWButton setTitle:@"获取动态密码" forState:UIControlStateNormal];
    [DynamicPWButton setBackgroundColor:[UIColor lightGrayColor]];
    DynamicPWButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:15.0];
    [DynamicPWButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:DynamicPWButton];
    
    
    // 单一自动登录布局
    UIView *autoLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, 90, 280, 40)];
    autoLoginView.backgroundColor = [UIColor clearColor];
    
    UILabel *autoLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 40)];
    [autoLoginLabel setBackgroundColor:[UIColor clearColor]];
    autoLoginLabel.font = [UIFont fontWithName:appTypeFace size:17.0f];
    autoLoginLabel.textColor = UIColorFromRGB(rgbValue_autoLogin);
    autoLoginLabel.text = @"自动登录";
    [autoLoginView addSubview:autoLoginLabel];
    
    //使用开关控件来实现用户记住密码和自动登录功能，使用IOS原声控件，更贴合IOS设计风格
    UISwitch *pwrSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pwrSwitch.tag = SWITCH_TAG;
    [pwrSwitch setOn:YES];
    [pwrSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    pwrSwitch.frame = CGRectMake(140, (autoLoginView.frame.size.height - pwrSwitch.frame.size.height)/2, 0, 0);
    [autoLoginView addSubview:pwrSwitch];
    [loginView addSubview:autoLoginView];
    // 自动登录及动态密码布局
//    UIView *autoLoginView = [[UIView alloc]initWithFrame:CGRectMake(0, 90, 280, 40)];
//    autoLoginView.backgroundColor = [UIColor clearColor];
//    
//    UILabel *autoLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
//    [autoLoginLabel setBackgroundColor:[UIColor clearColor]];
//    autoLoginLabel.font = [UIFont fontWithName:appTypeFace size:15.0f];
//    autoLoginLabel.textColor = UIColorFromRGB(rgbValue_autoLogin);
//    autoLoginLabel.text = @"自动登录";
//    [autoLoginView addSubview:autoLoginLabel];
//    
//    //使用开关控件来实现用户记住密码和自动登录功能，使用IOS原声控件，更贴合IOS设计风格
//    UISwitch *pwrSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    pwrSwitch.tag = SWITCH_TAG;
//    [pwrSwitch setOn:[MyMobileServiceYNParam getIsAutoLogin]];
//    [pwrSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//    pwrSwitch.frame = CGRectMake(60, (autoLoginView.frame.size.height - pwrSwitch.frame.size.height)/2, 0, 0);
//    [autoLoginView addSubview:pwrSwitch];
//    
//    UILabel *DynamicPDLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 0, 60, 40)];
//    [DynamicPDLabel setBackgroundColor:[UIColor clearColor]];
//    DynamicPDLabel.font = [UIFont fontWithName:appTypeFace size:15.0f];
//    DynamicPDLabel.textColor = UIColorFromRGB(rgbValue_autoLogin);
//    DynamicPDLabel.text = @"动态密码";
//    [autoLoginView addSubview:DynamicPDLabel];
//    
//    //使用开关控件来实现用户记住密码和自动登录功能，使用IOS原声控件，更贴合IOS设计风格
//    UISwitch *dpdSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    dpdSwitch.tag = SWITCH_TAG+1;
////    [dpdSwitch setOn:[MyMobileServiceYNParam getIsAutoLogin]];
//    [dpdSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//    dpdSwitch.frame = CGRectMake(200, (autoLoginView.frame.size.height - pwrSwitch.frame.size.height)/2, 0, 0);
//    [autoLoginView addSubview:dpdSwitch];
//    [loginView addSubview:autoLoginView];
    
    UIButton * clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(0, 140, 130, 40);
//    [clearButton.layer setCornerRadius:5];
//    [clearButton.layer setBorderWidth:0];
//    [clearButton.layer setMasksToBounds:YES];
    clearButton.tag = BUTTON_TAG + 1;
    clearButton.tintColor = [UIColor whiteColor];
    [clearButton setTitle:@"取消" forState:UIControlStateNormal];
    [clearButton setBackgroundColor:UIColorFromRGB(rgbValueButtonGreen)];
    clearButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:20.0];
    [clearButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:clearButton];
    [loginView addSubview:clearButton];
    
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(150, 140, 130, 40);
//    [loginButton.layer setCornerRadius:5];
//    [loginButton.layer setBorderWidth:0];
//    [loginButton.layer setMasksToBounds:YES];
    loginButton.tag = BUTTON_TAG + 2;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:20.0];
    loginButton.titleLabel.textColor = [UIColor whiteColor];
    [loginButton setBackgroundColor:UIColorFromRGB(rgbValueButtonGreen)];
    [loginButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:loginButton];
    [loginView addSubview:loginButton];
    
//    UIImageView *imageViewBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_logobg"]];
//    imageViewBG.frame = CGRectMake(0, self.view.frame.size.height-196, SCREEN_WIDTH, 196);
//    [self.view addSubview:imageViewBG];
    
    
    //判断缓存中是否存在号码和密码，如果存在直接设置。
    if (![[MyMobileServiceYNParam getSerialNumber] isEqualToString:@""]) {
        staffIdTextField.text = [MyMobileServiceYNParam getSerialNumber];
    }
    //    if (![[JscnMbossParam getPassWord] isEqualToString:@""]) {
    //        pwTextField.text = [JscnMbossParam getPassWord];
    //    }
    
    //如果当前为动态密码登录状态，那么展示相应的界面
    if (isDynamic) {
        [DynamicPWButton setTitle:@"切换客服密码" forState:UIControlStateNormal];
        pwTextField.placeholder = @"动态密码";//设置输入框提示为 动态密码
        pwTextField.secureTextEntry = NO;//设置为明文
        pwrSwitch.enabled = NO;//设置自动登录选择控件为不可用
    }
}

-(void)dealloc
{
    [httpRequest setRequestDelegatNil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---手势对应的触发时间
//手势对应的触发事件
//在空白处点击，收起键盘
-(void)viewTapped:(UITapGestureRecognizer *)tapGR
{
	[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2] resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self.view];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    [UIView commitAnimations];
}

#pragma mark---UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //当开始点击textField会调用的方法
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //当textField编辑结束时调用的方法
    //编辑完成后设置输入框内文本值
    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2] resignFirstResponder];
    switch (textField.tag) {
        case TEXTFIELD_TAG+1:
            //设置手机号码
            [MyMobileServiceYNParam setSerialNumber:textField.text];
            break;
        case TEXTFIELD_TAG+2:
            //设置客服密码
            [MyMobileServiceYNParam setUserPassWord:textField.text];
            break;
        default:
            break;
    }
}

//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField.returnKeyType == UIReturnKeyNext){
        // Make something else first responder
        UITextField *pwtf = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2];
        [pwtf becomeFirstResponder];
    }else if(textField.returnKeyType == UIReturnKeyGo){
        // Do something
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag ==TEXTFIELD_TAG+1){
        if(range.location>=11){
            return NO;
        }
        return YES;
    }if(textField.tag ==TEXTFIELD_TAG+2){
        if(range.location>=6){
            return NO;
        }
        return YES;
    }else{
        return YES;
    }
}

#pragma mark---switchAction
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    
    if (isButtonOn) {
        [MyMobileServiceYNParam setIsAutoLogin:YES];
    }else {
        [MyMobileServiceYNParam setIsAutoLogin:NO];
    }

    
}

#pragma mark---ButtonAction
-(IBAction)clickButton:(id)sender
{
    UIButton *button=(UIButton *) sender;
    int buttonTag = button.tag;
    if ((BUTTON_TAG)==buttonTag) {//获取动态密码
        //先获取
        UITextField *staffidTX = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1];
        UITextField *passwrodTX = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2];
        NSString *staffidtext = staffidTX.text;
        
        UISwitch *switchButton = (UISwitch *)[self.view viewWithTag:SWITCH_TAG];
        
        UIButton *button = (UIButton *)[self.view viewWithTag:BUTTON_TAG];
        
        //如果手机号码为空，提示用户先输入手机号码，在获取动态密码
        if ([staffidtext isEqualToString:@""]) {//如果号码为空，则提示用户输入号码
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:No_SerialNumber delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG;
            [alertView show];
        }else{
            if (isDynamic) {//如果当前为动态密码登录，点击后进行下面的操作
                
                [button setTitle:@"获取动态密码" forState:UIControlStateNormal];
                passwrodTX.placeholder = @"服务密码";//设置输入框提示为 服务密码
                passwrodTX.secureTextEntry = YES;//设置为密文
                switchButton.enabled = YES;//设置自动登录选择控件为可用
                isDynamic = NO;//设置不是动态密码登录
//                [MyMobileServiceYNParam setIsDynamicPW:NO];//设置不是动态密码登录
                
            }else{//如果当前为客服密码登录，点击后进行下面的操作
                [button setTitle:@"切换客服密码" forState:UIControlStateNormal];
                passwrodTX.placeholder = @"动态密码";//设置输入框提示为 动态密码
                passwrodTX.secureTextEntry = NO;//设置为明文
                [switchButton setOn:NO]; //设置自动登录状态为NO
                [MyMobileServiceYNParam setIsAutoLogin:NO];
                switchButton.enabled = NO;//设置自动登录选择控件为不可用
                isDynamic = YES;//设置是动态密码登录
//                [MyMobileServiceYNParam setIsDynamicPW:YES];//设置是动态密码登录
                
                [HUD showTextHUDWithVC:self.view];
                //获取动态密码
                busiCode =@"DynamicPsd";
                requestBeanDic=[httpRequest getHttpPostParamData:@"DynamicPsd"];
                [requestBeanDic setObject:staffidTX.text forKey:@"SERIAL_NUMBER"];
                [httpRequest startAsynchronous:@"DynamicPsd" requestParamData:requestBeanDic viewController:self];
            }
        }

    }
    else if ((BUTTON_TAG+1)==buttonTag) {
        //取消
        [self dismissViewControllerAnimated:YES completion:Nil];
    }
    else if ((BUTTON_TAG+2)==buttonTag)
    {   //登录
        UITextField *staffidTX = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1];
        UITextField *passwrodTX = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2];
        
        NSString *staffidtext = staffidTX.text;
        NSString *passwrodtext = passwrodTX.text;
        
        DebugNSLog(@"%@,%@",staffidtext,passwrodtext);
        
        if((![@"" isEqualToString:staffidTX.text])&&(![@"" isEqualToString:passwrodTX.text]))
        {
            [HUD showTextHUDWithVC:self.view];
            //登录
            [MyMobileServiceYNParam setIsDynamicPW:isDynamic];//设置是否为动态密码登录
            if (isDynamic) {//动态密码
                busiCode =@"Login_CheckDynamicPsd";
            }else{
                busiCode =@"Login_CheckPWD";
            }
            requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
            [requestBeanDic setObject:@"0" forKey:@"REMOVE_TAG"];
            [requestBeanDic setObject:@"3911" forKey:@"QUERYTYPE"];
            [requestBeanDic setObject:@"GETTHREENEW" forKey:@"QUERYDATA"];
            [requestBeanDic setObject:staffidTX.text forKey:@"SERIAL_NUMBER"];
            [requestBeanDic setObject:passwrodTX.text forKey:@"USER_PASSWD"];
            [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
            
            //设置账号密码
            NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc]init];
            //设置是否自动登录
            [userInfoDic setValue:[[NSNumber alloc]initWithBool:YES] forKey:@"AutoLogin"];
            
            if ([MyMobileServiceYNParam getIsAutoLogin]) {//自动登录
                [userInfoDic setValue:staffidTX.text forKey:@"UserPhoneNumber"];
                [userInfoDic setValue:passwrodTX.text forKey:@"UserPassWord"];
            }
            else{//不自动登录只需要获取用户名
                [userInfoDic setValue:staffidTX.text forKey:@"UserPhoneNumber"];
            }
            
            //获取应用程序沙盒的Documents目录
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *plistPath1 = [paths objectAtIndex:0];
            
            //得到完整的文件名
            NSString *configFielPath=[plistPath1 stringByAppendingPathComponent:@"MyMobileServiceYNConfig.plist"];
            
            NSMutableDictionary *MyMobileServiceYNConfigDicSandbox = [[NSMutableDictionary alloc] initWithContentsOfFile:configFielPath];
            [MyMobileServiceYNConfigDicSandbox removeObjectForKey:@"UserInfo"];
            [MyMobileServiceYNConfigDicSandbox setValue:userInfoDic forKey:@"UserInfo"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            DebugNSLog(@"%@",MyMobileServiceYNConfigDicSandbox);
            //先删除沙盒中原有文件
            [fileManager removeItemAtPath:configFielPath error:nil];
            //复制到沙盒中
            [MyMobileServiceYNConfigDicSandbox writeToFile:configFielPath atomically:YES];
            
//            [MyMobileServiceYNParam setIsLogin:YES];//登录成功后设置为已登录
            //返回到上一页
//            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:Login_no delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            alertView.tag = ALERTVIEW_TAG + 1;
            [alertView show];
        }
        
    }
    
}

#pragma mark---ASIHTTPRequestDelegate
//返回成功
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if(HUD){
        [HUD removeHUD];
    }
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[request responseData];
    DebugNSLog(@"%@",[request responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        if ([busiCode isEqualToString:@"DynamicPsd"]) {//动态密码登录
            
//            UITextField *passwrodTX = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2];
//            passwrodTX.text =[dic objectForKey:@"password"];//自动设置动态密码
            
        }else
        {
            if ([[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {
                //特殊处理，如果返回信息正确，但是无数据提示
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"登录号码信息异常,请确认后重新登录!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                alertView.tag = ALERTVIEW_TAG_RETURN+1;
                [alertView show];
            }else{//登陆成功
                //设置工号信息，及菜单
                [MyMobileServiceYNParam setIsLogin:YES];//登录成功后设置为已登录
                [MyMobileServiceYNParam setBrandCode:[dic objectForKey:@"BRAND_CODE"]];
                [MyMobileServiceYNParam setCityCode:[dic objectForKey:@"EPARCHY_CODE"]];
                [MyMobileServiceYNParam setVipTag:[dic objectForKey:@"VIP_TAG"]];
                [MyMobileServiceYNParam setCustName:[dic objectForKey:@"CUST_NAME"]];
                [MyMobileServiceYNParam setPsptID:[dic objectForKey:@"PSPT_ID"]];
                [MyMobileServiceYNParam setIsHuiDuVersion:[dic objectForKey:@"GREP_LIMIT"]];
                [MyMobileServiceYNParam setUserId:[dic objectForKey:@"USER_ID"]];
                
                NSDictionary *tempDic=[array objectAtIndex:2];
                if([[tempDic objectForKey:@"X_RESULTNUM"] integerValue]!=0){
                    NSArray *tempArray=[tempDic objectForKey:@"X_RESULTINFO"];
                    [MyMobileServiceYNParam setBannerArray:tempArray];
                }
                //返回到上一页
                
                [self dismissViewControllerAnimated:YES completion:Nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"toShowGuessYourLoveView" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"toSetIsRefreshMenu" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"toSetBannerScrollView" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"toSetLeftMenuInfo" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"iHaveLoggedIn" object:nil userInfo:nil];
            }
        }
    }
    else{
        NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG_RETURN+1;
        [alertView show];
    }
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"jfmallordersuccesstipsBack" object:nil];
}
//返回失败
-(void)requestFailed:(ASIHTTPRequest *)request
{
    DebugNSLog(@"------------requestFailed------------------");
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


@end
