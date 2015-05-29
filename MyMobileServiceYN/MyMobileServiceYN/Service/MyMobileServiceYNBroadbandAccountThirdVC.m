//
//  MyMobileServiceYNBroadbandAccountThirdVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-4-1.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBroadbandAccountThirdVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNBroadbandAccountFourthVC.h"
#import "MyMobileServiceYNStepCircleView.h"

@interface MyMobileServiceYNBroadbandAccountThirdVC ()

@end

@implementation MyMobileServiceYNBroadbandAccountThirdVC
@synthesize broadBandDic=_broadBandDic;

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
    requestBeanDic=[[NSMutableDictionary alloc]init];
    custName = [MyMobileServiceYNParam getCustName];
    idNumber = [MyMobileServiceYNParam getPsptID];
    contactPhone=[MyMobileServiceYNParam getSerialNumber];
    
    //手势
	UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
	tapGR.cancelsTouchesInView=NO;
	[self.view addGestureRecognizer:tapGR];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.delegate = self;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [self.view addSubview:homeScrollView];
    
    UIView *firstView=[MyMobileServiceYNStepCircleView setStepView:3 withString:@"输入个人信息"];
    [homeScrollView addSubview:firstView];
    
    
    UIView *serialNumberView = [[UIView alloc]initWithFrame:CGRectMake(0, 98, SCREEN_WIDTH, 40)];
    serialNumberView.backgroundColor = [UIColor clearColor];
    [homeScrollView addSubview:serialNumberView];
    
    UILabel *serialNumberNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 77.5, 40)];
    serialNumberNameLabel.backgroundColor = [UIColor clearColor];
    serialNumberNameLabel.text = @"手机号码:";
    serialNumberNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
    [serialNumberView addSubview:serialNumberNameLabel];
    
    UILabel *serialNumberName = [[UILabel alloc]initWithFrame:CGRectMake(87.5, 0, 212.5, 40)];
    serialNumberName.backgroundColor = [UIColor clearColor];
    serialNumberName.text = [MyMobileServiceYNParam getSerialNumber];
    serialNumberName.font = [UIFont fontWithName:appTypeFace size:20];
    [serialNumberView addSubview:serialNumberName];
    
    UIView *custNameView = [[UIView alloc]initWithFrame:CGRectMake(0, serialNumberView.frame.origin.y+serialNumberView.frame.size.height+10, SCREEN_WIDTH, 40)];
    custNameView.backgroundColor = [UIColor clearColor];
    [homeScrollView addSubview:custNameView];
    
    UILabel *custNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 77.5, 40)];
    custNameLabel.backgroundColor = [UIColor clearColor];
    custNameLabel.text = @"客户姓名:";
    custNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
    [custNameView addSubview:custNameLabel];
    
    UITextField *custNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(87.5, 0, 212.5, 40)];
    [custNameTextField setBorderStyle:UITextBorderStyleNone];
    [custNameTextField setBackgroundColor:[UIColor clearColor]];
    custNameTextField.tag = TEXTFIELD_TAG + 1;
    custNameTextField.placeholder = @"请输入客户姓名";
    custNameTextField.text = [MyMobileServiceYNParam getCustName];
    custName = [MyMobileServiceYNParam getCustName];
    //设置输入框内容的字体样式和大小
    custNameTextField.font = [UIFont fontWithName:appTypeFace size:20];
    //设置字体颜色
    custNameTextField.textColor = [UIColor blackColor];
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
//    [custNameTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    custNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    custNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    custNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    custNameTextField.keyboardType = UIKeyboardTypeDefault;
    //return键变成什么键
    custNameTextField.returnKeyType =UIReturnKeyDone;
    custNameTextField.delegate = self;
    [custNameView addSubview:custNameTextField];
    
    UILabel *custNameTextLine=[[UILabel alloc]initWithFrame:CGRectMake(80, 39.5, 220, 0.5)];
    custNameTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [custNameView addSubview:custNameTextLine];
    
    UIView *contactView = [[UIView alloc]initWithFrame:CGRectMake(0, custNameView.frame.origin.y+custNameView.frame.size.height+10, SCREEN_WIDTH, 40)];
    contactView.backgroundColor = [UIColor clearColor];
    [homeScrollView addSubview:contactView];
    
    UILabel *contactPhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 77.5, 40)];
    contactPhoneLabel.backgroundColor = [UIColor clearColor];
    contactPhoneLabel.text = @"联系电话:";
    contactPhoneLabel.font = [UIFont fontWithName:appTypeFace size:15];
    [contactView addSubview:contactPhoneLabel];
    
    UITextField *contactPhoneField = [[UITextField alloc]initWithFrame:CGRectMake(87.5, 0, 212.5, 40)];
    [contactPhoneField setBorderStyle:UITextBorderStyleNone];
    [contactPhoneField setBackgroundColor:[UIColor clearColor]];
    contactPhoneField.tag = TEXTFIELD_TAG + 3;
    contactPhoneField.placeholder = @"请输入联系电话";
    contactPhoneField.text = [MyMobileServiceYNParam getSerialNumber];
    contactPhone = [MyMobileServiceYNParam getSerialNumber];
    //设置输入框内容的字体样式和大小
    contactPhoneField.font = [UIFont fontWithName:appTypeFace size:20];
    //设置字体颜色
    contactPhoneField.textColor = [UIColor blackColor];
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    //    [custNameTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    contactPhoneField.clearButtonMode = UITextFieldViewModeAlways;
    contactPhoneField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    contactPhoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    contactPhoneField.keyboardType = UIKeyboardTypeDefault;
    //return键变成什么键
    contactPhoneField.returnKeyType =UIReturnKeyDone;
    contactPhoneField.delegate = self;
    [contactView addSubview:contactPhoneField];
    
    UILabel *contactPhoneFieldLine=[[UILabel alloc]initWithFrame:CGRectMake(80, 39.5, 220, 0.5)];
    contactPhoneFieldLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [contactView addSubview:contactPhoneFieldLine];
    
    UIView *idNameView = [[UIView alloc]initWithFrame:CGRectMake(0, contactView.frame.origin.y+contactView.frame.size.height+10, SCREEN_WIDTH, 40)];
    idNameView.backgroundColor = [UIColor clearColor];
    [homeScrollView addSubview:idNameView];
    
    UILabel *idNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 77.5, 40)];
    idNameLabel.backgroundColor = [UIColor clearColor];
    idNameLabel.text = @"证件类型:";
    idNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
    [idNameView addSubview:idNameLabel];
    
    UILabel *idName = [[UILabel alloc]initWithFrame:CGRectMake(87.5, 0, 212.5, 40)];
    idName.backgroundColor = [UIColor clearColor];
    idName.text = @"身份证";
    idName.font = [UIFont fontWithName:appTypeFace size:20];
    [idNameView addSubview:idName];
    
    
    UIView *idView = [[UIView alloc]initWithFrame:CGRectMake(0, idNameView.frame.origin.y+idNameView.frame.size.height+10, SCREEN_WIDTH, 40)];
    idView.backgroundColor = [UIColor clearColor];
    [homeScrollView addSubview:idView];
    
    UILabel *idNumberNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 77.5, 40)];
    idNumberNameLabel.backgroundColor = [UIColor clearColor];
    idNumberNameLabel.text = @"证件号码:";
    idNumberNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
    [idView addSubview:idNumberNameLabel];
    
    UITextField *idNumberNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(87.5, 0, 212.5, 40)];
    [idNumberNameTextField setBorderStyle:UITextBorderStyleNone];
    [idNumberNameTextField setBackgroundColor:[UIColor clearColor]];
    idNumberNameTextField.tag = TEXTFIELD_TAG + 2;
    idNumberNameTextField.placeholder = @"请输入身份证号码";
    idNumberNameTextField.text = [MyMobileServiceYNParam getPsptID];
    idNumber =[MyMobileServiceYNParam getPsptID];
    idNumberNameTextField.font = [UIFont fontWithName:appTypeFace size:20];
    idNumberNameTextField.textColor = [UIColor blackColor];
