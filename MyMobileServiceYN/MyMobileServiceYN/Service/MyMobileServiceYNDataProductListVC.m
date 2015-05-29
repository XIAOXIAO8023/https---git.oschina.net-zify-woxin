//
//  MyMobileServiceYNDataProductListVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-21.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//
//获取用户所有订购业务，进入到业务详情页面时将通过现在数据获取业务信息，
//在业务变更页面进行业务办理成功后，对数据进行更新

#import "MyMobileServiceYNDataProductListVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNDataProductDetailVC.h"

@interface MyMobileServiceYNDataProductListVC ()

@end

@implementation MyMobileServiceYNDataProductListVC

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
    self.title = @"业务办理";
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    
    //查询用户可办理服务，如果不全部不可办理，则不显示改选项。
    [HUD showTextHUDWithVC:self.navigationController.view];
    //登录
    requestBeanDic=[httpRequest getHttpPostParamData:@"orderService"];
    [requestBeanDic setObject:@"S" forKey:@"ELEMENT_TYPE_CODE"];
    [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [requestBeanDic setObject:@"00" forKey:@"PRODUCT_MODE"];
    [httpRequest startAsynchronous:@"orderService" requestParamData:requestBeanDic viewController:self];
    
    selectProductListItem = @"DataProductList";
    productListArray = [self setProductListArrayByPlist:selectProductListItem];
    //通过按钮来实现
    
    UIButton *dataProductListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dataProductListButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
    dataProductListButton.tag = BUTTON_TAG + 1;
    dataProductListButton.backgroundColor = [UIColor whiteColor];
    dataProductListButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:18];
    [dataProductListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dataProductListButton setTitle:@"数据业务" forState:UIControlStateNormal];
    [dataProductListButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dataProductListButton];
    
    UIView *blockLine1 = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-90)/2, 40, 90, 4)];
    blockLine1.tag = VIEW_TAG +1;
    blockLine1.backgroundColor = UIColorFromRGB(rgbValueButtonGreen);
    [self.view addSubview:blockLine1];
    
    UIButton *baseProductListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    baseProductListButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 44);
    baseProductListButton.tag = BUTTON_TAG + 2;
    baseProductListButton.backgroundColor = [UIColor whiteColor];
    baseProductListButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:18];
    [baseProductListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [baseProductListButton setTitle:@"基础服务" forState:UIControlStateNormal];
    [baseProductListButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:baseProductListButton];
    
    UIView *blockLine2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 + (SCREEN_WIDTH/2-90)/2, 40, 90, 4)];
    blockLine2.tag = VIEW_TAG +2;
    blockLine2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:blockLine2];
    
//    UIButton *commonProductListButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    commonProductListButton.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 44);
//    commonProductListButton.tag = BUTTON_TAG + 3;
//    commonProductListButton.backgroundColor = [UIColor whiteColor];
//    commonProductListButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:18];
//    [commonProductListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [commonProductListButton setTitle:@"套餐服务" forState:UIControlStateNormal];
//    [commonProductListButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:commonProductListButton];
//    
//    UIView *blockLine3 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2 + (SCREEN_WIDTH/3-90)/2, 40, 90, 4)];
//    blockLine3.tag = VIEW_TAG +3;
//    blockLine3.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:blockLine3];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    line.tag = VIEW_TAG + 4;
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    dataProductListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20-44)];
    dataProductListTableView.dataSource = self;
    dataProductListTableView.delegate = self;
    dataProductListTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dataProductListTableView];
}

//如果没有可办理的基础业务，则隐藏响应的按钮
-(void)resetViewByNoBaseProduct
{
    dataProductListTableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    
    UIButton *button1 = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 1];
    UIButton *button2 = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 2];
    UIButton *button3 = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 3];
    UIView *view1 = (UIView *)[self.view viewWithTag:VIEW_TAG + 1];
    UIView *view2 = (UIView *)[self.view viewWithTag:VIEW_TAG + 2];
    UIView *view3 = (UIView *)[self.view viewWithTag:VIEW_TAG + 3];
    UIView *view4 = (UIView *)[self.view viewWithTag:VIEW_TAG + 4];
    
    button1.frame = CGRectMake(0, 0, 0, 0);
    button2.frame = CGRectMake(0, 0, 0, 0);
    button3.frame = CGRectMake(0, 0, 0, 0);
    view1.frame = CGRectMake(0, 0, 0, 0);
    view2.frame = CGRectMake(0, 0, 0, 0);
    view3.frame = CGRectMake(0, 0, 0, 0);
    view4.frame = CGRectMake(0, 0, 0, 0);
}


