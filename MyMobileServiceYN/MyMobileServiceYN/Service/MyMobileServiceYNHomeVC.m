//
//  MyMobileServiceYNHomeVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-2-25.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNHomeVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNMenuChangesVC.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNPackageOverInfoVC.h"
#import "MyMobileServiceYNGprsQueryVC.h"
#import "MyMobileServiceYNBillInfoVC.h"
#import "MyMobileServiceYNPackageOverDetailInfoVC.h"
#import "MyMobileServiceYNRechargeVC.h"
#import "MyMobileServiceYNCurrentExpenseVC.h"
#import "MyMobileServiceYNOrderGprsVC.h"
#import "MyMobileServiceYNLoginVC.h"
#import "DateDeal.h"
#import "MyMobileServiceYNDataProductListVC.h"
#import "MyMobileServiceYNAdslReservationVC.h"
#import "MyMobileServiceYN10086SupportVC.h"
#import "MyMobileServiceYNOnlineServiceVC.h"
#import "MyMobileServiceYNWebViewVC.h"
#import "CycleScrollView.h"
#import "MyMobileServiceYNBroadbandAccountFirstVC.h"
#import "MyMobileServiceYNPackagesServiceVC.h"
#import "MyMobileServiceYNBusinessRecommendVC.h"
#import "MyMobileServiceYNCustomerServiceVC.h"
#import "MyMobileServiceYNShopsPartyVC.h"
#import "MyMobileServiceYNRechargeVC.h"
#import "UIImageView+WebCache.h"
#import "DialogInfo.h"
#import "LiuLiangMiaoShaView.h"
#import "MyMobileServiceYN10086SupportVC.h"
#import "MyMobileServiceYNAboutUSVC.h"
#import "MyMobileServiceYNChangeThemeVC.h"
#import "MyMobileServiceYNRechargeVC.h"
#import "MyMobileServiceYNAppRecommendVC.h"
#import "MyMobileServiceYNCustomerServiceVC.h"
#import "YearBill.h"
#import "MKUserInfo.h"

#import "WaterBallView.h"
#import "ZLProgressView.h"
#import "CommonUtils.h"
#import "DesEncrypt.h"
#import "Base64codeFunc.h"
#import "ViewUtils.h"
#import "RESideMenu.h"
#import "RefreshView.h"
#import <ShareSDK/ShareSDK.h>


//#define tabBarHeight 54


@interface MyMobileServiceYNHomeVC ()<RefreshViewDelegate>
{
    RefreshView *refishView;
}

@end

@implementation MyMobileServiceYNHomeVC
@synthesize sessionID;

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
    self.view.backgroundColor = UIColorFromRGB(0xDDDDDD);
    self.title = @"首页";
    
    isCurrentMonthCostRequest = NO;
    isCurrentCost = NO;
    ImageNum=0;
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftMenuButtonPressed:) name:@"Notification_LeftMenuButtonPressed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSetIsRefreshMenu) name:@"toSetIsRefreshMenu" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeThemeColor:) name:@"changeThemeColor" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:@"logOut" object:nil];
    

    //左侧边菜单栏
    UIButton *sideMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];

    sideMenuButton.frame = CGRectMake(0, 0, 25, 25);
    [sideMenuButton setBackgroundColor:[UIColor clearColor]];
    [sideMenuButton setImage:[UIImage imageNamed: @"frame_boxmenu"] forState:UIControlStateNormal];
    [sideMenuButton setImage:[UIImage imageNamed: @"frame_boxmenu"] forState:UIControlStateHighlighted];
    [sideMenuButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //后退按钮
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:sideMenuButton];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.tabBarController.navigationItem.leftBarButtonItem = leftBarButton;
    
    //右侧边栏
    sideRightMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage *imgRaw=[UIImage imageNamed: @"frame_discount"];
    sideRightMenuButton.frame = CGRectMake(0, 0, 35, 35);
    [sideRightMenuButton setBackgroundColor:[UIColor clearColor]];
//    [sideRightMenuButton setTitle:@"分享" forState:UIControlStateNormal];
    [sideRightMenuButton setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    sideRightMenuButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:18];
//    [sideRightMenuButton setImage:[UIImage imageNamed: @"frame_exit"] forState:UIControlStateNormal];
//    [sideRightMenuButton setImage:[UIImage imageNamed: @"frame_exit"] forState:UIControlStateHighlighted];
    [sideRightMenuButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //后退按钮
//    if(![MyMobileServiceYNParam getIsLogin]){
//        sideRightMenuButton.hidden=YES;
//    }
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:sideRightMenuButton];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.tabBarController.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    //加载主页面
    [self loadHomeScrollView];
    //菜单区
//    [self setTabBarScrollView];
    
    
    isRefreshMenu = NO;
}
//显示前
-(void) viewWillAppear:(BOOL)animated{
    logoImageView.hidden=NO;
    //登录
    if ([MyMobileServiceYNParam getIsLogin]) {
        sideRightMenuButton.hidden=NO;
        if (!isCurrentMonthCostRequest) {//当月话费
            if (HUD) {
                [HUD removeHUD];
                [HUD showTextHUDWithVC:self.navigationController.view];
            }
            else{
                [HUD showTextHUDWithVC:self.navigationController.view];
            }
            //设置busiCode,方便获取返回后判断
            busiCode = @"currentMonthCost";
            requestBeanDic=[httpRequest getHttpPostParamData:@"currentMonthCost"];
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [httpRequest startAsynchronous:@"currentMonthCost" requestParamData:requestBeanDic viewController:self];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    logoImageView.hidden=YES;
}

-(void)loadHomeScrollView{
    currThemeColor = [CommonUtils getCurrentThemeColor];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT)];
    homeScrollView.backgroundColor = self.view.backgroundColor;
    homeScrollView.delegate = self;
    homeScrollView.showsVerticalScrollIndicator = NO;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-60+TabBar_HEIGHT);
    [self.view addSubview:homeScrollView];
    
    float homeScrollViewHeight=0;
    UserInfoView = [self setUserInfoView];
    [homeScrollView addSubview:UserInfoView];
    homeScrollViewHeight+=UserInfoView.frame.size.height;
    
    NSArray *infoArray = [MyMobileServiceYNParam getBusinessInfoArray];
    hotArray = [NSMutableArray new];
    phoneArray = [NSMutableArray new];
    taskArray = [NSMutableArray new];
    for (NSDictionary *dic in infoArray) {
        if ([[dic objectForKey:@"ACTIVITY_TYPE"] isEqualToString:@"4"]) {
            [hotArray addObject:dic];
        }else if([[dic objectForKey:@"ACTIVITY_TYPE"] isEqualToString:@"5"]){
            [phoneArray addObject:dic];
        }else if([[dic objectForKey:@"ACTIVITY_TYPE"] isEqualToString:@"6"]){
            [taskArray addObject:dic];
        }
    }
    //taskArray 0 1交换
    NSDictionary *dic = [taskArray objectAtIndex:0];
    [taskArray setObject:[taskArray objectAtIndex:1] atIndexedSubscript:0];
    [taskArray setObject:dic atIndexedSubscript:1];
    
    [self setTabBarScrollView];
    homeScrollViewHeight += 75;
    
    if (/*年度账单条件*/1) {
        UIButton *yearBillBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, homeScrollViewHeight+1, SCREEN_WIDTH  , 108)];
        [homeScrollView addSubview:yearBillBtn];
        yearBillBtn.tag = BUTTON_TAG + 9527;
        [yearBillBtn addTarget:self action:@selector(busiMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        homeScrollViewHeight += yearBillBtn.frame.size.height ;
        [yearBillBtn setImage:[UIImage imageNamed:@"ad_billingnew"] forState:UIControlStateNormal];
    }
    
    if (hotArray!=nil&&[hotArray count] > 0) {
        //火热活动
        UIView *hotActView = [self setContectView:1];
        hotActView.frame = CGRectMake(hotActView.frame.origin.x,
                                      homeScrollViewHeight,
                                      hotActView.frame.size.width,
                                      hotActView.frame.size.height);
        [homeScrollView addSubview:hotActView];
        homeScrollViewHeight += hotActView.frame.size.height;
    }
    
    if (phoneArray!=nil&&[phoneArray count] > 0) {
        //手机商城
        UIView *phoneShopView = [self setContectView:2];
        phoneShopView.frame = CGRectMake(phoneShopView.frame.origin.x,
                                         homeScrollViewHeight,
                                         phoneShopView.frame.size.width,
                                         phoneShopView.frame.size.height);
        [homeScrollView addSubview:phoneShopView];
        homeScrollViewHeight += phoneShopView.frame.size.height;
    }
    
    if (taskArray!=nil&&[taskArray count] > 0) {
        //任务专区
        UIView *taskView = [self setContectView:3];
        taskView.frame = CGRectMake(taskView.frame.origin.x,
                                         homeScrollViewHeight,
                                         taskView.frame.size.width,
                                         taskView.frame.size.height);
        [homeScrollView addSubview:taskView];
        homeScrollViewHeight += taskView.frame.size.height;
    }

    //设置homeScrollView内容高度
    UIView *white = [[UIView alloc]initWithFrame:CGRectMake(0, homeScrollViewHeight, 320, TabBar_HEIGHT * 6)];
    [homeScrollView addSubview:white];
    white.backgroundColor = [UIColor whiteColor];
    
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, homeScrollViewHeight+ TabBar_HEIGHT);
    
    NSArray *nils = [[NSBundle mainBundle]loadNibNamed:@"RefreshView" owner:self options:nil];
    refishView = [nils objectAtIndex:0];
    
    [refishView setupWithOwner:homeScrollView delegate:self];
    
    [refishView stopLoading];
}
/**
 *  设置用户信息view
 */
