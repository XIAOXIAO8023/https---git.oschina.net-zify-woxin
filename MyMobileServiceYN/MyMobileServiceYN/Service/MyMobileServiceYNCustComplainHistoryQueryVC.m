//
//  MyMobileServiceYNcomplainComplainHistoryQueryVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNCustComplainHistoryQueryVC.h"
#import "MyMobileServiceYNCustComplainHistoryListVC.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"

#define fHeight 44

@interface MyMobileServiceYNCustComplainHistoryQueryVC ()

@end

@implementation MyMobileServiceYNCustComplainHistoryQueryVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // complainom initialization
    }
    return self;
}

-(void)setComplainTypeArray
{
    complainTypeArray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:@"10" forKey:@"complainTypeCode"];
    [dic1 setObject:@"投诉" forKey:@"complainTypeName"];
    [complainTypeArray addObject:dic1];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
    [dic2 setObject:@"20" forKey:@"complainTypeCode"];
    [dic2 setObject:@"建议" forKey:@"complainTypeName"];
    [complainTypeArray addObject:dic2];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
    [dic3 setObject:@"30" forKey:@"complainTypeCode"];
    [dic3 setObject:@"咨询" forKey:@"complainTypeName"];
    [complainTypeArray addObject:dic3];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"历史投诉";
    
    httpRequest=[[MyMobileServiceYNHttpRequest alloc]init];
    startDate=[[NSDate alloc]init];
    endDate=[[NSDate alloc]init];
    [self setComplainTypeArray];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT)];
    homeScrollView.backgroundColor = [UIColor clearColor];
    homeScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:homeScrollView];
    
    //手势
	tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
	tapGR.cancelsTouchesInView=NO;
	[homeScrollView addGestureRecognizer:tapGR];
    
    UIView *complainInfoView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fHeight*5)];
    complainInfoView.backgroundColor=[UIColor clearColor];
    [homeScrollView addSubview:complainInfoView];
    
    UIView *complainHearderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fHeight)];
    complainHearderView.backgroundColor=UIColorFromRGB(rgbValueBgGrey);
    [complainInfoView addSubview:complainHearderView];
    
    UIImageView *complainImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    complainImageView.image=[UIImage imageNamed:@"msg_lishitousuico"];
    [complainHearderView addSubview:complainImageView];
    
    UILabel *complainHeaderLabel=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 140, 44)];
    complainHeaderLabel.backgroundColor=[UIColor clearColor];
    complainHeaderLabel.font=[UIFont fontWithName:appTypeFace size:18];
    complainHeaderLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    complainHeaderLabel.text=@"请输入查询条件";
    [complainHearderView addSubview:complainHeaderLabel];
    
    UILabel *complainHeaderLabel2=[[UILabel alloc]initWithFrame:CGRectMake(175, 8, 150, 32)];
    complainHeaderLabel2.backgroundColor=[UIColor clearColor];
    complainHeaderLabel2.font=[UIFont fontWithName:appTypeFace size:14];
    complainHeaderLabel2.textColor=UIColorFromRGB(rgbValueDeepGrey);
    complainHeaderLabel2.text=@"(带*号的必填)";
    [complainHearderView addSubview:complainHeaderLabel2];
    
    UIView *complainContentInfoView=[[UIView alloc]initWithFrame:CGRectMake(0, fHeight, SCREEN_WIDTH, fHeight*4)];
    complainContentInfoView.backgroundColor=[UIColor clearColor];
    [complainInfoView addSubview:complainContentInfoView];
    
    UIView *complainTypeView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*0, SCREEN_WIDTH, fHeight)];
    complainTypeView.backgroundColor = [UIColor clearColor];
    [complainContentInfoView addSubview:complainTypeView];
    
    UILabel *complainTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    complainTypeLabel.backgroundColor = [UIColor clearColor];
    complainTypeLabel.text = @"*投诉类型:";
    complainTypeLabel.textAlignment=NSTextAlignmentRight;
    complainTypeLabel.font = [UIFont fontWithName:appTypeFace size:16];
    complainTypeLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [complainTypeView addSubview:complainTypeLabel];
    
    UIButton *complainTypeButton=[[UIButton alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    complainTypeButton.backgroundColor=[UIColor clearColor];
    [complainTypeButton addTarget:self action:@selector(showComplainTypePicker) forControlEvents:UIControlEventTouchUpInside];
    complainTypeButton.tag=BUTTON_TAG+1;
    [complainTypeView addSubview:complainTypeButton];
    
    selectComplainTypeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 195, fHeight-5)];
    selectComplainTypeLabel.backgroundColor=[UIColor clearColor];
    selectComplainTypeLabel.textColor=UIColorFromRGB(rgbValue_broadBand_textfieldText);
    selectComplainTypeLabel.font=[UIFont fontWithName:appTypeFace size:16];
    selectComplainTypeLabel.text=@"选择投诉类型";
    selectComplainTypeLabel.adjustsFontSizeToFitWidth=YES;
    [complainTypeButton addSubview:selectComplainTypeLabel];
    
    UIImageView *jiantou1=[[UIImageView alloc]initWithFrame:CGRectMake(290, 12, 20, 20)];
    jiantou1.image=[UIImage imageNamed:@"msg_more"];
    [complainTypeView addSubview:jiantou1];
    
    UILabel *complainTypeTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    complainTypeTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [complainTypeView addSubview:complainTypeTextLine];
    
    UIView *complainPhoneView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*1, SCREEN_WIDTH, fHeight)];
    complainPhoneView.backgroundColor = [UIColor clearColor];
    [complainContentInfoView addSubview:complainPhoneView];
    
    UILabel *complainPhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    complainPhoneLabel.backgroundColor = [UIColor clearColor];
    complainPhoneLabel.text = @"*投诉号码:";
    complainPhoneLabel.textAlignment=NSTextAlignmentRight;
    complainPhoneLabel.font = [UIFont fontWithName:appTypeFace size:16];
    complainPhoneLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [complainPhoneView addSubview:complainPhoneLabel];
    
    UITextField *complainPhoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    [complainPhoneTextField setBorderStyle:UITextBorderStyleNone];
    [complainPhoneTextField setBackgroundColor:[UIColor clearColor]];
    complainPhoneTextField.tag = TEXTFIELD_TAG + 1;
    complainPhoneTextField.placeholder = @"请输入投诉号码";
    complainPhoneTextField.text = [MyMobileServiceYNParam getSerialNumber];
    //设置输入框内容的字体样式和大小
    complainPhoneTextField.font = [UIFont fontWithName:appTypeFace size:16];
    //设置字体颜色
    complainPhoneTextField.textColor = UIColorFromRGB(rgbValueDeepGrey);
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    //    [complainPhoneTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    complainPhoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    complainPhoneTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    complainPhoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    complainPhoneTextField.keyboardType = UIKeyboardTypePhonePad;
    //return键变成什么键
    complainPhoneTextField.returnKeyType =UIReturnKeyDone;
    complainPhoneTextField.delegate = self;
    [complainPhoneView addSubview:complainPhoneTextField];
    
    UILabel *complainPhoneTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    complainPhoneTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [complainPhoneView addSubview:complainPhoneTextLine];
    
    UIView *complainStartTimeView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*2, SCREEN_WIDTH, fHeight)];
    complainStartTimeView.backgroundColor = [UIColor clearColor];
    [complainContentInfoView addSubview:complainStartTimeView];
    
    UILabel *complainStartTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    complainStartTimeLabel.backgroundColor = [UIColor clearColor];
    complainStartTimeLabel.text = @"*开始时间:";
    complainStartTimeLabel.textAlignment=NSTextAlignmentRight;
    complainStartTimeLabel.font = [UIFont fontWithName:appTypeFace size:16];
    complainStartTimeLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [complainStartTimeView addSubview:complainStartTimeLabel];
    
    UIButton *complainStartTimeButton=[[UIButton alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    complainStartTimeButton.backgroundColor=[UIColor clearColor];
    [complainStartTimeButton addTarget:self action:@selector(showComplainStartTimePicker) forControlEvents:UIControlEventTouchUpInside];
    complainStartTimeButton.tag=BUTTON_TAG+2;
    [complainStartTimeView addSubview:complainStartTimeButton];
    
    startTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 195, fHeight-5)];
    startTimeLabel.backgroundColor=[UIColor clearColor];
    startTimeLabel.textColor=UIColorFromRGB(rgbValue_broadBand_textfieldText);
    startTimeLabel.font=[UIFont fontWithName:appTypeFace size:16];
    startTimeLabel.text=@"选择开始时间";
    startTimeLabel.adjustsFontSizeToFitWidth=YES;
    [complainStartTimeButton addSubview:startTimeLabel];
    
    UIImageView *jiantou2=[[UIImageView alloc]initWithFrame:CGRectMake(290, 12, 20, 20)];
    jiantou2.image=[UIImage imageNamed:@"msg_more"];
    [complainStartTimeView addSubview:jiantou2];
    
    UILabel *complainStartTimeTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    complainStartTimeTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [complainStartTimeView addSubview:complainStartTimeTextLine];
    
    UIView *complainEndTimeView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*3, SCREEN_WIDTH, fHeight)];
    complainEndTimeView.backgroundColor = [UIColor clearColor];
    [complainContentInfoView addSubview:complainEndTimeView];
    
    UILabel *complainEndTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    complainEndTimeLabel.backgroundColor = [UIColor clearColor];
    complainEndTimeLabel.text = @"*结束时间:";
    complainEndTimeLabel.textAlignment=NSTextAlignmentRight;
    complainEndTimeLabel.font = [UIFont fontWithName:appTypeFace size:16];
    complainEndTimeLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [complainEndTimeView addSubview:complainEndTimeLabel];
    
    UIButton *complainEndTimeButton=[[UIButton alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    complainEndTimeButton.backgroundColor=[UIColor clearColor];
    [complainEndTimeButton addTarget:self action:@selector(showComplainEndTimePicker) forControlEvents:UIControlEventTouchUpInside];
    complainEndTimeButton.tag=BUTTON_TAG+3;
    [complainEndTimeView addSubview:complainEndTimeButton];
    
    endTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 195, fHeight-5)];
    endTimeLabel.backgroundColor=[UIColor clearColor];
    endTimeLabel.textColor=UIColorFromRGB(rgbValue_broadBand_textfieldText);
    endTimeLabel.font=[UIFont fontWithName:appTypeFace size:16];
    endTimeLabel.text=@"选择结束时间";
    endTimeLabel.adjustsFontSizeToFitWidth=YES;
    [complainEndTimeButton addSubview:endTimeLabel];
    
    UIImageView *jiantou3=[[UIImageView alloc]initWithFrame:CGRectMake(290, 12, 20, 20)];
    jiantou3.image=[UIImage imageNamed:@"msg_more"];
    [complainEndTimeView addSubview:jiantou3];
    
    UILabel *complainEndTimeTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    complainEndTimeTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [complainEndTimeView addSubview:complainEndTimeTextLine];
    
    UIView *commitView=[[UIView alloc]initWithFrame:CGRectMake(0, fHeight*5+20, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT-fHeight*5-20)];
    commitView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    [homeScrollView addSubview:commitView];
    
    UILabel *commitLine=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    commitLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [commitView addSubview:commitLine];
    
    UIButton *commitButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 44)];
    commitButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    commitButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:20];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //4个参数是上边界，左边界，下边界，右边界
    [commitButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:commitButton];
    [commitView addSubview:commitButton];
    
    [homeScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT)];
    
    backComplainTypeView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-216-44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT)];
    backComplainTypeView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:backComplainTypeView];
    backComplainTypeView.hidden=YES;
    
    UIToolbar *selectComplainTypeTooler = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UIPickerView *selectComplainTypePicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
    
    [selectComplainTypeTooler setBarStyle:UIBarStyleDefault];
    [selectComplainTypeTooler setBackgroundColor:[UIColor blackColor]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [selectComplainTypePicker setBackgroundColor:[UIColor whiteColor]];
    }
    
    NSMutableArray *buttons1 = [[NSMutableArray alloc] initWithCapacity:3];
    UIBarButtonItem *locationBarButtonItemButtonCan1 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(selectComplainTypePickerCancel)];
    [buttons1 addObject:locationBarButtonItemButtonCan1];
    
    
    UIBarButtonItem *flexibleSpaceItem1;
    flexibleSpaceItem1 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self  action:NULL];
    [buttons1 addObject:flexibleSpaceItem1];
    
    
    UIBarButtonItem *locationBarButtonItemButtonCom1 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectComplainTypePickerSure)];
    [buttons1 addObject:locationBarButtonItemButtonCom1];
    [selectComplainTypeTooler setItems:buttons1 animated:NO];
    selectComplainTypePicker.delegate=self;
    selectComplainTypePicker.tag=2001;
    selectComplainTypePicker.showsSelectionIndicator = YES;
    [backComplainTypeView addSubview:selectComplainTypeTooler];
    [backComplainTypeView addSubview:selectComplainTypePicker];
    
    backStartTimeView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-216-44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT)];
    backStartTimeView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:backStartTimeView];
    backStartTimeView.hidden=YES;
    
    UIToolbar *startTimeTooler = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UIDatePicker *startTimePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
    
    [startTimeTooler setBarStyle:UIBarStyleDefault];
    [startTimeTooler setBackgroundColor:[UIColor blackColor]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [startTimePicker setBackgroundColor:[UIColor whiteColor]];
    }
    
    NSMutableArray *buttons2 = [[NSMutableArray alloc] initWithCapacity:3];
    UIBarButtonItem *locationBarButtonItemButtonCan2 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(startTimePickerCancel)];
    [buttons2 addObject:locationBarButtonItemButtonCan2];
    
    
    UIBarButtonItem *flexibleSpaceItem2;
    flexibleSpaceItem2 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self  action:NULL];
    [buttons2 addObject:flexibleSpaceItem2];
    
    UIBarButtonItem *locationBarButtonItemButtonCom2 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(startTimePickerSure)];
    [buttons2 addObject:locationBarButtonItemButtonCom2];
    [startTimeTooler setItems:buttons2 animated:NO];
    startTimePicker.datePickerMode=UIDatePickerModeDate;
    startTimePicker.maximumDate=[NSDate date];
    startTimePicker.tag=2002;
    [startTimePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
    [backStartTimeView addSubview:startTimeTooler];
    [backStartTimeView addSubview:startTimePicker];
    
    backEndTimeView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-216-44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT)];
    backEndTimeView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:backEndTimeView];
    backEndTimeView.hidden=YES;
    
    UIToolbar *endTimeTooler = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UIDatePicker *endTimePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
    
    [endTimeTooler setBarStyle:UIBarStyleDefault];
    [endTimeTooler setBackgroundColor:[UIColor blackColor]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [endTimePicker setBackgroundColor:[UIColor whiteColor]];
    }
    
    NSMutableArray *buttons3 = [[NSMutableArray alloc] initWithCapacity:3];
    UIBarButtonItem *locationBarButtonItemButtonCan3 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(endTimePickerCancel)];
    [buttons3 addObject:locationBarButtonItemButtonCan3];
    
    
    UIBarButtonItem *flexibleSpaceItem3;
    flexibleSpaceItem3 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self  action:NULL];
    [buttons3 addObject:flexibleSpaceItem3];
    
    UIBarButtonItem *locationBarButtonItemButtonCom3 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(endTimePickerSure)];
    [buttons3 addObject:locationBarButtonItemButtonCom3];
    [endTimeTooler setItems:buttons3 animated:NO];
    endTimePicker.datePickerMode=UIDatePickerModeDate;
    endTimePicker.maximumDate=[NSDate date];
    endTimePicker.tag=2003;
    [endTimePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
    [backEndTimeView addSubview:endTimeTooler];
    [backEndTimeView addSubview:endTimePicker];

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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DebugNSLog(@"---------begin---------");
    if(!backComplainTypeView.hidden){
        [self selectComplainTypePickerCancel];
    }
    if(!backStartTimeView.hidden){
        [self startTimePickerCancel];
    }
    if(!backEndTimeView.hidden){
        [self endTimePickerCancel];
    }
    tapGR.enabled=YES;
    CGFloat keyboardHeight = 216.0f;
    //移动试图位置保证输入内容不被键盘遮挡
    if(textField.keyboardType==UIKeyboardTypeDefault){
        keyboardHeight = 216.0f+30.0f;
    }
    float moveHeight = 0.0f;
    float textViewHeight = fHeight*(textField.tag-TEXTFIELD_TAG)+fHeight*2;
    
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
    if(textField.tag ==TEXTFIELD_TAG+1){
        if(range.location>=11){
            return NO;
        }
        return YES;
    }else{
        return YES;
    }
}