-(void)buttonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    //数据业务
    if (button.tag == BUTTON_TAG +1) {
        selectProductListItem = @"DataProductList";
        productListArray = [self setProductListArrayByPlist:selectProductListItem];
        
        UIView *blockLine1 = (UIView *)[self.view viewWithTag:VIEW_TAG +1];
        UIView *blockLine2 = (UIView *)[self.view viewWithTag:VIEW_TAG +2];
        UIView *blockLine3 = (UIView *)[self.view viewWithTag:VIEW_TAG +3];
        
        [blockLine1 setBackgroundColor:UIColorFromRGB(rgbValueButtonGreen)];
        [blockLine2 setBackgroundColor:[UIColor clearColor]];
        [blockLine3 setBackgroundColor:[UIColor clearColor]];
        [dataProductListTableView reloadData];
    }
    
    //基础业务
    if (button.tag == BUTTON_TAG +2) {
        selectProductListItem = @"BaseProductList";
        productListArray = canSelectArray;
        
        UIView *blockLine1 = (UIView *)[self.view viewWithTag:VIEW_TAG +1];
        UIView *blockLine2 = (UIView *)[self.view viewWithTag:VIEW_TAG +2];
        UIView *blockLine3 = (UIView *)[self.view viewWithTag:VIEW_TAG +3];
        
        [blockLine1 setBackgroundColor:[UIColor clearColor]];
        [blockLine2 setBackgroundColor:UIColorFromRGB(rgbValueButtonGreen)];
        [blockLine3 setBackgroundColor:[UIColor clearColor]];
        [dataProductListTableView reloadData];
    }
    
    //套餐服务
    if (button.tag == BUTTON_TAG +3) {
        selectProductListItem = @"commonProductList";
        productListArray = [self setProductListArrayByPlist:selectProductListItem];
        
        UIView *blockLine1 = (UIView *)[self.view viewWithTag:VIEW_TAG +1];
        UIView *blockLine2 = (UIView *)[self.view viewWithTag:VIEW_TAG +2];
        UIView *blockLine3 = (UIView *)[self.view viewWithTag:VIEW_TAG +3];
        
        [blockLine1 setBackgroundColor:[UIColor clearColor]];
        [blockLine2 setBackgroundColor:[UIColor clearColor]];
        [blockLine3 setBackgroundColor:UIColorFromRGB(rgbValueButtonGreen)];
        [dataProductListTableView reloadData];
    }
    
}

-(NSArray *)setProductListArrayByPlist:(NSString *)listName
{
    //关于dataProductList plist文件，需要先判断沙盒里面是否存在，如果存在判断版本是否为当前版本。
    //版本不对，则替换为最新版本。如果存在且版本正确，则不做任何操作，直接读取。
    //读取dataProductList plist文件，获取业务菜单
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *productListFielPath=[plistPath1 stringByAppendingPathComponent:@"dataProductList.plist"];
    DebugNSLog(@"%@",productListFielPath);
    
    //判断文件是否存在沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:productListFielPath]== NO ) {
        DebugNSLog(@"dataProductList.plist is not exists");
        //方法二
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dataProductList"ofType:@"plist"];
        NSMutableDictionary *productListDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        [productListDic writeToFile:productListFielPath atomically:YES];
    }else{
        DebugNSLog(@"dataProductList.plist is exists");
        //获取版本字段并比较，如果不相同，则将自带复制到沙盒里面去
        //获取沙盒数据版本
        NSMutableDictionary *listDicSandbox = [[NSMutableDictionary alloc] initWithContentsOfFile:productListFielPath];
        NSString *versionSandbox = [listDicSandbox objectForKey:@"Version"];
        
        //获取自带数据版本
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dataProductList"ofType:@"plist"];
        NSMutableDictionary *productListDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        NSString *version = [productListDic objectForKey:@"Version"];
        
        //判断数据版本是否相同
        if (![versionSandbox isEqualToString:version]) {//不相同
            //先删除沙盒中原有文件
            [fileManager removeItemAtPath:productListFielPath error:nil];
            //复制到沙盒中
            [productListDic writeToFile:productListFielPath atomically:YES];
        }
    }
    
    //截止到目前位置沙盒中已经存在dataProductList.plist，读取menulist.plist文件，并展示到桌面
    
    NSDictionary *productListDicSandbox = [[NSMutableDictionary alloc] initWithContentsOfFile:productListFielPath];
   
    return [productListDicSandbox objectForKey:listName];
}