-(UIView*)setUserInfoView{
    
    //登录公告区，如果有客户端信息，则向下移动
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    view.backgroundColor = [UIColor whiteColor];
    
    //登录后显示用户信息，为登录时，提示用户登录
    if ([MyMobileServiceYNParam getIsLogin]) {
        float viewHeight = 0;
        NSMutableArray *titleArray = [[NSMutableArray alloc]init];
        [titleArray addObject:@"话费"];
        if (isShowGprs) {[titleArray addObject:@"流量"];}
        if (isShowWlan) {[titleArray addObject:@"WLAN"];}
        _control = [[DZNSegmentedControl alloc]initWithItems:titleArray];
        _control.delegate = self;
        _control.selectedSegmentIndex = 0;
        _control.bouncySelectionIndicator = YES;
        _control.showsCount = NO;
        _control.hairlineColor = currThemeColor;
        _control.tintColor = _control.hairlineColor;
        _control.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        _control.backgroundColor = UIColorFromRGB(rgbValueBaiYan);
        //        _control.showsGroupingSeparators = YES;
        //        _control.inverseTitles = YES;
        //        _control.backgroundColor = [UIColor lightGrayColor];
        //        _control.tintColor = [UIColor purpleColor];
        //        _control.hairlineColor = [UIColor purpleColor];
        //        _control.showsCount = NO;
        //        _control.autoAdjustSelectionIndicatorWidth = NO;
        //        _control.selectionIndicatorHeight = _control.intrinsicContentSize.height;
        //        _control.adjustsFontSizeToFitWidth = YES;
        [_control addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
        [view addSubview:_control];
        viewHeight += _control.frame.size.height;
        
        userInfoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, viewHeight, SCREEN_WIDTH, 200)];
        userInfoScrollView.showsHorizontalScrollIndicator = NO;
        userInfoScrollView.showsVerticalScrollIndicator = NO;
        userInfoScrollView.pagingEnabled = YES;
        userInfoScrollView.backgroundColor = UIColorFromRGB(rgbColor_userInfoScrollViewBg);
        userInfoScrollView.delegate = self;
        userInfoScrollView.tag = SCROLLVIEW_TAG + 2;
        [view addSubview:userInfoScrollView];
        
        UIView *feeView = [self loadUserInfoViewPage:UserInfoTypeFee];
        [userInfoScrollView addSubview:feeView];
        if (isShowGprs) {
            UIView *flowView = [self loadUserInfoViewPage:UserInfoTypeFlow];
            flowView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 200);
            [userInfoScrollView addSubview:flowView];
        }
        
        if (isShowWlan) {
            UIView *wlanView = [self loadUserInfoViewPage:UserInfoTypeWlan];
            if (isShowGprs) {
                wlanView.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, 200);
            }else{
                wlanView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 200);
            }
            [userInfoScrollView addSubview:wlanView];
        }
        
        viewHeight +=200;
        userInfoScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*titleArray.count, 200);
        [self updateView:view byHeight:viewHeight];
    }else{
        //640*214
        UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*214/640)];
        [loginBtn setImage:[UIImage imageNamed:@"login_again"] forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(LoginAndUserInfoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:loginBtn];
        
        [self updateView:view byHeight:loginBtn.frame.size.height];
    }
    
    return view;
}
-(UIView*)loadUserInfoViewPage:(UserInfoType) pageType{
//    float height = 0;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    view.backgroundColor = UIColorFromRGB(rgbValueBaiYan);
    
    if (pageType == UserInfoTypeFee) {
        //话费
        UILabel *feeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH/2, 20)];
        feeNameLabel.backgroundColor = [UIColor clearColor];
        feeNameLabel.textAlignment = NSTextAlignmentCenter;
        feeNameLabel.textColor = UIColorFromRGB(rgbValueDeepGrey);
        feeNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
        feeNameLabel.text = @"当月话费(元)";
        [view addSubview:feeNameLabel];
        
        UILabel *feeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, feeNameLabel.frame.origin.y+40, SCREEN_WIDTH/2, 40)];
        feeLabel.backgroundColor = [UIColor clearColor];
        feeLabel.textAlignment = NSTextAlignmentCenter;
        feeLabel.textColor = UIColorFromRGB(rgbValue_packageInfo_headerLabel);
        feeLabel.font = [UIFont fontWithName:appTypeFace size:30];
        float num2 = [[[MyMobileServiceYNParam getCurrentMonthCostDic] objectForKey:@"RSRV_NUM2"]floatValue]/100;
        float num1 = [[[MyMobileServiceYNParam getCurrentMonthCostDic] objectForKey:@"RSRV_NUM1"]floatValue]/100;
        feeLabel.text = [NSString stringWithFormat:@"%.2f",(float)(num2-num1)];
        [view addSubview:feeLabel];
        
        UIView *yeView=[UIView new];
        [view addSubview:yeView];
        UILabel *balanceNameLabel = [[UILabel alloc]initWithFrame:
                                     CGRectMake(SCREEN_WIDTH/2,
                                                feeNameLabel.frame.origin.y,
                                                SCREEN_WIDTH/2,
                                                20)];
        balanceNameLabel.backgroundColor = [UIColor clearColor];
        balanceNameLabel.textAlignment = NSTextAlignmentCenter;
        balanceNameLabel.textColor = UIColorFromRGB(rgbValueDeepGrey);
        balanceNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
        balanceNameLabel.text = @"余额(元)";
        float balanceNameLabelWidth=[balanceNameLabel.text sizeWithFont:balanceNameLabel.font].width;
        balanceNameLabel.frame=CGRectMake(0, feeNameLabel.frame.origin.y,
                                          balanceNameLabelWidth, 20);
        [yeView addSubview:balanceNameLabel];
        
        float balanceFee = [[[MyMobileServiceYNParam getCurrentMonthCostDic] objectForKey:@"RSRV_NUM3"]floatValue]/100;//余额
        if (balanceFee<10) {
            UIButton *czBtn = [UIButton new];
            int bgHeight = 50;
            czBtn.frame = CGRectMake(balanceNameLabelWidth,
                                     20,
                                     bgHeight*118/96,
                                     bgHeight);
            GlobalThemeColor themeColor = [CommonUtils getCurrentGlobalThemeColor];
            NSString *czBgImage;
            if (themeColor == GlobalThemeColorRed) {
                czBgImage = @"recharge_red";
            }else if (themeColor == GlobalThemeColorBlue){
                czBgImage = @"recharge_blue";
            }else if (themeColor == GlobalThemeColorGreen){
                czBgImage = @"recharge_green";
            }else if (themeColor == GlobalThemeColorPueple){
                czBgImage = @"recharge_pink";
            }
            [czBtn setBackgroundImage:[UIImage imageNamed:czBgImage] forState:UIControlStateNormal];
            [czBtn setTitle:@"充值" forState:UIControlStateNormal];
            [czBtn addTarget:self action:@selector(toChargeFee) forControlEvents:UIControlEventTouchUpInside];
            [czBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [yeView addSubview:czBtn];
            yeView.frame = CGRectMake(0, 0, czBtn.frame.origin.x+czBtn.frame.size.width, 60);
        }else{
            yeView.frame = CGRectMake(0, 0, balanceNameLabelWidth, 60);
        }
        yeView.center = CGPointMake(SCREEN_WIDTH*3/4, 60/2);
        //余额金额
        valueLabel = [[UILabel alloc]initWithFrame:
                               CGRectMake(SCREEN_WIDTH/2,
                                          feeLabel.frame.origin.y,
                                          SCREEN_WIDTH/2,
                                          40)];
        valueLabel.backgroundColor = [UIColor clearColor];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.textColor = currThemeColor;
        valueLabel.font = [UIFont fontWithName:appTypeFace size:30];
        
        valueLabel.text = [NSString stringWithFormat:@"%.2f",balanceFee];
        [view addSubview:valueLabel];
        
        if(isShowFeeDetailView){
            NSArray *titleArray = [NSArray arrayWithObjects:@"近3月赠送(元)",@"近3月返还(元)",@"保底消费(元)", nil];
            NSArray *valueArray = [NSArray arrayWithObjects:giveFee,returnFee,bdCostFee, nil];
            for (int i=0; i<3; i++) {
                UILabel *aTitle = [[UILabel alloc]initWithFrame:
                                   CGRectMake(SCREEN_WIDTH/3*(i%3),
                                              150,
                                              SCREEN_WIDTH/3,
                                              25)];
                aTitle.backgroundColor = [UIColor clearColor];
                aTitle.textAlignment = NSTextAlignmentCenter;
                aTitle.textColor = UIColorFromRGB(rgbValueLightGrey);
                aTitle.font = [UIFont fontWithName:appTypeFace size:13];
                aTitle.text = [titleArray objectAtIndex:i];
                [view addSubview:aTitle];
                
                UILabel *aValue = [[UILabel alloc]initWithFrame:
                                   CGRectMake(SCREEN_WIDTH/3*(i%3),
                                              175,
                                              SCREEN_WIDTH/3,
                                              25)];
                aValue.backgroundColor = [UIColor clearColor];
                aValue.textAlignment = NSTextAlignmentCenter;
                aValue.textColor = UIColorFromRGB(rgbValueDeepGrey);
                aValue.font = [UIFont fontWithName:appTypeFace size:16];
                aValue.text = [valueArray objectAtIndex:i];
                [view addSubview:aValue];
                
                if (i==0) {continue;}
                
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(aTitle.frame.origin.x, aTitle.frame.origin.y+5, 0.5, 40)];
                line.backgroundColor = UIColorFromRGB(rgbValueLineGrey);
                [view addSubview:line];
            }
        }
        
    }else if (pageType == UserInfoTypeFlow){
        
        float ballWith = 110;//ball的宽度
        float waterHeight = 0;//水的高度
        NSString *titleStr = @"";//标题
        float percent = -1;//百分比
        
        percent = [[gprsDic objectForKey:@"balance"] floatValue]/[[gprsDic objectForKey:@"total"] floatValue] *100;
        titleStr = @"剩余流量";
        waterHeight = ballWith*(1-percent/100);
        if(waterHeight < 5){
            waterHeight = 5;
        }
        UIColor *waveColor,*waveColorBg;
//        if (percent >= 50) {
//            waveColorBg = UIColorFromRGB(rgbNav_blue);
//            waveColor = UIColorFromRGB(0x7EC1E3);
//        }
        waveColorBg = UIColorFromRGB(rgbValueBaiYan);
        waveColor = UIColorFromRGB(rgbValueBaiYan);
        waterView = [[WaterBallView alloc]initWithFrame:CGRectMake(0, 0, ballWith, ballWith)];
        waterView.circleLineColor = currThemeColor;
        waterView.circleOuterColor = UIColorFromRGB(rgbValueBaiYan);
        waterView.backgroundColor = [UIColor whiteColor];
        [waterView setCurrentWaterColor:waveColor];
        [waterView reloadWater:waterHeight];
        waterView.center = CGPointMake(SCREEN_WIDTH/2,150/2);
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, ballWith, 20)];
        title.backgroundColor = [UIColor clearColor];
        title.text = titleStr;
        title.font = [UIFont fontWithName:appTypeFace size:12];
        title.textColor = currThemeColor;
        title.textAlignment = NSTextAlignmentCenter;
        title.numberOfLines = 0;
        [waterView addSubview:title];
        
        percentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ballWith, 40)];
        percentLabel.backgroundColor = [UIColor clearColor];
        NSMutableString* percentLabelStr = [[NSMutableString alloc]initWithFormat:@"%.0f",roundf(percent)];
        [percentLabelStr appendString:@"%"];
        percentLabel.text = percentLabelStr;
        percentLabel.font = [UIFont fontWithName:appTypeFace size:37];
        percentLabel.textColor = currThemeColor;
        percentLabel.textAlignment = NSTextAlignmentCenter;
        percentLabel.numberOfLines = 0;
        CGSize kSize = CGSizeMake(200 ,50);
        CGSize percentLabelSize = [percentLabel.text
                                   sizeWithFont:percentLabel.font
                                   constrainedToSize:kSize
                                   lineBreakMode:NSLineBreakByWordWrapping];
        percentLabel.frame = CGRectMake(0, 40, ballWith, percentLabelSize.height);
        [waterView addSubview:percentLabel];
        [view addSubview:waterView];
        
        NSArray *titleArray = [NSArray arrayWithObjects:@"总量(M)",@"已用(M)",@"剩余(M)", nil];
        NSArray *valueArray = [NSArray arrayWithObjects:[gprsDic objectForKey:@"total"],[gprsDic objectForKey:@"used"],[gprsDic objectForKey:@"balance"], nil];
        for (int i=0; i<3; i++) {
            UIView *templeView = [UIView new];
            templeView.frame = CGRectMake(SCREEN_WIDTH/3*(i%3),150,SCREEN_WIDTH/3,25);
            [view addSubview:templeView];
            
            UILabel *aTitle = [UILabel new];
            aTitle.backgroundColor = [UIColor clearColor];
            aTitle.textAlignment = NSTextAlignmentCenter;
            aTitle.textColor = UIColorFromRGB(rgbValueLightGrey);
            aTitle.font = [UIFont fontWithName:appTypeFace size:15];
            aTitle.text = [titleArray objectAtIndex:i];
            float aTitleWidth = [aTitle.text sizeWithFont:aTitle.font].width;
            aTitle.frame = CGRectMake(0, 0, aTitleWidth, 25);
            [templeView addSubview:aTitle];
            
            float xsFlow = [gprsDic objectForKey:@"闲时流量"]!=nil?[[gprsDic objectForKey:@"闲时流量"] floatValue]:0;
            if(i==2&&xsFlow>0){
                UIImageView *xsBgImageView = [UIImageView new];
                int bgHeight = 42;
                xsBgImageView.frame = CGRectMake(aTitleWidth,
                                         -15,
                                         bgHeight*118/96,
                                         bgHeight);
                GlobalThemeColor themeColor = [CommonUtils getCurrentGlobalThemeColor];
                NSString *bgImage;
                if (themeColor == GlobalThemeColorRed) {
                    bgImage = @"flow_red";
                }else if (themeColor == GlobalThemeColorBlue){
                    bgImage = @"flow_blue";
                }else if (themeColor == GlobalThemeColorGreen){
                    bgImage = @"flow_green";
                }else if (themeColor == GlobalThemeColorPueple){
                    bgImage = @"flow_pink";
                }
                xsBgImageView.image = [UIImage imageNamed:bgImage];
                [templeView addSubview:xsBgImageView];
                
                
                UILabel *xsLabel = [UILabel new];
                xsLabel.frame = CGRectMake(0, 0, xsBgImageView.frame.size.width, xsBgImageView.frame.size.height);
                xsLabel.text=[NSString stringWithFormat:@"闲时流量:\n%.0fM", xsFlow];
                xsLabel.textColor = [UIColor whiteColor];
                xsLabel.font = [UIFont fontWithName:appTypeFaceBold size:10];
                xsLabel.textAlignment = NSTextAlignmentCenter;
                xsLabel.backgroundColor = [UIColor clearColor];
                xsLabel.numberOfLines=2;
                [xsBgImageView addSubview:xsLabel];
                
                templeView.frame = CGRectMake(0, 0, aTitleWidth+xsBgImageView.frame.size.width, 25);
            }else{
                templeView.frame = CGRectMake(0, 0, aTitleWidth, 25);
            }
            templeView.center = CGPointMake(SCREEN_WIDTH/3*(i%3+0.5), 150+25.0/2);
            
            UILabel *aValue = [[UILabel alloc]initWithFrame:
                               CGRectMake(SCREEN_WIDTH/3*(i%3),
                                          175,
                                          SCREEN_WIDTH/3,
                                          25)];
            aValue.backgroundColor = [UIColor clearColor];
            aValue.textAlignment = NSTextAlignmentCenter;
            aValue.textColor = UIColorFromRGB(rgbValueDeepGrey);
            aValue.font = [UIFont fontWithName:appTypeFace size:16];
            aValue.text = [valueArray objectAtIndex:i];
            [view addSubview:aValue];
            
            if (i==0) {continue;}
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(aTitle.frame.origin.x, aTitle.frame.origin.y+5, 0.5, 40)];
            line.backgroundColor = UIColorFromRGB(rgbValueLineGrey);
            [view addSubview:line];
        }
    }else if (pageType == UserInfoTypeWlan){
        
        NSArray *titleArray = [NSArray arrayWithObjects:@"WLAN(流量)",@"WLAN(时长)", nil];
        NSArray *totalArray = [NSArray arrayWithObjects:
                               [NSString stringWithFormat:@"%@M",[wlanFlowDic objectForKey:@"total"]],
                               [NSString stringWithFormat:@"%@分",[wlanTimeDic objectForKey:@"total"]], nil];
        NSArray *balanceArray = [NSArray arrayWithObjects:
                               [NSString stringWithFormat:@"%@M",[wlanFlowDic objectForKey:@"balance"]],
                               [NSString stringWithFormat:@"%@分",[wlanTimeDic objectForKey:@"balance"]], nil];
        float didTime = [[wlanTimeDic objectForKey:@"total"]floatValue]-[[wlanTimeDic objectForKey:@"balance"]floatValue];
        float didFlow = [[wlanTimeDic objectForKey:@"total"]floatValue]-[[wlanTimeDic objectForKey:@"balance"]floatValue];
        
        NSArray *progressArray = [NSArray arrayWithObjects:
                                   [NSString stringWithFormat:@"%f",didFlow/[[wlanFlowDic objectForKey:@"total"]floatValue]],
                                   [NSString stringWithFormat:@"%f",didTime/[[wlanTimeDic objectForKey:@"total"]floatValue]], nil];
        for(int i=0;i<titleArray.count;i++){
            
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, 20+80*i, SCREEN_WIDTH-40, 18)];
            title.backgroundColor = [UIColor clearColor];
            title.text = [titleArray objectAtIndex:i];
            title.font = [UIFont fontWithName:appTypeFace size:14];
            title.textColor = UIColorFromRGB(rgbValueDeepGrey);
            title.numberOfLines = 0;
            [view addSubview:title];
            
            UILabel *remain = [[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+20, title.frame.size.width, 15)];
            remain.backgroundColor = [UIColor clearColor];
            remain.text = [NSString stringWithFormat:@"剩%@",[balanceArray objectAtIndex:i]];
            remain.font = [UIFont fontWithName:appTypeFace size:12];
            remain.textColor = UIColorFromRGB(rgbValue_navBarBg);
            remain.numberOfLines = 0;
            if(i==0){remain01=remain;}
            else if(i==1){remain02=remain;}
            [view addSubview:remain];
            
            float remainWidth = [remain.text sizeWithFont:remain.font].width;
            
            UILabel *total = [[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x+remainWidth, remain.frame.origin.y, title.frame.size.width, 15)];
            total.backgroundColor = [UIColor clearColor];
            total.text = [NSString stringWithFormat:@"/共%@",[totalArray objectAtIndex:i]];
            total.font = [UIFont fontWithName:appTypeFace size:12];
            total.textColor = UIColorFromRGB(rgbValueLightGrey);
            total.numberOfLines = 0;
            [view addSubview:total];
            
