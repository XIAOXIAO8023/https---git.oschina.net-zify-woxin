//
//  RPGiftPointRecordVC.m
//  Market
//
//  Created by 陆楠 on 15/3/26.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "RPGiftPointRecordVC.h"
#import "MKUserInfo.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"

@interface RPGiftPointRecordVC ()

@end

@implementation RPGiftPointRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"积分转赠记录";
    

    [self sendRequestWithBusiCode:@"ITF_CRM_ScoreDonateDetail"];
}


-(void)loadTitleV
{
    UIImageView *head = [[UIImageView alloc]initWithFrame:CGRectMake(0, -0.5f, 320, 100)];
    [self.view addSubview:head];
    head.image = [UIImage imageNamed:@"bule-bg"];
    
    UILabel *outNameL = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 100, 20)];
    [head addSubview:outNameL];
    outNameL.textColor = [UIColor whiteColor];
    outNameL.text = @"转出积分";
    outNameL.textAlignment = NSTextAlignmentCenter;
    
    outPointL = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 100, 20)];
    [head addSubview:outPointL];
    outPointL.textAlignment = NSTextAlignmentCenter;
    outPointL.textColor = [UIColor whiteColor];
    
    UILabel *inNameL = [[UILabel alloc]initWithFrame:CGRectMake(head.frame.size.width - 110, 50, 100, 20)];
    [head addSubview:inNameL];
    inNameL.textColor = [UIColor whiteColor];
    inNameL.text = @"转入积分";
    inNameL.textAlignment = NSTextAlignmentCenter;
    
    inPointL = [[UILabel alloc]initWithFrame:CGRectMake(head.frame.size.width - 110, 70, 100, 20)];
    [head addSubview:inPointL];
    inPointL.textAlignment = NSTextAlignmentCenter;
    inPointL.textColor = [UIColor whiteColor];
    
    
    UIView *white = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
    white.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    white.layer.cornerRadius = white.frame.size.height / 2;
    [self.view addSubview:white];
    c = [[CirclePointV alloc]initWithFrame:CGRectMake(110, head.frame.size.height - 50, 100, 100)];
    [self.view addSubview:c];
    [c setPoint:100 withType:CirclePointTypeOut];
    c.backgroundColor = UIColorFromRGB(0xfc6b9f);
    white.center = c.center;
    
    
    
    grayV = [[UIView alloc]initWithFrame:CGRectMake(159.5, c.frame.size.height + c.frame.origin.y , 1, [[UIScreen mainScreen] bounds].size.height - 150 - 64)];
    [self.view addSubview:grayV];
    grayV.backgroundColor = UIColorFromRGB(0xcecece);
}

-(void)loadRecordList
{
    if (recordList) {
        [recordList removeFromSuperview];
        recordList = nil;
    }
    recordList = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, 320, [[UIScreen mainScreen] bounds].size.height - 150 - 64)];
    [self.view addSubview:recordList];
    
    NSArray *arr = [MKUserInfo getGiftRecordArray];
    CGFloat tmpH = 0;
    NSInteger inOutPoint = 0;
    NSInteger inPoint = 0;
    NSInteger outPoint = 0;
    if ([[arr objectAtIndex:0] count] > 3) {
        for (NSDictionary *dic in arr) {
            RecordItem *item = [[RecordItem alloc]initWithFrame:CGRectMake(0, 0, 155, 70)];
            [item setInfoDic:dic];
            if (item.type == RecordItemTypeOut) {
                item.frame = CGRectMake(5, tmpH, item.frame.size.width, item.frame.size.height);
                inOutPoint -= [[dic objectForKey:@"TransferPoint"] integerValue];
                outPoint += [[dic objectForKey:@"TransferPoint"] integerValue];
            }else{
                item.frame = CGRectMake(160, tmpH, item.frame.size.width, item.frame.size.height);
                inOutPoint += [[dic objectForKey:@"TransferPoint"] integerValue];
                inPoint += [[dic objectForKey:@"TransferPoint"] integerValue];
            }
            [recordList addSubview:item];
            tmpH += 75;
        }
        recordList.contentSize = CGSizeMake(320, tmpH + 20);
    }else{
        [grayV setHidden:YES];
        UILabel *lack = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        [recordList addSubview:lack];
        lack.textColor = [UIColor lightGrayColor];
        lack.text = @"暂无转赠记录";
        lack.textAlignment = NSTextAlignmentCenter;
        lack.center = CGPointMake(recordList.center.x, 40);
    }
    
    [c setPoint:inOutPoint
       withType:(inOutPoint > 0)?CirclePointTypeIn:CirclePointTypeOut];
    outPointL.text = [NSString stringWithFormat:@"%ld",(long)outPoint];
    inPointL.text = [NSString stringWithFormat:@"%ld",(long)inPoint];
    
}