//-(void)setProductListArray
//{
//    productListArray = [[NSMutableArray alloc]init];
//    
//    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
//    [dic1 setObject:@"和阅读悦读会会员" forKey:@"BusiName"];//业务名称
//    [dic1 setObject:@"icon_hyd" forKey:@"BusiLogoName"];//Logo
//    [dic1 setObject:@"100203" forKey:@"BusiBizCode"];//biz_code
//    [dic1 setObject:@"698001" forKey:@"BusiSpCode"];//sp_code
//    [dic1 setObject:@"99192111" forKey:@"BusiServiceId"];//service_id
//    [dic1 setObject:@"60" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic1 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic1 setObject:@"3元/月" forKey:@"BusiFee"];//资费
//    [dic1 setObject:@"开通后可通过“和阅读”免费阅读本书包内所有图书（共计1326本图书可供阅读），并享多项会员特权。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic1];
//    
//    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
//    [dic2 setObject:@"和通迅录会员" forKey:@"BusiName"];//业务名称
//    [dic2 setObject:@"icon_htx" forKey:@"BusiLogoName"];//Logo
//    [dic2 setObject:@"100000" forKey:@"BusiBizCode"];//biz_code
//    [dic2 setObject:@"698022" forKey:@"BusiSpCode"];//sp_code
//    [dic2 setObject:@"98001001" forKey:@"BusiServiceId"];//service_id
//    [dic2 setObject:@"10" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic2 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic2 setObject:@"4元/月" forKey:@"BusiFee"];//资费
//    [dic2 setObject:@"会员可使用智能同步中的即时同步功能，并享有每月100条“秒发”短信的特权。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic2];
//    
//    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
//    [dic3 setObject:@"和游戏游戏玩家" forKey:@"BusiName"];//业务名称
//    [dic3 setObject:@"icon_hyx" forKey:@"BusiLogoName"];//Logo
//    [dic3 setObject:@"500230544000" forKey:@"BusiBizCode"];//biz_code
//    [dic3 setObject:@"701001" forKey:@"BusiSpCode"];//sp_code
//    [dic3 setObject:@"99002781" forKey:@"BusiServiceId"];//service_id
//    [dic3 setObject:@"28" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic3 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic3 setObject:@"5元/月" forKey:@"BusiFee"];//资费
//    [dic3 setObject:@"和游戏玩家，每月仅需5元会员功能费，享受至尊游戏体验，包您玩个够：免费特权!免费游戏享不停；折扣特权!全场单机八折惠；网游特权!超值道具免费领；活动特权!会员专属好活动" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic3];
//    
//    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc]init];
//    [dic4 setObject:@"和视频V+精选包" forKey:@"BusiName"];//业务名称
//    [dic4 setObject:@"icon_htv" forKey:@"BusiLogoName"];//Logo
//    [dic4 setObject:@"30830003" forKey:@"BusiBizCode"];//biz_code
//    [dic4 setObject:@"699019" forKey:@"BusiSpCode"];//sp_code
//    [dic4 setObject:@"99781381" forKey:@"BusiServiceId"];//service_id
//    [dic4 setObject:@"14" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic4 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic4 setObject:@"5元/月" forKey:@"BusiFee"];//资费
//    [dic4 setObject:@"结合当季主题内容，第一时间带给您各类精选节目内容，同时配合丰富的互动内容，让您畅享优惠、精彩的视频节目。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic4];
//    
//    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc]init];
//    [dic5 setObject:@"和动漫漫赏包" forKey:@"BusiName"];//业务名称
//    [dic5 setObject:@"icon_hdm" forKey:@"BusiLogoName"];//Logo
//    [dic5 setObject:@"2300000005" forKey:@"BusiBizCode"];//biz_code
//    [dic5 setObject:@"698025" forKey:@"BusiSpCode"];//sp_code
//    [dic5 setObject:@"91118231" forKey:@"BusiServiceId"];//service_id
//    [dic5 setObject:@"36" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic5 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic5 setObject:@"5元/月" forKey:@"BusiFee"];//资费
//    [dic5 setObject:@"可通过WAP门户以及“和动漫”客户端，每月不限集数的免费在线观看或下载动漫漫赏包专区的动漫作品（动画、漫画或绘本）" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic5];
//    
//    NSMutableDictionary *dic6 = [[NSMutableDictionary alloc]init];
//    [dic6 setObject:@"和娱乐优惠包" forKey:@"BusiName"];//业务名称
//    [dic6 setObject:@"icon_hylyh" forKey:@"BusiLogoName"];//Logo
//    [dic6 setObject:@"1406684301" forKey:@"BusiBizCode"];//biz_code
//    [dic6 setObject:@"135502" forKey:@"BusiSpCode"];//sp_code
//    [dic6 setObject:@"95072011" forKey:@"BusiServiceId"];//service_id
//    [dic6 setObject:@"57" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic6 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic6 setObject:@"6元/月" forKey:@"BusiFee"];//资费
//    [dic6 setObject:@"可在“和娱乐体验包”的全部优惠的基础之上，更可享受阅读频道、音乐频道、动漫频道、视频频道、游戏频道指定付费单品的9折优惠，以及MM VIP会员特权，并免费成为无线音乐咪咕普通会员。每月登录MM还可领取600个MM币。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic6];
//    
//    NSMutableDictionary *dic7 = [[NSMutableDictionary alloc]init];
//    [dic7 setObject:@"和娱乐体验包" forKey:@"BusiName"];//业务名称
//    [dic7 setObject:@"icon_hylty" forKey:@"BusiLogoName"];//Logo
//    [dic7 setObject:@"1406684101" forKey:@"BusiBizCode"];//biz_code
//    [dic7 setObject:@"135502" forKey:@"BusiSpCode"];//sp_code
//    [dic7 setObject:@"95072010" forKey:@"BusiServiceId"];//service_id
//    [dic7 setObject:@"57" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic7 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic7 setObject:@"0元/月" forKey:@"BusiFee"];//资费
//    [dic7 setObject:@"享受1万款游戏免费下载，2万集动漫免费看，300万首歌免费试听，400万章节免费阅读，5万条视频50路直播免费看，6大分类手机精品应用免费下载。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic7];
//    
//    NSMutableDictionary *dic8 = [[NSMutableDictionary alloc]init];
//    [dic8 setObject:@"139邮箱5元套餐" forKey:@"BusiName"];//业务名称
//    [dic8 setObject:@"icon_139mail" forKey:@"BusiLogoName"];//Logo
//    [dic8 setObject:@"+MAILBZ" forKey:@"BusiBizCode"];//biz_code
//    [dic8 setObject:@"925555" forKey:@"BusiSpCode"];//sp_code
//    [dic8 setObject:@"99008753" forKey:@"BusiServiceId"];//service_id
//    [dic8 setObject:@"16" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic8 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic8 setObject:@"5元/月" forKey:@"BusiFee"];//资费
//    [dic8 setObject:@"《139邮箱标准版》优化了邮箱内的功能布局，引导更加清晰，减少了您不必要的操作，新增加欢迎页回归、换肤、多标签、一键搬家等功能。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic8];
//    
//    NSMutableDictionary *dic9 = [[NSMutableDictionary alloc]init];
//    [dic9 setObject:@"手机导航" forKey:@"BusiName"];//业务名称
//    [dic9 setObject:@"icon_nav" forKey:@"BusiLogoName"];//Logo
//    [dic9 setObject:@"20100100" forKey:@"BusiBizCode"];//biz_code
//    [dic9 setObject:@"300008" forKey:@"BusiSpCode"];//sp_code
//    [dic9 setObject:@"99341317" forKey:@"BusiServiceId"];//service_id
//    [dic9 setObject:@"65" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic9 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic9 setObject:@"5元/月" forKey:@"BusiFee"];//资费
//    [dic9 setObject:@"您可以随时定位自己的位置，无论在哪里都不会迷路，还可以直接询问10086，由专门的客户人员帮助您查询目的地。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic9];
//    
//    NSMutableDictionary *dic10 = [[NSMutableDictionary alloc]init];
//    [dic10 setObject:@"手机视频V+喜乐包" forKey:@"BusiName"];//业务名称
//    [dic10 setObject:@"icon_tv" forKey:@"BusiLogoName"];//Logo
//    [dic10 setObject:@"30830001" forKey:@"BusiBizCode"];//biz_code
//    [dic10 setObject:@"699019" forKey:@"BusiSpCode"];//sp_code
//    [dic10 setObject:@"99781380" forKey:@"BusiServiceId"];//service_id
//    [dic10 setObject:@"14" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic10 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic10 setObject:@"3元/月" forKey:@"BusiFee"];//资费
//    [dic10 setObject:@"V+喜乐包内容数量限定在300条以内，内容涵盖直播、电影、剧集、综艺、资讯。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic10];
//    
//    NSMutableDictionary *dic11 = [[NSMutableDictionary alloc]init];
//    [dic11 setObject:@"手机动漫三元包" forKey:@"BusiName"];//业务名称
//    [dic11 setObject:@"icon_dm3" forKey:@"BusiLogoName"];//Logo
//    [dic11 setObject:@"1300000006" forKey:@"BusiBizCode"];//biz_code
//    [dic11 setObject:@"698025" forKey:@"BusiSpCode"];//sp_code
//    [dic11 setObject:@"99055043" forKey:@"BusiServiceId"];//service_id
//    [dic11 setObject:@"36" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic11 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic11 setObject:@"3元/月" forKey:@"BusiFee"];//资费
//    [dic11 setObject:@"支持WAP门户上的漫画、动画阅读功能，包含最新最全的连载漫画及完结作品，提供全新的在线阅读体验,可浏览50集动画、漫画。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic11];
//    
//    NSMutableDictionary *dic12 = [[NSMutableDictionary alloc]init];
//    [dic12 setObject:@"手机动漫每日一笑" forKey:@"BusiName"];//业务名称
//    [dic12 setObject:@"icon_dm" forKey:@"BusiLogoName"];//Logo
//    [dic12 setObject:@"1100000004" forKey:@"BusiBizCode"];//biz_code
//    [dic12 setObject:@"698029" forKey:@"BusiSpCode"];//sp_code
//    [dic12 setObject:@"99965335" forKey:@"BusiServiceId"];//service_id
//    [dic12 setObject:@"36" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic12 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic12 setObject:@"3元/月" forKey:@"BusiFee"];//资费
//    [dic12 setObject:@"手机动漫让您随时随地可以通过手机观看您喜欢的漫画、动漫。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic12];
//    
//    NSMutableDictionary *dic13 = [[NSMutableDictionary alloc]init];
//    [dic13 setObject:@"新闻早晚报" forKey:@"BusiName"];//业务名称
//    [dic13 setObject:@"icon_news" forKey:@"BusiLogoName"];//Logo
//    [dic13 setObject:@"110301" forKey:@"BusiBizCode"];//biz_code
//    [dic13 setObject:@"801234" forKey:@"BusiSpCode"];//sp_code
//    [dic13 setObject:@"99038858" forKey:@"BusiServiceId"];//service_id
//    [dic13 setObject:@"05" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic13 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic13 setObject:@"3元/月" forKey:@"BusiFee"];//资费
//    [dic13 setObject:@"新闻早晚报》为您提供国际、国内时政、财经、体育、娱乐、生活等新闻信息。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic13];
//    
//    NSMutableDictionary *dic14 = [[NSMutableDictionary alloc]init];
//    [dic14 setObject:@"快乐8手机报" forKey:@"BusiName"];//业务名称
//    [dic14 setObject:@"icon_happy8" forKey:@"BusiLogoName"];//Logo
//    [dic14 setObject:@"621001" forKey:@"BusiBizCode"];//biz_code
//    [dic14 setObject:@"825268" forKey:@"BusiSpCode"];//sp_code
//    [dic14 setObject:@"99034024" forKey:@"BusiServiceId"];//service_id
//    [dic14 setObject:@"05" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic14 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic14 setObject:@"5元/月" forKey:@"BusiFee"];//资费
//    [dic14 setObject:@"云南移动手机资讯发布平台，让您随时随地掌握第一手信息。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic14];
//    
//    NSMutableDictionary *dic15 = [[NSMutableDictionary alloc]init];
//    [dic15 setObject:@"手机报-光明日报" forKey:@"BusiName"];//业务名称
//    [dic15 setObject:@"icon_sjb" forKey:@"BusiLogoName"];//Logo
//    [dic15 setObject:@"113146" forKey:@"BusiBizCode"];//biz_code
//    [dic15 setObject:@"801234" forKey:@"BusiSpCode"];//sp_code
//    [dic15 setObject:@"99256311" forKey:@"BusiServiceId"];//service_id
//    [dic15 setObject:@"05" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic15 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic15 setObject:@"3元/月" forKey:@"BusiFee"];//资费
//    [dic15 setObject:@"《手机报-光明日报》为您提供时政、经济、社会、文化、教育等时事新闻。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic15];
//    
//    NSMutableDictionary *dic16 = [[NSMutableDictionary alloc]init];
//    [dic16 setObject:@"139邮箱VIP版" forKey:@"BusiName"];//业务名称
//    [dic16 setObject:@"icon_139vip" forKey:@"BusiLogoName"];//Logo
//    [dic16 setObject:@"+MAILVIP" forKey:@"BusiBizCode"];//biz_code
//    [dic16 setObject:@"925555" forKey:@"BusiSpCode"];//sp_code
//    [dic16 setObject:@"99009009" forKey:@"BusiServiceId"];//service_id
//    [dic16 setObject:@"16" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic16 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic16 setObject:@"20元/月" forKey:@"BusiFee"];//资费
//    [dic16 setObject:@"139邮箱VIP版》不仅拥有一般139邮箱的功能，而且容量更大，功能更强，操作更简单，优惠更多。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic16];
//    
//    NSMutableDictionary *dic17 = [[NSMutableDictionary alloc]init];
//    [dic17 setObject:@"来电呼" forKey:@"BusiName"];//业务名称
//    [dic17 setObject:@"icon_tel" forKey:@"BusiLogoName"];//Logo
//    [dic17 setObject:@"-LDH001" forKey:@"BusiBizCode"];//biz_code
//    [dic17 setObject:@"925231" forKey:@"BusiSpCode"];//sp_code
//    [dic17 setObject:@"99577299" forKey:@"BusiServiceId"];//service_id
//    [dic17 setObject:@"04" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic17 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic17 setObject:@"3元/月" forKey:@"BusiFee"];//资费
//    [dic17 setObject:@"当您打电话遇到对方关机或在通话中时，《来电呼》将以短信的方式告知对方漏接的电话，并提醒对方及时回复您的电话。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic17];
//    
//    NSMutableDictionary *dic18 = [[NSMutableDictionary alloc]init];
//    [dic18 setObject:@"手机动漫（每日一笑）" forKey:@"BusiName"];//业务名称
//    [dic18 setObject:@"icon_sjdm" forKey:@"BusiLogoName"];//Logo
//    [dic18 setObject:@"1100000004" forKey:@"BusiBizCode"];//biz_code
//    [dic18 setObject:@"698025" forKey:@"BusiSpCode"];//sp_code
//    [dic18 setObject:@"99055004" forKey:@"BusiServiceId"];//service_id
//    [dic18 setObject:@"36" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic18 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic18 setObject:@"3元/月" forKey:@"BusiFee"];//资费
//    [dic18 setObject:@"《手机动漫（每日一笑）》为您提供让人乐翻天的漫画，含蓄幽默的笑话、段子、网络趣味流行语、流行网文，经典新颖的冷笑话，创意雷人的搞笑图片等信息。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic18];
//    
//    NSMutableDictionary *dic19 = [[NSMutableDictionary alloc]init];
//    [dic19 setObject:@"飞信" forKey:@"BusiName"];//业务名称
//    [dic19 setObject:@"icon_feixin" forKey:@"BusiLogoName"];//Logo
//    [dic19 setObject:@"IIC" forKey:@"BusiBizCode"];//biz_code
//    [dic19 setObject:@"901508" forKey:@"BusiSpCode"];//sp_code
//    [dic19 setObject:@"98002301" forKey:@"BusiServiceId"];//service_id
//    [dic19 setObject:@"23" forKey:@"BusiBizTypeCode"];//biz_type_code
//    [dic19 setObject:@"Z" forKey:@"BusiElementTypeCode"];//element_type_code
//    [dic19 setObject:@"0元/月" forKey:@"BusiFee"];//资费
//    [dic19 setObject:@"《飞信》让您可以实现在线短消息发送、语音聊天、彩铃文件共享等多种通信功能。" forKey:@"BusiDesc"];//描述
//    [productListArray addObject:dic19];
//}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return productListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        imageView.tag = IMAGE_TAG + 1;
        [cell.contentView addSubview:imageView];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, 190, 30)];
        lable.tag = LABEL_TAG + 1;
        [cell.contentView addSubview:lable];
        
        UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(245, 15, 60, 30)];
        lable2.tag = LABEL_TAG + 2;
        lable2.font=[UIFont fontWithName:appTypeFace size:16];
        lable2.textColor=UIColorFromRGB(rgbValueDeepGrey);
        lable2.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:lable2];
    }
    NSDictionary *rowData=[productListArray objectAtIndex:[indexPath row]];
    UIImageView *imageview=(UIImageView *)[cell.contentView viewWithTag:IMAGE_TAG + 1];
    imageview.image = [UIImage imageNamed:[rowData objectForKey:@"BusiLogoName"]];
    
    UILabel *lable = (UILabel *)[cell.contentView viewWithTag:LABEL_TAG + 1];
    lable.text=[rowData objectForKey:@"BusiName"];
    
    UILabel *lable2 = (UILabel *)[cell.contentView viewWithTag:LABEL_TAG + 2];
    lable2.text=[rowData objectForKey:@"BusiFee"];
    
    return cell;
}

