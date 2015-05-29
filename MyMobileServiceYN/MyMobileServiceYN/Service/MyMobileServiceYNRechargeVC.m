//
//  MyMobileServiceYNRechargeVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-12.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNRechargeVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNWebViewVC.h"


#define fheight 44
#define fspacing 10

@interface MyMobileServiceYNRechargeVC ()

@end

@implementation MyMobileServiceYNRechargeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"充值";
    
    isOnlinePayment = YES;//默认在线充值
    
    //手势
	UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
	tapGR.cancelsTouchesInView=NO;
	[self.view addGestureRecognizer:tapGR];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.delegate = self;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [self.view addSubview:homeScrollView];
    
    //输入号码区域
    UIView *userPhoneNumberView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fheight*2)];
    userPhoneNumberView.backgroundColor = [UIColor clearColor];
    
    UIView *userPhoneNumberNameBlockView = [[UIView alloc]initWithFrame:CGRectMake(12, 12, 10, 20)];
    userPhoneNumberNameBlockView.backgroundColor = UIColorFromRGB(rgbValue_blockBg);
    [userPhoneNumberView addSubview:userPhoneNumberNameBlockView];
    
    UILabel *userPhoneNumberNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(34, 0, 200, fheight)];
    userPhoneNumberNameLabel.backgroundColor = [UIColor clearColor];
    userPhoneNumberNameLabel.textColor = UIColorFromRGB(rgbValue_blockNameBg);
    userPhoneNumberNameLabel.textAlignment = NSTextAlignmentLeft;
    userPhoneNumberNameLabel.text = @"输入号码";
    [userPhoneNumberView addSubview:userPhoneNumberNameLabel];
    
    UIView *userPhoneNumberBlockView = [[UIView alloc]initWithFrame:CGRectMake(0, fheight, SCREEN_WIDTH, fheight)];
    userPhoneNumberBlockView.backgroundColor = UIColorFromRGB(rgbValueBgGrey);
    [userPhoneNumberView addSubview:userPhoneNumberBlockView];
    
    UITextField *userPhoneNmuberTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300, fheight)];
    [userPhoneNmuberTextField setBorderStyle:UITextBorderStyleNone];
    [userPhoneNmuberTextField setBackgroundColor:[UIColor clearColor]];
    userPhoneNmuberTextField.keyboardType=UIKeyboardTypePhonePad;
    userPhoneNmuberTextField.tag = TEXTFIELD_TAG + 1;
    if ([[MyMobileServiceYNParam getSerialNumber]isEqualToString:@""]) {
        userPhoneNmuberTextField.placeholder = @"请输入需充值的手机号码";
    }else
    {
        userPhoneNmuberTextField.text = [MyMobileServiceYNParam getSerialNumber];
    }
    
    //设置输入框内容的字体样式和大小
    userPhoneNmuberTextField.font = [UIFont fontWithName:appTypeFaceBold size:30.0f];
    //设置字体颜色
    userPhoneNmuberTextField.textColor = UIColorFromRGB(rgbValue_blockValueBg);
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
//    [userPhoneNmuberTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
//    userPhoneNmuberTextField.clearButtonMode = UITextFieldViewModeAlways;
    userPhoneNmuberTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //每输入一个字符就变成点用语密码输入
    //    staffIdTextField.secureTextEntry = YES;
    //内容对齐方式
    userPhoneNmuberTextField.textAlignment = NSTextAlignmentCenter;
    userPhoneNmuberTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //return键变成什么键
    userPhoneNmuberTextField.returnKeyType =UIReturnKeyDone;
    userPhoneNmuberTextField.delegate = self;
    [userPhoneNumberBlockView addSubview:userPhoneNmuberTextField];
    [homeScrollView addSubview:userPhoneNumberView];
    
    
    //支付方式区域
    UIView *payView = [[UIView alloc]initWithFrame:CGRectMake(0, fheight*2+1, SCREEN_WIDTH, fheight*2)];
    payView.backgroundColor = [UIColor clearColor];
    [homeScrollView addSubview:payView];
    
    UIView *payNameBlockView = [[UIView alloc]initWithFrame:CGRectMake(12, 12, 10, 20)];
    payNameBlockView.backgroundColor = UIColorFromRGB(rgbValue_blockBg);
    [payView addSubview:payNameBlockView];
    
    UILabel *payNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(34, 0, 200, fheight)];
    payNameLabel.backgroundColor = [UIColor clearColor];
    payNameLabel.textColor = UIColorFromRGB(rgbValue_blockNameBg);
    payNameLabel.textAlignment = NSTextAlignmentLeft;
    payNameLabel.text = @"支付方式";
    [payView addSubview:payNameLabel];
    
    LeeSegmentedControl *segmentPay = [[LeeSegmentedControl alloc]initWithFrame:CGRectMake(10, fheight, SCREEN_WIDTH-20, fheight) items:@[               @{@"text":@"和包充值",@"icon":@"icon"},@{@"text":@"充值卡充值",@"icon":@"icon"},                                ] iconPosition:IconPositionLeft andSelectionBlock:^(NSUInteger segmentIndex) {}];
    segmentPay.delegate = self;
    segmentPay.backgroundColor = UIColorFromRGB(rgbValue_segmentPayBg);
    segmentPay.borderWidth = 1.0f;
    segmentPay.borderColor = [UIColor lightGrayColor];
    segmentPay.color = [UIColor blackColor];
    segmentPay.textColor = [UIColor lightGrayColor];
    segmentPay.lineColor = UIColorFromRGB(rgbValueTitleBlue);
    segmentPay.selectedColor = UIColorFromRGB(rgbValueTitleBlue);
    segmentPay.textFont = [UIFont fontWithName:appTypeFace size:20.0f];
    [payView addSubview:segmentPay];
    
    //设置一个选择后展示区域方便处理
    
    rechargeView = [[UIView alloc]initWithFrame:CGRectMake(0, fheight*5+1, SCREEN_WIDTH, fheight*2.5)];
    [homeScrollView addSubview:rechargeView];
    //默认银行卡充值
    //选择金额区域
