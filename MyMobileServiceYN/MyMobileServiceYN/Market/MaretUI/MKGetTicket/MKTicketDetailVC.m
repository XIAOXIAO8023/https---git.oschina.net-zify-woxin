//
//  MKTicketDetailVC.m
//  Market
//
//  Created by 陆楠 on 15/3/26.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "MKTicketDetailVC.h"
#import "UIImageView+WebCache.h"
#import "LNSuitLabel.h"
#import "ImageUtils.h"
#import "GlobalDef.h"
#import "MKUserInfo.h"
#import "MyMobileServiceYNParam.h"
#import "MyMobileServiceYNLoginVC.h"

@interface MKTicketDetailVC ()

@end

@implementation MKTicketDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"电子券";
    
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 64)];
    [self.view addSubview:mainScrollView];
    
    NSString *temp = [_infoDic objectForKey:@"RSRV_STR3"];
    
    NSRange mid = [temp rangeOfString:@"电子券使用范围"];
    
    mendian = [temp substringWithRange:NSMakeRange(0, mid.location)];
    
    shuoming = [temp substringWithRange:NSMakeRange(mid.location + 9, temp.length - mid.location - 9)];
    
    [self loadContent];
}


-(void)loadContent
{
    [self loadCommitBtn];
}

-(void)loadCommitBtn
{
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 104, 320, 40)];
    [self.view addSubview:footV];
    footV.backgroundColor = [UIColor whiteColor];
    
    UIButton *commit = [[UIButton alloc]initWithFrame:CGRectMake(100, 5, 120, 30)];
    [footV addSubview:commit];
    commit.backgroundColor = [UIColor orangeColor];
    [commit setTitle:@"立即兑换" forState:UIControlStateNormal];
    commit.tag = 200;
    commit.layer.cornerRadius = 5.0f;
    [commit addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    commit.backgroundColor = UIColorFromRGB(0x3dc1ef);
    footV.alpha = 0.98f;
    
    pointPrice = 83;
    
    CGFloat tmpH = 10;
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, tmpH, self.view.frame.size.width - 20, 90)];
    [mainScrollView addSubview:imageV];
    [imageV sd_setImageWithURL:[NSURL URLWithString:[[_infoDic objectForKey:@"IMAGE_PATH"] stringByAppendingString:[_infoDic objectForKey:@"IMAGE_NAME"]]]
           placeholderImage:[UIImage imageNamed:@"ad_loading"]
                    options:SDWebImageProgressiveDownload];
    tmpH += 100;
    
    UILabel *timeL = [[UILabel alloc]initWithFrame:CGRectMake(10, tmpH, 300, 20)];
    [mainScrollView addSubview:timeL];
    timeL.font = [UIFont fontWithName:@"Arial" size:12];
    timeL.textColor = [UIColor lightGrayColor];
    timeL.text = [NSString stringWithFormat:@"有效期：%@至%@",[_infoDic objectForKey:@"EFFECT_TIME"],[_infoDic objectForKey:@"FAILURE_TIME"]];
    tmpH += 40;
    
    if ([[_infoDic objectForKey:@"RSRV_STR4"] isEqualToString:@"1"]) {
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, tmpH, 320, 45)];
        [mainScrollView addSubview:view1];
        tmpH += 55;
        UILabel *view1TL = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 20)];
        [view1 addSubview:view1TL];
        view1TL.font = [UIFont fontWithName:@"Arial" size:16];
        view1TL.text = @"电子券专属权益:";
        view1TL.textColor = [UIColor orangeColor];
        UIView *grayV1 = [[UIView alloc]initWithFrame:CGRectMake(10, 19, 300, 1)];
        [view1 addSubview:grayV1];
        grayV1.backgroundColor = UIColorFromRGB(0xcecece);
        NSString *price = [_infoDic objectForKey:@"RSRV_STR2"];
        NSRange divR = [price rangeOfString:@":"];
        newPrice = [[price substringWithRange:NSMakeRange(0, divR.location)] floatValue];
        oldPrice = [[price substringWithRange:NSMakeRange(divR.location + 1, price.length - divR.location - 1)] floatValue];
        
        UILabel *view1PL1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 300, 20)];
        [view1 addSubview:view1PL1];
        view1PL1.textColor = UIColorFromRGB(0x595959);
        view1PL1.font = [UIFont fontWithName:@"Arial" size:14];
        NSString *cs = [NSString stringWithFormat:@"现价:%.0f  原价:%.0f      需%.0f积分兑换",newPrice,oldPrice,newPrice * pointPrice];
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc]initWithString:cs];
        [s addAttribute:NSForegroundColorAttributeName
                  value:[UIColor lightGrayColor]
                  range:[cs rangeOfString:[NSString stringWithFormat:@"原价:%.0f ",oldPrice]]];
        [s addAttribute:NSStrikethroughStyleAttributeName
                  value:[NSNumber numberWithInt:1]
                  range:[cs rangeOfString:[NSString stringWithFormat:@"原价:%.0f ",oldPrice]]];
        [s addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0xfc6b9f)
                  range:[cs rangeOfString:[NSString stringWithFormat:@"%.0f",newPrice * pointPrice]]];
        [s addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Arial" size:16]
                  range:[cs rangeOfString:[NSString stringWithFormat:@"%.0f",newPrice * pointPrice]]];
        
        
        [view1PL1 setAttributedText:s];
        
    }else if([[_infoDic objectForKey:@"RSRV_STR4"] isEqualToString:@"2"]){
    
        UIView *contentV = [[UIView alloc]initWithFrame:CGRectZero];
        [mainScrollView addSubview:contentV];
        UILabel *contentVL1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 20)];
        [contentV addSubview:contentVL1];
        contentVL1.font = [UIFont fontWithName:@"Arial" size:16];
        contentVL1.text = @"商户消费说明:";
        contentVL1.textColor = [UIColor orangeColor];
    
        UIView *grayV2 = [[UIView alloc]initWithFrame:CGRectMake(10, 19, 300, 1)];
        [contentV addSubview:grayV2];
        grayV2.backgroundColor = UIColorFromRGB(0xcecece);
    
        LNSuitLabel *contentVL2 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(10, 25, 300, 20)];
        [contentV addSubview:contentVL2];
        contentVL2.font = [UIFont fontWithName:@"Arial" size:14];
        contentVL2.text = shuoming;
        contentVL2.textColor = UIColorFromRGB(0x595959);
        contentV.frame = CGRectMake(0, tmpH, 320, contentVL2.frame.size.height + 25);
        tmpH += contentV.frame.size.height + 25;
    
    
        UIView *contentV1 = [[UIView alloc]initWithFrame:CGRectZero];
        [mainScrollView addSubview:contentV1];
        UILabel *contentV1L1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 20)];
        [contentV1 addSubview:contentV1L1];
        contentV1L1.font = [UIFont fontWithName:@"Arial" size:16];
        contentV1L1.text = @"移动电子券细则:";
        contentV1L1.textColor = [UIColor orangeColor];
    
        UIView *grayV02 = [[UIView alloc]initWithFrame:CGRectMake(10, 19, 300, 1)];
        [contentV1 addSubview:grayV02];
        grayV02.backgroundColor = UIColorFromRGB(0xcecece);
    
        LNSuitLabel *contentV1L2 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(10, 25, 300, 20)];
        [contentV1 addSubview:contentV1L2];
        contentV1L2.font = [UIFont fontWithName:@"Arial" size:14];
        contentV1L2.text = [_infoDic objectForKey:@"DESCRIPTION"];
        contentV1L2.textColor = UIColorFromRGB(0x595959);
        contentV1.frame = CGRectMake(0, tmpH, 320, contentV1L2.frame.size.height + 25);
        tmpH += contentV1.frame.size.height + 25;
    
        UIView *contentV2 = [[UIView alloc]initWithFrame:CGRectZero];
        [mainScrollView addSubview:contentV2];
        UILabel *contentV2L1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 20)];
        [contentV2 addSubview:contentV2L1];
        contentV2L1.font = [UIFont fontWithName:@"Arial" size:16];
        contentV2L1.text = @"适用门店:";
        contentV2L1.textColor = [UIColor orangeColor];
        
        UIView *grayV3 = [[UIView alloc]initWithFrame:CGRectMake(10, 19, 300, 1)];
        [contentV2 addSubview:grayV3];
        grayV3.backgroundColor = UIColorFromRGB(0xcecece);
    
        LNSuitLabel *contentV2L2 = [[LNSuitLabel alloc]initWithFrame:CGRectMake(10, 25, 300, 20)];
        [contentV2 addSubview:contentV2L2];
        contentV2L2.font = [UIFont fontWithName:@"Arial" size:14];
        contentV2L2.text = mendian;
        contentV2L2.textColor = UIColorFromRGB(0x595959);
        contentV2.frame = CGRectMake(0, tmpH, 320, contentV2L2.frame.size.height + 20);
        tmpH += contentV2.frame.size.height + 15;
    
        mainScrollView.contentSize = CGSizeMake(320, tmpH + 40);
    }
    //3代表自由输入类型(10元以上)
    
}

