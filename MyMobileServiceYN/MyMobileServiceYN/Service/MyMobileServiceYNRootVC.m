//
//  MyMobileServiceYNRootVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-5.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNRootVC.h"
#import "MyMobileServiceYNHomeVC.h"
#import "MyMobileServiceYNLeftSideMenuVC.h"
#import "MyMobileServiceYNRightSideMenuVC.h"
#import "MyMobileServiceYN10086SupportVC.h"
#import "MyMobileServiceYNAboutUSVC.h"
#import "MyMobileServiceYNIntroduceVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNRootVC ()

@end

@implementation MyMobileServiceYNRootVC

@synthesize centerController = _centerController;
@synthesize rightController = _rightController;
@synthesize leftController = _leftController;

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
    
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    MyMobileServiceYNHomeVC *home = [[MyMobileServiceYNHomeVC alloc]init];
    _centerController = [[UINavigationController alloc]initWithRootViewController: home];
    
    //设置nav bar 颜色
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(rgbValue_navBarBg)];
    }else{
        [[UINavigationBar appearance] setTintColor:UIColorFromRGB(rgbValue_navBarBg)];
    }
    [_centerController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, [UIFont fontWithName:appTypeFace size:18.0], UITextAttributeFont,nil]];
    
    _leftController = [[MyMobileServiceYNLeftSideMenuVC alloc]init];
    
    _rightController = [[MyMobileServiceYNRightSideMenuVC alloc]init];
    
    [self.view addSubview:_centerController.view];
    [_centerController.view setTag:1];
    [_centerController.view setFrame:self.view.bounds];
    
    [self.view addSubview:_leftController.view];
    [_leftController.view setTag:2];
    [_leftController.view setFrame:self.view.bounds];
    
//    [self.view addSubview:_rightController.view];
//    [_rightController.view setTag:3];
//    [_rightController.view setFrame:self.view.bounds];
    
    [self.view bringSubviewToFront:_centerController.view];
    
    //add swipe gesture
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [_centerController.view addGestureRecognizer:swipeGestureRight];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_centerController.view addGestureRecognizer:swipeGestureLeft];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftButtonPressed:) name:@"Notification_LeftButtonPressed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftMenuButtonPressed:) name:@"Notification_LeftMenuButtonPressed" object:nil];
}

-(void) swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    
//    CALayer *layer = [_centerController.view layer];
//    layer.shadowColor = [UIColor blackColor].CGColor;
//    layer.shadowOffset = CGSizeMake(1, 1);
//    layer.shadowOpacity = 1;
//    layer.shadowRadius = 20.0;
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
//        [_leftController.view setHidden:NO];
//        [_rightController.view setHidden:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        if (_centerController.view.frame.origin.x == self.view.frame.origin.x || _centerController.view.frame.origin.x == -260) {
            [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x+260, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        }
        
        [UIView commitAnimations];
    }
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
//        [_rightController.view setHidden:NO];
//        [_leftController.view setHidden:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//        if (_centerController.view.frame.origin.x == self.view.frame.origin.x || _centerController.view.frame.origin.x == 160)
        if (_centerController.view.frame.origin.x == 260){
            [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x-260, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
        }
        
        [UIView commitAnimations];
    }
}

-(void)leftButtonPressed:(NSNotification*) notification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    if (_centerController.view.frame.origin.x == self.view.frame.origin.x) {
        [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x+260, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
    }else if (_centerController.view.frame.origin.x == 260){
        [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x-260, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
    }
    
    [UIView commitAnimations];
}

-(void)leftMenuButtonPressed:(NSNotification*) notification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    if (_centerController.view.frame.origin.x == 260){
        [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x-260, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
    }
    [UIView commitAnimations];
    NSMutableDictionary *dic=(NSMutableDictionary *)[notification object];
    if([[dic objectForKey:@"Operate"] isEqualToString:@"support"]){
        MyMobileServiceYN10086SupportVC *supportVC=[[MyMobileServiceYN10086SupportVC alloc]init];
        [_centerController pushViewController:supportVC animated:YES];
    }
    //关于
    if([[dic objectForKey:@"Operate"] isEqualToString:@"about"]){
        MyMobileServiceYNAboutUSVC *aboutUSVC=[[MyMobileServiceYNAboutUSVC alloc]init];
        [_centerController pushViewController:aboutUSVC animated:YES];
    }
    //新版介绍
    if([[dic objectForKey:@"Operate"] isEqualToString:@"introduce"]){
        MyMobileServiceYNIntroduceVC *introduceVC = [[MyMobileServiceYNIntroduceVC alloc]init];
        [_centerController pushViewController:introduceVC animated:YES];
        NSLog(@"新版介绍");
    }
    /**
    //分享应用
    if([[dic objectForKey:@"Operate"] isEqualToString:@"share"]){
        NSLog(@"分享应用");
//        UIActionSheet *sendSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微信",@"分享到新浪微博",@"分享到手机联系人",nil];
        UIActionSheet *sendSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微信",@"分享到新浪微博",nil];
        sendSheet.tag = ALERTVIEW_TAG + 200;
        [sendSheet showInView:self.view];
    }
     */
}

/**
#pragma mark - aciontSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"点击了actionsheet");
    if (ALERTVIEW_TAG + 200 == actionSheet.tag)
    {
        if (0 == buttonIndex)
        {
            //分享到微信
            CMClientShareEngine *share = [[CMClientShareEngine alloc]init];
//            [share sendTextContentToWeChat:@"我信"];
            
            [share sendLinkContentToWeChat:@"我信" MessageDescription:
                          @"123" MessageImageName:@"AppIcon.png" MessagePageUrl:@"http://wap.cq.10086.cn/app?service=page/Home&listener=initPage"];
        }
        else if (1 == buttonIndex)
        {
            //分享到新浪微博
            CMClientShareEngine *share = [[CMClientShareEngine alloc]init];
            [share sendTextContentToSinaWeibo:@"我信"];

//            [share sendLinkContentToSinaWeibo:@"我信" MessageDescription:@"大家好" MessageImageName:@"logo_114" MessagePageUrl:@"http://wap.cq.10086.cn/app?service=page/Home&listener=initPage"];
        }else if(2 == buttonIndex){
            //分享到短信，无
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://10000"]];
//            [self showSMSPicker];
        }else{
            
        }
    }
}
*/

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Notification_GetUserProfileSuccess" object:nil]; //单个移除
}

@end