//    UIView *moneyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fheight*4)];
//    moneyView.backgroundColor = [UIColor clearColor];
//    [rechargeView addSubview:moneyView];
//    
//    UIView *moneyNameBlockView = [[UIView alloc]initWithFrame:CGRectMake(12, 12, 10, 20)];
//    moneyNameBlockView.backgroundColor = UIColorFromRGB(rgbValue_blockBg);
//    [moneyView addSubview:moneyNameBlockView];
//    
//    UILabel *moneyNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(34, 0, 200, fheight)];
//    moneyNameLabel.backgroundColor = [UIColor clearColor];
//    moneyNameLabel.textColor = UIColorFromRGB(rgbValue_blockNameBg);
//    moneyNameLabel.textAlignment = NSTextAlignmentLeft;
//    moneyNameLabel.text = @"选择金额(元)";
//    [moneyView addSubview:moneyNameLabel];
//    
//    LeeSegmentedControl *segment = [[LeeSegmentedControl alloc]initWithFrame:CGRectMake(10, fheight, SCREEN_WIDTH-20, fheight*3) items:@[               @{@"text":@"20",@"icon":@"icon"},@{@"text":@"30",@"icon":@"icon"},@{@"text":@"50",@"icon":@"icon"},                                @{@"text":@"100",@"icon":@"icon"},@{@"text":@"200",@"icon":@"icon"},@{@"text":@"300",@"icon":@"icon"}] iconPosition:IconPositionLeft andLines:2 andSelectionBlock:^(NSUInteger segmentIndex) {}];
//    segment.delegate = self;
//    segment.backgroundColor = UIColorFromRGB(rgbValue_segmentPayBg);
//    segment.borderWidth = 1.0f;
//    segment.borderColor = [UIColor lightGrayColor];
//    segment.color = [UIColor blackColor];
//    segment.textColor = [UIColor lightGrayColor];
//    segment.lineColor = [UIColor lightGrayColor];
//    segment.selectedColor = UIColorFromRGB(rgbValue_buttonBg);
//    segment.textFont = [UIFont fontWithName:appTypeFace size:30.0f];
//    [moneyView addSubview:segment];
    
    //充值按钮
    UIButton *rechargeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rechargeButton.frame = CGRectMake(20, fheight*0.5, SCREEN_WIDTH-40, fheight);
    rechargeButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:25.0];
    rechargeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    rechargeButton.titleLabel.textColor =[UIColor whiteColor];
    [rechargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *image =[self createImageWithColor:UIColorFromRGB(rgbValueTitleBlue)];
    [rechargeButton setBackgroundImage:image forState:UIControlStateNormal];
    [rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeButton addTarget:self action:@selector(rechargeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:rechargeButton];
    [rechargeView addSubview:rechargeButton];
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, fheight*7);
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

-(void)rechargeButtonPressed:(id)sender
{
    if (isOnlinePayment) {//手机支付在线支付
        NSString *url;
        UITextField *serialNumberTF = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1];
        NSString *serialNumber = serialNumberTF.text;
        
        if (![@"" isEqualToString:serialNumber]) {
            url = [NSString stringWithFormat:@"%@%@&mobile=%@",[MyMobileServiceYNParam getPayUrl],[MyMobileServiceYNParam getMerc],serialNumber];
        }else
        {
            url = [NSString stringWithFormat:@"%@%@",[MyMobileServiceYNParam getPayUrl],[MyMobileServiceYNParam getMerc]];
        }
        MyMobileServiceYNWebViewVC *webViewVC=[[MyMobileServiceYNWebViewVC alloc]init];
        webViewVC.webUrlString=url;
        webViewVC.title=@"充值";
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController: webViewVC];
        //设置nav bar 颜色
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(rgbValue_navBarBg)];
        }else{
            [[UINavigationBar appearance] setTintColor:UIColorFromRGB(rgbValue_navBarBg)];
        }
        [nav.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:appTypeFace size:18.0], UITextAttributeFont,nil]];
        [self presentModalViewController:nav animated:YES];
    }
    else//充值卡充值
    {
        if( [MFMessageComposeViewController canSendText] ){
            
            UITextField *serialNumberTF = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1];
            NSString *serialNumber = serialNumberTF.text;
            
            UITextField *rechargeTF = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2];
            NSString *rechargeString = rechargeTF.text;
            
            MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
            controller.recipients = [NSArray arrayWithObject:@"10086"];
            NSString *smsString = [NSString stringWithFormat:@"CZ%@#%@",rechargeString,serialNumber];
            controller.body = smsString;
            controller.messageComposeDelegate = self;
            [self presentModalViewController:controller animated:YES];
            [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"充值卡充值"];//修改短信界面标题
        }else{
            [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
        }
    }
}

//MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissModalViewControllerAnimated:NO];//关键的一句   不能为YES
    switch ( result ) {
        case MessageComposeResultCancelled:
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        default:
            break;
    }
}

- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];  
    
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
    homeScrollView.frame = CGRectMake(homeScrollView.frame.origin.x, 0, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark---UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //移动试图位置保证输入内容不被键盘遮挡
    CGFloat keyboardHeight = 216.0f;
    CGFloat moveHeight = 0.0f;
    UITextField *tf = (UITextField *)[self.view viewWithTag:textField.tag];
    
    if (textField.tag == TEXTFIELD_TAG +2 ) {
        if(!(homeScrollView.frame.size.height - keyboardHeight > fheight*5 + tf.frame.size.height))
        {
            if(homeScrollView.contentOffset.y==0){
                moveHeight = fheight*5 + tf.frame.size.height - (homeScrollView.frame.size.height - keyboardHeight);
            }else{
                moveHeight = fheight*5 + tf.frame.size.height - homeScrollView.contentOffset.y - (homeScrollView.frame.size.height - keyboardHeight);
            }
            // [UIView beginAnimations:@"scrollView" context:nil];
            //切换动画效果
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelegate:homeScrollView];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.275f];
            homeScrollView.frame = CGRectMake(homeScrollView.frame.origin.x, -moveHeight, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
            [UIView commitAnimations];
        }
    }
    return YES;
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
            break;
        case TEXTFIELD_TAG+2:
            //设置充值金额
            break;
        default:
            break;
    }
}

//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField.returnKeyType == UIReturnKeyNext){
        // Make something else first responder
//        UITextField *pwtf = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2];
//        [pwtf becomeFirstResponder];
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
        if(range.location>=18){
            return NO;
        }
        return YES;
    }else{
        return YES;
    }
}