-(void)buttonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([MyMobileServiceYNParam getIsLogin]) {
        if (btn.tag == 200) {
            if (!editWinwow) {
                editWinwow = [[UIWindow alloc]initWithFrame:self.view.window.bounds];
                [editWinwow setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
                [editWinwow setWindowLevel:UIWindowLevelAlert - 1];
                
                editView *edv = [[editView alloc]initWithFrame:CGRectMake(30, editWinwow.frame.size.height / 2 - 90, 260, 180)];
                [editWinwow addSubview:edv];
                edv.layer.cornerRadius = 5.0f;
                edv.pointPrice = pointPrice;
                if ([[_infoDic objectForKey:@"RSRV_STR4"] isEqualToString:@"1"]) {
                    edv.rmb = [NSString stringWithFormat:@"%ld",(long)newPrice];
                    edv.title = @"请确定兑换金额";
                }else if ([[_infoDic objectForKey:@"RSRV_STR4"] isEqualToString:@"2"]){
                    edv.rmb = [NSString stringWithFormat:@"%ld",(long)15];
                    edv.title = @"请确定兑换金额";
                }
                edv.delegate = self;
                edv.backgroundColor = [UIColor whiteColor];
            }
            [editWinwow makeKeyAndVisible];
        }
    }else{
        MyMobileServiceYNLoginVC *login = [[MyMobileServiceYNLoginVC alloc]init];
        [self presentViewController:login animated:YES completion:nil];
    }
    
}

