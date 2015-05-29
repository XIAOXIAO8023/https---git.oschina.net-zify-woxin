//
//  MyMobileServiceYNBroadbandAccountQueryVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-4.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBroadbandAccountQueryVC.h"
#import "MyMobileServiceYNBroadbandAccountAddressListVC.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"

#define fHeight 44

@interface MyMobileServiceYNBroadbandAccountQueryVC ()

@end

@implementation MyMobileServiceYNBroadbandAccountQueryVC
@synthesize resID=_resID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // addressom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"查询地址";
    
    httpRequest=[[MyMobileServiceYNHttpRequest alloc]init];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT)];
    homeScrollView.backgroundColor = [UIColor clearColor];
    homeScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:homeScrollView];
    
    //手势
	tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
	tapGR.cancelsTouchesInView=NO;
	[homeScrollView addGestureRecognizer:tapGR];
    
    UIView *addressInfoView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fHeight*6)];
    addressInfoView.backgroundColor=[UIColor clearColor];
    [homeScrollView addSubview:addressInfoView];
    
    UIView *addressHearderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fHeight)];
    addressHearderView.backgroundColor=UIColorFromRGB(rgbValueBgGrey);
    [addressInfoView addSubview:addressHearderView];
    
    UIImageView *addressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    addressImageView.image=[UIImage imageNamed:@"msg_lishitousuico"];
    [addressHearderView addSubview:addressImageView];
    
    UILabel *addressHeaderLabel=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 120, 44)];
    addressHeaderLabel.backgroundColor=[UIColor clearColor];
    addressHeaderLabel.font=[UIFont fontWithName:appTypeFace size:18];
    addressHeaderLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    addressHeaderLabel.text=@"宽带地址信息";
    [addressHearderView addSubview:addressHeaderLabel];
    
    UILabel *addressHeaderLabel2=[[UILabel alloc]initWithFrame:CGRectMake(164, 8, 150, 32)];
    addressHeaderLabel2.backgroundColor=[UIColor clearColor];
    addressHeaderLabel2.font=[UIFont fontWithName:appTypeFace size:14];
    addressHeaderLabel2.textColor=UIColorFromRGB(rgbValueDeepGrey);
    addressHeaderLabel2.text=@"(带*号的必填)";
    [addressHearderView addSubview:addressHeaderLabel2];
    
    UIView *addressContentInfoView=[[UIView alloc]initWithFrame:CGRectMake(0, fHeight, SCREEN_WIDTH, fHeight*5)];
    addressContentInfoView.backgroundColor=[UIColor clearColor];
    [addressInfoView addSubview:addressContentInfoView];
    
    UIView *neighborView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*0, SCREEN_WIDTH, fHeight)];
    neighborView.backgroundColor = [UIColor clearColor];
    [addressContentInfoView addSubview:neighborView];
    
    UILabel *neighborLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    neighborLabel.backgroundColor = [UIColor clearColor];
    neighborLabel.text = @"*小区或路:";
    neighborLabel.textAlignment=NSTextAlignmentRight;
    neighborLabel.font = [UIFont fontWithName:appTypeFace size:16];
    neighborLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [neighborView addSubview:neighborLabel];
    
    UITextField *neighborTextField = [[UITextField alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    [neighborTextField setBorderStyle:UITextBorderStyleNone];
    [neighborTextField setBackgroundColor:[UIColor clearColor]];
    neighborTextField.tag = TEXTFIELD_TAG + 1;
    neighborTextField.placeholder = @"请输入所在小区或路";
    //设置输入框内容的字体样式和大小
    neighborTextField.font = [UIFont fontWithName:appTypeFace size:16];
    //设置字体颜色
    neighborTextField.textColor = UIColorFromRGB(rgbValueDeepGrey);
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    //    [neighborTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    neighborTextField.clearButtonMode = UITextFieldViewModeAlways;
    neighborTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    neighborTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    neighborTextField.keyboardType = UIKeyboardTypeDefault;
    //return键变成什么键
    neighborTextField.returnKeyType =UIReturnKeyDone;
    neighborTextField.delegate = self;
    [neighborView addSubview:neighborTextField];
    
    UILabel *neighborTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    neighborTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [neighborView addSubview:neighborTextLine];
    
    UIView *buildingView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*1, SCREEN_WIDTH, fHeight)];
    buildingView.backgroundColor = [UIColor clearColor];
    [addressContentInfoView addSubview:buildingView];
    
    UILabel *buildingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    buildingLabel.backgroundColor = [UIColor clearColor];
    buildingLabel.text = @"所在楼栋:";
    buildingLabel.textAlignment=NSTextAlignmentRight;
    buildingLabel.font = [UIFont fontWithName:appTypeFace size:16];
    buildingLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [buildingView addSubview:buildingLabel];
    
    UITextField *buildingTextField = [[UITextField alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    [buildingTextField setBorderStyle:UITextBorderStyleNone];
    [buildingTextField setBackgroundColor:[UIColor clearColor]];
    buildingTextField.tag = TEXTFIELD_TAG + 2;
    buildingTextField.placeholder = @"请输入所在的楼栋";
    //设置输入框内容的字体样式和大小
    buildingTextField.font = [UIFont fontWithName:appTypeFace size:16];
    //设置字体颜色
    buildingTextField.textColor = UIColorFromRGB(rgbValueDeepGrey);
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    //    [neighborTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    buildingTextField.clearButtonMode = UITextFieldViewModeAlways;
    buildingTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    buildingTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    buildingTextField.keyboardType = UIKeyboardTypeDefault;
    //return键变成什么键
    buildingTextField.returnKeyType =UIReturnKeyDone;
    buildingTextField.delegate = self;
    [buildingView addSubview:buildingTextField];
    
    UILabel *buildingTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    buildingTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [buildingView addSubview:buildingTextLine];
    
    UIView *apartmentView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*2, SCREEN_WIDTH, fHeight)];
    apartmentView.backgroundColor = [UIColor clearColor];
    [addressContentInfoView addSubview:apartmentView];
    
    UILabel *apartmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    apartmentLabel.backgroundColor = [UIColor clearColor];
    apartmentLabel.text = @"所在单元:";
    apartmentLabel.textAlignment=NSTextAlignmentRight;
    apartmentLabel.font = [UIFont fontWithName:appTypeFace size:16];
    apartmentLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [apartmentView addSubview:apartmentLabel];
    
    UITextField *apartmentTextField = [[UITextField alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    [apartmentTextField setBorderStyle:UITextBorderStyleNone];
    [apartmentTextField setBackgroundColor:[UIColor clearColor]];
    apartmentTextField.tag = TEXTFIELD_TAG + 3;
    apartmentTextField.placeholder = @"请输入所在单元";
    //设置输入框内容的字体样式和大小
    apartmentTextField.font = [UIFont fontWithName:appTypeFace size:16];
    //设置字体颜色
    apartmentTextField.textColor = UIColorFromRGB(rgbValueDeepGrey);
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    //    [neighborTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    apartmentTextField.clearButtonMode = UITextFieldViewModeAlways;
    apartmentTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    apartmentTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    apartmentTextField.keyboardType = UIKeyboardTypeDefault;
    //return键变成什么键
    apartmentTextField.returnKeyType =UIReturnKeyDone;
    apartmentTextField.delegate = self;
    [apartmentView addSubview:apartmentTextField];
    
    UILabel *apartmentTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    apartmentTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [apartmentView addSubview:apartmentTextLine];
    
    UIView *levelView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*3, SCREEN_WIDTH, fHeight)];
    levelView.backgroundColor = [UIColor clearColor];
    [addressContentInfoView addSubview:levelView];
    
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    levelLabel.backgroundColor = [UIColor clearColor];
    levelLabel.text = @"所在楼层:";
    levelLabel.textAlignment=NSTextAlignmentRight;
    levelLabel.font = [UIFont fontWithName:appTypeFace size:16];
    levelLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [levelView addSubview:levelLabel];
    
    UITextField *levelTextField = [[UITextField alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    [levelTextField setBorderStyle:UITextBorderStyleNone];
    [levelTextField setBackgroundColor:[UIColor clearColor]];
    levelTextField.tag = TEXTFIELD_TAG + 4;
    levelTextField.placeholder = @"请输入所在楼层";
    //设置输入框内容的字体样式和大小
    levelTextField.font = [UIFont fontWithName:appTypeFace size:16];
    //设置字体颜色
    levelTextField.textColor = UIColorFromRGB(rgbValueDeepGrey);
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    //    [neighborTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    levelTextField.clearButtonMode = UITextFieldViewModeAlways;
    levelTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    levelTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    levelTextField.keyboardType = UIKeyboardTypeDefault;
    //return键变成什么键
    levelTextField.returnKeyType =UIReturnKeyDone;
    levelTextField.delegate = self;
    [levelView addSubview:levelTextField];
    
    UILabel *levelTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    levelTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [levelView addSubview:levelTextLine];
    
    UIView *roomView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*4, SCREEN_WIDTH, fHeight)];
    roomView.backgroundColor = [UIColor clearColor];
    [addressContentInfoView addSubview:roomView];
    
    UILabel *roomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    roomLabel.backgroundColor = [UIColor clearColor];
    roomLabel.text = @"所在门牌:";
    roomLabel.textAlignment=NSTextAlignmentRight;
    roomLabel.font = [UIFont fontWithName:appTypeFace size:16];
    roomLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [roomView addSubview:roomLabel];
    
    UITextField *roomTextField = [[UITextField alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    [roomTextField setBorderStyle:UITextBorderStyleNone];
    [roomTextField setBackgroundColor:[UIColor clearColor]];
    roomTextField.tag = TEXTFIELD_TAG + 5;
    roomTextField.placeholder = @"请输入所在门牌号";
    //设置输入框内容的字体样式和大小
    roomTextField.font = [UIFont fontWithName:appTypeFace size:16];
    //设置字体颜色
    roomTextField.textColor = UIColorFromRGB(rgbValueDeepGrey);
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    //    [neighborTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    roomTextField.clearButtonMode = UITextFieldViewModeAlways;
    roomTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    roomTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    roomTextField.keyboardType = UIKeyboardTypeDefault;
    //return键变成什么键
    roomTextField.returnKeyType =UIReturnKeyDone;
    roomTextField.delegate = self;
    [roomView addSubview:roomTextField];
    
    UILabel *roomLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    roomLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [roomView addSubview:roomLine];
    
    UIView *commitView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-64, SCREEN_WIDTH, 64)];
    commitView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    [homeScrollView addSubview:commitView];
    
    UILabel *commitLine=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    commitLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [commitView addSubview:commitLine];
    
    UIButton *commitButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 44)];
    commitButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    commitButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:20];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //4个参数是上边界，左边界，下边界，右边界
    [commitButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:commitButton];
    [commitView addSubview:commitButton];
    
    [homeScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, fHeight*6+84)];
}

