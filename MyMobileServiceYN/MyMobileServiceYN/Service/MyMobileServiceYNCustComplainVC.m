//
//  MyMobileServiceYNCustComplainVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-6.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNCustComplainVC.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"

#define fHeight 44

@interface MyMobileServiceYNCustComplainVC ()

@end

@implementation MyMobileServiceYNCustComplainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

-(void)setComplainAddressArray
{
    complainAddressArray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:@"0871" forKey:@"cityCode"];
    [dic1 setObject:@"昆明" forKey:@"cityName"];
    [complainAddressArray addObject:dic1];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
    [dic2 setObject:@"0883" forKey:@"cityCode"];
    [dic2 setObject:@"临沧" forKey:@"cityName"];
    [complainAddressArray addObject:dic2];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
    [dic3 setObject:@"0874" forKey:@"cityCode"];
    [dic3 setObject:@"曲靖" forKey:@"cityName"];
    [complainAddressArray addObject:dic3];
    
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc]init];
    [dic4 setObject:@"0876" forKey:@"cityCode"];
    [dic4 setObject:@"文山" forKey:@"cityName"];
    [complainAddressArray addObject:dic4];
    
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc]init];
    [dic5 setObject:@"0692" forKey:@"cityCode"];
    [dic5 setObject:@"德宏" forKey:@"cityName"];
    [complainAddressArray addObject:dic5];
    
    NSMutableDictionary *dic6 = [[NSMutableDictionary alloc]init];
    [dic6 setObject:@"0887" forKey:@"cityCode"];
    [dic6 setObject:@"迪庆" forKey:@"cityName"];
    [complainAddressArray addObject:dic6];
    
    NSMutableDictionary *dic7 = [[NSMutableDictionary alloc]init];
    [dic7 setObject:@"0879" forKey:@"cityCode"];
    [dic7 setObject:@"普洱" forKey:@"cityName"];
    [complainAddressArray addObject:dic7];
    
    NSMutableDictionary *dic8 = [[NSMutableDictionary alloc]init];
    [dic8 setObject:@"0878" forKey:@"cityCode"];
    [dic8 setObject:@"楚雄" forKey:@"cityName"];
    [complainAddressArray addObject:dic8];
    
    NSMutableDictionary *dic9 = [[NSMutableDictionary alloc]init];
    [dic9 setObject:@"0877" forKey:@"cityCode"];
    [dic9 setObject:@"玉溪" forKey:@"cityName"];
    [complainAddressArray addObject:dic9];
    
    NSMutableDictionary *dic10 = [[NSMutableDictionary alloc]init];
    [dic10 setObject:@"0886" forKey:@"cityCode"];
    [dic10 setObject:@"怒江" forKey:@"cityName"];
    [complainAddressArray addObject:dic10];
    
    NSMutableDictionary *dic11 = [[NSMutableDictionary alloc]init];
    [dic11 setObject:@"0873" forKey:@"cityCode"];
    [dic11 setObject:@"红河" forKey:@"cityName"];
    [complainAddressArray addObject:dic11];
    
    NSMutableDictionary *dic12 = [[NSMutableDictionary alloc]init];
    [dic12 setObject:@"0888" forKey:@"cityCode"];
    [dic12 setObject:@"丽江" forKey:@"cityName"];
    [complainAddressArray addObject:dic12];
    
    NSMutableDictionary *dic13 = [[NSMutableDictionary alloc]init];
    [dic13 setObject:@"0870" forKey:@"cityCode"];
    [dic13 setObject:@"昭通" forKey:@"cityName"];
    [complainAddressArray addObject:dic13];
    
    NSMutableDictionary *dic14 = [[NSMutableDictionary alloc]init];
    [dic14 setObject:@"0691" forKey:@"cityCode"];
    [dic14 setObject:@"西双版纳" forKey:@"cityName"];
    [complainAddressArray addObject:dic14];
    
    NSMutableDictionary *dic15 = [[NSMutableDictionary alloc]init];
    [dic15 setObject:@"0875" forKey:@"cityCode"];
    [dic15 setObject:@"保山" forKey:@"cityName"];
    [complainAddressArray addObject:dic15];
    
    NSMutableDictionary *dic16 = [[NSMutableDictionary alloc]init];
    [dic16 setObject:@"0872" forKey:@"cityCode"];
    [dic16 setObject:@"大理" forKey:@"cityName"];
    [complainAddressArray addObject:dic16];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"投诉建议";
    
    httpRequest=[[MyMobileServiceYNHttpRequest alloc]init];
    [self setComplainTypeArray];
    [self setComplainAddressArray];
    for (int i=0; i<complainAddressArray.count; i++) {
        if([[[complainAddressArray objectAtIndex:i] objectForKey:@"cityCode"] isEqualToString:[MyMobileServiceYNParam getCityCode]]){
            selectComplainAddressRow=i;
        }
    }

    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT)];
    homeScrollView.backgroundColor = [UIColor clearColor];
    homeScrollView.delegate = self;
    homeScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:homeScrollView];
    
    //手势
	tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
	tapGR.cancelsTouchesInView=NO;
	[homeScrollView addGestureRecognizer:tapGR];
    
    UIView *custInfoView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fHeight*5)];
    custInfoView.backgroundColor=[UIColor clearColor];
    [homeScrollView addSubview:custInfoView];
    
    UIView *custHearderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fHeight)];
    custHearderView.backgroundColor=UIColorFromRGB(rgbValueBgGrey);
    [custInfoView addSubview:custHearderView];
    
    UIImageView *custImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    custImageView.image=[UIImage imageNamed:@"msg_lishitousuico"];
    [custHearderView addSubview:custImageView];
    
    UILabel *custHeaderLabel=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 80, 44)];
    custHeaderLabel.backgroundColor=[UIColor clearColor];
    custHeaderLabel.font=[UIFont fontWithName:appTypeFace size:18];
    custHeaderLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    custHeaderLabel.text=@"用户信息";
    [custHearderView addSubview:custHeaderLabel];
    
    UILabel *custHeaderLabel2=[[UILabel alloc]initWithFrame:CGRectMake(124, 8, 150, 32)];
    custHeaderLabel2.backgroundColor=[UIColor clearColor];
    custHeaderLabel2.font=[UIFont fontWithName:appTypeFace size:14];
    custHeaderLabel2.textColor=UIColorFromRGB(rgbValueDeepGrey);
    custHeaderLabel2.text=@"(带*号的必填)";
    [custHearderView addSubview:custHeaderLabel2];
    
    UIView *custContentInfoView=[[UIView alloc]initWithFrame:CGRectMake(0, fHeight, SCREEN_WIDTH, fHeight*4)];
    custContentInfoView.backgroundColor=[UIColor clearColor];
    [custInfoView addSubview:custContentInfoView];
    
    UIView *complainPhoneView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*0, SCREEN_WIDTH, fHeight)];
    complainPhoneView.backgroundColor = [UIColor clearColor];
    [custContentInfoView addSubview:complainPhoneView];
    
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
    
    UIView *complainNameView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*1, SCREEN_WIDTH, fHeight)];
    complainNameView.backgroundColor = [UIColor clearColor];
    [custContentInfoView addSubview:complainNameView];
    
    UILabel *complainNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    complainNameLabel.backgroundColor = [UIColor clearColor];
    complainNameLabel.text = @"联系人:";
    complainNameLabel.textAlignment=NSTextAlignmentRight;
    complainNameLabel.font = [UIFont fontWithName:appTypeFace size:16];
    complainNameLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [complainNameView addSubview:complainNameLabel];
    
    UITextField *complainNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    [complainNameTextField setBorderStyle:UITextBorderStyleNone];
    [complainNameTextField setBackgroundColor:[UIColor clearColor]];
    complainNameTextField.tag = TEXTFIELD_TAG + 2;
    complainNameTextField.text = @"";
    complainNameTextField.placeholder = @"请输入联系人";
    //设置输入框内容的字体样式和大小
    complainNameTextField.font = [UIFont fontWithName:appTypeFace size:16];
    //设置字体颜色
    complainNameTextField.textColor = UIColorFromRGB(rgbValueDeepGrey);
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    //    [complainPhoneTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    complainNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    complainNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    complainNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    complainNameTextField.keyboardType = UIKeyboardTypeDefault;
    //return键变成什么键
    complainNameTextField.returnKeyType =UIReturnKeyDone;
    complainNameTextField.delegate = self;
    [complainNameView addSubview:complainNameTextField];
    
    UILabel *complainNameTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    complainNameTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [complainNameView addSubview:complainNameTextLine];
    
    UIView *complainContactPhoneView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*2, SCREEN_WIDTH, fHeight)];
    complainContactPhoneView.backgroundColor = [UIColor clearColor];
    [custContentInfoView addSubview:complainContactPhoneView];
    
    UILabel *complainContactPhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    complainContactPhoneLabel.backgroundColor = [UIColor clearColor];
    complainContactPhoneLabel.text = @"联系电话:";
    complainContactPhoneLabel.textAlignment=NSTextAlignmentRight;
    complainContactPhoneLabel.font = [UIFont fontWithName:appTypeFace size:16];
    complainContactPhoneLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [complainContactPhoneView addSubview:complainContactPhoneLabel];
    
    UITextField *complainContactPhoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    [complainContactPhoneTextField setBorderStyle:UITextBorderStyleNone];
    [complainContactPhoneTextField setBackgroundColor:[UIColor clearColor]];
    complainContactPhoneTextField.tag = TEXTFIELD_TAG + 3;
    complainContactPhoneTextField.text = @"";
    complainContactPhoneTextField.placeholder = @"请输入联系电话";
    //设置输入框内容的字体样式和大小
    complainContactPhoneTextField.font = [UIFont fontWithName:appTypeFace size:16];
    //设置字体颜色
    complainContactPhoneTextField.textColor = UIColorFromRGB(rgbValueDeepGrey);
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    //    [complainPhoneTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    complainContactPhoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    complainContactPhoneTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    complainContactPhoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    complainContactPhoneTextField.keyboardType = UIKeyboardTypePhonePad;
    //return键变成什么键
    complainContactPhoneTextField.returnKeyType =UIReturnKeyDone;
    complainContactPhoneTextField.delegate = self;
    [complainContactPhoneView addSubview:complainContactPhoneTextField];
    
    UILabel *complainContactPhoneTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    complainContactPhoneTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [complainContactPhoneView addSubview:complainContactPhoneTextLine];
    
    UIView *complainContactAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*3, SCREEN_WIDTH, fHeight)];
    complainContactAddressView.backgroundColor = [UIColor clearColor];
    [custContentInfoView addSubview:complainContactAddressView];
    
    UILabel *complainContactAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    complainContactAddressLabel.backgroundColor = [UIColor clearColor];
    complainContactAddressLabel.text = @"联系地址:";
    complainContactAddressLabel.textAlignment=NSTextAlignmentRight;
    complainContactAddressLabel.font = [UIFont fontWithName:appTypeFace size:16];
    complainContactAddressLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [complainContactAddressView addSubview:complainContactAddressLabel];
    
    UITextField *complainContactAddressTextField = [[UITextField alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    [complainContactAddressTextField setBorderStyle:UITextBorderStyleNone];
    [complainContactAddressTextField setBackgroundColor:[UIColor clearColor]];
    complainContactAddressTextField.tag = TEXTFIELD_TAG + 4;
    complainContactAddressTextField.text = @"";
    complainContactAddressTextField.placeholder = @"请输入联系地址";
    //设置输入框内容的字体样式和大小
    complainContactAddressTextField.font = [UIFont fontWithName:appTypeFace size:16];
    //设置字体颜色
    complainContactAddressTextField.textColor = UIColorFromRGB(rgbValueDeepGrey);
    //设置焦点,进入界面后，设置焦点为该区域，自动弹出键盘，设置唯一一个
    //    [complainPhoneTextField becomeFirstResponder];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    complainContactAddressTextField.clearButtonMode = UITextFieldViewModeAlways;
    complainContactAddressTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    complainContactAddressTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    //设置键盘的样式
    complainContactAddressTextField.keyboardType = UIKeyboardTypeDefault;
    //return键变成什么键
    complainContactAddressTextField.returnKeyType =UIReturnKeyDone;
    complainContactAddressTextField.delegate = self;
    [complainContactAddressView addSubview:complainContactAddressTextField];
    
    UILabel *complainContactAddressTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    complainContactAddressTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [complainContactAddressView addSubview:complainContactAddressTextLine];
    

    //==================================================
    
    
    
    UIView *complainInfoView=[[UIView alloc]initWithFrame:CGRectMake(0, fHeight*5+10, SCREEN_WIDTH, fHeight*6+10)];
    complainInfoView.backgroundColor=[UIColor clearColor];
    [homeScrollView addSubview:complainInfoView];
    
    UIView *complainHearderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fHeight)];
    complainHearderView.backgroundColor=UIColorFromRGB(rgbValueBgGrey);
    [complainInfoView addSubview:complainHearderView];
    
    UIImageView *complainImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    complainImageView.image=[UIImage imageNamed:@"msg_lishitousuico2"];
    [complainHearderView addSubview:complainImageView];
    
    UILabel *complainHeaderLabel=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 80, 44)];
    complainHeaderLabel.backgroundColor=[UIColor clearColor];
    complainHeaderLabel.font=[UIFont fontWithName:appTypeFace size:18];
    complainHeaderLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    complainHeaderLabel.text=@"投诉信息";
    [complainHearderView addSubview:complainHeaderLabel];
    
    UILabel *complainHeaderLabel2=[[UILabel alloc]initWithFrame:CGRectMake(124, 8, 150, 32)];
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
    
    UIView *complainAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*1, SCREEN_WIDTH, fHeight)];
    complainAddressView.backgroundColor = [UIColor clearColor];
    [complainContentInfoView addSubview:complainAddressView];
    
    UILabel *complainAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 90, fHeight-5)];
    complainAddressLabel.backgroundColor = [UIColor clearColor];
    complainAddressLabel.text = @"投诉地州:";
    complainAddressLabel.textAlignment=NSTextAlignmentRight;
    complainAddressLabel.font = [UIFont fontWithName:appTypeFace size:16];
    complainAddressLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [complainAddressView addSubview:complainAddressLabel];
    
    UIButton *complainAddressButton=[[UIButton alloc]initWithFrame:CGRectMake(95, 5, 215, fHeight-5)];
    complainAddressButton.backgroundColor=[UIColor clearColor];
    [complainAddressButton addTarget:self action:@selector(showComplainAddressPicker) forControlEvents:UIControlEventTouchUpInside];
    complainAddressButton.tag=BUTTON_TAG+2;
    [complainAddressView addSubview:complainAddressButton];
    
    selectComplainAddressLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 195, fHeight-5)];
    selectComplainAddressLabel.backgroundColor=[UIColor clearColor];
    selectComplainAddressLabel.textColor=UIColorFromRGB(rgbValue_broadBand_textfieldText);
    selectComplainAddressLabel.font=[UIFont fontWithName:appTypeFace size:16];
    selectComplainAddressLabel.text=[MyMobileServiceYNParam getCityName];
    selectComplainAddressLabel.adjustsFontSizeToFitWidth=YES;
    [complainAddressButton addSubview:selectComplainAddressLabel];
    
    UIImageView *jiantou2=[[UIImageView alloc]initWithFrame:CGRectMake(290, 12, 20, 20)];
    jiantou2.image=[UIImage imageNamed:@"msg_more"];
    [complainAddressView addSubview:jiantou2];
    
    UILabel *complainAddressTextLine=[[UILabel alloc]initWithFrame:CGRectMake(90, fHeight-0.5, 220, 0.5)];
    complainAddressTextLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [complainAddressView addSubview:complainAddressTextLine];
    
    UIView *complainDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, fHeight*2+10, SCREEN_WIDTH, fHeight*3)];
    complainDetailView.backgroundColor = [UIColor clearColor];
    [complainContentInfoView addSubview:complainDetailView];
    
    UILabel *complainDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    complainDetailLabel.backgroundColor = [UIColor clearColor];
    complainDetailLabel.text = @"投诉内容:";
    complainDetailLabel.textAlignment=NSTextAlignmentRight;
    complainDetailLabel.font = [UIFont fontWithName:appTypeFace size:16];
    complainDetailLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    [complainDetailView addSubview:complainDetailLabel];
    
    UILabel *complainDetailLabel2=[[UILabel alloc]initWithFrame:CGRectMake(95, 0, 150, 30)];
    complainDetailLabel2.backgroundColor=[UIColor clearColor];
    complainDetailLabel2.font=[UIFont fontWithName:appTypeFace size:14];
    complainDetailLabel2.textColor=[UIColor redColor];
    complainDetailLabel2.text=@"(内容不能为空)";
    [complainDetailView addSubview:complainDetailLabel2];
    
    UITextView *complainDetailTextView=[[UITextView alloc]initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-40, fHeight*3-30)];
    complainDetailTextView.backgroundColor=[UIColor whiteColor];
    complainDetailTextView.delegate=self;
    complainDetailTextView.tag=1;
    complainDetailTextView.font = [UIFont fontWithName:appTypeFace size:16.0];//设置字体名字和字体大小
    complainDetailTextView.returnKeyType = UIReturnKeyDone;//返回键的类型
    complainDetailTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    complainDetailTextView.scrollEnabled = YES;//是否可以拖动
    [complainDetailTextView.layer setBorderColor: [UIColorFromRGB(rgbValueLineGrey) CGColor]];
    [complainDetailTextView.layer setBorderWidth: 1.0];  //边框宽度
    [complainDetailTextView.layer setCornerRadius:3.0f]; //边框弧度
    [complainDetailTextView.layer setMasksToBounds:YES];
    [complainDetailView addSubview:complainDetailTextView];
    
    UIView *commitView=[[UIView alloc]initWithFrame:CGRectMake(0, fHeight*11+30, SCREEN_WIDTH, 64)];
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
    
    [homeScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, fHeight*11+94)];
    
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
    
    backComplainAddressView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-216-44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT)];
    backComplainAddressView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:backComplainAddressView];
    backComplainAddressView.hidden=YES;
    
    UIToolbar *selectComplainAddressToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UIPickerView *selectComplainAddressPicker =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
    
    [selectComplainAddressToolbar setBarStyle:UIBarStyleDefault];
    [selectComplainAddressToolbar setBackgroundColor:[UIColor blackColor]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [selectComplainAddressPicker setBackgroundColor:[UIColor whiteColor]];
    }
    
    NSMutableArray *buttons2 = [[NSMutableArray alloc] initWithCapacity:3];
    UIBarButtonItem *locationBarButtonItemButtonCan2 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(selectComplainAddressPickerCancel)];
    [buttons2 addObject:locationBarButtonItemButtonCan2];
    
    
    UIBarButtonItem *flexibleSpaceItem2;
    flexibleSpaceItem2 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self  action:NULL];
    [buttons2 addObject:flexibleSpaceItem2];
    
    
    UIBarButtonItem *locationBarButtonItemButtonCom2 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectComplainAddressPickerSure)];
    [buttons2 addObject:locationBarButtonItemButtonCom2];
    [selectComplainAddressToolbar setItems:buttons2 animated:NO];
    selectComplainAddressPicker.delegate=self;
    selectComplainAddressPicker.tag=2003;
    selectComplainAddressPicker.showsSelectionIndicator = YES;
    [backComplainAddressView addSubview:selectComplainAddressToolbar];
    [backComplainAddressView addSubview:selectComplainAddressPicker];
    [selectComplainAddressPicker selectRow:selectComplainAddressRow inComponent:0 animated:NO];
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
    [(UITextView *)[self.view viewWithTag:1] resignFirstResponder];
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
    if(!backComplainAddressView.hidden){
        [self selectComplainAddressPickerCancel];
    }
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
    if(textField.tag ==TEXTFIELD_TAG+1){
        if(range.location>=11){
            return NO;
        }
        return YES;
    }else if(textField.tag ==TEXTFIELD_TAG+2){
        if(range.location >= 12){
            return NO;
        }
        return YES;
    }
    else if(textField.tag ==TEXTFIELD_TAG+3){
        if(range.location >= 15){
            return NO;
        }
        return YES;
    }
    else if(textField.tag ==TEXTFIELD_TAG+4){
        if(range.location >= 16){
            return NO;
        }
        return YES;
    }
    else{
        return YES;
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    DebugNSLog(@"---------begin---------");
    tapGR.enabled=YES;
    //移动试图位置保证输入内容不被键盘遮挡
    CGFloat keyboardHeight = 216.0f;
    if(textView.keyboardType==UIKeyboardTypeDefault){
        keyboardHeight = 216.0f+30.0f;
    }
    float moveHeight = 0.0f;
    
    if(!(homeScrollView.frame.size.height - keyboardHeight > fHeight*11+10 ))
    {
        if(homeScrollView.contentOffset.y==0){
            moveHeight = fHeight*11+10 - (homeScrollView.frame.size.height - keyboardHeight);
        }else{
            moveHeight = fHeight*11+10 - homeScrollView.contentOffset.y - (homeScrollView.frame.size.height - keyboardHeight);
        }
        DebugNSLog(@"%f",moveHeight);
        
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(range.location >= 250){
        return NO;
    }
    return YES;
}

/*serialNumber
acceptFrom
sheetType
serviceNumber
complainContent
userName
complainLocation
contactPhone
contactAddress
userRegion
userType
*/
-(void)buttonPressed{
    NSString *complainPhone=[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG+1] text];
    NSString *contactName=[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG+2] text];
    NSString *contactPhone=[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG+3] text];
    NSString *contactAddress=[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG+4] text];
    NSString *complainType=selectComplainTypeLabel.text;
    NSString *complainDetail=[(UITextView *)[self.view viewWithTag:1] text];
    if(![complainPhone isEqualToString:@""]&&complainPhone!=nil&&![complainType isEqualToString:@"选择投诉类型"]&&complainType!=nil&&![complainDetail isEqualToString:@""]&&complainDetail!=nil){
        
        [HUD showTextHUDWithVC:self.navigationController.view];
        
        NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:@"newComplain"];
        [requestBeanDic setObject:@"123456" forKey:@"SERIAL_NUMBER"];
        [requestBeanDic setObject:@"30" forKey:@"acceptFrom"];
        [requestBeanDic setObject:[[complainTypeArray objectAtIndex:selectComplainTypeRow] objectForKey:@"complainTypeCode"] forKey:@"sheetType"];
        [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"serviceNumber"];
        [requestBeanDic setObject:complainDetail forKey:@"complainContent"];
        [requestBeanDic setObject:contactName forKey:@"userName"];
