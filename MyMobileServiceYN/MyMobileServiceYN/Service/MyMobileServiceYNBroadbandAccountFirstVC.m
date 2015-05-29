//
//  MyMobileServiceYNBroadbandAccountFirstVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-1.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBroadbandAccountFirstVC.h"
#import "MyMobileServiceYNBroadbandAccountSecondVC.h"
#import "MyMobileServiceYNBroadbandAccountQueryVC.h"
#import "MyMobileServiceYNStepCircleView.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNBroadbandAccountFifthVC.h"

#define fheight 44

@interface MyMobileServiceYNBroadbandAccountFirstVC ()

@end

@implementation MyMobileServiceYNBroadbandAccountFirstVC

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
    
    self.title=@"新装宽带";
    
    busiCode=@"";
    httpRequest=[[MyMobileServiceYNHttpRequest alloc]init];
    countryArray=[[NSMutableArray alloc]init];
    neighborArray=[[NSMutableArray alloc]init];
    sectionArray=[[NSMutableArray alloc]init];
    
    addressInfo=[[NSDictionary alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toQueryAddress:) name:@"toSelectAddress" object:nil];
    
    [self queryInternet];
//    [self drawFinishBand:nil];
}

//宽带预约第一步view
-(void)drawBroadBand{
//    UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
//	tapGR.cancelsTouchesInView=NO;
//	[self.view addGestureRecognizer:tapGR];
    
    homeScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT)];
    homeScrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:homeScrollView];
    
    UIView *firstView=[MyMobileServiceYNStepCircleView setStepView:1 withString:@"选择装机地址"];
    [homeScrollView addSubview:firstView];
    
    UIView *secondView=[[UIView alloc]initWithFrame:CGRectMake(0, 88, SCREEN_WIDTH, 256)];
    secondView.backgroundColor=[UIColor clearColor];
    [homeScrollView addSubview:secondView];
    
    UILabel *cityLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 44)];
    cityLabel.backgroundColor=[UIColor clearColor];
    cityLabel.textColor=UIColorFromRGB(rgbValue_packageInfo_headerLabel);
    cityLabel.font=[UIFont fontWithName:appTypeFaceBold size:25];
    cityLabel.text=[MyMobileServiceYNParam getCityName];
    [secondView addSubview:cityLabel];
    
    CGSize labelSize=[cityLabel.text sizeWithFont:[UIFont fontWithName:appTypeFaceBold size:25] constrainedToSize:CGSizeMake(85, 50) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(labelSize.width+20, 25, 220, 20)];
    phoneLabel.backgroundColor=[UIColor clearColor];
    phoneLabel.textColor=UIColorFromRGB(rgbValue_packageInfo_headerLabel);
    phoneLabel.font=[UIFont fontWithName:appTypeFace size:14];
    phoneLabel.text=[NSString stringWithFormat:@"(登录号码 %@ 所在地州)",[MyMobileServiceYNParam getSerialNumber]];
    [secondView addSubview:phoneLabel];
    
    selectAddress=[[UIButton alloc]initWithFrame:CGRectMake(20, 64, SCREEN_WIDTH-90, 44)];
    selectAddress.backgroundColor=UIColorFromRGB(rgbValue_broadBand_textfieldBackGround);
    [selectAddress addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    [selectAddress.layer setBorderColor:[UIColorFromRGB(rgbValue_scrollLine) CGColor]];
    [selectAddress.layer setBorderWidth:1.0];  //边框宽度
    [selectAddress.layer setCornerRadius:3.0f]; //边框弧度
    [selectAddress.layer setMasksToBounds:YES];
    [secondView addSubview:selectAddress];
    
    countrySelectedLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-110, 44)];
    countrySelectedLabel.backgroundColor=[UIColor clearColor];
    countrySelectedLabel.textColor=UIColorFromRGB(rgbValue_broadBand_textfieldText);
    countrySelectedLabel.font=[UIFont fontWithName:appTypeFace size:18];
    countrySelectedLabel.text=@"点击选择区县";
    countrySelectedLabel.adjustsFontSizeToFitWidth=YES;
    [selectAddress addSubview:countrySelectedLabel];
    
    UIButton *queryAddress=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 64, 40, 44)];
    queryAddress.backgroundColor=[UIColor clearColor];
    [queryAddress setTitle:@"搜索" forState:UIControlStateNormal];
    [queryAddress setTitleColor:UIColorFromRGB(rgbValueTitleBlue) forState:UIControlStateNormal];
    [queryAddress addTarget:self action:@selector(queryAddressList) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:queryAddress];
    