//    idNumberNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    idNumberNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    idNumberNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    idNumberNameTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    idNumberNameTextField.returnKeyType = UIReturnKeyGo;
    idNumberNameTextField.delegate = self;
    [idView addSubview:idNumberNameTextField];
    
    UILabel *TextLine=[[UILabel alloc]initWithFrame:CGRectMake(80, 39.5, 220, 0.5)];
    TextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [idView addSubview:TextLine];

    UIView *thirdView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-64, SCREEN_WIDTH, 64)];
    thirdView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    [homeScrollView addSubview:thirdView];
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [thirdView addSubview:line];
    
    nextButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 44)];
    nextButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
    [nextButton setTitle:@"下一步:确认信息" forState:UIControlStateNormal];
    nextButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:20];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //4个参数是上边界，左边界，下边界，右边界
    [nextButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:nextButton];
//    nextButton.enabled=NO;
    [thirdView addSubview:nextButton];
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

#pragma mark---手势对应的触发时间
//手势对应的触发事件
//在空白处点击，收起键盘
-(void)viewTapped:(UITapGestureRecognizer *)tapGR
{
	[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 3] resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self.view];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    homeScrollView.frame = CGRectMake(0, 0, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark---UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    DebugNSLog(@"---------begin---------");
    //移动试图位置保证输入内容不被键盘遮挡
    CGFloat keyboardHeight = 216.0f;
    float moveHeight = 0.0f;
    float textViewHeight = 0.0f;
    if (textView.tag == TEXTFIELD_TAG + 1) {
        textViewHeight = 88+44+44;
    }
    if (textView.tag == TEXTFIELD_TAG + 2) {
        textViewHeight = 88+44+44+44+44+44+50;
    }
    if (textView.tag == TEXTFIELD_TAG + 3) {
        textViewHeight = 88+44+44+44+40;
    }
    
    if(!(homeScrollView.frame.size.height - keyboardHeight > textViewHeight))
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
    //当textField编辑结束时调用的方法
    //编辑完成后设置输入框内文本值
//    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1] resignFirstResponder];
//    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2] resignFirstResponder];
//    [(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 3] resignFirstResponder];
//    switch (textField.tag) {
//        case TEXTFIELD_TAG+1:
//            //设置客户姓名
//            custName = textField.text;
//            break;
//        case TEXTFIELD_TAG+2:
//            //设置身份证号码
//            idNumber = textField.text;
//            break;
//        case TEXTFIELD_TAG+3:
//            //设置身份证号码
//            contactPhone = textField.text;
//            break;
//        default:
//            break;
//    }
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1];
    custName = textField1.text;
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2];
    idNumber = textField2.text;
    UITextField *textField3 = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 3];
    contactPhone = textField3.text;
}

