//
//  MyMobileServiceYNWebViewVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-3-30.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNWebViewVC.h"
#import "GlobalDef.h"
#import "WebViewJavascriptBridge.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNLoginVC.h"
#import <ShareSDK/ShareSDK.h>

@interface MyMobileServiceYNWebViewVC ()

@property WebViewJavascriptBridge* bridge;

@end

@implementation MyMobileServiceYNWebViewVC
@synthesize webUrlString=_webUrlString;

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
    
	anWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-44)];
    anWebView.backgroundColor = [UIColor clearColor];
    anWebView.opaque = NO;
    anWebView.delegate=self;
    anWebView.scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:anWebView];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webUrlString]];
    [anWebView loadRequest:request];
    
    UIView *buttonView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-44, SCREEN_WIDTH, 44)];
    buttonView.backgroundColor=[UIColor whiteColor];
    buttonView.alpha=0.8;
    [self.view addSubview:buttonView];
    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(20, 7, 30, 30)];
    back.backgroundColor=[UIColor clearColor];
    back.tag=BUTTON_TAG+1;
    if([anWebView canGoBack]){
        [back setImage:[UIImage imageNamed:@"page_beforeblue"] forState:UIControlStateNormal];
        back.enabled=YES;
    }else{
        [back setImage:[UIImage imageNamed:@"page_before"] forState:UIControlStateNormal];
        back.enabled=NO;
    }
    [back addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:back];
    
    UIButton *go=[[UIButton alloc]initWithFrame:CGRectMake(100, 7, 30, 30)];
    go.backgroundColor=[UIColor clearColor];
    go.tag=BUTTON_TAG+2;
    if([anWebView canGoForward]){
        [go setImage:[UIImage imageNamed:@"page_nextblue"] forState:UIControlStateNormal];
        go.enabled=YES;
    }else{
        [go setImage:[UIImage imageNamed:@"page_next"] forState:UIControlStateNormal];
        go.enabled=NO;
    }
    [go addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:go];
    
    
    
    UIButton *refresh=[[UIButton alloc]initWithFrame:CGRectMake(250, 7, 30, 30)];
    refresh.backgroundColor=[UIColor clearColor];
    refresh.tag=BUTTON_TAG+3;
    [refresh setImage:[UIImage imageNamed:@"page_newblue"] forState:UIControlStateNormal];
    [refresh addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:refresh];
    
    UIView *gray = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0.4)];
    gray.backgroundColor = [UIColor lightGrayColor];
    [buttonView addSubview:gray];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    [HUD removeHUD];
    if(![[anWebView stringByEvaluatingJavaScriptFromString:@"document.title"] isEqualToString:@""]&&[anWebView stringByEvaluatingJavaScriptFromString:@"document.title"]!=nil&&![self.title isEqualToString:@"宽带办理"]){
        NSMutableString *title=[[NSMutableString alloc]initWithString:[anWebView stringByEvaluatingJavaScriptFromString:@"document.title"]];
        self.title=title;
    }
    
    if([anWebView canGoBack]){
        [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setImage:[UIImage imageNamed:@"page_beforeblue"] forState:UIControlStateNormal];
        [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:YES];
    }else{
        [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setImage:[UIImage imageNamed:@"page_before"] forState:UIControlStateNormal];
        [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:NO];
    }
    
    if([anWebView canGoForward]){
        [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setImage:[UIImage imageNamed:@"page_nextblue"] forState:UIControlStateNormal];
        [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setEnabled:YES];
    }else{
        [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setImage:[UIImage imageNamed:@"page_next"] forState:UIControlStateNormal];
        [(UIButton *)[self.view viewWithTag:BUTTON_TAG+2] setEnabled:NO];
    }
    
    
    NSDictionary *dic = @{@"BUSINESSNAME":@"initJS",@"OSTYPE":@"ios"};
    
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:dic
                                                      options:NSJSONWritingPrettyPrinted error:nil];
    NSString *js = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//    
//    
//    NSLog(@"%@",jsonObject);
    
    NSRange range = [_webUrlString rangeOfString:@"ios:"];
    if (range.length == 0) {
        [anWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:
                                                           @"iosInvokeJS(%@)",js]];
    }
    
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    
    return YES;
}



-(void)webViewDidStartLoad:(UIWebView *)webView{
//    [HUD showTextHUDWithVC:self.navigationController.view];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [HUD removeHUD];
    
    UILabel *prom=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    prom.text=@"加载失败";
    [self.view addSubview:prom];
}

//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    
//}

