//
//  QuerryPointVC.m
//  Market
//
//  Created by 陆楠 on 15/3/24.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "QuerryPointVC.h"
#import "ImageUtils.h"
#import "QPHadePointV.h"
#import "QPHandOutPointV.h"
#import "QPUsedPointV.h"
#import "MKUserInfo.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"

@interface QuerryPointVC ()

@end

@implementation QuerryPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"积分查询";
    
    [self loadSegment];
    
//    [self loadContentV];
    [self sendRequestWithBusinessCode:@"ITF_CRM_ScoreLogQry"];
}

-(void)loadSegment
{
    segmentV = [[LNSegment alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
    [self.view addSubview:segmentV];
    segmentV.delegate = self;
    [segmentV.layer setCornerRadius:5.0f];
    segmentV.layer.borderWidth = 0.4f;
    segmentV.layer.borderColor = UIColorFromRGB(0x3dc1ef).CGColor;
    segmentV.clipsToBounds = YES;
    
    NSMutableArray *btnArry = [[NSMutableArray alloc]init];
    NSArray *nameArry = @[@"可兑换积分",@"积分发放",@"积分使用"];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        [btn setTitle:nameArry[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x3dc1ef) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[ImageUtils imageWithColor:[UIColor whiteColor] size:btn.bounds.size] forState:UIControlStateNormal];
        [btn setBackgroundImage:[ImageUtils imageWithColor:UIColorFromRGB(0x3dc1ef) size:btn.bounds.size] forState:UIControlStateSelected];
        btn.layer.borderColor = UIColorFromRGB(0x3dc1ef).CGColor;
        btn.layer.borderWidth = 0.4f;
        btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
        [btnArry addObject:btn];
    }
    
    segmentV.titleButtonArry = btnArry;
}


-(void)loadContentV
{
    [self loadHadePointV];
    
    [self loadHandOutPointV];
    
    [self loadUsedPointV];
}

-(void)loadHadePointV
{
    hadePointV = [[QPHadePointV alloc]initWithFrame:CGRectMake(0, segmentV.frame.origin.y + segmentV.frame.size.height , 320, [UIScreen mainScreen].bounds.size.height - 40 - 64)];
    [self.view addSubview:hadePointV];
    hadePointV.pointArry = [MKUserInfo getUnzeroPointArray];
    [hadePointV setHidden:NO];
}

-(void)loadHandOutPointV
{
    handOutPointV = [[QPHandOutPointV alloc]initWithFrame:CGRectMake(0, segmentV.frame.origin.y + segmentV.frame.size.height , 320, [UIScreen mainScreen].bounds.size.height - 40 - 64)];
    [self.view addSubview:handOutPointV];
    handOutPointV.pointArry = [MKUserInfo getPointInArray];
    [handOutPointV setHidden:YES];
}

-(void)loadUsedPointV
{
    usedPointV = [[QPUsedPointV alloc]initWithFrame:CGRectMake(0, segmentV.frame.origin.y + segmentV.frame.size.height , 320, [UIScreen mainScreen].bounds.size.height - 40 - 64)];
    [self.view addSubview:usedPointV];
    usedPointV.pointArry = [MKUserInfo getPointOutArray];
    [usedPointV setHidden:YES];
}

-(void)LNSegmentDidSelectAtIndex:(NSInteger)index
{
    if (index == 0) {
        [handOutPointV setHidden:YES];
        [usedPointV setHidden:YES];
        [hadePointV setHidden:NO];
    }else if (index == 1){
        [usedPointV setHidden:YES];
        [hadePointV setHidden:YES];
        [handOutPointV setHidden:NO];
    }else if (index == 2){
        [handOutPointV setHidden:YES];
        [hadePointV setHidden:YES];
        [usedPointV setHidden:NO];
    }
}

#pragma mark - http通信
-(void)sendRequestWithBusinessCode:(NSString *)code
{

    [HUD showTextHUDWithVC:self.navigationController.view];
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    busiCode = code;
    NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
    
    if ([busiCode isEqualToString:@"ITF_CRM_ScoreLogQry"]) {
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:@"ITF_CRM_ScoreLogQry" forKey:@"intf_code"];
        [requestParamData setObject:@"-1" forKey:@"OPERA_TYPE"];
        [requestParamData setObject:@"-1" forKey:@"SVC_TYPE_CODE"];
        NSDateFormatter *datefo = [[NSDateFormatter alloc]init];
        [datefo setDateFormat:@"yyyyMMdd"];
        NSString *endDate = [datefo stringFromDate:[NSDate date]];
        NSString *startDate = [datefo stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-182 * 24 *60 *60]];
        [requestParamData setObject:startDate forKey:@"START_CYCLE_ID"];
        [requestParamData setObject:endDate forKey:@"END_CYCLE_ID"];
    }
    
    [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    DebugNSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSArray *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    
    if ([busiCode isEqualToString:@"ITF_CRM_ScoreLogQry"]) {
        if (resultJSON.count > 0) {
            if ([[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
                NSLog(@"积分出入记录查询成功...");
                NSArray *pointInOutArray = [[resultJSON objectAtIndex:0] objectForKey:@"SCOREINFOS"];
                [MKUserInfo setPointInOutArray:pointInOutArray];
                [self loadContentV];
            }
        }else{
            //空数据包
        }
    }
    if (HUD) {
        [HUD removeHUD];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    if (HUD) {
        [HUD removeHUD];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:@"请求失败，请检查网络..."
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