//segment代理方法
-(void)SelectSegmentedControlAtIndex:(NSInteger)index
{
    if(index==0){//银行卡支付
        isOnlinePayment = YES;
        [rechargeView removeFromSuperview];
        //设置一个选择后展示区域方便处理
        rechargeView = [[UIView alloc]initWithFrame:CGRectMake(0, fheight*5+1, SCREEN_WIDTH, fheight*2.5)];
        [homeScrollView addSubview:rechargeView];
        
        //充值按钮
        UIButton *rechargeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        rechargeButton.frame = CGRectMake(20, fheight*0.5, SCREEN_WIDTH-40, fheight);
        rechargeButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:25.0];
        rechargeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        rechargeButton.titleLabel.textColor =[UIColor whiteColor];
        //    [choosePackageButton setBackgroundColor:UIColorFromRGB(rgbVaelu_gprsQueryButtonBg)];
        UIImage *image =[self createImageWithColor:UIColorFromRGB(rgbValueTitleBlue)];
        [rechargeButton setBackgroundImage:image forState:UIControlStateNormal];
        [rechargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
        [rechargeButton addTarget:self action:@selector(rechargeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self setButtonBorder:rechargeButton];
        [rechargeView addSubview:rechargeButton];
        homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, fheight*7);
    }else if(index==1){//充值卡充值
        isOnlinePayment = NO;
        [rechargeView removeFromSuperview];
        rechargeView = [[UIView alloc]initWithFrame:CGRectMake(0, fheight*4+1, SCREEN_WIDTH, fheight*6)];
        [homeScrollView addSubview:rechargeView];
        //充值卡充值
        //输入充值卡密码
        UIView *cardPassWordView = [[UIView alloc]initWithFrame:CGRectMake(10, fheight/2, SCREEN_WIDTH-20, fheight*1)];
        cardPassWordView.backgroundColor = [UIColor whiteColor];
        [cardPassWordView.layer setCornerRadius:3];
        [cardPassWordView.layer setBorderWidth:2];
        [cardPassWordView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [cardPassWordView.layer setMasksToBounds:YES];
        [rechargeView addSubview:cardPassWordView];
        
        UITextField *cardPassWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, fheight*1)];
        [cardPassWordTextField setBorderStyle:UITextBorderStyleNone];
        [cardPassWordTextField setBackgroundColor:[UIColor clearColor]];
        cardPassWordTextField.tag = TEXTFIELD_TAG + 2;
        cardPassWordTextField.placeholder = @"请输入充值卡密码";
        //设置输入框内容的字体样式和大小
        cardPassWordTextField.font = [UIFont fontWithName:appTypeFace size:16.0f];
        //设置字体颜色
        cardPassWordTextField.textColor = UIColorFromRGB(rgbValue_blockValueBg);
        //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
        //    [userPhoneNmuberTextField becomeFirstResponder];
        //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
        //    userPhoneNmuberTextField.clearButtonMode = UITextFieldViewModeAlways;
        cardPassWordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        //每输入一个字符就变成点用语密码输入
        //    staffIdTextField.secureTextEntry = YES;
        //内容对齐方式
        cardPassWordTextField.textAlignment = NSTextAlignmentCenter;
        cardPassWordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
        //设置键盘的样式
        cardPassWordTextField.keyboardType = UIKeyboardTypeNumberPad;
        //return键变成什么键
        cardPassWordTextField.returnKeyType =UIReturnKeyDone;
        cardPassWordTextField.delegate = self;
        [cardPassWordView addSubview:cardPassWordTextField];
        
        //温馨提示
        UIView *promptView = [[UIView alloc]initWithFrame:CGRectMake(0, fheight*2, SCREEN_WIDTH, fheight*2)];
        promptView.backgroundColor = [UIColor clearColor];
        [rechargeView addSubview:promptView];
        
        UILabel *promptLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 200, (fheight/3)*2)];
        promptLabel1.backgroundColor = [UIColor clearColor];
        promptLabel1.textColor = UIColorFromRGB(rgbValue_blockNameBg);
        promptLabel1.textAlignment = NSTextAlignmentLeft;
        promptLabel1.text = @"温馨提示:";
        [promptView addSubview:promptLabel1];
        
        UILabel *promptLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(5, (fheight/3)*2, SCREEN_WIDTH-10, (fheight/3)*2)];
        promptLabel2.backgroundColor = [UIColor clearColor];
        promptLabel2.textColor = UIColorFromRGB(rgbValue_blockNameBg);
        promptLabel2.textAlignment = NSTextAlignmentLeft;
        promptLabel2.font = [UIFont fontWithName:appTypeFace size:10.0];
        promptLabel2.text = @"1、充值卡充值会有10分钟左右延迟，请耐心等待。";
        [promptView addSubview:promptLabel2];
        
        UILabel *promptLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(5, ((fheight/3)*2)*2, SCREEN_WIDTH-10, (fheight/3)*2)];
        promptLabel3.backgroundColor = [UIColor clearColor];
        promptLabel3.textColor = UIColorFromRGB(rgbValue_blockNameBg);
        promptLabel3.textAlignment = NSTextAlignmentLeft;
        promptLabel3.font = [UIFont fontWithName:appTypeFace size:10.0];
        promptLabel3.text = @"2、如果充值不成功，建议拨打1380013800进行语音充值。";
        [promptView addSubview:promptLabel3];
        
        //充值按钮
        UIButton *rechargeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        rechargeButton.frame = CGRectMake(20, fheight*4.5, SCREEN_WIDTH-40, fheight);
        rechargeButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:25.0];
        rechargeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        rechargeButton.titleLabel.textColor =[UIColor whiteColor];
        //    [choosePackageButton setBackgroundColor:UIColorFromRGB(rgbVaelu_gprsQueryButtonBg)];
        UIImage *image =[self createImageWithColor:UIColorFromRGB(rgbValueTitleBlue)];
        [rechargeButton setBackgroundImage:image forState:UIControlStateNormal];
        [rechargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
        [rechargeButton addTarget:self action:@selector(rechargeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [rechargeView addSubview:rechargeButton];
        homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, fheight*10.5);
        
    }else if (index == 100)
    {
        
    }else if (index == 101)
    {
        
    }else if (index == 102)
    {
        
    }else if (index == 103)
    {
        
    }else if (index == 104)
    {
        
    }else if (index == 105)
    {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