//    selectNeighbour=[[UIButton alloc]initWithFrame:CGRectMake(20, 128, SCREEN_WIDTH-40, 44)];
//    selectNeighbour.backgroundColor=UIColorFromRGB(rgbValue_broadBand_textfieldBackGround);
//    [selectNeighbour addTarget:self action:@selector(selectNeighbour) forControlEvents:UIControlEventTouchUpInside];
//    [selectNeighbour.layer setBorderColor:[UIColorFromRGB(rgbValue_scrollLine) CGColor]];
//    [selectNeighbour.layer setBorderWidth:1.0];  //边框宽度
//    [selectNeighbour.layer setCornerRadius:3.0f]; //边框弧度
//    [selectNeighbour.layer setMasksToBounds:YES];
//    [secondView addSubview:selectNeighbour];
//    selectNeighbour.enabled=NO;
//    
//    neighbourSelectedLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-60, 44)];
//    neighbourSelectedLabel.backgroundColor=[UIColor clearColor];
//    neighbourSelectedLabel.textColor=UIColorFromRGB(rgbValue_broadBand_textfieldText);
//    neighbourSelectedLabel.font=[UIFont fontWithName:appTypeFace size:18];
//    neighbourSelectedLabel.text=@"点击选择街道";
//    neighbourSelectedLabel.adjustsFontSizeToFitWidth=YES;
//    [selectNeighbour addSubview:neighbourSelectedLabel];
//    
//    selectSection=[[UIButton alloc]initWithFrame:CGRectMake(20, 192, SCREEN_WIDTH-90, 44)];
//    selectSection.backgroundColor=UIColorFromRGB(rgbValue_broadBand_textfieldBackGround);
//    [selectSection addTarget:self action:@selector(selectSection) forControlEvents:UIControlEventTouchUpInside];
//    [selectSection.layer setBorderColor:[UIColorFromRGB(rgbValue_scrollLine) CGColor]];
//    [selectSection.layer setBorderWidth:1.0];  //边框宽度
//    [selectSection.layer setCornerRadius:3.0f]; //边框弧度
//    [selectSection.layer setMasksToBounds:YES];
//    [secondView addSubview:selectSection];
//    selectSection.enabled=NO;
//    
//    sectionSelectedLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-110, 44)];
//    sectionSelectedLabel.backgroundColor=[UIColor clearColor];
//    sectionSelectedLabel.textColor=UIColorFromRGB(rgbValue_broadBand_textfieldText);
//    sectionSelectedLabel.font=[UIFont fontWithName:appTypeFace size:18];
//    sectionSelectedLabel.text=@"点击选择小区";
//    sectionSelectedLabel.adjustsFontSizeToFitWidth=YES;
//    [selectSection addSubview:sectionSelectedLabel];
//    
//    UIButton *queryAddress=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 192, 40, 44)];
//    queryAddress.backgroundColor=[UIColor clearColor];
//    [queryAddress setTitle:@"搜索" forState:UIControlStateNormal];
//    [queryAddress setTitleColor:UIColorFromRGB(rgbValueTitleBlue) forState:UIControlStateNormal];
//    [queryAddress addTarget:self action:@selector(queryAddressList) forControlEvents:UIControlEventTouchUpInside];
//    [secondView addSubview:queryAddress];

    addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 128, SCREEN_WIDTH-40, 100)];
    addressLabel.backgroundColor=[UIColor clearColor];
    addressLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    addressLabel.font=[UIFont fontWithName:appTypeFace size:16];
    addressLabel.tag=LABEL_TAG+1;
    addressLabel.numberOfLines=0;
    addressLabel.hidden=YES;
    [secondView addSubview:addressLabel];
    
    
//    detailTextfield=[[UITextField alloc]initWithFrame:CGRectMake(20, 192, SCREEN_WIDTH-40, 44)];
//    [detailTextfield setBorderStyle:UITextBorderStyleNone];
//    [detailTextfield setBackgroundColor:[UIColor clearColor]];
//    detailTextfield.tag = TEXTFIELD_TAG + 1;
//    detailTextfield.placeholder = @"请输入详细楼栋单元门牌号";
//    detailTextfield.text = @"";
//    //设置输入框内容的字体样式和大小
//    detailTextfield.font = [UIFont fontWithName:appTypeFace size:18];
//    //设置字体颜色
//    detailTextfield.textColor = UIColorFromRGB(rgbValue_broadBand_textfieldText);
//    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
//    detailTextfield.clearButtonMode = UITextFieldViewModeAlways;
//    detailTextfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    detailTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
//    //设置键盘的样式
//    detailTextfield.keyboardType = UIKeyboardTypeDefault;
//    //return键变成什么键
//    detailTextfield.returnKeyType =UIReturnKeyDone;
//    detailTextfield.delegate = self;
//    [detailTextfield.layer setBorderColor:[UIColorFromRGB(rgbValue_scrollLine) CGColor]];
//    [detailTextfield.layer setBorderWidth:1.0];  //边框宽度
//    [detailTextfield.layer setCornerRadius:3.0f]; //边框弧度
//    [detailTextfield.layer setMasksToBounds:YES];
//    [secondView addSubview:detailTextfield];
    
    
    UIView *thirdView=[[UIView alloc]initWithFrame:CGRectMake(0, 256+88, SCREEN_WIDTH, 246)];
    thirdView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    [homeScrollView addSubview:thirdView];
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [thirdView addSubview:line];
    
    nextButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 16, SCREEN_WIDTH-40, 44)];
    nextButton.backgroundColor=UIColorFromRGB(rgbValue_broadBand_noButtonBg);
    [nextButton setTitle:@"下一步:宽带选择" forState:UIControlStateNormal];
    nextButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:20];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //4个参数是上边界，左边界，下边界，右边界
    [nextButton addTarget:self action:@selector(toNextVC) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:nextButton];
    nextButton.enabled=NO;
    [thirdView addSubview:nextButton];
    
    UILabel *promptLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 76, SCREEN_WIDTH-10, 20)];
    promptLabel.backgroundColor=[UIColor clearColor];
    promptLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    promptLabel.font=[UIFont fontWithName:appTypeFace size:18];
    promptLabel.text=@"温馨提示:";
    [thirdView addSubview:promptLabel];
    
    UILabel *firstPromptLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 96, SCREEN_WIDTH-20, 60)];
    firstPromptLabel.backgroundColor=[UIColor clearColor];
    firstPromptLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
    firstPromptLabel.font=[UIFont fontWithName:appTypeFace size:14];
    firstPromptLabel.numberOfLines=0;
    firstPromptLabel.text=@"1、当您成功提交宽带开户信息后，工作人员将会根据您提交的小区地址及宽带产品上门为您安装宽带。";
    [thirdView addSubview:firstPromptLabel];
    
    UILabel *secondPromptLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 156, SCREEN_WIDTH-20, 40)];
    secondPromptLabel.backgroundColor=[UIColor clearColor];
    secondPromptLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
    secondPromptLabel.font=[UIFont fontWithName:appTypeFace size:14];
    secondPromptLabel.numberOfLines=0;
    secondPromptLabel.text=@"2、提交成功后，请保持手机畅通，方便工作人员与您取得联系。";
    [thirdView addSubview:secondPromptLabel];
    
    UILabel *thirdPromptLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 196, SCREEN_WIDTH-20, 40)];
    thirdPromptLabel.backgroundColor=[UIColor clearColor];
    thirdPromptLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
    thirdPromptLabel.font=[UIFont fontWithName:appTypeFace size:14];
    thirdPromptLabel.numberOfLines=0;
    thirdPromptLabel.text=@"3、目前有部分小区不支持宽带安装，不能提交宽带开户信息。";
    [thirdView addSubview:thirdPromptLabel];
    
    [homeScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 88+256+246)];
    
    backgroundCountryView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-216-44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT)];
    backgroundCountryView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:backgroundCountryView];
    backgroundCountryView.hidden=YES;
    
    //选择器初始化
    selectCountryToolber = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    selectCountryPicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0,44, SCREEN_WIDTH, 216)];
    
    [selectCountryToolber setBarStyle:UIBarStyleDefault];
    [selectCountryToolber setBackgroundColor:[UIColor blackColor]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [selectCountryPicker setBackgroundColor:[UIColor whiteColor]];
    }
    
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:3];
    UIBarButtonItem *locationBarButtonItemButtonCan = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(selectCountryPickerCancel)];
    [buttons addObject:locationBarButtonItemButtonCan];
    
    
    UIBarButtonItem *flexibleSpaceItem;
    flexibleSpaceItem =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self  action:NULL];
    [buttons addObject:flexibleSpaceItem];
    
    
    UIBarButtonItem *locationBarButtonItemButtonCom = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectCountryPickerSure)];
    [buttons addObject:locationBarButtonItemButtonCom];
    [selectCountryToolber setItems:buttons animated:NO];
    
    selectCountryPicker.delegate=self;
    selectCountryPicker.showsSelectionIndicator = YES;
    selectCountryPicker.tag=2001;
    [backgroundCountryView addSubview:selectCountryToolber];
    [backgroundCountryView addSubview:selectCountryPicker];
    