/*acceptFrom
 sheetType
 serviceNumber
 beginTime
 endTime
*/
-(void)buttonPressed{
    NSString *complainPhone=[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG+1] text];
    NSString *complainType=selectComplainTypeLabel.text;
    NSString *complainStartTime=startTimeLabel.text;
    NSString *complainEndTime=endTimeLabel.text;
    if(![complainPhone isEqualToString:@""]&&complainPhone!=nil&&![complainType isEqualToString:@"选择投诉类型"]&&complainType!=nil&&![complainStartTime isEqualToString:@"选择开始时间"]&&complainStartTime!=nil&&![complainEndTime isEqualToString:@"选择结束时间"]&&complainEndTime!=nil){
        
        [HUD showTextHUDWithVC:self.navigationController.view];
        
        NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:@"queryComplainList"];
        [requestBeanDic setObject:@"30" forKey:@"acceptFrom"];
        [requestBeanDic setObject:[[complainTypeArray objectAtIndex:selectComplainTypeRow] objectForKey:@"complainTypeCode"] forKey:@"sheetType"];
        [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"serviceNumber"];
        [requestBeanDic setObject:[NSString stringWithFormat:@"%@ 00:00:00",complainStartTime] forKey:@"beginTime"];
        [requestBeanDic setObject:[NSString stringWithFormat:@"%@ 23:59:59",complainEndTime] forKey:@"endTime"];
        [requestBeanDic setObject:@"123456" forKey:@"SERIAL_NUMBER"];
        [httpRequest startAsynchronous:@"queryComplainList" requestParamData:requestBeanDic viewController:self];
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
    NSDictionary *dic=[array objectAtIndex:0];
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        MyMobileServiceYNCustComplainHistoryListVC *custComplainHistoryListVC=[[MyMobileServiceYNCustComplainHistoryListVC alloc]init];
        custComplainHistoryListVC.complainHistoryArray=array;
        [self.navigationController pushViewController:custComplainHistoryListVC animated:YES];
    }else{
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
    NSString *returnMessage = [returnMessageDeal returnMessage:@"网络异常" andreturnMessage:@""];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN+2;
    [alertView show];
    if(HUD){
        [HUD removeHUD];
    }
}