//            #74d2bb进度条颜色 #b6d6e3边框颜色
            ZLProgressView *progressView = [[ZLProgressView alloc]initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height, title.frame.size.width, 20)];
            progressView.progressTintColor = UIColorFromRGB(0x74d2bb);//属性 填充部分的颜色
            progressView.trackTintColor = [UIColor whiteColor];//属性，未填充部分的颜色
            progressView.layer.cornerRadius = 10;
            progressView.layer.borderWidth = 1;
            progressView.layer.borderColor =  UIColorFromRGB(0xb6d6e3).CGColor;
            [progressView loadProgress:[[progressArray objectAtIndex:i] floatValue]];
            [view addSubview:progressView];
        }
    }
    
    return view;
}

-(UIView*)setContectView:(int) tag{
    float height = 0;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    view.backgroundColor = [UIColor whiteColor];
    //标题
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, height, view.frame.size.width-20, 40)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor darkTextColor];
    title.font = [UIFont fontWithName:appTypeFace size:17];
    if (tag == 1) {
        title.text = @"火热活动";
    }else if(tag == 2){
        title.text = @"手机商城";
    }else if (tag == 3){
        title.text = @"任务专区";
    }
    [view addSubview:title];
    height+=40;
    UIView *contView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 0)];
    [self setViewBorder:contView];
    [view addSubview:contView];
    if (tag == 1||tag == 2||tag == 3) {
        
        CGRect frame1 = CGRectMake(0, 0, SCREEN_WIDTH*300/640, SCREEN_WIDTH*340/640);
        CGRect frame2 = CGRectMake(frame1.size.width, 0, SCREEN_WIDTH-frame1.size.width, frame1.size.height/2);
        CGRect frame3 = CGRectMake(frame1.size.width, frame2.size.height, frame2.size.width, frame2.size.height);
        int count = tag==1?hotArray.count:phoneArray.count;
        for(int i=0;i<count;i++){
            NSDictionary *rowData;
            if (tag==1) {rowData = [hotArray objectAtIndex:i];}
            else if(tag==2){rowData = [phoneArray objectAtIndex:i];}
            else if(tag==3){rowData = [taskArray objectAtIndex:i];}
            
            UIButton *btn = [[UIButton alloc]init];
            switch (i) {
                case 0:btn.frame = frame1;break;
                case 1:btn.frame = frame2;break;
                case 2:btn.frame = frame3;break;
                default:
                    break;
            }
            btn.tag = BUTTON_TAG+10*tag+i;
            [btn addTarget:self action:@selector(activityButton:) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
            if(i==1||i==2){
                image.frame=CGRectMake(0, 0, btn.frame.size.height*338/170, btn.frame.size.height);
            }
            image.center = CGPointMake(btn.frame.size.width/2, btn.frame.size.height/2);
            [btn addSubview:image];
            [contView addSubview:btn];
            
            if(i<3){
                NSMutableString *imageUrl = [[NSMutableString alloc]initWithString:[rowData objectForKey:@"IMAGE_PATH"]];
                [imageUrl appendString:[rowData objectForKey:@"IMG_NAME"]];
                
                
                [image sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:SDWebImageProgressiveDownload&SDWebImageCacheMemoryOnly];
                
            }
            
        }
        //line1
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(frame1.size.width, 0,1, frame1.size.height)];
        line1.backgroundColor = UIColorFromRGB(rgbValue_grayLine);
        [contView addSubview:line1];
        //line1
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(frame1.size.width, frame2.size.height,frame2.size.width, 1)];
        line2.backgroundColor = UIColorFromRGB(rgbValue_grayLine);
        [contView addSubview:line2];
        
        height += frame1.size.height;
    }
    
    [self updateView:contView byHeight:height-40];
    [self updateView:view byHeight:height];
    return view;
}
//设置视图边框
-(void)setViewBorder:(UIView *)view{
    view.layer.borderColor = UIColorFromRGB(rgbValue_grayLine).CGColor;
    view.layer.borderWidth = 1;
}
-(void)toSeeWeb{
    if ([MyMobileServiceYNParam getIsDynamicPW]) {//如果是动态密码登录，不允许使用，提示用户重新登录
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
        alertView.tag = ALERTVIEW_TAG;
        [alertView show];
    }else
    {
        MyMobileServiceYNBusinessRecommendVC *businessRecommendVC = [[MyMobileServiceYNBusinessRecommendVC alloc]init];
        [self.navigationController pushViewController:businessRecommendVC animated:YES];
    }
}
/**
 *  初始化菜单数组
 */