-(void)editViewButtonPressed:(NSDictionary *)info
{
    if ([[info objectForKeyedSubscript:@"action"] isEqualToString:@"cancel"]) {
        [editWinwow setHidden:YES];
    }else if ([[info objectForKeyedSubscript:@"action"] isEqualToString:@"commit"]){
        [editWinwow setHidden:YES];
        payment = [info objectForKeyedSubscript:@"rmb"];
        [self sendRequestWithBusinessCode:@"ITF_CRM_ScoreExchangePayment"];
    }
}

#pragma mark - http通信
-(void)sendRequestWithBusinessCode:(NSString *)code
{

    [HUD showTextHUDWithVC:self.view.window];
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    busiCode = code;
    NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
    
    if ([busiCode isEqualToString:@"ITF_CRM_ScoreExchangePayment"]) {
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:@"ITF_CRM_ScoreExchangePayment" forKey:@"intf_code"];
        [requestParamData setObject:[NSString stringWithFormat:@"%ld",(long)payment.integerValue] forKey:@"MOBILE_PAYMENT_MONEY"];
        [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (HUD) {
        [HUD removeHUD];
    }
    NSData *responseData = [request responseData];
    DebugNSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    if ([busiCode isEqualToString:@"ITF_CRM_ScoreExchangePayment"]) {
        NSArray *resultJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        if ([[[resultJSON objectAtIndex:0] objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"恭喜您！兑换成功！"
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [MKUserInfo setTotalPoint:([MKUserInfo getTotalPoint] - payment.integerValue)];
            [alert show];
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





@implementation editView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContent];
    
    return self;
}


-(void)loadContent
{
    [self setUpForDismissKeyboard];
    isOK = NO;
    
    titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
    [self addSubview:titleL];
    titleL.text = @"请输入10元以上金额";
    titleL.textColor = UIColorFromRGB(0x595959);
    
    rmbT = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, 100, 30)];
    [self addSubview:rmbT];
    rmbT.delegate = self;
    rmbT.keyboardType = UIKeyboardTypeNumberPad;
    rmbT.layer.borderWidth = 0.5f;
    rmbT.layer.borderColor = [UIColor lightGrayColor].CGColor;
    rmbT.layer.cornerRadius = 5.0f;
    rmbT.textColor = UIColorFromRGB(0x595959);
    
    pointL = [[UILabel alloc]initWithFrame:CGRectMake(120, 50, 135, 30)];
    [self addSubview:pointL];
    pointL.textColor = [UIColor redColor];
    pointL.text = [NSString stringWithFormat:@"扣减积分0"];
    
    psL = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 200, 20)];
    [self addSubview:psL];
    psL.textColor = [UIColor redColor];
    psL.font = [UIFont fontWithName:@"Arial" size:12];
    
    UIButton *cancleB = [[UIButton alloc]initWithFrame:CGRectMake(10, 110, 115, 40)];
    [self addSubview:cancleB];
    [cancleB setClipsToBounds:YES];
    cancleB.layer.cornerRadius = 5.0f;
    [cancleB setTitle:@"取消" forState:UIControlStateNormal];
    [cancleB setBackgroundImage:[ImageUtils imageWithColor:UIColorFromRGB(0x3dc1ef) size:cancleB.bounds.size] forState:UIControlStateNormal];
    cancleB.tag = 101;
    [cancleB addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    commitB = [[UIButton alloc]initWithFrame:CGRectMake(135, 110, 115, 40)];
    [self addSubview:commitB];
    commitB.layer.cornerRadius = 5.0f;
    [commitB setClipsToBounds:YES];
    [commitB setTitle:@"确定" forState:UIControlStateNormal];
    [commitB setBackgroundImage:[ImageUtils imageWithColor:UIColorFromRGB(0x3dc1ef) size:cancleB.bounds.size] forState:UIControlStateNormal];
    [commitB setBackgroundImage:[ImageUtils imageWithColor:[UIColor lightGrayColor] size:cancleB.bounds.size] forState:UIControlStateSelected];
    commitB.tag = 102;
    [commitB addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [commitB setSelected:YES];
    [commitB setUserInteractionEnabled:NO];
}

-(void)setRmb:(NSString *)rmb
{
    _rmb = rmb;
    rmbT.text = _rmb;
    rmbS = _rmb;
    [commitB setSelected:NO];
    [commitB setUserInteractionEnabled:YES];
    pointL.text = [NSString stringWithFormat:@"扣减积分%.0f",_rmb.floatValue * _pointPrice];
    isOK = YES;

    [rmbT setUserInteractionEnabled:NO];
}

-(void)setPointPrice:(CGFloat)pointPrice
{
    _pointPrice = pointPrice;
    
    pointL.text = [NSString stringWithFormat:@"扣减积分%.0f",_rmb.floatValue * _pointPrice];
}

-(void)setPsString:(NSString *)psString
{
    _psString = psString;
    
    psL.text = psString;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    titleL.text = _title;
}

-(void)buttonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 101) {
        [self.delegate editViewButtonPressed:@{@"action":@"cancel"}];
    }else if (btn.tag == 102){
        [self.delegate editViewButtonPressed:@{@"action":@"commit",@"rmb":rmbS}];
    }
}

#pragma mark - TextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    CGFloat po = toBeString.floatValue * _pointPrice;
    if (po > [MKUserInfo getTotalPoint]) {
        pointL.text = @"积分不足";
        [commitB setSelected:YES];
        [commitB setUserInteractionEnabled:NO];
    }else{
        pointL.text = [NSString stringWithFormat:@"扣减积分%.0f",po];
        rmbS = toBeString;
        [commitB setSelected:NO];
        [commitB setUserInteractionEnabled:YES];
    }
    return YES;
}


#pragma mark - 点击屏幕任何地方隐藏键盘实现
- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note){
        [self.superview addGestureRecognizer:singleTapGR];
    }];
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note){
        [self.superview removeGestureRecognizer:singleTapGR];
    }];
}
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self endEditing:YES];
    [self setUserInteractionEnabled:YES];
}

@end