//    backgroundNeighborView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-216-44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT)];
//    backgroundNeighborView.backgroundColor=[UIColor clearColor];
//    [self.view addSubview:backgroundNeighborView];
//    backgroundNeighborView.hidden=YES;
//    
//    selectNeighborTooler = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//    selectNeighborPicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
//    
//    [selectNeighborTooler setBarStyle:UIBarStyleDefault];
//    [selectNeighborTooler setBackgroundColor:[UIColor blackColor]];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        [selectNeighborPicker setBackgroundColor:[UIColor whiteColor]];
//    }
//    
//    NSMutableArray *buttons2 = [[NSMutableArray alloc] initWithCapacity:3];
//    UIBarButtonItem *locationBarButtonItemButtonCan2 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(selectNeighborPickerCancel)];
//    [buttons2 addObject:locationBarButtonItemButtonCan2];
//    
//    
//    UIBarButtonItem *flexibleSpaceItem2;
//    flexibleSpaceItem2 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self  action:NULL];
//    [buttons2 addObject:flexibleSpaceItem2];
//    
//    
//    UIBarButtonItem *locationBarButtonItemButtonCom2 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectNeighborPickerSure)];
//    [buttons2 addObject:locationBarButtonItemButtonCom2];
//    [selectNeighborTooler setItems:buttons2 animated:NO];
//    selectNeighborPicker.delegate=self;
//    selectNeighborPicker.tag=2002;
//    selectNeighborPicker.showsSelectionIndicator = YES;
//    [backgroundNeighborView addSubview:selectNeighborTooler];
//    [backgroundNeighborView addSubview:selectNeighborPicker];
//    
//    backgroundSectionView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-216-44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT)];
//    backgroundSectionView.backgroundColor=[UIColor clearColor];
//    [self.view addSubview:backgroundSectionView];
//    backgroundSectionView.hidden=YES;
//    
//    selectSectionToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//    selectSectionPicker =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
//    
//    [selectSectionToolbar setBarStyle:UIBarStyleDefault];
//    [selectSectionToolbar setBackgroundColor:[UIColor blackColor]];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        [selectSectionPicker setBackgroundColor:[UIColor whiteColor]];
//    }
//    
//    NSMutableArray *buttons3 = [[NSMutableArray alloc] initWithCapacity:3];
//    UIBarButtonItem *locationBarButtonItemButtonCan3 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(selectSectionPickerCancel)];
//    [buttons3 addObject:locationBarButtonItemButtonCan3];
//    
//    
//    UIBarButtonItem *flexibleSpaceItem3;
//    flexibleSpaceItem3 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self  action:NULL];
//    [buttons3 addObject:flexibleSpaceItem3];
//    
//    
//    UIBarButtonItem *locationBarButtonItemButtonCom3 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectSectionPickerSure)];
//    [buttons3 addObject:locationBarButtonItemButtonCom3];
//    [selectSectionToolbar setItems:buttons3 animated:NO];
//    selectSectionPicker.delegate=self;
//    selectSectionPicker.tag=2003;
//    selectSectionPicker.showsSelectionIndicator = YES;
//    [backgroundSectionView addSubview:selectSectionToolbar];
//    [backgroundSectionView addSubview:selectSectionPicker];
}