-(void)initMenuListArray{
    //关于menulist plist文件，需要先判断沙盒里面是否存在，如果存在判断版本是否为当前版本。
    //版本不对，则替换为最新版本。如果存在且版本正确，则不做任何操作，直接读取。
    //读取菜单menulist plist文件，获取菜单列表
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    menuListFielPath=[plistPath1 stringByAppendingPathComponent:@"menulist.plist"];
    DebugNSLog(@"%@",menuListFielPath);
    
    //判断文件是否存在沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:menuListFielPath]== NO ) {
        DebugNSLog(@"menulist.plist is not exists");
        //将plist文件 复制到沙盒中 ，方法一
        //        NSError *error;
        //        NSFileManager *fileManager = [NSFileManager defaultManager];
        //        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"menulist" ofType:@"plist"];
        //        [fileManager copyItemAtPath:bundle toPath:menuListFielPath error:&error];
        
        //方法二
        NSString *path = [[NSBundle mainBundle] pathForResource:@"menulist"ofType:@"plist"];
        NSMutableDictionary *menuListDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        [menuListDic writeToFile:menuListFielPath atomically:YES];
    }else{
        DebugNSLog(@"menulist.plist is exists");
        //获取版本字段并比较，如果不相同，则将自带复制到沙盒里面去
        //获取沙盒数据版本
        NSMutableDictionary *listDicSandbox = [[NSMutableDictionary alloc] initWithContentsOfFile:menuListFielPath];
        NSString *versionSandbox = [listDicSandbox objectForKey:@"Version"];
        
        //获取自带数据版本
        NSString *path = [[NSBundle mainBundle] pathForResource:@"menulist"ofType:@"plist"];
        NSMutableDictionary *menuListDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        NSString *version = [menuListDic objectForKey:@"Version"];
        
        //判断数据版本是否相同
        if (![versionSandbox isEqualToString:version]) {//不相同
            //先删除沙盒中原有文件
            [fileManager removeItemAtPath:menuListFielPath error:nil];
            //复制到沙盒中
            [menuListDic writeToFile:menuListFielPath atomically:YES];
        }
    }
    
    //截止到目前位置沙盒中已经存在menulist.plist，读取menulist.plist文件，并展示到桌面
    
    menuListDicSandbox = [[NSMutableDictionary alloc] initWithContentsOfFile:menuListFielPath];
    menuListArray = [menuListDicSandbox objectForKey:@"MenuList"];
    
    DebugNSLog(@"%@\n%ld",menuListArray,(long)menuListArray.count);
}

