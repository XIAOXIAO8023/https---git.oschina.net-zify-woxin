//
//  MyMobileServiceYNBroadbandAccountFifthVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-3.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBroadbandAccountFifthVC.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"

#define fheight 44

@interface MyMobileServiceYNBroadbandAccountFifthVC ()

@end

@implementation MyMobileServiceYNBroadbandAccountFifthVC

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
	
    UIView *firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, fheight*1.5)];
    firstView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    [self.view addSubview:firstView];
    
    UILabel *titleImage = [[UILabel alloc]initWithFrame:CGRectMake(15, 23, 10, 20)];
    titleImage.backgroundColor=UIColorFromRGB(rgbValueButtonGreen);
    [firstView addSubview:titleImage];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(30, 18, 120, 30)];
    title.backgroundColor=[UIColor clearColor];
    title.textColor=UIColorFromRGB(rgbValueDeepGrey);
    title.text=@"工单进度信息";
    title.font=[UIFont fontWithName:appTypeFace size:20];
    [firstView addSubview:title];
    
    UILabel *account=[[UILabel alloc]initWithFrame:CGRectMake(150, 22, 160, 23)];
    account.backgroundColor=[UIColor clearColor];
    account.textColor=UIColorFromRGB(rgbValueDeepGrey);
    account.text=[NSString stringWithFormat:@"(宽带账号%@)",[MyMobileServiceYNParam getSerialNumber]];
    account.font=[UIFont fontWithName:appTypeFace size:14];
    [firstView addSubview:account];
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, fheight*1.5-1, SCREEN_WIDTH, 1)];
    line.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [firstView addSubview:line];
    
    UIScrollView *secondView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, fheight*1.5, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-fheight*3)];
    secondView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:secondView];
    
    UILabel *orderIDText=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, fheight)];
    orderIDText.backgroundColor=[UIColor clearColor];
    orderIDText.textColor=UIColorFromRGB(rgbValueDeepGrey);
    orderIDText.text=@"施工单号:";
    orderIDText.font=[UIFont fontWithName:appTypeFace size:16];
    [secondView addSubview:orderIDText];
    
    UILabel *orderID=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 180, fheight)];
    orderID.backgroundColor=[UIColor clearColor];
    orderID.textColor=UIColorFromRGB(rgbValueDeepGrey);
    orderID.font=[UIFont fontWithName:appTypeFace size:18];
    orderID.tag=LABEL_TAG+1;
    [secondView addSubview:orderID];
    
    UILabel *statusText=[[UILabel alloc]initWithFrame:CGRectMake(20, fheight*1, 80, fheight)];
    statusText.backgroundColor=[UIColor clearColor];
    statusText.textColor=UIColorFromRGB(rgbValueDeepGrey);
    statusText.text=@"当前环节:";
    statusText.font=[UIFont fontWithName:appTypeFace size:16];
    [secondView addSubview:statusText];
    
    UILabel *status=[[UILabel alloc]initWithFrame:CGRectMake(100, fheight+1, 180, fheight)];
    status.backgroundColor=[UIColor clearColor];
    status.textColor=UIColorFromRGB(rgbValueDeepGrey);
    status.font=[UIFont fontWithName:appTypeFace size:18];
    status.tag=LABEL_TAG+2;
    [secondView addSubview:status];
    
    UILabel *flowStatusText=[[UILabel alloc]initWithFrame:CGRectMake(20, fheight*2, 80, fheight)];
    flowStatusText.backgroundColor=[UIColor clearColor];
    flowStatusText.textColor=UIColorFromRGB(rgbValueDeepGrey);
    flowStatusText.text=@"流程状态:";
    flowStatusText.font=[UIFont fontWithName:appTypeFace size:16];
    [secondView addSubview:flowStatusText];
    
    UILabel *flowStatus=[[UILabel alloc]initWithFrame:CGRectMake(100, fheight*2, 180, fheight)];
    flowStatus.backgroundColor=[UIColor clearColor];
    flowStatus.textColor=UIColorFromRGB(rgbValueDeepGrey);
    flowStatus.font=[UIFont fontWithName:appTypeFace size:18];
    flowStatus.tag=LABEL_TAG+3;
    [secondView addSubview:orderID];

    UILabel *timeText=[[UILabel alloc]initWithFrame:CGRectMake(20, fheight*3, 80, fheight)];
    timeText.backgroundColor=[UIColor clearColor];
    timeText.textColor=UIColorFromRGB(rgbValueDeepGrey);
    timeText.text=@"开始时间:";
    timeText.font=[UIFont fontWithName:appTypeFace size:16];
    [secondView addSubview:timeText];
    
    UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(100, fheight*3, 180, fheight)];
    time.backgroundColor=[UIColor clearColor];
    time.textColor=UIColorFromRGB(rgbValueDeepGrey);
    time.font=[UIFont fontWithName:appTypeFace size:18];
    time.tag=LABEL_TAG+4;
    [secondView addSubview:time];

    UILabel *contactNameText=[[UILabel alloc]initWithFrame:CGRectMake(20, fheight*4, 80, fheight)];
    contactNameText.backgroundColor=[UIColor clearColor];
    contactNameText.textColor=UIColorFromRGB(rgbValueDeepGrey);
    contactNameText.text=@"联系人:";
    contactNameText.font=[UIFont fontWithName:appTypeFace size:16];
    [secondView addSubview:contactNameText];
    
    UILabel *contactName=[[UILabel alloc]initWithFrame:CGRectMake(100, fheight*4, 180, fheight)];
    contactName.backgroundColor=[UIColor clearColor];
    contactName.textColor=UIColorFromRGB(rgbValueDeepGrey);
    contactName.font=[UIFont fontWithName:appTypeFace size:18];
    contactName.tag=LABEL_TAG+5;
    [secondView addSubview:contactName];

    UILabel *contactPhoneText=[[UILabel alloc]initWithFrame:CGRectMake(20, fheight*5, 80, fheight)];
    contactPhoneText.backgroundColor=[UIColor clearColor];
    contactPhoneText.textColor=UIColorFromRGB(rgbValueDeepGrey);
    contactPhoneText.text=@"联系电话:";
    contactPhoneText.font=[UIFont fontWithName:appTypeFace size:16];
    [secondView addSubview:contactPhoneText];
    
    UILabel *contactPhone=[[UILabel alloc]initWithFrame:CGRectMake(100, fheight*5, 180, fheight)];
    contactPhone.backgroundColor=[UIColor clearColor];
    contactPhone.textColor=UIColorFromRGB(rgbValueDeepGrey);
    contactPhone.font=[UIFont fontWithName:appTypeFace size:18];
    contactPhone.tag=LABEL_TAG+6;
    [secondView addSubview:contactPhone];

    UILabel *addressText=[[UILabel alloc]initWithFrame:CGRectMake(20, fheight*6, 80, fheight)];
    addressText.backgroundColor=[UIColor clearColor];
    addressText.textColor=UIColorFromRGB(rgbValueDeepGrey);
    addressText.text=@"安装地址:";
    addressText.font=[UIFont fontWithName:appTypeFace size:16];
    [secondView addSubview:addressText];
    
    UILabel *address=[[UILabel alloc]initWithFrame:CGRectMake(100, fheight*6, 180, fheight)];
    address.backgroundColor=[UIColor clearColor];
    address.textColor=UIColorFromRGB(rgbValueDeepGrey);
    address.font=[UIFont fontWithName:appTypeFace size:18];
    address.tag=LABEL_TAG+7;
    [secondView addSubview:address];

    UILabel *otherText=[[UILabel alloc]initWithFrame:CGRectMake(20, fheight*7, 80, fheight)];
    otherText.backgroundColor=[UIColor clearColor];
    otherText.textColor=UIColorFromRGB(rgbValueDeepGrey);
    otherText.text=@"备注:";
    otherText.font=[UIFont fontWithName:appTypeFace size:16];
    [secondView addSubview:otherText];
    
    UILabel *other=[[UILabel alloc]initWithFrame:CGRectMake(100, fheight*7, 180, fheight)];
    other.backgroundColor=[UIColor clearColor];
    other.textColor=UIColorFromRGB(rgbValueDeepGrey);
    other.font=[UIFont fontWithName:appTypeFace size:18];
    other.tag=LABEL_TAG+8;
    [secondView addSubview:other];
    
    [secondView setContentSize:CGSizeMake(SCREEN_WIDTH, fheight*8)];

    UIView *thirdView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-64, SCREEN_WIDTH, 64)];
    thirdView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    [self.view addSubview:thirdView];
    
    UILabel *downLine=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    downLine.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [thirdView addSubview:downLine];
    
    UIButton *nextButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 44)];
    nextButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
    [nextButton setTitle:@"速拨施工联系人电话" forState:UIControlStateNormal];
    nextButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:20];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //4个参数是上边界，左边界，下边界，右边界
    [nextButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:nextButton];
    [thirdView addSubview:nextButton];
}

-(void)buttonPressed{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)dealloc{
//    [httpRequest setRequestDelegatNil];
//}


@end