//        [requestBeanDic setObject:[[complainAddressArray objectAtIndex:selectComplainAddressRow] objectForKey:@"cityCode"] forKey:@"complainLocation"];
        [requestBeanDic setObject:@"" forKey:@"complainLocation"];
        [requestBeanDic setObject:contactPhone forKey:@"contactPhone"];
        [requestBeanDic setObject:contactAddress forKey:@"contactAddress"];
        [requestBeanDic setObject:[MyMobileServiceYNParam getCityName] forKey:@"userRegion"];
        [requestBeanDic setObject:@"" forKey:@"userType"];
        [httpRequest startAsynchronous:@"newComplain" requestParamData:requestBeanDic viewController:self];
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

    NSDictionary *dic = [[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil] objectAtIndex:0];
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您提交的单子已受理，我们将尽快为您处理，您可以通过历史投诉查询进度。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG_RETURN+100;
        [alertView show];
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

-(void)backButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark  -- AlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (ALERTVIEW_TAG_RETURN+1 == alertView.tag){
        [self backButtonPressed];
    }else if(ALERTVIEW_TAG_RETURN+2 == alertView.tag){
        [self backButtonPressed];
    }else if(ALERTVIEW_TAG_RETURN+100 == alertView.tag){
        [self backButtonPressed];
    }else if(ALERTVIEW_TAG+1 == alertView.tag){
        
    }
}