//设置tabbar 菜单按钮
-(void)setTabBarScrollView{
    //根据MenuChangeStatus判断是否在首页显示，yes为显示，no为不显示
    //过滤menuListArray数据
    //定义最新menuListArray
    //初始化菜单数组
    [self initMenuListArray];
    NSMutableArray *newMenuListArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<menuListArray.count; i++){
        NSDictionary *dic = [menuListArray objectAtIndex:i];
        //plist中bool需要先转成NSNumber 再转成boolValue，写的时候反之NSNumber *testBoolean =[[NSNumber alloc]initWithBool:YES];
        BOOL bMenuChangeStatus = [(NSNumber*)[dic objectForKey:@"MenuChangeStatus"]boolValue];
        if (bMenuChangeStatus) {
            NSArray *menuArray = [NSArray arrayWithObjects:@"实时话费",@"套餐变更",@"业务办理",@"充值",@"套餐余量",@"我的账单",@"流量查询",@"流量订购",@"宽带办理", nil];
            if([menuArray indexOfObject:[dic objectForKey:@"MenuName"]]<=menuArray.count){
                if(![[MyMobileServiceYNParam getIsHuiDuVersion] boolValue]){ //gIsHuiDuVersion默认为1，只有当登录后返回灰度值为0时，则执行。显示所有功能，包括灰度功能
                    [newMenuListArray addObject:dic];
                }else{
                    if([[dic objectForKey:@"isHuiDuVersion"] boolValue]){ //isHuiDuVersion=1为正常显示版本执行，只显示plist文件里面isHuiDuVersion 为1的普通非灰度功能。
                        [newMenuListArray addObject:dic];
                    }
                }
            }
        }
    }
    //菜单区
    menuWidthCount = 0;
    if ((newMenuListArray.count)%4 == 0) {
        menuWidthCount = (int)((newMenuListArray.count)/4);
    }else{
        menuWidthCount = (int)((newMenuListArray.count)/4) + 1;
    }
    
    
    tabBarScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, UserInfoView.frame.size.height, SCREEN_WIDTH, 76)];
    [self setViewBorder:tabBarScrollView];
    [tabBarScrollView setHidden:NO];
    tabBarScrollView.backgroundColor = [UIColor whiteColor];
    tabBarScrollView.pagingEnabled = YES;
    tabBarScrollView.showsHorizontalScrollIndicator = NO;
    tabBarScrollView.showsVerticalScrollIndicator = NO;
    tabBarScrollView.contentSize = CGSizeMake(menuWidthCount*SCREEN_WIDTH, TabBar_HEIGHT);
    tabBarScrollView.delegate = self;
    tabBarScrollView.tag = SCROLLVIEW_TAG + 1;
    
    float buttonH = 63;
    
    for (int i=0; i<newMenuListArray.count; i++) {
        UIButton *buttonView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 75, buttonH)];
        buttonView.center = CGPointMake(SCREEN_WIDTH*(i/4)+SCREEN_WIDTH/4*(i%4+0.5),
                                        buttonView.center.y);
        buttonView.tag = BUTTON_TAG+100+[[[newMenuListArray objectAtIndex:i] objectForKey:@"MenuID"] intValue];
        [buttonView addTarget:self action:@selector(busiMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView setBackgroundImage:[ViewUtils imageWithColor:UIColorFromRGB(rgbValueBaiYan) size:buttonView.frame.size] forState:UIControlStateHighlighted];
        
        UIImageView *busiButton =[[UIImageView alloc]initWithFrame:CGRectMake(18, 8, 35, 35)];
        NSString *imageUrl;
        NSString *menuName=[[newMenuListArray objectAtIndex:i] objectForKey:@"MenuName"];
        
        if ([menuName isEqualToString:@"客服"]){
            busiButton.image = [UIImage imageNamed:[[newMenuListArray objectAtIndex:i] objectForKey:@"MenuImage"]];
//            [busiButton setBackgroundImage:[UIImage imageNamed:[[[newMenuListArray objectAtIndex:i] objectForKey:@"MenuImage"] stringByAppendingString:@"on"]] forState:UIControlStateHighlighted];
        }else{
            if ([menuName isEqualToString:@"实时话费"]) {
                imageUrl = @"service_button_50";
            }else if ([menuName isEqualToString:@"流量查询"]) {
                imageUrl = @"service_button_52";
            }else if ([menuName isEqualToString:@"流量订购"]) {
                imageUrl = @"service_button_62";
            }else if ([menuName isEqualToString:@"我的账单"]) {
                imageUrl = @"service_button_53";
            }else if ([menuName isEqualToString:@"套餐余量"]) {
                imageUrl = @"service_button_51";
            }else if ([menuName isEqualToString:@"充值"]) {
                imageUrl = @"service_button_70";
            }else if ([menuName isEqualToString:@"业务办理"]) {
                imageUrl = @"service_button_60";
            }else if ([menuName isEqualToString:@"客服"]) {
                imageUrl = @"ico_cseron";
            }else if ([menuName isEqualToString:@"套餐变更"]) {
                imageUrl = @"service_button_61";
            }else if ([menuName isEqualToString:@"话费查询"]) {
                imageUrl = @"yw_hfcx";
            }else if ([menuName isEqualToString:@"宽带办理"]) {
                imageUrl = @"service_button_64";
            }
            busiButton.image = [UIImage imageNamed:imageUrl];
        }
        
        [buttonView addSubview:busiButton];
        [tabBarScrollView addSubview:buttonView];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 46, 75, 14)];
        lable.text = [[newMenuListArray objectAtIndex:i] objectForKey:@"MenuName"];
        lable.textColor = UIColorFromRGB(rgbValueDeepGrey);
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font=[UIFont fontWithName:appTypeFace size:11];
        [buttonView addSubview:lable];
    }
    

    tabBarPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,
                                                                      tabBarScrollView.frame.origin.y + 73-10,
                                                                      SCREEN_WIDTH,
                                                                       10)];
    NSLog(@"%f",tabBarScrollView.frame.origin.y);
    tabBarPageControl.numberOfPages = menuWidthCount;
    tabBarPageControl.currentPage = 0;
    tabBarPageControl.backgroundColor = [UIColor clearColor];
    tabBarPageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    tabBarPageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    tabBarPageControl.hidesForSinglePage = YES;
    tabBarPageControl.userInteractionEnabled = NO;
    [homeScrollView addSubview:tabBarScrollView];
    [homeScrollView addSubview:tabBarPageControl];
}
-(void)toSetIsRefreshMenu{
//    [tabBarScrollView removeFromSuperview];

    [menuListDicSandbox removeAllObjects];
    [menuListArray removeAllObjects];
    menuListDicSandbox = [[NSMutableDictionary alloc] initWithContentsOfFile:menuListFielPath];
    menuListArray = [menuListDicSandbox objectForKey:@"MenuList"];
    
//    [self setTabBarScrollView];
}

//展示猜你喜欢
-(void)toShowGuessYourLoveView{
    toCloseButton.hidden=NO;
    guessYourLoveView.hidden=NO;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:guessYourLoveView];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0f];
    guessYourLoveView.frame = CGRectMake(guessYourLoveView.frame.origin.x, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT-117.5, guessYourLoveView.frame.size.width, guessYourLoveView.frame.size.height);
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(toCloseGuessYourLoveView) userInfo:nil repeats:NO];
}

//隐藏猜你喜欢
-(void)toCloseGuessYourLoveView{
    toCloseButton.hidden=YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:guessYourLoveView];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0f];
    guessYourLoveView.frame = CGRectMake(guessYourLoveView.frame.origin.x, SCREEN_HEIGHT, guessYourLoveView.frame.size.width, guessYourLoveView.frame.size.height);
    [UIView commitAnimations];
}

-(void)toViewAdvertiseMent:(id)sender{
    NSInteger index=[sender tag]-BUTTON_TAG-50;
    NSArray *bannerArray=[MyMobileServiceYNParam getBannerArray];
    MyMobileServiceYNWebViewVC *webViewVC=[[MyMobileServiceYNWebViewVC alloc]init];
    webViewVC.title=[[bannerArray objectAtIndex:index] objectForKey:@"ACTIVITY_NAME"];
    webViewVC.webUrlString=[[bannerArray objectAtIndex:index] objectForKey:@"ACTIVITY_DETAILS"];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController: webViewVC];
    //设置nav bar 颜色
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
//        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(rgbValue_navBarBg)];
    }else{
//        [[UINavigationBar appearance] setTintColor:UIColorFromRGB(rgbValue_navBarBg)];
    }
    [nav.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:appTypeFace size:18.0], UITextAttributeFont,nil]];
    [self presentModalViewController:nav animated:YES];
}

/**
 *  改变view的高度
 *
 *  @param view   视图
 *  @param height 更新后高度
 *
 *  @return 更新后的视图
 */
-(BOOL)updateView:(UIView*)view byHeight:(float) height{
    if (view==nil) {
        return NO;
    }
    CGRect rect = view.frame;
    rect.size.height = height;
    view.frame = rect;
    return YES;
}

/**
 *  更改主题
 *
 *  @param notification <#notification description#>
 */
-(void)changeThemeColor:(NSNotification *)notification
{
    NSLog(@"homeView 更改主题");
    
    [CommonUtils setCurrentThemeColor:notification.object];
    [self changeViewsThemeColor];
}
/**
 *  更改指定views的背景颜色
 *
 *  @param themeColor <#themeColor description#>
 */
-(void)changeViewsThemeColor{
    
//    _control.tintColor = themeColor;
//    [_control setTitleColor:themeColor forState:UIControlStateHighlighted];
//    _control.hairlineColor = themeColor;
//    
//    valueLabel.textColor = themeColor;//余额金钱
//    waterView.circleLineColor = themeColor;//流量球
//    percentLabel.textColor = themeColor;
//    remain01.textColor = themeColor;//剩余01
//    remain02.textColor = themeColor;
    
    [self refreshHomeScrollView];
}

/**
 *  刷新HomeScrollView
 */
-(void)refreshHomeScrollView{
    [homeScrollView removeFromSuperview];
    [self loadHomeScrollView];
}

#pragma mark - segement methods
-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar{
    return UIBarPositionBottom;
}

- (void)selectedSegment:(DZNSegmentedControl *)control
{
    DebugNSLog(@"你点击了segement");
    currPage = control.selectedSegmentIndex;
    DebugNSLog(@"currPage==%d",currPage);
    userInfoScrollView.contentOffset = CGPointMake(currPage*SCREEN_WIDTH, 0);
}
#pragma mark - scrollviewDelegate methods
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == SCROLLVIEW_TAG+1) {
        CGFloat pageWith = scrollView.frame.size.width;
        int page =  floor((scrollView.contentOffset.x - pageWith /2)/pageWith)+1;
        DebugNSLog(@"page==%d",page);
        tabBarPageControl.currentPage = page;
    }else if (scrollView.tag == SCROLLVIEW_TAG+2){
        CGFloat pageWith = scrollView.frame.size.width;
        currPage =  floor((scrollView.contentOffset.x - pageWith /2)/pageWith)+1;
        DebugNSLog(@"currPage==%d",currPage);
        [_control setSelectedSegmentIndex:currPage];
    }
}