//查询宽带预约进度view
-(void)drawFinishBand:(NSDictionary *)dic{
    UIView *firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fheight)];
    firstView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    [self.view addSubview:firstView];
    
    UILabel *titleImage = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 10, 20)];
    titleImage.backgroundColor=UIColorFromRGB(rgbValueButtonGreen);
    [firstView addSubview:titleImage];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(25, 7, 120, 30)];
    title.backgroundColor=[UIColor clearColor];
    title.textColor=UIColorFromRGB(rgbValueDeepGrey);
    title.text=@"工单进度信息";
    title.font=[UIFont fontWithName:appTypeFace size:20];
    [firstView addSubview:title];
    
    UILabel *account=[[UILabel alloc]initWithFrame:CGRectMake(145, 11, 170, 23)];
    account.backgroundColor=[UIColor clearColor];
    account.textColor=UIColorFromRGB(rgbValueDeepGrey);
    account.text=[NSString stringWithFormat:@"(宽带账号 %@)",[[[dic objectForKey:@"common"] objectAtIndex:0] objectForKey:@"account"]];
    account.font=[UIFont fontWithName:appTypeFace size:14];
    [firstView addSubview:account];
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, fheight-0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [firstView addSubview:line];
    
    UIScrollView *secondView=[[UIScrollView alloc]initWithFrame:CGRectMake(10, fheight+10, SCREEN_WIDTH-20, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-fheight*3)];
    secondView.backgroundColor=[UIColor whiteColor];
    secondView.showsHorizontalScrollIndicator=NO;
    secondView.showsVerticalScrollIndicator=NO;
    [secondView.layer setBorderColor:[UIColorFromRGB(rgbValue_scrollLine) CGColor]];
    [secondView.layer setBorderWidth:0.5];  //边框宽度
    [secondView.layer setCornerRadius:3.0f]; //边框弧度
    [secondView.layer setMasksToBounds:YES];
    [self.view addSubview:secondView];
    
    UIView *custNameView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 30)];
    custNameView.backgroundColor=[UIColor clearColor];
    [self setView:custNameView withTitle:@"客户名称：" withValue:[[[dic objectForKey:@"common"] objectAtIndex:0] objectForKey:@"custName"]];
    [secondView addSubview:custNameView];
    
    UIView *custPhoneView=[[UIView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH-20, 30)];
    custPhoneView.backgroundColor=[UIColor clearColor];
    [self setView:custPhoneView withTitle:@"客户号码：" withValue:[[[dic objectForKey:@"common"] objectAtIndex:0] objectForKey:@"custPhone"]];
    [secondView addSubview:custPhoneView];
    
    UIView *custAddressView=[[UIView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH-20, 70)];
    custAddressView.backgroundColor=[UIColor clearColor];
    [self setView:custAddressView withTitle:@"安装地址：" withValue:[[[dic objectForKey:@"common"] objectAtIndex:0] objectForKey:@"address"]];
    [secondView addSubview:custAddressView];
    
    UILabel *line2=[[UILabel alloc]initWithFrame:CGRectMake(0, 134.5, SCREEN_WIDTH-20, 0.5)];
    line2.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [secondView addSubview:line2];
    
    
    UIImageView *firstStepImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 165, 40, 40)];
    [secondView addSubview:firstStepImage];
    
    UILabel *sLine1=[[UILabel alloc]initWithFrame:CGRectMake(30, 205, 1, 90)];
    sLine1.backgroundColor=UIColorFromRGB(rgbValueLineGrey);
    [secondView addSubview:sLine1];
    
    UIImageView *secondStepImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 295, 40, 40)];
    [secondView addSubview:secondStepImage];
    
    UILabel *sLine2=[[UILabel alloc]initWithFrame:CGRectMake(30, 335, 1, 90)];
    sLine2.backgroundColor=UIColorFromRGB(rgbValueLineGrey);
    [secondView addSubview:sLine2];
    
    UIImageView *thirdStepImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 425, 40, 40)];
    [secondView addSubview:thirdStepImage];
    
    UIImage *backImage = [UIImage imageNamed:@"step_msg"] ;

    if([[dic objectForKey:@"sceneOpen"] objectAtIndex:0]!=nil){
        firstStepImage.image=[UIImage imageNamed:@"step_on_ok"];
        secondStepImage.image=[UIImage imageNamed:@"step_on_ok"];
        thirdStepImage.image=[UIImage imageNamed:@"step_on"];
        
        UIView *firstStepView=[[UIView alloc]initWithFrame:CGRectMake(55, 145, SCREEN_WIDTH-80, 90)];
        firstStepView.backgroundColor=[UIColor colorWithPatternImage:backImage];
        [self setStepView:firstStepView withDic:[[dic objectForKey:@"openAppointment"] objectAtIndex:0] withStep:1];
        [secondView addSubview:firstStepView];
        
        UIView *secondStepView=[[UIView alloc]initWithFrame:CGRectMake(55, 275, SCREEN_WIDTH-80, 90)];
        secondStepView.backgroundColor=[UIColor colorWithPatternImage:backImage];
        [self setStepView:secondStepView withDic:[[dic objectForKey:@"dataMake"] objectAtIndex:0] withStep:2];
        [secondView addSubview:secondStepView];
        
        UIView *thirdStepView=[[UIView alloc]initWithFrame:CGRectMake(55, 405, SCREEN_WIDTH-80, 90)];
        thirdStepView.backgroundColor=[UIColor colorWithPatternImage:backImage];
        [self setStepView:thirdStepView withDic:[[dic objectForKey:@"sceneOpen"] objectAtIndex:0] withStep:3];
        [secondView addSubview:thirdStepView];

    }else{
        thirdStepImage.image=[UIImage imageNamed:@"step_off"];
        if([[dic objectForKey:@"dataMake"] objectAtIndex:0]!=nil){
            firstStepImage.image=[UIImage imageNamed:@"step_on_ok"];
            secondStepImage.image=[UIImage imageNamed:@"step_on"];
            
            UIView *firstStepView=[[UIView alloc]initWithFrame:CGRectMake(55, 145, SCREEN_WIDTH-80, 90)];
            firstStepView.backgroundColor=[UIColor colorWithPatternImage:backImage];
            [self setStepView:firstStepView withDic:[[dic objectForKey:@"openAppointment"] objectAtIndex:0] withStep:1];
            [secondView addSubview:firstStepView];
            
            UIView *secondStepView=[[UIView alloc]initWithFrame:CGRectMake(55, 275, SCREEN_WIDTH-80, 90)];
            secondStepView.backgroundColor=[UIColor colorWithPatternImage:backImage];
            [self setStepView:secondStepView withDic:[[dic objectForKey:@"dataMake"] objectAtIndex:0] withStep:2];
            [secondView addSubview:secondStepView];
        }else{
            secondStepImage.image=[UIImage imageNamed:@"step_off"];
            if([[dic objectForKey:@"openAppointment"] objectAtIndex:0]!=nil){
                firstStepImage.image=[UIImage imageNamed:@"step_on"];
                
                UIView *firstStepView=[[UIView alloc]initWithFrame:CGRectMake(55, 145, SCREEN_WIDTH-80, 90)];
                firstStepView.backgroundColor=[UIColor colorWithPatternImage:backImage];
                [self setStepView:firstStepView withDic:[[dic objectForKey:@"openAppointment"] objectAtIndex:0] withStep:1];
                [secondView addSubview:firstStepView];
            }else{
                firstStepImage.image=[UIImage imageNamed:@"step_off"];
            }
        }
    }

    [secondView setContentSize:CGSizeMake(SCREEN_WIDTH-20, 510)];
    
    UIView *thirdView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-64, SCREEN_WIDTH, 64)];
    thirdView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    [self.view addSubview:thirdView];
    
    UILabel *downLine=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    downLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [thirdView addSubview:downLine];
    
    UIButton *callButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 44)];
    callButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
    [callButton setTitle:@"速拨施工联系人电话" forState:UIControlStateNormal];
    callButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:20];
    [callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //4个参数是上边界，左边界，下边界，右边界
    [callButton addTarget:self action:@selector(toCall) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:callButton];
    [thirdView addSubview:callButton];
}