#pragma mark  -- AlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (ALERTVIEW_TAG_RETURN+1 == alertView.tag){
        
    }else if(ALERTVIEW_TAG_RETURN+2 == alertView.tag){
        
    }else if(ALERTVIEW_TAG_RETURN+100 == alertView.tag){
        
    }else if(ALERTVIEW_TAG+1 == alertView.tag){
        
    }
}

-(void)showComplainTypePicker{
    if(!backStartTimeView.hidden){
        backStartTimeView.hidden=YES;
        CATransition *animation2 = [CATransition animation];
        [animation2 setDuration:0.5f];
        [animation2 setType:kCATransitionPush];
        [animation2 setSubtype:kCATransitionFromBottom];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [backStartTimeView.layer addAnimation:animation2 forKey:@"fade"];
    }
    if(!backEndTimeView.hidden){
        backEndTimeView.hidden=YES;
        CATransition *animation2 = [CATransition animation];
        [animation2 setDuration:0.5f];
        [animation2 setType:kCATransitionPush];
        [animation2 setSubtype:kCATransitionFromBottom];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [backEndTimeView.layer addAnimation:animation2 forKey:@"fade"];
    }
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:NO];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+3] setEnabled:YES];
    tapGR.enabled=NO;
    
    backComplainTypeView.hidden=NO;
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromTop];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backComplainTypeView.layer addAnimation:animation1 forKey:@"fade"];
}