#pragma mark - ASIHTTPRequestDelegate methods
- (void)requestFinished:(ASIHTTPRequest *)requestBean
{
    NSArray *cookies = [requestBean responseCookies];
    DebugNSLog(@"%@",cookies);
    DebugNSLog(@"第二个%@",sessionID);
    NSData *jsonData =[requestBean responseData];
    DebugNSLog(@"%@",[requestBean responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([array isKindOfClass:[NSDictionary class]]) {
        array = [NSArray arrayWithObjects:array, nil];
    }
    NSDictionary *dic = [array objectAtIndex:0];
    //sessionid = [dic objectForKey:@"SCORE_ID"];
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        //登陆后接口调用顺序
        //currentMonthCost--》queryUserAmount--》queryDetailLog--》QAM_USERSCORE--》queryGuarantees
        if ([busiCode isEqualToString:@"currentMonthCost"]) {
            //1
            isCurrentMonthCostRequest = YES;
            [MyMobileServiceYNParam setCurrentMonthCostDic:dic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"toSetLeftMenuInfo" object:nil userInfo:nil];
            //登录后显示用户信息
            if ([MyMobileServiceYNParam getIsLogin]) {
                NSMutableString *billCycle=[[NSMutableString alloc]init];
                if ([DateDeal getMonth]<10) {
                    [billCycle appendString:[NSString stringWithFormat:@"%ld0%ld",(long)[DateDeal getYear],(long)[DateDeal getMonth]]];
                }else
                {
                    [billCycle appendString:[NSString stringWithFormat:@"%ld%ld",(long)[DateDeal getYear],(long)[DateDeal getMonth]]];
                }
                DebugNSLog(@"%@",billCycle);
                //套餐余量查询
                busiCode = @"queryUserAmount";
                requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
                [requestBeanDic setObject:billCycle forKey:@"BCYC_ID"];
                [requestBeanDic setObject:@"0" forKey:@"REMOVE_TAG"];
                [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
                [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
            }
        }else if ([busiCode isEqualToString:@"checkVersion"]){
            if ([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"X_RESULTINFO"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                alertView.tag = ALERTVIEW_TAG_RETURN + 12;
                [alertView show];
            }
            else if ([@"1" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]]) {//不是最新版本，不强制更新
                downLoadUrl=[dic objectForKey:@"newest-path"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"X_RESULTINFO"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新",nil];
                alertView.tag = ALERTVIEW_TAG_RETURN + 10;
                [alertView show];
            }
            else if ([@"-1" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]]) {//不是最新版本，强制更新
                downLoadUrl=[dic objectForKey:@"newest-path"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"X_RESULTINFO"] delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"更新",nil];
                alertView.tag = ALERTVIEW_TAG_RETURN + 11;
                [alertView show];
            }
            if (HUD) {
                [HUD removeHUD];
            }
        }else if([busiCode isEqualToString:@"queryUserAmount"]){
            //2套餐余量查询
            long long gprsTotal=0,wlanFlowTotal=0,wlanTimeTotal=0,
            gprsBalance=0,wlanFlowBalance=0,wlanTimeBalance=0,xsGprsBalance=0;
            isShowWlan = NO;isShowGprs = NO;
            for(NSDictionary *dic in array){
                NSString *itemType = [dic objectForKey:@"ITEM_TYPE"];
                if([itemType isEqualToString:@"优惠GPRS流量（M）"]){
                    isShowGprs = YES;
                    gprsTotal += [[dic objectForKey:@"HIGH_FEE"] longLongValue];
                    gprsBalance += [[dic objectForKey:@"BALANCE"]longLongValue];
                    if ([[dic objectForKey:@"DISCNT_CODE"] isEqualToString:@"99003137"]) {
                        xsGprsBalance += [[dic objectForKey:@"BALANCE"]longLongValue];
                    }
                }
                else if ([itemType isEqualToString:@"优惠WLAN时长（分钟）"]) {
                    isShowWlan = YES;
                    wlanTimeTotal += [[dic objectForKey:@"HIGH_FEE"] longLongValue];
                    wlanTimeBalance += [[dic objectForKey:@"BALANCE"]longLongValue];
                }
                else if ([itemType isEqualToString:@"优惠WLAN流量（M）"]) {
                    isShowWlan = YES;
                    wlanFlowTotal += [[dic objectForKey:@"HIGH_FEE"] longLongValue];
                    wlanFlowBalance += [[dic objectForKey:@"BALANCE"]longLongValue];
                }
            }
            if (wlanFlowDic==nil) { wlanFlowDic = [[NSMutableDictionary alloc]init];}
            if (wlanTimeDic==nil) { wlanTimeDic = [[NSMutableDictionary alloc]init];}
            if (gprsDic==nil) { gprsDic = [[NSMutableDictionary alloc]init];}
            
            [wlanFlowDic setValue:[CommonUtils formateNumber:[NSNumber numberWithFloat:(float)wlanFlowTotal/1024/1024] FractionDigits:2] forKey:@"total"];
            [wlanFlowDic setValue:[CommonUtils formateNumber:[NSNumber numberWithFloat:(float)(wlanFlowTotal-wlanFlowBalance)/1024/1024] FractionDigits:2] forKey:@"used"];
            [wlanFlowDic setValue:[CommonUtils formateNumber:[NSNumber numberWithFloat:(float)wlanFlowBalance/1024/1024] FractionDigits:2] forKey:@"balance"];
            
            [wlanTimeDic setValue:[NSString stringWithFormat:@"%.0f",(float)wlanTimeTotal] forKey:@"total"];
            [wlanTimeDic setValue:[NSString stringWithFormat:@"%.0f",(float)(wlanTimeTotal-wlanTimeBalance)] forKey:@"used"];
            [wlanTimeDic setValue:[NSString stringWithFormat:@"%.0f",(float)wlanTimeBalance] forKey:@"balance"];

            [gprsDic setValue:[CommonUtils formateNumber:[NSNumber numberWithFloat:(float)gprsTotal/1024/1024] FractionDigits:2]forKey:@"total"];
            [gprsDic setValue:[CommonUtils formateNumber:[NSNumber numberWithFloat:(float)(gprsTotal-gprsBalance)/1024/1024] FractionDigits:2]forKey:@"used"];
            [gprsDic setValue:[CommonUtils formateNumber:[NSNumber numberWithFloat:(float)gprsBalance/1024/1024] FractionDigits:2]forKey:@"balance"];
            [gprsDic setValue:[CommonUtils formateNumber:[NSNumber numberWithFloat:(float)xsGprsBalance/1024/1024] FractionDigits:2]forKey:@"闲时流量"];
            
            if ([MyMobileServiceYNParam getIsLogin]) {
                //接着获取猜你喜欢营销数据
                if (!HUD) {
                    [HUD showTextHUDWithVC:self.navigationController.view];
                }
                //设置busiCode,方便获取返回后判断
                busiCode = @"queryDetailLog";
                requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
                [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];//用户号码
                [requestBeanDic setObject:@"0" forKey:@"MONTH"];//查询日期
                [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
            }
        }else if([busiCode isEqualToString:@"queryDetailLog"]){
            //3 获取近3月话费 返费和赠送金额
        
            //根据详细信息获取汇总信息并展示
            //赠送
            int k = [[dic objectForKey:@"NEW_PRESENT_FEE"] intValue];
            giveFee = [NSString stringWithFormat:@"%.2f",(float)k/100];
            
            int l = [[dic objectForKey:@"NEW_CASH_DIVIDED_FEE"] intValue];
            int m = [[dic objectForKey:@"NEW_PRESENT_DIVIDED_FEE"] intValue];
            
            if (l<0) {l = 0-l;}
            if (m<0) {m = 0-m;}
            //返回
            returnFee = [NSString stringWithFormat:@"%.2f",(float)(l+m)/100];
            
            isShowFeeDetailView = YES;
//            NEW_PRESENT_FEE这个字段是赠送
//            NEW_CASH_DIVIDED_FEE+NEW_PRESENT_DIVIDED_FEE是返还
            if ([MyMobileServiceYNParam getIsLogin]) {
                if (!HUD) {
                    [HUD showTextHUDWithVC:self.navigationController.view];
                }
                //设置busiCode,方便获取返回后判断
                busiCode = @"QAM_USERSCORE";
                requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
                [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
                [requestBeanDic setObject:@"ZZZZ" forKey:@"YEAR_ID"];
                [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
            }
        }else if([busiCode isEqualToString:@"QAM_USERSCORE"]){
            //4 总积分
            int totalScore = 0;
            for(NSDictionary *dic in array){
                totalScore += [[dic objectForKey:@"SCORE"]intValue];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"toSetLeftMenuInfo" object:[NSString stringWithFormat:@"%d",totalScore] userInfo:nil];
            
            if ([MyMobileServiceYNParam getIsLogin]) {
                //
                if (!HUD) {
                    [HUD showTextHUDWithVC:self.navigationController.view];
                }
                //设置busiCode,方便获取返回后判断
                busiCode = @"queryGuarantees";
                requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
                [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
                [requestBeanDic setObject:@"ZZZZ" forKey:@"TRADE_CITY_CODE"];
                [requestBeanDic setObject:[MyMobileServiceYNParam getUserId] forKey:@"USER_ID"];//用户id
                [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
            }
        }else if([busiCode isEqualToString:@"queryGuarantees"]){
            //保底消费
            int fee = 0;
            for (NSDictionary *dic in array) {
                fee += [[dic objectForKey:@"ALL_FEE"] intValue];
            }
            bdCostFee = [NSString stringWithFormat:@"%.2f",(float)fee/100];
            //5
            
            busiCode = @"HQSM_IntegralQryAcctInfos";
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [requestBeanDic setObject:@"HQSM_IntegralQryAcctInfos" forKey:@"intf_code"];
            [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
        }else if ([busiCode isEqualToString:@"HQSM_IntegralQryAcctInfos"]){
            [MKUserInfo setHomePointArray:array];
            [self refreshHomeScrollView];
            if(HUD){
                [HUD removeHUD];
            }
        }
        
        else if([busiCode isEqualToString:@"TouchSaleCheckNum"]){
            //根据RERV_TAG1判断判断是否有推荐信息0-有推荐信息 1-无推荐信息
            if ([[dic objectForKey:@"RERV_TAG1"]isEqualToString:@"0"]) {
                [MyMobileServiceYNParam setBusinessRecommendDic:dic];
                
                toCloseButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-117.5)];
                toCloseButton.backgroundColor=[UIColor clearColor];
                [toCloseButton addTarget:self action:@selector(toCloseGuessYourLoveView) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:toCloseButton];
                
                guessYourLoveView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 117.5)];
                guessYourLoveView.backgroundColor=[UIColor clearColor];
                [self.view addSubview:guessYourLoveView];
                
                UIImageView *guessYourLoveImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 117.5)];
                guessYourLoveImageView.image=[UIImage imageNamed:@"guessYourLove_bg"];
                [guessYourLoveView addSubview:guessYourLoveImageView];
                
                //设置猜你喜欢显示文字信息
                UILabel *guessYourLoveLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 43, 220, 70)];
                guessYourLoveLabel.backgroundColor = [UIColor clearColor];
                guessYourLoveLabel.font = [UIFont fontWithName:appTypeFace size:15];
                guessYourLoveLabel.textColor = [UIColor orangeColor];
                guessYourLoveLabel.textAlignment = NSTextAlignmentCenter;
                guessYourLoveLabel.lineBreakMode = UILineBreakModeTailTruncation;     //指定换行模式
                guessYourLoveLabel.numberOfLines = 3;    // 指定label的行数
                guessYourLoveLabel.text = [dic objectForKey:@"CAMPN_CONTENT"];
                [guessYourLoveView addSubview:guessYourLoveLabel];
                
                UIButton *guessYourLoveButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 117.5)];
                guessYourLoveButton.backgroundColor=[UIColor clearColor];
                [guessYourLoveButton addTarget:self action:@selector(toSeeWeb) forControlEvents:UIControlEventTouchUpInside];
                [guessYourLoveView addSubview:guessYourLoveButton];
                
                UIImageView *closeButtonImage=[[UIImageView alloc]initWithFrame:CGRectMake(290, 20, 20, 20)];
                closeButtonImage.image=[UIImage imageNamed:@"btn_close"];
                [guessYourLoveView addSubview:closeButtonImage];
                
                UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(280, 20, 40, 40)];
                closeButton.backgroundColor=[UIColor clearColor];
                [closeButton addTarget:self action:@selector(toCloseGuessYourLoveView) forControlEvents:UIControlEventTouchUpInside];
                [guessYourLoveView addSubview:closeButton];
                
                //显示猜你喜欢
                [self toShowGuessYourLoveView];
            }
            
            //第二个接口调用完成后关闭等待框
            if(HUD){
                [HUD removeHUD];
            }
        }
        
    }else{
        if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"2"]&&([busiCode isEqualToString:@"queryDetailLog"])){
            isShowFeeDetailView = NO;
            if ([MyMobileServiceYNParam getIsLogin]) {
                if (!HUD) {
                    [HUD showTextHUDWithVC:self.navigationController.view];
                }
                //设置busiCode,方便获取返回后判断
                busiCode = @"QAM_USERSCORE";
                requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
                [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
                [requestBeanDic setObject:@"ZZZZ" forKey:@"YEAR_ID"];
                [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
            }
            return;
        }
        else if ([@"1620" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]])//超时
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
        }else if([@"1" isEqualToString:[dic objectForKey:@"X_RESULTCODE"]]&&[@"该客户号码无营销活动可以推荐" isEqualToString:[dic objectForKey:@"X_RESULTINFO"]])//查询推荐无数据，不提示
        {
            DebugNSLog(@"该客户号码无营销活动可以推荐");
        }
        else
        {
            NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG_RETURN+1;
            [alertView show];
        }
        if(HUD){
            [HUD removeHUD];
        }
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-- 为了防止程序异常，需要手动清除代理，在此方法里面进行清除
-(void)dealloc {
    [httpRequest setRequestDelegatNil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark---
#pragma mark 登录和用户信息区域点击按钮
-(void)LoginAndUserInfoButtonPressed:(id) sender
{
    if ([MyMobileServiceYNParam getIsLogin]) {
        [self toCloseGuessYourLoveView];
        MyMobileServiceYNPackageOverInfoVC *packageOverInfoVC = [[MyMobileServiceYNPackageOverInfoVC alloc]init];
        [self.navigationController pushViewController:packageOverInfoVC animated:YES];
    }else
    {
        MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
//        [self.navigationController pushViewController:login animated:YES];
        [self presentModalViewController:login animated:YES];
    }
}

//#pragma mark-- 点击菜单按钮对应事件，需要增加button tag
//-(void)changesMenuButton
//{
//    [self toCloseGuessYourLoveView];
//    isRefreshMenu = YES;
//    MyMobileServiceYNMenuChangesVC *menuChangesVC = [[MyMobileServiceYNMenuChangesVC alloc]init];
//    [self.navigationController pushViewController:menuChangesVC animated:YES];
//}

/**
 *  充值
 */
-(void)toChargeFee{
        MyMobileServiceYNRechargeVC *changesVC = [[MyMobileServiceYNRechargeVC alloc]init];
        [self.navigationController pushViewController:changesVC animated:YES];
}
-(void)activityButton:(id) sender{
    DebugNSLog(@"活动按钮被点击%ld-%ld",([sender tag]-BUTTON_TAG)/10,([sender tag]-BUTTON_TAG)%10);
    int aTag = ([sender tag]-BUTTON_TAG)/10;
    int ai = ([sender tag]-BUTTON_TAG)%10;
    
    NSString *url;
    NSDictionary *rowData;
    if (aTag==1) {rowData = [hotArray objectAtIndex:ai];}
    else if(aTag==2){rowData = [phoneArray objectAtIndex:ai];}
    else if(aTag==3){rowData = [taskArray objectAtIndex:ai];}
    
    url=[rowData objectForKey:@"ACTIVITY_DETAILS"];
    if ([url hasSuffix:@"msisdn="]) {
        NSString *serialNumber = [MyMobileServiceYNParam getSerialNumber];
        DesEncrypt *des = [DesEncrypt new];
        NSString *enStr = [des encryptUseDES:serialNumber key:@"ynzjcx"];
        NSString *enStr2=__BASE64(serialNumber, @"ynzjcx");
        
        
        url = [NSString stringWithFormat:@"%@%@",url,enStr2];
    }
    if ([MyMobileServiceYNParam getIsLogin]) {
        if(ai == 2){//当用户登录并且点击第三个营销活动的时候在链接后面添加两个参数
        NSString *tel = [MyMobileServiceYNParam getSerialNumber];
            
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:sessionID forKey:@"SESSIONID"];
        [dic setValue:tel forKey:@"SERIAL_NUM"];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        url =[NSString stringWithFormat:@"%@%@",url,str];
        }
    }
    
    DebugNSLog(@"weburl -%@",url);
    MyMobileServiceYNWebViewVC *webVC = [[MyMobileServiceYNWebViewVC alloc]init];
    webVC.webUrlString = url;
//    webVC.webUrlString = @"http://192.168.123.1:8080/sessionText.html";
//    webVC.title = aTag==1?@"火热活动":@"手机商城";
    if(aTag == 1){
        webVC.title = @"火热活动";
    }else if (aTag == 2){
        webVC.title = @"手机商城";
    }else if (aTag == 3){
        webVC.title = @"任务专区";
    }
    [self presentWebVC:webVC animated:YES];
}
#pragma mark---
#pragma mark 业务按钮点击
-(void)busiMenuButton:(id) sender
{
    [self toCloseGuessYourLoveView];
    UIButton *button=(UIButton *) sender;
    int busiId = button.tag;
    if ((BUTTON_TAG + 100 + 5) == busiId) {//充值
        MyMobileServiceYNRechargeVC *rechargeVC = [[MyMobileServiceYNRechargeVC alloc]init];
        [self.navigationController pushViewController:rechargeVC animated:YES];
    }else if ([MyMobileServiceYNParam getIsLogin]) {
        if ((BUTTON_TAG + 100 + 0) == busiId) {//实时话费
            MyMobileServiceYNCurrentExpenseVC *currentExpenseVC = [[MyMobileServiceYNCurrentExpenseVC alloc]init];
            [self.navigationController pushViewController:currentExpenseVC animated:YES];
        }else if ((BUTTON_TAG + 100 + 1) == busiId) {//流量查询
            MyMobileServiceYNGprsQueryVC *gprsQuery = [[MyMobileServiceYNGprsQueryVC alloc]init];
            [self.navigationController pushViewController:gprsQuery animated:YES];
        }
        else if ((BUTTON_TAG + 100 + 2) == busiId) {//流量订购
            if ([MyMobileServiceYNParam getIsDynamicPW]) {//如果是动态密码登录，不允许使用，提示用户重新登录
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
                alertView.tag = ALERTVIEW_TAG;
                [alertView show];
            }else
            {
                MyMobileServiceYNOrderGprsVC *orderGprsVC = [[MyMobileServiceYNOrderGprsVC alloc]init];
                [self.navigationController pushViewController:orderGprsVC animated:YES];
            }
        }
        else if ((BUTTON_TAG + 100 + 3) == busiId) {//我的账单
            MyMobileServiceYNBillInfoVC *billInfo = [[MyMobileServiceYNBillInfoVC alloc]init];
            [self.navigationController pushViewController:billInfo animated:YES];
        }
        else if ((BUTTON_TAG + 100 + 4) == busiId) {//套餐余量
            MyMobileServiceYNPackageOverDetailInfoVC *detailInfoVC = [[MyMobileServiceYNPackageOverDetailInfoVC alloc]init];
            [self.navigationController pushViewController:detailInfoVC animated:YES];
        }
        else if ((BUTTON_TAG + 100 + 6) == busiId) {//业务办理
            if ([MyMobileServiceYNParam getIsDynamicPW]) {//如果是动态密码登录，不允许使用，提示用户重新登录
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
                alertView.tag = ALERTVIEW_TAG;
                [alertView show];
            }else
            {
                MyMobileServiceYNDataProductListVC *dataProductListVC = [[MyMobileServiceYNDataProductListVC alloc]init];
                [self.navigationController pushViewController:dataProductListVC animated:YES];
            }
        }
        else if ((BUTTON_TAG + 100 + 7) == busiId) {//客服支持
//            MyMobileServiceYN10086SupportVC *supportVC=[[MyMobileServiceYN10086SupportVC alloc]init];
//            [self.navigationController pushViewController:supportVC animated:YES];
            
//            MyMobileServiceYNOnlineServiceVC *onlineServiceVC=[[MyMobileServiceYNOnlineServiceVC alloc]init];
//            [self.navigationController pushViewController:onlineServiceVC animated:YES];
            
            MyMobileServiceYNCustomerServiceVC *customerServiceVC=[[MyMobileServiceYNCustomerServiceVC alloc]init];
            [self.navigationController pushViewController:customerServiceVC animated:YES];
        }
        else if ((BUTTON_TAG + 100 + 8) == busiId) {//套餐变更
            if ([MyMobileServiceYNParam getIsDynamicPW]) {//如果是动态密码登录，不允许使用，提示用户重新登录
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
                alertView.tag = ALERTVIEW_TAG;
                [alertView show];
            }else
            {
                MyMobileServiceYNPackagesServiceVC *packagesServiceVC=[[MyMobileServiceYNPackagesServiceVC alloc]init];
                [self.navigationController pushViewController:packagesServiceVC animated:YES];
            }
        }
        else if ((BUTTON_TAG + 100 + 9) == busiId) {//宽带预约
            if ([MyMobileServiceYNParam getIsDynamicPW]) {//如果是动态密码登录，不允许使用，提示用户重新登录
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:DynamicPW_Info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
                alertView.tag = ALERTVIEW_TAG;
                [alertView show];
            }else
            {
                MyMobileServiceYNBroadbandAccountFirstVC *firstVC=[[MyMobileServiceYNBroadbandAccountFirstVC alloc]init];
                [self.navigationController pushViewController:firstVC animated:YES];
            }
        }
        
        else if ((BUTTON_TAG + 100 + 10) == busiId) {//商家联盟
            MyMobileServiceYNShopsPartyVC *shopsPartyVC=[[MyMobileServiceYNShopsPartyVC alloc]init];
            [self.navigationController pushViewController:shopsPartyVC animated:YES];
        }else if ((BUTTON_TAG + 100 + 11) == busiId){
            MyMobileServiceYNWebViewVC *webVC = [[MyMobileServiceYNWebViewVC alloc]init];
            webVC.title = @"宽带办理";
            webVC.webUrlString = @"http://wx.netvan.cn/mmc/app?service=page/BandIndex&listener=initPage";
            [self presentWebVC:webVC animated:YES];
        }else if (busiId == BUTTON_TAG + 9527){
            YearBillVC *yb = [[YearBillVC alloc] init];
            [self.navigationController pushViewController:yb animated:YES];
        }
    }else
    {
        MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
        [self presentModalViewController:login animated:YES];
//        [self.navigationController pushViewController:login animated:YES];
    }

}

#pragma mark---rightButtonPressed
-(void)rightButtonPressed:(id)sender
{
//    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"确定退出当前账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    alertView.tag=ALERTVIEW_TAG+50;
//    [alertView show];
    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"logo_57" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"云南移动手机营业厅客户端官方出品，实时掌握最新优惠活动、快速进行话费信息查询，更享快捷充值"
                                       defaultContent:@""
                                                image:[ShareSDK imageWithUrl:@"http://218.202.0.168:8099/icon.png"]
                                                title:@"云南移动分享"
                                                  url:@"http://yn.10086.cn/client/"
                                          description:@"云南移动"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [publishContent addSMSUnitWithContent:@"云南移动手机营业厅客户端官方出品，实时掌握最新优惠活动、快速进行话费信息查询，更享快捷充值http://yn.10086.cn/client/"];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}

#pragma mark---leftButtonPressed
-(void)leftButtonPressed:(id)sender
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LeftButtonPressed" object:self userInfo:nil];
    [self presentLeftMenuViewController:sender];
    
}