-(void)setStepView:(UIView *)view withDic:(NSDictionary *)dic withStep:(NSInteger)step{
    
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-90, 20)];
    view1.backgroundColor=[UIColor clearColor];
    [view addSubview:view1];
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(5, 25, SCREEN_WIDTH-90, 20)];
    view2.backgroundColor=[UIColor clearColor];
    [view addSubview:view2];
    
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(5, 45, SCREEN_WIDTH-90, 20)];
    view3.backgroundColor=[UIColor clearColor];
    [view addSubview:view3];
    
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(5, 65, SCREEN_WIDTH-90, 20)];
    view4.backgroundColor=[UIColor clearColor];
    [view addSubview:view4];
    
    if(step==1){
        [self setStepDescView:view1 withTitle:@"预约人：" withValue:[dic objectForKey:@"appointmentMan"]];
        [self setStepDescView:view2 withTitle:@"预约时间：" withValue:[dic objectForKey:@"appointmentTime"]];
        [self setStepDescView:view3 withTitle:@"预约电话：" withValue:[dic objectForKey:@"appointmentManPhone"]];
        [self setStepDescView:view4 withTitle:@"状态：" withValue:[dic objectForKey:@"setpStatus"]];
    }else if(step==2){
        [self setStepDescView:view1 withTitle:@"处理人：" withValue:[dic objectForKey:@"handleMan"]];
        [self setStepDescView:view2 withTitle:@"处理时间：" withValue:[dic objectForKey:@"handleTime"]];
        [self setStepDescView:view3 withTitle:@"处理电话：" withValue:[dic objectForKey:@"handleManPhone"]];
        [self setStepDescView:view4 withTitle:@"状态：" withValue:[dic objectForKey:@"setpStatus"]];
    }else if(step==3){
        [self setStepDescView:view1 withTitle:@"处理人：" withValue:[dic objectForKey:@"handleMan"]];
        [self setStepDescView:view2 withTitle:@"处理时间：" withValue:[dic objectForKey:@"handleTime"]];
        [self setStepDescView:view3 withTitle:@"处理电话：" withValue:[dic objectForKey:@"handleManPhone"]];
        [self setStepDescView:view4 withTitle:@"状态：" withValue:[dic objectForKey:@"setpStatus"]];
    }
    
}

-(void)setView:(UIView *)view withTitle:(NSString *)title withValue:(NSString *)value{
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 30)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.font=[UIFont fontWithName:appTypeFace size:16];
    titleLabel.textColor=UIColorFromRGB(rgbValue_packageDetailInfoTotal);
    titleLabel.text=title;
    [view addSubview:titleLabel];
    
    UILabel *valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 200, view.frame.size.height)];
    valueLabel.backgroundColor=[UIColor clearColor];
    valueLabel.font=[UIFont fontWithName:appTypeFace size:16];
    valueLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    valueLabel.text=value;
    valueLabel.numberOfLines=0;
    [view addSubview:valueLabel];
}

-(void)setStepDescView:(UIView *)view withTitle:(NSString *)title withValue:(NSString *)value{
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 70, 20)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.font=[UIFont fontWithName:appTypeFace size:14];
    titleLabel.textColor=UIColorFromRGB(rgbValue_packageDetailInfoTotal);
    titleLabel.text=title;
    [view addSubview:titleLabel];
    
    UILabel *valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 0, 170, view.frame.size.height)];
    valueLabel.backgroundColor=[UIColor clearColor];
    valueLabel.font=[UIFont fontWithName:appTypeFace size:14];
    valueLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    valueLabel.text=value;
    valueLabel.numberOfLines=0;
    [view addSubview:valueLabel];
}