-(void)showComplainTypePicker{
    if(!backComplainAddressView.hidden){
        backComplainAddressView.hidden=YES;
        CATransition *animation2 = [CATransition animation];
        [animation2 setDuration:0.5f];
        [animation2 setType:kCATransitionPush];
        [animation2 setSubtype:kCATransitionFromBottom];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [backComplainAddressView.layer addAnimation:animation2 forKey:@"fade"];
    }
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:NO];
    tapGR.enabled=NO;
    
    backComplainTypeView.hidden=NO;
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromTop];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backComplainTypeView.layer addAnimation:animation1 forKey:@"fade"];
    
    CGFloat pickerHeight = 216 + 44;
    if(SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT - pickerHeight < fHeight*7){
        CGFloat moveHeight=SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT - pickerHeight-fHeight*7;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:homeScrollView];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.275f];
        homeScrollView.frame = CGRectMake(0, moveHeight, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT);
        [UIView commitAnimations];
    }
}

-(void)showComplainAddressPicker{
    if(!backComplainTypeView.hidden){
        backComplainTypeView.hidden=YES;
        CATransition *animation2 = [CATransition animation];
        [animation2 setDuration:0.5f];
        [animation2 setType:kCATransitionPush];
        [animation2 setSubtype:kCATransitionFromBottom];
        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [backComplainTypeView.layer addAnimation:animation2 forKey:@"fade"];
    }
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setEnabled:NO];
    tapGR.enabled=NO;
    
    backComplainAddressView.hidden=NO;
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromTop];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backComplainAddressView.layer addAnimation:animation1 forKey:@"fade"];
    
    CGFloat pickerHeight = 216 + 44;
    if(SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT - pickerHeight < fHeight*8){
        CGFloat moveHeight=SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT - pickerHeight-fHeight*8;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:homeScrollView];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.275f];
        homeScrollView.frame = CGRectMake(0, moveHeight, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT);
        [UIView commitAnimations];
    }
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
    if(pickerView.tag==2001){
        return complainTypeArray.count;
    }else{
        return complainAddressArray.count;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag==2001){
        selectComplainTypeRow=row;
    }else{
        selectComplainAddressRow=row;
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *locationPiclerView = nil;
    if(pickerView.tag == 2001){
        locationPiclerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        locationPiclerView.textAlignment = UITextAlignmentCenter;
        locationPiclerView.text = [[complainTypeArray objectAtIndex:row] objectForKey:@"complainTypeName"];
        locationPiclerView.font = [UIFont fontWithName:appTypeFace size:16];
        locationPiclerView.adjustsFontSizeToFitWidth=YES;
        locationPiclerView.backgroundColor = [UIColor clearColor];
    }else{
        locationPiclerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        locationPiclerView.textAlignment = UITextAlignmentCenter;
        locationPiclerView.text = [[complainAddressArray objectAtIndex:row] objectForKey:@"cityName"];
        locationPiclerView.font = [UIFont fontWithName:appTypeFace size:16];
        locationPiclerView.adjustsFontSizeToFitWidth=YES;
        locationPiclerView.backgroundColor = [UIColor clearColor];
    }
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
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromBottom];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backComplainTypeView.layer addAnimation:animation1 forKey:@"fade"];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:homeScrollView];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    homeScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT);
    [UIView commitAnimations];
}

-(void)selectComplainAddressPickerSure{
    NSString  *result = [[complainAddressArray objectAtIndex:selectComplainAddressRow] objectForKey:@"cityName"];
    selectComplainAddressLabel.text = result;
    [self selectComplainAddressPickerCancel];
}

-(void)selectComplainAddressPickerCancel{
    backComplainAddressView.hidden=YES;
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:YES];
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setEnabled:YES];
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromBottom];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backComplainAddressView.layer addAnimation:animation1 forKey:@"fade"];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:homeScrollView];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    homeScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark-- 为了防止程序异常，需要手动清除代理，在此方法里面进行清除
-(void)dealloc {
    [httpRequest setRequestDelegatNil];
}


@end