//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self.view];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    homeScrollView.frame = CGRectMake(0, 0, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
    [UIView commitAnimations];
    
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1];
    [textField1 resignFirstResponder];
    custName = textField1.text;
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 2];
    [textField2 resignFirstResponder];
    idNumber = textField2.text;
    UITextField *textField3 = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 3];
    [textField3 resignFirstResponder];
    contactPhone = textField3.text;
    
    if(textField.returnKeyType == UIReturnKeyNext){
        // Make something else first responder

//        UITextField *idNumberTf = (UITextField *)[self.view viewWithTag:textField.tag + 1];
//        [idNumberTf becomeFirstResponder];
        
    }else if(textField.returnKeyType == UIReturnKeyGo){
        // Do something
        
        [self buttonPressed:textField];
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
    }else if(textField.tag ==TEXTFIELD_TAG+2){
        if(range.location >= 18){
            return NO;
        }
//        else if(range.location<=0){
//            nextButton.backgroundColor=UIColorFromRGB(rgbValue_broadBand_noButtonBg);
//            nextButton.enabled=NO;
//        }else{
//            nextButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
//            nextButton.enabled=YES;
//        }
        return YES;
    }
    else if(textField.tag ==TEXTFIELD_TAG+3){
        if(range.location >= 11){
            return NO;
        }
        return YES;
    }
    else{
        return YES;
    }
}

-(void)buttonPressed:(id)sender
{
//    UIButton *button = (UIButton *)sender;
    //先判断输入的客户名称和身份证ID是否符合规范
    NSString *alertMessage = @"";
    NSString *nameCheckString = @"^[\u4E00-\u9FA5A-Za-z0-9]+$";
    NSPredicate *nameCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameCheckString];
    if([custName isEqualToString:@""]){
        alertMessage = [NSString stringWithFormat:@"%@客户名称不能为空！\n",alertMessage];
    }else if(![nameCheck evaluateWithObject:custName]){
        alertMessage = [NSString stringWithFormat:@"%@客户名称输入不符合规范！\n",alertMessage];
    }
    
    NSString *phoneCheckString = @"^((\\+86)|(86))?(1)\\d{10}$";
    NSPredicate *phoneCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneCheckString];
    if([contactPhone isEqualToString:@""]){
        alertMessage = [NSString stringWithFormat:@"%@联系号码不能为空！\n",alertMessage];
    }else if(![phoneCheck evaluateWithObject:contactPhone]){
        alertMessage = [NSString stringWithFormat:@"%@联系号码输入不符合规范！\n",alertMessage];
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    
    if([idNumber isEqualToString:@""]){
        alertMessage = [NSString stringWithFormat:@"%@证件号码不能为空！\n",alertMessage];
    }else if(![identityCardPredicate evaluateWithObject:idNumber]){
        alertMessage = [NSString stringWithFormat:@"%@证件号码输入不符合规范！\n",alertMessage];
    }
    
    if (![alertMessage isEqualToString:@""]) {
        alertMessage = [NSString stringWithFormat:@"%@请填写正确后再次提交！",alertMessage];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:alertMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag=ALERTVIEW_TAG+1;
        [alertView show];
    }else{
        MyMobileServiceYNBroadbandAccountFourthVC *nextVC = [[MyMobileServiceYNBroadbandAccountFourthVC alloc]init];
        [_broadBandDic setObject:idNumber forKey:@"idNumber"];
        [_broadBandDic setObject:custName forKey:@"custName"];
        [_broadBandDic setObject:contactPhone forKey:@"contactPhone"];
        nextVC.broadBandDic=_broadBandDic;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
