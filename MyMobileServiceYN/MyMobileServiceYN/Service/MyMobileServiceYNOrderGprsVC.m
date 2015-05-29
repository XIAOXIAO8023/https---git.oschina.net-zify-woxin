//
//  MyMobileServiceYNOrderGprsVC.m
//  MyMobileServiceYN
//
//  Created by Michelle on 14-3-13.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNOrderGprsVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNGprsPackageInfo.h"
#import "MyMobileServiceYNMoreGprsOptionVC.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNCircle.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNGprsOderInfoVC.h"

@interface MyMobileServiceYNOrderGprsVC ()

@end

@implementation MyMobileServiceYNOrderGprsVC
@synthesize alertTag = _alertTag;
@synthesize alertDic = _alertDic;
@synthesize sendTag = _sendTag;
@synthesize isOpen = _isOpen;
@synthesize currentOderedPackage = _currentOderedPackage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)toSetBusiCode
{
    [HUD showTextHUDWithVC:self.navigationController.view];
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    busiCode = @"setGrayCircle";
    
    requestBeanDic=[httpRequest getHttpPostParamData:@"GetAllElementEC"];
    [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [requestBeanDic setObject:@"D" forKey:@"ELEMENT_TYPE_CODE"];
    [httpRequest startAsynchronous:@"GetAllElementEC" requestParamData:requestBeanDic viewController:self];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"流量订购";
    
    self.view.backgroundColor = UIColorFromRGB(rgbValue_backColor);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSetBusiCode) name:@"refresh" object:nil];
    
    [HUD showTextHUDWithVC:self.navigationController.view];
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    busiCode = @"setGrayCircle";
    
    requestBeanDic=[httpRequest getHttpPostParamData:@"GetAllElementEC"];
    [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [requestBeanDic setObject:@"D" forKey:@"ELEMENT_TYPE_CODE"];
    [httpRequest startAsynchronous:@"GetAllElementEC" requestParamData:requestBeanDic viewController:self];
    
    //手势左右滑动（上下的不处理）
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.delegate = self;
    homeScrollView.scrollEnabled = NO;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH-10, SCREEN_HEIGHT-20);
    [self.view addSubview:homeScrollView];
    
    pageControl = [[GrayPageControl alloc] init];
    pageControl.frame = CGRectMake(120, 15, 80, 20);
//    pageControl.backgroundColor = [UIColor grayColor];
    pageControl.numberOfPages = 1;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(pageControlPressed:)forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:pageControl];
    
    
    
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    
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



//左右滑动手势响应
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    //往左滑
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        DebugNSLog(@"-----left--------");
        //先加载数据，再加载动画特效
        //        [self nextQuestion];
        //        self.view.frame = CGRectMake(320, 0, 320, 480);
        //        [UIViewbeginAnimations:@"animationID"context:nil];
        //        [UIViewsetAnimationDuration:0.3f];
        //        [UIViewsetAnimationCurve:UIViewAnimationCurveEaseInOut];
        //        [UIViewsetAnimationRepeatAutoreverses:NO];
        //        self.view.frame = CGRectMake(0, 0, 320, 480);
        //        [UIViewcommitAnimations];
        
//        if (pageControl.currentPage<3) {
//            [homeScrollView setContentOffset:CGPointMake((pageControl.currentPage+1)*SCREEN_WIDTH, 0) animated:YES];
//            homeScrollView.bouncesZoom = NO;
//            pageControl.currentPage +=1;
//        }
    }
    
    //如果往右滑
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        DebugNSLog(@"-----right--------");
        //        [self lastQuestion];
        //        self.view.frame = CGRectMake(-320, 0, 320, 480);
        //        [UIViewbeginAnimations:@"animationID"context:nil];
        //        [UIViewsetAnimationDuration:0.3f];
        //        [UIViewsetAnimationCurve:UIViewAnimationCurveEaseInOut];
        //        [UIViewsetAnimationRepeatAutoreverses:NO];
        //        self.view.frame = CGRectMake(0, 0, 320, 480);
        //        [UIViewcommitAnimations];
//        if (pageControl.currentPage>0) {
//            [homeScrollView setContentOffset:CGPointMake((pageControl.currentPage-1)*SCREEN_WIDTH, 0) animated:YES];
//            homeScrollView.bouncesZoom = NO;
//            pageControl.currentPage -=1;
//        }
    }
    
}

-(void)pageControlPressed:(id)sender
{
    int page = pageControl.currentPage;
    [homeScrollView setContentOffset:CGPointMake(page*SCREEN_WIDTH, 0) animated:YES];
//    [scrollview setContentOffset:CGPointMake(300 * page, 0)];
}