#pragma mark - http通信
-(void)sendRequestWithBusiCode:(NSString *)code
{
    [HUD showTextHUDWithVC:self.navigationController.view];
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    busiCode = code;
    NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
    
    if ([busiCode isEqualToString:@"ITF_CRM_ScoreDonateDetail"]) {
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"LMobile"];
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"BMobile"];
        [requestParamData setObject:@"ITF_CRM_ScoreDonateDetail" forKey:@"intf_code"];
        NSDateFormatter *datefo = [[NSDateFormatter alloc]init];
        [datefo setDateFormat:@"yyyyMMddHHmmss"];
        NSString *endDate = [datefo stringFromDate:[NSDate date]];
        NSString *startDate = [datefo stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-182 * 24 *60 *60]];
        [requestParamData setObject:startDate forKey:@"StartTime"];
        [requestParamData setObject:endDate forKey:@"EndTime"];
    }
    
    [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (HUD) {
        [HUD removeHUD];
    }
    NSData *responseData = [request responseData];
    DebugNSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    if ([busiCode isEqualToString:@"ITF_CRM_ScoreDonateDetail"]) {
        NSArray *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        if ([[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
            [MKUserInfo setGiftRecordArray:resultJSON];
            [self loadTitleV];
            [self loadRecordList];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                           message:[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTINFO"]
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }
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





@implementation CirclePointV

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [[self layer] setCornerRadius:self.frame.size.height / 2];
    [self loadContent];
    [self setClipsToBounds:YES];
    
    return self;
}

-(void)loadContent
{
    self.layer.borderWidth = 5.0f;
    self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
    
    
    pointL = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height / 2 - 20, self.frame.size.width, 20)];
    [self addSubview:pointL];
    pointL.textAlignment = NSTextAlignmentCenter;
    pointL.font = [UIFont fontWithName:@"Arial" size:20];
    pointL.textColor = [UIColor whiteColor];
    
    typeL = [[UILabel alloc]initWithFrame:CGRectMake(0, pointL.frame.origin.y + pointL.frame.size.height + 5, self.frame.size.width, 20)];
    [self addSubview:typeL];
    typeL.textAlignment = NSTextAlignmentCenter;
    typeL.font = [UIFont fontWithName:@"Arial" size:18];
    typeL.textColor = [UIColor whiteColor];
}

-(void)setPoint:(NSInteger)point withType:(CirclePointType)type
{
    _point = point;
    _type = type;
    
    
    if (_type == CirclePointTypeIn) {
        pointL.text = [NSString stringWithFormat:@"+%ld分",(long)_point];
        typeL.text = @"净入";
    }else if (_type == CirclePointTypeOut) {
        pointL.text = [NSString stringWithFormat:@"%ld分",(long)_point];
        typeL.text = @"净入";
    }
}

@end




@implementation RecordItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContent];
    
    return self;
}


-(void)loadContent
{
    pointL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.6)];
    [self addSubview:pointL];
    pointL.font = [UIFont fontWithName:@"Arial" size:16];
    pointL.textAlignment = NSTextAlignmentCenter;
    
    
    infoLimageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.5, self.frame.size.width, self.frame.size.height * 0.5)];
    [self addSubview:infoLimageV];
    infoL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, infoLimageV.frame.size.width * 0.6, infoLimageV.frame.size.height)];
    [infoLimageV addSubview:infoL];
    infoL.font = [UIFont fontWithName:@"Arial" size:14];
    infoL.textAlignment = NSTextAlignmentCenter;
    
    infoL2 = [[UILabel alloc]initWithFrame:CGRectMake(infoL.frame.size.width, 0, infoLimageV.frame.size.width * 0.4, infoLimageV.frame.size.height)];
    [infoLimageV addSubview:infoL2];
    infoL2.font = [UIFont fontWithName:@"Arial" size:10];
    infoL2.textAlignment = NSTextAlignmentCenter;
    infoL2.numberOfLines = 0;
    infoL2.lineBreakMode = UILineBreakModeWordWrap;
    infoL2.textColor = [UIColor lightGrayColor];
    
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    _infoDic = infoDic;
    
    if ([[infoDic objectForKey:@"BMobile"] isEqualToString:[MyMobileServiceYNParam getSerialNumber]]) {
        _type = RecordItemTypeIn;
    }else{
        _type = RecordItemTypeOut;
    }
    
    if (_type == RecordItemTypeIn) {
        pointL.textColor = [UIColor greenColor];
        NSString *text = [NSString stringWithFormat:@"+%ld  积分",(long)[[_infoDic objectForKey:@"TransferPoint"] integerValue]];
        NSMutableAttributedString *as = [[NSMutableAttributedString alloc]initWithString:text];
        NSRange r = [text rangeOfString:[_infoDic objectForKey:@"TransferPoint"]];
        [as addAttribute:NSFontAttributeName
                   value:[UIFont fontWithName:@"Arial" size:26]
                   range:r];
        [pointL setAttributedText:as];
        
        infoLimageV.image = [UIImage imageNamed:@"talk_r"];
    }else{
        pointL.textColor = [UIColor redColor];
        NSString *text = [NSString stringWithFormat:@"-%ld  积分",(long)[[_infoDic objectForKey:@"TransferPoint"] integerValue]];
        NSMutableAttributedString *as = [[NSMutableAttributedString alloc]initWithString:text];
        NSRange r = [text rangeOfString:[_infoDic objectForKey:@"TransferPoint"]];
        [as addAttribute:NSFontAttributeName
                   value:[UIFont fontWithName:@"Arial" size:26]
                   range:r];
        [pointL setAttributedText:as];
        
        infoLimageV.image = [UIImage imageNamed:@"talk_l"];
        
    }
    
    infoL.textColor = [UIColor grayColor];
    infoL.text = [_infoDic objectForKey:@"BMobile"];
    
    infoL2.text = [[_infoDic objectForKey:@"IN_DATE"] substringWithRange:NSMakeRange(0, [[_infoDic objectForKey:@"IN_DATE"] length] - 2)];
}


@end
