-(void)buttonPressed{
    NSString *neighbor=[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG+1] text];
    NSString *building=[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG+2] text];
    NSString *apartment=[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG+3] text];
    NSString *level=[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG+4] text];
    NSString *room=[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG+5] text];
    if(![neighbor isEqualToString:@""]&&neighbor!=nil){
        
        [HUD showTextHUDWithVC:self.navigationController.view];
        
        NSMutableString *address=[[NSMutableString alloc]initWithString:neighbor];
        [address appendString:@","];
        if(building==nil){
            [address appendString:@","];
        }else{
            [address appendString:building];
            [address appendString:@","];
        }
        if(apartment==nil){
            [address appendString:@","];
        }else{
            [address appendString:apartment];
            [address appendString:@","];
        }
        if(level==nil){
            [address appendString:@","];
        }else{
            [address appendString:level];
            [address appendString:@","];
        }
        if(room==nil){
            [address appendString:@","];
        }else{
            [address appendString:room];
            [address appendString:@","];
        }
        
        NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:@"WidenetAdderssInfo"];
        [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestBeanDic setObject:[MyMobileServiceYNParam getCityCode] forKey:@"EPARCHY_CODE"];
        [requestBeanDic setObject:address forKey:@"MISS_ADD"];
        [requestBeanDic setObject:_resID forKey:@"AREA_ID"];
        [httpRequest startAsynchronous:@"WidenetAdderssInfo" requestParamData:requestBeanDic viewController:self];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"带*号的选项不能为空" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG+1;
        [alertView show];
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[request responseData];
    DebugNSLog(@"%@",[request responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if([[[array objectAtIndex:0] objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        if ([[[array objectAtIndex:0] objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {
            NSString *returnMessage = @"请检查地址输入是否正确或该地址暂未覆盖，敬请期待。";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG_RETURN+1;
            [alertView show];
        }else{
            MyMobileServiceYNBroadbandAccountAddressListVC *addressListVC=[[MyMobileServiceYNBroadbandAccountAddressListVC alloc]init];
            addressListVC.addressList=array;
            [self.navigationController pushViewController:addressListVC animated:YES];
        }
    }
    else{
        NSString *returnMessage = [returnMessageDeal returnMessage:[[array objectAtIndex:0] objectForKey:@"X_RESULTCODE"] andreturnMessage:[[array objectAtIndex:0] objectForKey:@"X_RESULTINFO"]];
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

#pragma mark---手势对应的触发时间
//手势对应的触发事件
//在空白处点击，收起键盘
-(void)viewTapped:(UITapGestureRecognizer *)tapGR
{
	[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 3] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 4] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 5] resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self.view];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    homeScrollView.frame = CGRectMake(0, 0, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark---UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DebugNSLog(@"---------begin---------");
    tapGR.enabled=YES;
    CGFloat keyboardHeight = 216.0f;
    //移动试图位置保证输入内容不被键盘遮挡
    if(textField.keyboardType==UIKeyboardTypeDefault){
        keyboardHeight = 216.0f+30.0f;
    }
    float moveHeight = 0.0f;
    float textViewHeight = fHeight*(textField.tag-TEXTFIELD_TAG)+fHeight;
    
    if(!(homeScrollView.frame.size.height - keyboardHeight > textViewHeight ))
    {
        if(homeScrollView.contentOffset.y==0){
            moveHeight = textViewHeight - (homeScrollView.frame.size.height - keyboardHeight);
        }else{
            moveHeight = textViewHeight - homeScrollView.contentOffset.y - (homeScrollView.frame.size.height - keyboardHeight);
        }
        DebugNSLog(@"%f",textViewHeight);
        DebugNSLog(@"%f",moveHeight);
        
        // [UIView beginAnimations:@"scrollView" context:nil];
        //切换动画效果
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:homeScrollView];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.275f];
        homeScrollView.frame = CGRectMake(homeScrollView.frame.origin.x, -moveHeight, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
        [UIView commitAnimations];
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //当开始点击textField会调用的方法
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self.view];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    homeScrollView.frame = CGRectMake(0, 0, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
    [UIView commitAnimations];
    
    if(textField.returnKeyType == UIReturnKeyNext){
        
    }else if(textField.returnKeyType == UIReturnKeyGo){
        
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if(textField.tag ==TEXTFIELD_TAG+1){
//        if(range.location>=11){
//            return NO;
//        }
//        return YES;
//    }else if(textField.tag ==TEXTFIELD_TAG+2){
//        if(range.location >= 12){
//            return NO;
//        }
//        return YES;
//    }
//    else if(textField.tag ==TEXTFIELD_TAG+3){
//        if(range.location >= 15){
//            return NO;
//        }
//        return YES;
//    }
//    else if(textField.tag ==TEXTFIELD_TAG+4){
//        if(range.location >= 16){
//            return NO;
//        }
//        return YES;
//    }
//    else{
        return YES;
//    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    [httpRequest setRequestDelegatNil];
}

@end