-(void)queryInternet{
    //先查询用户是否有正在进行中的工单，如果没有则查询用户是否已经办过款单，如果办理过则提示用户已经办理。如果正在办理中显示办理流程，如果不在办理中显示：地址选择页面！
    [HUD showTextHUDWithVC:self.navigationController.view];
    
    busiCode=@"WorkSheetQuery";
    NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
    [requestBeanDic setValue:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
}

-(void)selectAddress{
    addressLabel.text=@"";
    addressLabel.hidden=YES;
    if(countryArray.count<=0){
        [HUD showTextHUDWithVC:self.navigationController.view];
        
        busiCode=@"WidenetAdderssLevel";
        NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
        [requestBeanDic setValue:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestBeanDic setValue:[MyMobileServiceYNParam getCityCode] forKey:@"EPARCHY_CODE"];
        [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
    }else{
        [self showCountryPicker];
    }
}

//-(void)selectNeighbour{
//    if(countrySelectedLabel.text!=nil&&![countrySelectedLabel.text isEqualToString:@""]){
//        neighborArray=[[countryArray objectAtIndex:selectCountryRow] objectForKey:@"ROAD"];
//        [selectNeighborPicker reloadAllComponents];
//        [self showNeighborPicker];
//    }
//}
//
//-(void)selectSection{
//    if(neighbourSelectedLabel.text!=nil&&![neighbourSelectedLabel.text isEqualToString:@""]){
//        sectionArray=[[neighborArray objectAtIndex:selectNeighborRow] objectForKey:@"HOUS"];
//        [selectSectionPicker reloadAllComponents];
//        [self showSectionPicker];
//    }
//}

-(void)queryAddressList{
//    if(countrySelectedLabel.text!=nil&&![countrySelectedLabel.text isEqualToString:@""]&&neighbourSelectedLabel.text!=nil&&![neighbourSelectedLabel.text isEqualToString:@""]&&sectionSelectedLabel.text!=nil&&![sectionSelectedLabel.text isEqualToString:@""]){
//        MyMobileServiceYNBroadbandAccountQueryVC *queryVC=[[MyMobileServiceYNBroadbandAccountQueryVC alloc]init];
//        queryVC.hourID=[[sectionArray objectAtIndex:selectSectionRow] objectForKey:@"HOUS_ID"];
//        [self.navigationController pushViewController:queryVC animated:YES];
//    }
    if(countrySelectedLabel.text!=nil&&![countrySelectedLabel.text isEqualToString:@"点击选择区县"]){
        MyMobileServiceYNBroadbandAccountQueryVC *queryVC=[[MyMobileServiceYNBroadbandAccountQueryVC alloc]init];
        queryVC.resID=[[countryArray objectAtIndex:selectCountryRow] objectForKey:@"RES_ID"];
        [self.navigationController pushViewController:queryVC animated:YES];
    }else{
        NSString *returnMessage = @"请首先选择所在区县。";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG+1;
        [alertView show];
    }
}

-(void)toQueryAddress:(id)sender{
    //模糊匹配后返回信息
    addressInfo=(NSDictionary *)[sender object];
    addressLabel.text=[NSString stringWithFormat:@"您的地址：%@",[addressInfo objectForKey:@"RES_NAME"]];
    CGSize labelSize2=[addressLabel.text sizeWithFont:addressLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH-40, 100) lineBreakMode:NSLineBreakByCharWrapping];
    addressLabel.frame=CGRectMake(20, 128, SCREEN_WIDTH-40, labelSize2.height);
    addressLabel.hidden=NO;
    nextButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
    nextButton.enabled=YES; 
}

-(void)toNextVC{
    MyMobileServiceYNBroadbandAccountSecondVC *secondVC=[[MyMobileServiceYNBroadbandAccountSecondVC alloc]init];
    secondVC.broadBandDic=[[NSMutableDictionary alloc]initWithDictionary:addressInfo];
    [self.navigationController pushViewController:secondVC animated:YES];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[request responseData];
    DebugNSLog(@"%@",[request responseString]);
    
    if (![busiCode isEqualToString:@"WorkSheetQuery"]) {
        if(HUD){
            [HUD removeHUD];
        }
    }
    
    if([busiCode isEqualToString:@"IsOpenWidenet"]){//调用是否办理过宽带接口如果办理过，则调用查询，如果没有办理过则直接接入办理界面。
        NSDictionary *dic = [[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil] objectAtIndex:0];
        if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){//没办理过直接显示宽带新装页面
            [self drawBroadBand];
        }
        else{
            NSString *returnMessage = @"该用户已经办理过宽带业务，不能再次办理！";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG_RETURN+3;
            [alertView show];
        }
    }
    else if([busiCode isEqualToString:@"WorkSheetQuery"]){//调用办理进度查询接口
        NSDictionary *dic = [[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil] objectAtIndex:0];
        if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
            if(![[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"])//如果返回条数不为0，则表示已预约，展示预约界面，如果返回数据为0，则未预约，展示预约界面。
            {
                NSString *dealStateDti =[[[dic objectForKey:@"common"] objectAtIndex:0] objectForKey:@"dealStateDti"];
                if ([dealStateDti isEqualToString:@"回单失败"]) {//回单失败可以重新办理,进入宽带新装页面
                    [self drawBroadBand];
                }else{
                    agentPhone = [[[dic objectForKey:@"common"] objectAtIndex:0] objectForKey:@"custPhone"];
                    [self drawFinishBand:dic];
                }

                if(HUD){
                    [HUD removeHUD];
                }
            }else{
                
                busiCode=@"IsOpenWidenet";
                NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
                [requestBeanDic setValue:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
                [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
                
            }
        }
        else{
            NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG_RETURN+1;
            [alertView show];
            if(HUD){
                [HUD removeHUD];
            }
        }
    }else{
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic=[array objectAtIndex:0];
        if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
            if(![[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"])//如果返回条数不为0，则展示，否则不展示
            {
                countryArray=[[NSMutableArray alloc]initWithArray:array];
                [selectCountryPicker reloadAllComponents];
                [self showCountryPicker];
            }else{
                NSString *returnMessage = @"请检查地址输入是否正确或该地址暂未覆盖，敬请期待。";
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                alertView.tag = ALERTVIEW_TAG_RETURN+1;
                [alertView show];
            }
        }
        else{
            NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG_RETURN+1;
            [alertView show];
        }
    }
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    if ([busiCode isEqualToString:@"WorkSheetQuery"]) {
        [self drawBroadBand];
    }else{
        DebugNSLog(@"------------requestFailed------------------");
        NSError *error = [request error];
        DebugNSLog(@"----------2---------%@",error);
        NSString *returnMessage = [returnMessageDeal returnMessage:@"网络异常" andreturnMessage:@""];
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
    DebugNSLog(@"test buttonIndex:%i",buttonIndex);
    if (ALERTVIEW_TAG_RETURN+3 == alertView.tag)
    {//宽带办理成功，返回首页
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)showCountryPicker{
//    if(!backgroundNeighborView.hidden){
//        backgroundNeighborView.hidden=YES;
//        CATransition *animation2 = [CATransition animation];
//        [animation2 setDuration:0.5f];
//        [animation2 setType:kCATransitionPush];
//        [animation2 setSubtype:kCATransitionFromBottom];
//        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [backgroundNeighborView.layer addAnimation:animation2 forKey:@"fade"];
//    }
//    if(!backgroundSectionView.hidden){
//        backgroundSectionView.hidden=YES;
//        CATransition *animation2 = [CATransition animation];
//        [animation2 setDuration:0.5f];
//        [animation2 setType:kCATransitionPush];
//        [animation2 setSubtype:kCATransitionFromBottom];
//        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [backgroundSectionView.layer addAnimation:animation2 forKey:@"fade"];
//    }
    selectAddress.enabled=NO;
    
    backgroundCountryView.hidden=NO;
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromTop];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backgroundCountryView.layer addAnimation:animation1 forKey:@"fade"];
    
}

//-(void)showNeighborPicker{
//    DebugNSLog(@"%@",neighborArray);
//    if(!backgroundCountryView.hidden){
//        backgroundCountryView.hidden=YES;
//        CATransition *animation2 = [CATransition animation];
//        [animation2 setDuration:0.5f];
//        [animation2 setType:kCATransitionPush];
//        [animation2 setSubtype:kCATransitionFromBottom];
//        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [backgroundCountryView.layer addAnimation:animation2 forKey:@"fade"];
//    }
//    if(!backgroundSectionView.hidden){
//        backgroundSectionView.hidden=YES;
//        CATransition *animation2 = [CATransition animation];
//        [animation2 setDuration:0.5f];
//        [animation2 setType:kCATransitionPush];
//        [animation2 setSubtype:kCATransitionFromBottom];
//        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [backgroundSectionView.layer addAnimation:animation2 forKey:@"fade"];
//    }
//    selectAddress.enabled=YES;
//    selectNeighbour.enabled=NO;
//    
//    backgroundNeighborView.hidden=NO;
//    CATransition *animation1 = [CATransition animation];
//    [animation1 setDuration:0.5f];
//    [animation1 setType:kCATransitionPush];
//    [animation1 setSubtype:kCATransitionFromTop];
//    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [backgroundNeighborView.layer addAnimation:animation1 forKey:@"fade"];
//    
//    CGFloat pickerHeight = 216 + 44;
//    if(SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT - pickerHeight < 128+44+88){
//        CGFloat moveHeight=SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT - pickerHeight-128-44-88;
//        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDelegate:homeScrollView];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationDuration:0.275f];
//        homeScrollView.frame = CGRectMake(0, moveHeight, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT);
//        [UIView commitAnimations];
//    }
//}
//
//-(void)showSectionPicker{
//    if(!backgroundCountryView.hidden){
//        backgroundCountryView.hidden=YES;
//        CATransition *animation2 = [CATransition animation];
//        [animation2 setDuration:0.5f];
//        [animation2 setType:kCATransitionPush];
//        [animation2 setSubtype:kCATransitionFromBottom];
//        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [backgroundCountryView.layer addAnimation:animation2 forKey:@"fade"];
//    }
//    if(!backgroundNeighborView.hidden){
//        backgroundNeighborView.hidden=YES;
//        CATransition *animation2 = [CATransition animation];
//        [animation2 setDuration:0.5f];
//        [animation2 setType:kCATransitionPush];
//        [animation2 setSubtype:kCATransitionFromBottom];
//        [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [backgroundNeighborView.layer addAnimation:animation2 forKey:@"fade"];
//    }
//    selectNeighbour.enabled=YES;
//    selectAddress.enabled=YES;
//    selectSection.enabled=NO;
//    
//    backgroundSectionView.hidden=NO;
//    CATransition *animation1 = [CATransition animation];
//    [animation1 setDuration:0.5f];
//    [animation1 setType:kCATransitionPush];
//    [animation1 setSubtype:kCATransitionFromTop];
//    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [backgroundSectionView.layer addAnimation:animation1 forKey:@"fade"];
//    
//    CGFloat pickerHeight = 216 + 44;
//    if(SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT - pickerHeight < 192+44+88){
//        CGFloat moveHeight=SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT - pickerHeight-192-44-88;
//        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDelegate:homeScrollView];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationDuration:0.275f];
//        homeScrollView.frame = CGRectMake(0, moveHeight, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT);
//        [UIView commitAnimations];
//    }
//}

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
//    if(pickerView.tag==2001){
        return countryArray.count;
//    }else if(pickerView.tag==2002){
//        return neighborArray.count;
//    }else{
//        return sectionArray.count;
//    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    if(pickerView.tag==2001){
        selectCountryRow=row;
//    }else if(pickerView.tag==2002){
//        selectNeighborRow=row;
//    }else{
//        selectSectionRow=row;
//    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *locationPiclerView = nil;
//    if(pickerView.tag == 2001){
        locationPiclerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        locationPiclerView.textAlignment = UITextAlignmentCenter;
        locationPiclerView.text = [[countryArray objectAtIndex:row] objectForKey:@"RES_NAME"];
        locationPiclerView.font = [UIFont fontWithName:appTypeFace size:16];
        locationPiclerView.adjustsFontSizeToFitWidth=YES;
        locationPiclerView.backgroundColor = [UIColor clearColor];
//    }else if(pickerView.tag==2002){
//        locationPiclerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
//        locationPiclerView.textAlignment = UITextAlignmentCenter;
//        locationPiclerView.text = [[neighborArray objectAtIndex:row] objectForKey:@"ROAD_NAME"];
//        locationPiclerView.font = [UIFont fontWithName:appTypeFace size:16];
//        locationPiclerView.adjustsFontSizeToFitWidth=YES;
//        locationPiclerView.backgroundColor = [UIColor clearColor];
//    }else{
//        locationPiclerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
//        locationPiclerView.textAlignment = UITextAlignmentCenter;
//        locationPiclerView.text = [[sectionArray objectAtIndex:row] objectForKey:@"HOUS_NAME"];
//        locationPiclerView.font = [UIFont fontWithName:appTypeFace size:16];
//        locationPiclerView.adjustsFontSizeToFitWidth=YES;
//        locationPiclerView.backgroundColor = [UIColor clearColor];
//    }
    return locationPiclerView;
}


-(void)selectCountryPickerSure{
    NSString  *result = [[countryArray objectAtIndex:selectCountryRow] objectForKey:@"RES_NAME"];
    countrySelectedLabel.text = result;
    [self selectCountryPickerCancel];
//    neighborArray=[[countryArray objectAtIndex:selectCountryRow] objectForKey:@"ROAD"];
//    neighbourSelectedLabel.text=[[neighborArray objectAtIndex:0] objectForKey:@"ROAD_NAME"];
//    sectionArray=[[neighborArray objectAtIndex:0] objectForKey:@"HOUS"];
//    sectionSelectedLabel.text=[[sectionArray objectAtIndex:0] objectForKey:@"HOUS_NAME"];
//    [selectNeighborPicker reloadAllComponents];
//    [self showNeighborPicker];
}

//-(void)selectNeighborPickerSure{
//    NSString  *result = [[neighborArray objectAtIndex:selectNeighborRow] objectForKey:@"ROAD_NAME"];
//    neighbourSelectedLabel.text = result;
//    sectionArray=[[neighborArray objectAtIndex:selectNeighborRow] objectForKey:@"HOUS"];
//    sectionSelectedLabel.text=[[sectionArray objectAtIndex:0] objectForKey:@"HOUS_NAME"];
//    [selectSectionPicker reloadAllComponents];
//    [self showSectionPicker];
//}
//
//-(void)selectSectionPickerSure{
//    NSString  *result = [[sectionArray objectAtIndex:selectSectionRow] objectForKey:@"HOUS_NAME"];
//    sectionSelectedLabel.text = result;
//    [self selectSectionPickerCancel];
//    MyMobileServiceYNBroadbandAccountQueryVC *queryVC=[[MyMobileServiceYNBroadbandAccountQueryVC alloc]init];
//    queryVC.hourID=[[sectionArray objectAtIndex:selectSectionRow] objectForKey:@"HOUS_ID"];
//    [self.navigationController pushViewController:queryVC animated:YES];
//}

-(void)selectCountryPickerCancel{
    selectAddress.enabled=YES;
    selectNeighbour.enabled=YES;
    selectSection.enabled=YES;
    backgroundCountryView.hidden=YES;
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromBottom];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backgroundCountryView.layer addAnimation:animation1 forKey:@"fade"];
}

//-(void)selectNeighborPickerCancel{
//    selectNeighbour.enabled=YES;
//    selectSection.enabled=YES;
//    backgroundNeighborView.hidden=YES;
//    CATransition *animation1 = [CATransition animation];
//    [animation1 setDuration:0.5f];
//    [animation1 setType:kCATransitionPush];
//    [animation1 setSubtype:kCATransitionFromBottom];
//    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [backgroundNeighborView.layer addAnimation:animation1 forKey:@"fade"];
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelegate:homeScrollView];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.275f];
//    homeScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT);
//    [UIView commitAnimations];
//}
//
//-(void)selectSectionPickerCancel{
//    selectSection.enabled=YES;
//    backgroundSectionView.hidden=YES;
//    CATransition *animation1 = [CATransition animation];
//    [animation1 setDuration:0.5f];
//    [animation1 setType:kCATransitionPush];
//    [animation1 setSubtype:kCATransitionFromBottom];
//    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [backgroundSectionView.layer addAnimation:animation1 forKey:@"fade"];
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelegate:homeScrollView];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.275f];
//    homeScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT);
//    [UIView commitAnimations];
//}