-(void)showComplainStartTimePicker{
    if(!backComplainTypeView.hidden){
        backComplainTypeView.hidden=YES;
        CATransition *animation2 = [CATransition animation];
        [animation2 setDuration:0.5f];
        [animation2 setType:kCATransitionPush];
        [animation2 setSubtype:kCATransitionFromBottom];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [backComplainTypeView.layer addAnimation:animation2 forKey:@"fade"];
    }
    if(!backEndTimeView.hidden){
        backEndTimeView.hidden=YES;
        CATransition *animation2 = [CATransition animation];
        [animation2 setDuration:0.5f];
        [animation2 setType:kCATransitionPush];
        [animation2 setSubtype:kCATransitionFromBottom];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [backEndTimeView.layer addAnimation:animation2 forKey:@"fade"];
    }
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setEnabled:NO];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+3] setEnabled:YES];
    tapGR.enabled=NO;
    
    backStartTimeView.hidden=NO;
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromTop];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backStartTimeView.layer addAnimation:animation1 forKey:@"fade"];
}

-(void)showComplainEndTimePicker{
    if(!backComplainTypeView.hidden){
        backComplainTypeView.hidden=YES;
        CATransition *animation2 = [CATransition animation];
        [animation2 setDuration:0.5f];
        [animation2 setType:kCATransitionPush];
        [animation2 setSubtype:kCATransitionFromBottom];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [backComplainTypeView.layer addAnimation:animation2 forKey:@"fade"];
    }
    if(!backStartTimeView.hidden){
        backStartTimeView.hidden=YES;
        CATransition *animation2 = [CATransition animation];
        [animation2 setDuration:0.5f];
        [animation2 setType:kCATransitionPush];
        [animation2 setSubtype:kCATransitionFromBottom];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [backStartTimeView.layer addAnimation:animation2 forKey:@"fade"];
    }
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+3] setEnabled:NO];
    tapGR.enabled=NO;
    
    backEndTimeView.hidden=NO;
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromTop];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backEndTimeView.layer addAnimation:animation1 forKey:@"fade"];
}