-(void)requestFinished:(ASIHTTPRequest *)requestBean
{

    NSData *jsonData =[requestBean responseData];
    DebugNSLog(@"%@",[requestBean responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableDictionary *fomerDic = [array objectAtIndex:0];
    
    //获取应用程序沙盒的Documents目录
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [path objectAtIndex:0];
    
    //获取文件名
    NSString *configFilePath = [plistPath stringByAppendingPathComponent:@"GprsList.plist"];
    DebugNSLog(@"%@",configFilePath);
    
    monthlyPackage = [[NSArray alloc]init];
    upshiftPackage = [[NSArray alloc]init];
    refuelPackage = [[NSArray alloc]init];
    otherPackage = [[NSArray alloc]init];
    leisurePackage = [[NSArray alloc]init];
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:configFilePath] == NO) {
        DebugNSLog(@"GprsList.plist does not exist");
    //由于修改后没有版本判断，所以必须每次都从程序里面写到沙盒里面，保证plist最新
        NSString *sPath = [[NSBundle mainBundle]pathForResource:@"GprsList" ofType:@"plist"];
        NSMutableDictionary *configDic = [[NSMutableDictionary alloc]initWithContentsOfFile:sPath];
        [configDic writeToFile:configFilePath atomically:YES];
//    }
    
    //获取所有gprs套餐的编码
    NSMutableDictionary *packageDic = [[[NSMutableDictionary alloc]initWithContentsOfFile:configFilePath]objectForKey:@"gprsInfo"];
    monthlyPackage = [packageDic objectForKey:@"monthlyGprs"];
    upshiftPackage = [packageDic objectForKey:@"upshiftGprs"];
    refuelPackage = [packageDic objectForKey:@"refuelGprs"];
    otherPackage = [packageDic objectForKey:@"otherGprs"];
    leisurePackage = [packageDic objectForKey:@"leisureGprs"];
    
    NSMutableArray *sumCode = [[NSMutableArray alloc]init];
    [sumCode addObjectsFromArray:monthlyPackage];
    [sumCode addObjectsFromArray:upshiftPackage];
    [sumCode addObjectsFromArray:leisurePackage];
    [sumCode addObjectsFromArray:otherPackage];
    [sumCode addObjectsFromArray:refuelPackage];
    
    elementIdArray = [[NSMutableArray alloc]init];
    _currentOderedPackage = [[NSMutableArray alloc]init];
    
    if ([busiCode isEqualToString:@"setGrayCircle"]) {
        if ([[fomerDic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
            //检查是否已有订购套餐
            int packageCount = array.count;
            _isOpen = NO;
            for (int i=0 ; i<packageCount; i++) {
                NSMutableDictionary *fomerPackage = [array objectAtIndex:i];
                elementID = [fomerPackage objectForKey:@"ELEMENT_ID"];
                for (int j=0 ; j<(sumCode.count-refuelPackage.count-otherPackage.count); j++) {
                    if ([[[sumCode objectAtIndex:j] objectForKey:@"SVC_DESC"] isEqualToString:elementID]) {
                        _isOpen = YES;
                        
                        [_currentOderedPackage addObject:[sumCode objectAtIndex:j]];
                        [elementIdArray addObject:elementID];
                        
   
                    }
                }
                for (int j=0; j<refuelPackage.count; j++) {
                    if ([[[refuelPackage objectAtIndex:j] objectForKey:@"SVC_DESC"]isEqualToString:elementID]) {
                        
                        _isOpen = YES;
                        
                     //将已订购套餐显示到订购细节页面
                        [_currentOderedPackage addObject:[refuelPackage objectAtIndex:j]];
                        
                    }
                }
                for (int j=0; j<otherPackage.count; j++) {
                    if ([[[otherPackage objectAtIndex:j] objectForKey:@"SVC_DESC"]isEqualToString:elementID]) {
                        
                        _isOpen = YES;
                        
                        //将已订购套餐显示到订购细节页面
                        [_currentOderedPackage addObject:[otherPackage objectAtIndex:j]];
            }
                }
            }
            
            MyMobileServiceYNGprsPackageInfo *gprsPackageInfo1 = [[MyMobileServiceYNGprsPackageInfo alloc]initWithFrame:CGRectMake(0*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20-28)];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:@"上网流量包" forKey:@"TitleName"];
            [dic setObject:@"flow_line" forKey:@"FlowLine"];
            [dic setObject:@"一次办理，月月有效" forKey:@"TitlePrompt"];
            [dic setObject:@"flow_pic1" forKey:@"FlowPic"];
            [dic setObject:@"flow_fs1" forKey:@"FlowFs"];
            NSString *buttonTag1 = [NSString stringWithFormat:@"%d",BUTTON_TAG+1];
            [dic setObject:buttonTag1 forKey:@"button"];
            [gprsPackageInfo1 setView:dic withViewController:self withNsmutableArray:elementIdArray];
            [homeScrollView addSubview:gprsPackageInfo1];
            
//            MyMobileServiceYNGprsPackageInfo *gprsPackageInfo2 = [[MyMobileServiceYNGprsPackageInfo alloc]initWithFrame:CGRectMake(1*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20-28)];
//            NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
//            [dic2 setObject:@"自动升档套餐包" forKey:@"TitleName"];
//            [dic2 setObject:@"flow_line" forKey:@"FlowLine"];
//            [dic2 setObject:@"一次办理 月月有效" forKey:@"TitlePrompt"];
//            [dic2 setObject:@"flow_pic2" forKey:@"FlowPic"];
//            [dic2 setObject:@"flow_fs2" forKey:@"FlowFs"];
//            NSString *buttonTag2 = [NSString stringWithFormat:@"%d",BUTTON_TAG+101];
//            [dic2 setObject:buttonTag2 forKey:@"button"];
//            [gprsPackageInfo2 setView:dic2 withViewController:self withNsmutableArray:elementIdArray];
//            [homeScrollView addSubview:gprsPackageInfo2];
//            DebugNSLog(@"----------------------%@",buttonTag2);
            
//            MyMobileServiceYNGprsPackageInfo *gprsPackageInfo3 = [[MyMobileServiceYNGprsPackageInfo alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20-28)];
//            NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
//            [dic3 setObject:@"加油包" forKey:@"TitleName"];
//            [dic3 setObject:@"flow_line" forKey:@"FlowLine"];
//            [dic3 setObject:@"当月办理 次月失效" forKey:@"TitlePrompt"];
//            [dic3 setObject:@"flow_pic3" forKey:@"FlowPic"];
//            [dic3 setObject:@"flow_fs3" forKey:@"FlowFs"];
//            NSString *buttonTag3 = [NSString stringWithFormat:@"%d",BUTTON_TAG+1001];
//            [dic3 setObject:buttonTag3 forKey:@"button"];
//            [gprsPackageInfo3 setView:dic3 withViewController:self withNsmutableArray:elementIdArray];
//            [homeScrollView addSubview:gprsPackageInfo3];
            
//            MyMobileServiceYNGprsPackageInfo *gprsPackageInfo4 = [[MyMobileServiceYNGprsPackageInfo alloc]initWithFrame:CGRectMake(3*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20-28)];
//            NSMutableDictionary *dic4 = [[NSMutableDictionary alloc]init];
//            [dic4 setObject:@"闲时流量包" forKey:@"TitleName"];
//            [dic4 setObject:@"flow_line" forKey:@"FlowLine"];
//            [dic4 setObject:@"一次办理 月月有效" forKey:@"TitlePrompt"];
//            [dic4 setObject:@"flow_pic4" forKey:@"FlowPic"];
//            [dic4 setObject:@"flow_fs4" forKey:@"FlowFs"];
//            NSString *buttonTag4 = [NSString stringWithFormat:@"%d",BUTTON_TAG+10001];
//            [dic4 setObject:buttonTag4 forKey:@"button"];
//            [gprsPackageInfo4 setView:dic4 withViewController:self withNsmutableArray:elementIdArray];
//            [homeScrollView addSubview:gprsPackageInfo4];

        }
            else{
                if ([@"1620" isEqualToString:[fomerDic objectForKey:@"X_RESULTCODE"]])//超时
                {
//                    NSString *returnMessage = [returnMessageDeal returnMessage:[fomerDic objectForKey:@"X_RESULTCODE"] andreturnMessage:[fomerDic objectForKey:@"X_RESULTINFO"]];
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//                    alertView.tag = ALERTVIEW_TAG_RETURN+10;
//                    [alertView show];
                    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
                    busiCode = @"HQSM_IntegralQryAcctInfos";
                    NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
                    [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
                    [requestParamData setObject:@"HQSM_IntegralQryAcctInfos" forKey:@"intf_code"];
                    [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
                }else
                {
                    NSString *returnMessage = [returnMessageDeal returnMessage:[fomerDic objectForKey:@"X_RESULTCODE"] andreturnMessage:[fomerDic objectForKey:@"X_RESULTINFO"]];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    alertView.tag = ALERTVIEW_TAG_RETURN+1;
                    [alertView show];
                }
            }
            if(HUD){
                [HUD removeHUD];
            }

    }
    
    if(HUD){
        [HUD removeHUD];
    }
    
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    DebugNSLog(@"----------2---------%@",error);
    NSString *returnMessage = [returnMessageDeal returnMessage:@"" andreturnMessage:@""];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN+2;
    [alertView show];
    if(HUD){
        [HUD removeHUD];
    }

}

-(void)dealloc{
    [httpRequest setRequestDelegatNil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