////手势对应的触发事件
////在空白处点击，收起键盘
//-(void)viewTapped:(UITapGestureRecognizer *)tapGR
//{
//	[(UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + 1] resignFirstResponder];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelegate:homeScrollView];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.275f];
//    homeScrollView.frame = CGRectMake(0, 0, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
//    [UIView commitAnimations];
//}
//
//#pragma mark---UITextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextView *)textView
//{
//    DebugNSLog(@"---------begin---------");
//    //移动试图位置保证输入内容不被键盘遮挡
//    CGFloat keyboardHeight = 216.0f+30;
//    float moveHeight = 0.0f;
//
//    if(!(homeScrollView.frame.size.height - keyboardHeight > 192+88+44))
//    {
//        if(homeScrollView.contentOffset.y==0){
//            moveHeight = 192+88+44 - (homeScrollView.frame.size.height - keyboardHeight);
//        }else{
//            moveHeight = 192+88+44- homeScrollView.contentOffset.y - (homeScrollView.frame.size.height - keyboardHeight);
//        }
//        //切换动画效果
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDelegate:homeScrollView];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationDuration:0.275f];
//        homeScrollView.frame = CGRectMake(homeScrollView.frame.origin.x, -moveHeight, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
//        [UIView commitAnimations];
//    }
//    
//    return YES;
//}
//
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    //当开始点击textField会调用的方法
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    //当textField编辑结束时调用的方法
//    if(![textField.text isEqualToString:@""]&&textField.text!=nil){
//        if(neighbourSelectedLabel.text!=nil&&![neighbourSelectedLabel.text isEqualToString:@""]&&![neighbourSelectedLabel.text isEqualToString:@"点击选择小区"]){
//            nextButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
//            nextButton.enabled=YES;
//        }else if(addressLabel.text!=nil&&![addressLabel.text isEqualToString:@""]){
//            nextButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
//            nextButton.enabled=YES;
//        }
//    }
//}
//
////按下Done按钮的调用方法，我们让键盘消失
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelegate:self.view];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.275f];
//    homeScrollView.frame = CGRectMake(0, 0, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
//    [UIView commitAnimations];
//    
//    [textField resignFirstResponder];
//    return YES;
//}
//
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if(textField.tag ==TEXTFIELD_TAG+1){
//        if(range.location>=50){
//            return NO;
//        }
//        return YES;
//    }
//    else{
//        return YES;
//    }
//}

-(void)toCall{
    NSString *url = [NSString stringWithFormat:@"tel://%@",agentPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    [httpRequest setRequestDelegatNil];
}

@end