#pragma mark -
#pragma mark 处理方法
// 返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}
// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return complainTypeArray.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectComplainTypeRow=row;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *locationPiclerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    locationPiclerView.textAlignment = UITextAlignmentCenter;
    locationPiclerView.text = [[complainTypeArray objectAtIndex:row] objectForKey:@"complainTypeName"];
    locationPiclerView.font = [UIFont fontWithName:appTypeFace size:16];
    locationPiclerView.adjustsFontSizeToFitWidth=YES;
    locationPiclerView.backgroundColor = [UIColor clearColor];
    return locationPiclerView;
}

-(void)selectComplainTypePickerSure{
    NSString  *result = [[complainTypeArray objectAtIndex:selectComplainTypeRow] objectForKey:@"complainTypeName"];
    selectComplainTypeLabel.text = result;
    [self selectComplainTypePickerCancel];
}

-(void)selectComplainTypePickerCancel{
    backComplainTypeView.hidden=YES;
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+3] setEnabled:YES];
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromBottom];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backComplainTypeView.layer addAnimation:animation1 forKey:@"fade"];
}

-(void)selectDate:(id)sender{
    if([sender tag]==2002){
        UIDatePicker* control = (UIDatePicker *)sender;
        startDate = control.date;
    }else{
        UIDatePicker* control = (UIDatePicker *)sender;
        endDate = control.date;
    }
}

-(void)startTimePickerSure{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    startTimeLabel.text = [dateformatter stringFromDate:startDate];
    [self startTimePickerCancel];
}

-(void)startTimePickerCancel{
    backStartTimeView.hidden=YES;
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+3] setEnabled:YES];
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromBottom];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backStartTimeView.layer addAnimation:animation1 forKey:@"fade"];
}

-(void)endTimePickerSure{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    endTimeLabel.text = [dateformatter stringFromDate:endDate];
    [self endTimePickerCancel];
}

-(void)endTimePickerCancel{
    backEndTimeView.hidden=YES;
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+3] setEnabled:YES];
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromBottom];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backEndTimeView.layer addAnimation:animation1 forKey:@"fade"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    
}


@end