-(void)leftMenuButtonPressed:(NSNotification*) notification
{
//    NSDictionary *dic = [notification object];//通过这个获取到传递的对象
//    if ([[dic objectForKey:@"Operate"] isEqualToString:@"home"]) {
//        MyMobileServiceYNGprsQueryVC *gprsQuery = [[MyMobileServiceYNGprsQueryVC alloc]init];
//        [self.navigationController pushViewController:gprsQuery animated:YES];
//    }
    NSMutableDictionary *dic=(NSMutableDictionary *)[notification object];
    if([[dic objectForKey:@"Operate"] isEqualToString:@"customService"]){
        if ([MyMobileServiceYNParam getIsLogin]) {
            MyMobileServiceYNCustomerServiceVC *supportVC=[[MyMobileServiceYNCustomerServiceVC alloc]init];
            [self.navigationController popToRootViewControllerAnimated:NO];
            [self.navigationController pushViewController:supportVC animated:NO];
        }else{
            MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
            [self.sideMenuViewController presentModalViewController:login animated:YES];
        }
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"aboutUs"]){
        MyMobileServiceYNAboutUSVC *aboutUsVC=[[MyMobileServiceYNAboutUSVC alloc]init];
        [self.navigationController popToRootViewControllerAnimated:NO];
        [self.navigationController pushViewController:aboutUsVC animated:NO];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"themeSet"]){
        MyMobileServiceYNChangeThemeVC *changeThemeVC=[[MyMobileServiceYNChangeThemeVC alloc]init];
        [self.navigationController popToRootViewControllerAnimated:NO];
        [self.navigationController pushViewController:changeThemeVC animated:NO];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"recommendApp"]){
        MyMobileServiceYNAppRecommendVC *appRecommend = [[MyMobileServiceYNAppRecommendVC alloc]init];
        [self.navigationController pushViewController:appRecommend animated:NO];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"login"]){
        MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
        [self.sideMenuViewController presentModalViewController:login animated:YES];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"charge"]){
        MyMobileServiceYNRechargeVC *chargeVC=[[MyMobileServiceYNRechargeVC alloc]init];
        [self.navigationController popToRootViewControllerAnimated:NO];
        [self.navigationController pushViewController:chargeVC animated:NO];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"checkVersion"]){
        [HUD showTextHUDWithVC:self.sideMenuViewController.view];
        busiCode = @"checkVersion";
        NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
        [requestParamData setObject:[MyMobileServiceYNParam getVersion] forKey:@"version"];
        [requestParamData setObject:[MyMobileServiceYNParam getPattern] forKey:@"pattern"];
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:[MyMobileServiceYNParam getCityCode] forKey:@"EPARCHY_CODE"];
        [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
    }else if([[dic objectForKey:@"Operate"] isEqualToString:@"deLog"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logOut" object:nil];
    }

}