-(void)buttonAction:(id)sender{
    if(BUTTON_TAG+1==[sender tag]){
        if([anWebView canGoBack]){
            [anWebView goBack];
        }
    }else if(BUTTON_TAG+2==[sender tag]){
        if([anWebView canGoForward]){
            [anWebView goForward];
        }
    }else if(BUTTON_TAG+3==[sender tag]){
        [anWebView reload];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)backButtonPressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (_bridge) { return; }
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:anWebView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        responseCallback(@"Response for message from ObjC");
    }];
    
    [_bridge registerHandler:@"getSession" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"getSession called: %@", data);
        NSDictionary *dd = (NSDictionary *)data;
        NSDictionary *dic = [self getResDicWithCode:((NSString *)[dd objectForKey:@"CODE"]).integerValue busName:@"getSession"];
        responseCallback(dic);
    }];
    
    [_bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"getSession called: %@", data);
        NSDictionary *dd = (NSDictionary *)data;
        NSDictionary *dic = [self getResDicWithCode:((NSString *)[dd objectForKey:@"CODE"]).integerValue busName:@"share"];
        responseCallback(dic);
    }];
    
    [_bridge registerHandler:@"toLogin" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"getSession called: %@", data);
        NSDictionary *dd = (NSDictionary *)data;
        NSDictionary *dic = [self getResDicWithCode:((NSString *)[dd objectForKey:@"CODE"]).integerValue busName:@"toLogin"];
        responseCallback(dic);
    }];
    
    [_bridge registerHandler:@"getDEVICE_ID" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"getSession called: %@", data);
        NSDictionary *dd = (NSDictionary *)data;
        NSDictionary *dic = [self getResDicWithCode:((NSString *)[dd objectForKey:@"CODE"]).integerValue busName:@"getDEVICE_ID"];
        responseCallback(dic);
    }];
}

-(NSDictionary *)getResDicWithCode:(NSInteger)CODE busName:(NSString *)BUSSINESSNAME
{
    NSDictionary *dic;
    
    if (CODE == 1) {
        if ([BUSSINESSNAME isEqualToString:@"getSession"]) {
            dic = @{@"RESULT":@"ok",
                    @"CODE":@(CODE),
                    @"TOKEN":[MyMobileServiceYNParam getSerialNumber],
                    @"SERAIL_NUMBER":[MyMobileServiceYNParam getIsLogin]?[MyMobileServiceYNParam getSerialNumber]:@"",
                    @"USERID":[MyMobileServiceYNParam getUserId],
                    @"EPARCHY_CODE":[MyMobileServiceYNParam getCityCode]};
        }else{
            dic = @{@"RESULT":@"BUSINESSNAME is wrong "};
        }
    }else if (CODE == 2){
        if ([BUSSINESSNAME isEqualToString:@"toLogin"]) {
            MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
            [self.navigationController presentModalViewController:login animated:YES];
        }else{
            dic = @{@"RESULT":@"BUSINESSNAME is wrong "};
        }
    }else if (CODE == 3){
        if ([BUSSINESSNAME isEqualToString:@"share"]) {
            [self ClientShare:@"http://www.yn.10086.cn/client/"];
        }else {
            dic = @{@"RESULT":@"BUSINESSNAME is wrong "};
        }
    }else if (CODE == 4){
        if ([BUSSINESSNAME isEqualToString:@"share"]) {
            [self ClientShare:[NSString stringWithFormat:@"https://yn.clientaccess.10086.cn:7443/individual/share/serialNum&%@",[MyMobileServiceYNParam getSerialNumber]]];
        }else {
            dic = @{@"RESULT":@"BUSINESSNAME is wrong "};
        }
    }else if (CODE == 5){
        if ([BUSSINESSNAME isEqualToString:@"getDEVICE_ID"]) {
            dic = @{@"RESULT":@"ok",
                    @"CODE":@(CODE),
                    @"DEVICE_ID":[[NSUserDefaults standardUserDefaults] objectForKey:@"openUDID"],
                    @"SERAIL_NUMBER":[MyMobileServiceYNParam getIsLogin]?[MyMobileServiceYNParam getSerialNumber]:@"",
                    @"OSTYPE":@"ios",
                    @"USERID":[MyMobileServiceYNParam getUserId],
                    @"EPARCHY_CODE":[MyMobileServiceYNParam getCityCode]};
        }else{
            dic = @{@"RESULT":@"BUSINESSNAME is wrong "};
        }
    }
    return dic;
}


-(void)ClientShare:(NSString *)url
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
                                                  url:url
                                          description:@"云南移动"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [publishContent addSMSUnitWithContent:@"云南移动手机营业厅客户端官方出品，实时掌握最新优惠活动、快速进行话费信息查询，更享快捷充值http://yn.10086.cn/client/"];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
    
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


@end