//设置点击行的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyMobileServiceYNDataProductDetailVC *dataProductDetailVC = [[MyMobileServiceYNDataProductDetailVC alloc]init];
    NSMutableDictionary *tempDic=[productListArray objectAtIndex:[indexPath row]];
    if([indexPath row]<7){
       [tempDic setObject:@"true" forKey:@"level"];
    }
    
    [tempDic setObject:selectProductListItem forKey:@"SelectItem"];
    dataProductDetailVC.productDetail =[[NSDictionary alloc]initWithDictionary:tempDic];
    [self.navigationController pushViewController:dataProductDetailVC animated:YES];
}

//设置行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark---ASIHTTPRequestDelegate
//返回成功
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[request responseData];
    DebugNSLog(@"%@",[request responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        if (![[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {
            //获取配置文件中的数据
            NSArray *baseProductArray = [self setProductListArrayByPlist:@"BaseProductList"];
            NSMutableArray *temp = [[NSMutableArray alloc]init];
            for (int i =0; i<baseProductArray.count; i++) {
                for (int j = 0; j<array.count; j++) {
                    //循环判断配置文件中的serviceID是否存在可办理数据中，存在现实，不存在不显示。
                    if ([[[array objectAtIndex:j] objectForKey:@"ELEMENT_ID"]isEqualToString:[[baseProductArray objectAtIndex:i] objectForKey:@"BusiServiceId"]]) {
                        [temp addObject:[baseProductArray objectAtIndex:i]];
                        break;
                    }
                }
            }
            
            canSelectArray = temp;
            if (canSelectArray.count == 0) {
                [self resetViewByNoBaseProduct];
            }
            
        }else{
            [self resetViewByNoBaseProduct];
        }
    }
    else{
        NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG_RETURN+1;
        [alertView show];
    }
    if(HUD){
        [HUD removeHUD];
    }
}
//返回失败
-(void)requestFailed:(ASIHTTPRequest *)request
{
//    NSError *error = [request error];
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

-(void)dealloc{
    [httpRequest setRequestDelegatNil];
}


@end