//-(void)pageControlPressed:(id)sender
//{
//    int page = pageControl.currentPage;
//    [bannerScrollView setContentOffset:CGPointMake(page*SCREEN_WIDTH, 0) animated:YES];
//}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==ALERTVIEW_TAG){//如果为动态密码登录，点击确定后跳转到登录界面，重新登录
        if(buttonIndex==1){
            MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
            [self presentModalViewController:login animated:YES];
        }
    }
    if(alertView.tag==ALERTVIEW_TAG+50){
        if(buttonIndex==1){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logOut" object:nil];
            
//            sideRightMenuButton.hidden=YES;
            [MyMobileServiceYNParam setIsLogin:NO];
            [UserInfoView removeFromSuperview];
            
            isCurrentMonthCostRequest = NO;
            
            //刷新页面
            [homeScrollView removeFromSuperview];
            [self loadHomeScrollView];
            
            //获取应用程序沙盒的Documents目录
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *plistPath1 = [paths objectAtIndex:0];
            
            //得到完整的文件名
            NSString *configFielPath=[plistPath1 stringByAppendingPathComponent:@"MyMobileServiceYNConfig.plist"];
            DebugNSLog(@"%@",configFielPath);
            
            //判断文件是否存在沙盒中
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if( [fileManager fileExistsAtPath:configFielPath]!= NO ) {
                //获取工号及密码，判断是否为空，不为空在赋值给
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:configFielPath];
                [dic removeObjectForKey:@"UserInfo"];
                [dic writeToFile:configFielPath atomically:YES];
            }
            [MyMobileServiceYNParam setIsHuiDuVersion:@"1"];
            [self toSetIsRefreshMenu];
        }
    }
    if (ALERTVIEW_TAG_RETURN + 10 == alertView.tag) {
        
        if (0 == buttonIndex) {
            
        }
        else if (1 == buttonIndex) {
            //更新，跳转到appstore
            //方法一：根据应用的id打开appstore，并跳转到应用下载页面
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoadUrl]];
        }
        
    }else if (ALERTVIEW_TAG_RETURN + 11 == alertView.tag) {
        
        if (0 == buttonIndex) {
            //取消后退出
            exit(0);
        }
        else if (1 == buttonIndex) {
            //更新，跳转到appstore
            //去itunes中更新
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoadUrl]];
        }
    }else if (ALERTVIEW_TAG_RETURN + 12 == alertView.tag) {
        
        DebugNSLog(@"----------");
        //更新，跳转到appstore
        //去itunes中更新
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoadUrl]];
        
    }
}

-(void)logout:(NSNotification*) notification
{
    [MyMobileServiceYNParam setIsHuiDuVersion:@"1"];
    [MyMobileServiceYNParam setIsLogin:NO];
    [UserInfoView removeFromSuperview];
    
    isCurrentMonthCostRequest = NO;
    
    //刷新页面
    [homeScrollView removeFromSuperview];
    [self loadHomeScrollView];
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *configFielPath=[plistPath1 stringByAppendingPathComponent:@"MyMobileServiceYNConfig.plist"];
    DebugNSLog(@"%@",configFielPath);
    
    //判断文件是否存在沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:configFielPath]!= NO ) {
        //获取工号及密码，判断是否为空，不为空在赋值给
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:configFielPath];
        [dic removeObjectForKey:@"UserInfo"];
        [dic writeToFile:configFielPath atomically:YES];
    }
    [self toSetIsRefreshMenu];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// 刚拖动的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView_ {
    [refishView scrollViewWillBeginDragging:scrollView_];
}
// 拖动过程中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView_ {
    [refishView scrollViewDidScroll:scrollView_];
}
// 拖动结束后
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView_ willDecelerate:(BOOL)decelerate {
    [refishView scrollViewDidEndDragging:scrollView_ willDecelerate:decelerate];
}

#pragma mark - RefreshViewDelegate
- (void)refreshViewDidCallBack {
    if ([MyMobileServiceYNParam getIsLogin]) {
        [self refresh];
    }
}

-(void)refresh
{
    NSLog(@"re");
    [refishView startLoading];
    busiCode = @"currentMonthCost";
    requestBeanDic=[httpRequest getHttpPostParamData:@"currentMonthCost"];
    [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [httpRequest startAsynchronous:@"currentMonthCost" requestParamData:requestBeanDic viewController:self];
}

//-(void)setAfterLogin
//{
//    
//}


#pragma tabBar


@end
