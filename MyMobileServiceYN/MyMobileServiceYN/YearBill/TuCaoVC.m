//
//  TuCaoVC.m
//  YearBill
//
//  Created by 陆楠 on 15/3/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "TuCaoVC.h"
#import "YBColorDef.h"
#import "YearBillUserInfo.h"
#import "GlobalDef.h"

#define QUESTION_1_QUESTION        @"1、亲，客户端里有这个消费报告，你觉得怎么样？"
#define QUESTION_1_ANSWER_1        @"非常喜欢"
#define QUESTION_1_ANSWER_2        @"喜欢"
#define QUESTION_1_ANSWER_3        @"没感觉"
#define QUESTION_1_ANSWER_4        @"不喜欢"
#define QUESTION_1_ANSWER_5        @"非常不喜欢"

#define QUESTION_2_QUESTION        @"2、那如果客户端里没有这个消费报告，你的感觉呢？"
#define QUESTION_2_ANSWER_1        @"有是最好的"
#define QUESTION_2_ANSWER_2        @"还是希望有"
#define QUESTION_2_ANSWER_3        @"有没有无所谓"
#define QUESTION_2_ANSWER_4        @"希望没有"
#define QUESTION_2_ANSWER_5        @"非常希望没有"

@interface TuCaoVC ()

@end

@implementation TuCaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问卷调查";
    [self setUpForDismissKeyboard];
    
    Q1answerID = 51;
    Q2answerID = 55;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pink.png"]];
    
    [self loadMainScrollView];
}


-(void)loadMainScrollView
{
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 64)];
    [self.view addSubview:mainScrollView];
    [mainScrollView setContentSize:CGSizeMake(320, 470)];
    
    [self loadQuestions];
    
    [self loadTextView];
    
}

-(void)loadQuestions
{
    UILabel *Qu1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 290, 40)];
    [mainScrollView addSubview:Qu1];
    Qu1.numberOfLines = 0;
    Qu1.lineBreakMode = UILineBreakModeWordWrap;
    Qu1.text = QUESTION_1_QUESTION;
    Qu1.textColor = [UIColor whiteColor];
    Qu1.font = [UIFont fontWithName:@"Arial" size:14];
    
    SelectBtn *Q1A1 = [[SelectBtn alloc]initWithFrame:CGRectMake(15, 60, 150, 20)];
    [mainScrollView addSubview:Q1A1];
    Q1A1.questionLabel.text = QUESTION_1_ANSWER_1;
    Q1A1.tag = 101;
    [Q1A1 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    SelectBtn *Q1A2 = [[SelectBtn alloc]initWithFrame:CGRectMake(15, 80, 150, 20)];
    [mainScrollView addSubview:Q1A2];
    Q1A2.questionLabel.text = QUESTION_1_ANSWER_2;
    Q1A2.tag = 102;
    [Q1A2 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    SelectBtn *Q1A3 = [[SelectBtn alloc]initWithFrame:CGRectMake(15, 100, 150, 20)];
    [mainScrollView addSubview:Q1A3];
    Q1A3.questionLabel.text = QUESTION_1_ANSWER_3;
    Q1A3.tag = 103;
    [Q1A3 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    SelectBtn *Q1A4 = [[SelectBtn alloc]initWithFrame:CGRectMake(15, 120, 150, 20)];
    [mainScrollView addSubview:Q1A4];
    Q1A4.questionLabel.text = QUESTION_1_ANSWER_4;
    Q1A4.tag = 104;
    [Q1A4 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    SelectBtn *Q1A5 = [[SelectBtn alloc]initWithFrame:CGRectMake(15, 140, 150, 20)];
    [mainScrollView addSubview:Q1A5];
    Q1A5.questionLabel.text = QUESTION_1_ANSWER_5;
    Q1A5.tag = 105;
    [Q1A5 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *Qu2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 170, 290, 40)];
    [mainScrollView addSubview:Qu2];
    Qu2.numberOfLines = 0;
    Qu2.lineBreakMode = UILineBreakModeWordWrap;
    Qu2.text = QUESTION_2_QUESTION;
    Qu2.textColor = [UIColor whiteColor];
    Qu2.font = [UIFont fontWithName:@"Arial" size:14];
    
    SelectBtn *Q2A1 = [[SelectBtn alloc]initWithFrame:CGRectMake(15, 210, 150, 20)];
    [mainScrollView addSubview:Q2A1];
    Q2A1.questionLabel.text = QUESTION_2_ANSWER_1;
    Q2A1.tag = 201;
    [Q2A1 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    SelectBtn *Q2A2 = [[SelectBtn alloc]initWithFrame:CGRectMake(15, 230, 150, 20)];
    [mainScrollView addSubview:Q2A2];
    Q2A2.questionLabel.text = QUESTION_2_ANSWER_2;
    Q2A2.tag = 202;
    [Q2A2 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    SelectBtn *Q2A3 = [[SelectBtn alloc]initWithFrame:CGRectMake(15, 250, 150, 20)];
    [mainScrollView addSubview:Q2A3];
    Q2A3.questionLabel.text = QUESTION_2_ANSWER_3;
    Q2A3.tag = 203;
    [Q2A3 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    SelectBtn *Q2A4 = [[SelectBtn alloc]initWithFrame:CGRectMake(15, 270, 150, 20)];
    [mainScrollView addSubview:Q2A4];
    Q2A4.questionLabel.text = QUESTION_2_ANSWER_4;
    Q2A4.tag = 204;
    [Q2A4 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    SelectBtn *Q2A5 = [[SelectBtn alloc]initWithFrame:CGRectMake(15, 290, 150, 20)];
    [mainScrollView addSubview:Q2A5];
    Q2A5.questionLabel.text = QUESTION_2_ANSWER_5;
    Q2A5.tag = 205;
    [Q2A5 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    answersQ1 = [NSArray arrayWithObjects:Q1A1,Q1A2,Q1A3,Q1A4,Q1A5, nil];
    answersQ2 = [NSArray arrayWithObjects:Q2A1,Q2A2,Q2A3,Q2A4,Q2A5, nil];
}


-(void)loadTextView
{
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(15, 320, 290, 30)];
    l.text = @"3、吐槽";
    [mainScrollView addSubview:l];
    l.textColor = [UIColor whiteColor];
    l.font = [UIFont fontWithName:@"Arial" size:14];
    
    f = [[UITextView alloc]initWithFrame:CGRectMake(15, 350, 290, 60)];
    [mainScrollView addSubview:f];
    f.textColor = [UIColor whiteColor];
    f.delegate = self;
    f.layer.borderWidth = 0.5f;
    f.layer.borderColor = [UIColor whiteColor].CGColor;
    [f.layer setCornerRadius:5.0f];
    f.backgroundColor = [UIColor clearColor];
    
    UIButton *commit = [[UIButton alloc]initWithFrame:CGRectMake(70, 420, 180, 35)];
    [mainScrollView addSubview:commit];
    [commit setTitle:@"提交" forState:UIControlStateNormal];
    [commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commit setBackgroundColor:UIColorFromRGB(COMMON_PURPLE)];
    commit.tag = 300;
    [commit addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (textView)
    {
        if ([toBeString length] > 100) {
            textView.text = [toBeString substringToIndex:100];
            return NO;
        }
    }
    return YES;
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (mainScrollView.frame.origin.y == 0) {
        [UIView animateWithDuration:0.275f
                         animations:^{
                             mainScrollView.frame = CGRectMake(mainScrollView.frame.origin.x, mainScrollView.frame.origin.y - 200, mainScrollView.frame.size.width, mainScrollView.frame.size.height);
                         }];
    }
    
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (mainScrollView.frame.origin.y != 0) {
        [UIView animateWithDuration:0.275f
                         animations:^{
                             mainScrollView.frame = CGRectMake(mainScrollView.frame.origin.x, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height);
                         }];
        
    }
}

-(void)btnPressed:(UIButton *)btn
{
    [btn setSelected:YES];
    if (btn.tag / 100 == 1) {
        for (int i = 0; i < answersQ1.count; i++) {
            if (btn.tag != [(UIButton *)[answersQ1 objectAtIndex:i] tag]) {
                [(UIButton *)[answersQ1 objectAtIndex:i] setSelected:NO];
            }
        }
    }else if (btn.tag / 100 == 2){
        for (int i = 0; i < answersQ2.count; i++) {
            if (btn.tag != [(UIButton *)[answersQ2 objectAtIndex:i] tag]) {
                [(UIButton *)[answersQ2 objectAtIndex:i] setSelected:NO];
            }
        }
    }
    
    if (btn.tag == 101) {
        Q1answerID = 51;
        Q1answer = @"非常喜欢";
    }else if (btn.tag == 102) {
        Q1answerID = 52;
        Q1answer = @"喜欢";
    }else if (btn.tag == 103) {
        Q1answerID = 54;
        Q1answer = @"没感觉";
    }else if (btn.tag == 104) {
        Q1answerID = 53;
        Q1answer = @"不喜欢";
    }else if (btn.tag == 105) {
        Q1answerID = 60;
        Q1answer = @"非常不喜欢";
    }else if (btn.tag == 201) {
        Q1answerID = 55;
        Q2answer = @"有是最好的";
    }else if (btn.tag == 202) {
        Q1answerID = 56;
        Q2answer = @"还是希望有";
    }else if (btn.tag == 203) {
        Q1answerID = 57;
        Q2answer = @"有没有无所谓";
    }else if (btn.tag == 204) {
        Q1answerID = 58;
        Q2answer = @"希望没有";
    }else if (btn.tag == 205) {
        Q1answerID = 59;
        Q2answer = @"非常希望没有";
    }else if (btn.tag == 300){
        [self sendCommitRequest];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---点击屏幕任何地方隐藏键盘实现
- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note){
        [self.view.superview addGestureRecognizer:singleTapGR];
    }];
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note){
        [self.view.superview removeGestureRecognizer:singleTapGR];
    }];
}
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
    [self.view setUserInteractionEnabled:YES];
}

-(void)sendCommitRequest
{
    [HUD showTextHUDWithVC:self.view.window];
    
    NSDictionary *dic1 = @{@"QUESTION_ID":@"11",
                           @"QUESTION_TYPE":@"1",
                           @"OPTION_ID":@(Q1answerID),
                           @"MOBILE_PHONE_NO":[MyMobileServiceYNParam getSerialNumber],
                           @"IS_OTHER":@"0",
                           @"OPTION_ANSWER":Q1answer};
    
    NSDictionary *dic2 = @{@"QUESTION_ID":@"12",
                           @"QUESTION_TYPE":@"1",
                           @"OPTION_ID":@(Q2answerID),
                           @"MOBILE_PHONE_NO":[MyMobileServiceYNParam getSerialNumber],
                           @"IS_OTHER":@"0",
                           @"OPTION_ANSWER":Q2answer};
    
    NSDictionary *dic3 = @{@"QUESTION_ID":@"13",
                           @"QUESTION_TYPE":@"1",
                           @"OPTION_ID":@"61",
                           @"MOBILE_PHONE_NO":[MyMobileServiceYNParam getSerialNumber],
                           @"IS_OTHER":@"1",
                           @"OPTION_ANSWER":f.text};
    
    NSArray *arr = @[dic1,dic2,dic3];
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    
    busiCode = @"setQuestionAnswer";
    
    NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
    [requestParamData setObject:arr forKey:@"question_answer"];
    [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [requestParamData setObject:@"setQuestionAnswer" forKey:@"intf_code"];
    [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (HUD) {
        [HUD removeHUD];
    }
    NSData *responseData = [request responseData];
    DebugNSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSError *error;
    NSDictionary *resultJSON = [[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error] objectAtIndex:0];
    NSLog(@"%@",resultJSON);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:[resultJSON objectForKey:@"X_RESULTINFO"]
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    [alert show];
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    if (HUD) {
        [HUD removeHUD];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:@"提交失败，请检查网络..."
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    [alert show];
}


@end
















@implementation SelectBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContent];
    
    return self;
}

-(void)loadContent
{
    gouImageV = [[UIButton alloc]initWithFrame:CGRectMake(0, 2.5, 15, 15)];
    [self addSubview:gouImageV];
    
    _questionLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 + gouImageV.frame.size.width, 0, self.frame.size.width - 25, self.frame.size.height)];
    [self addSubview:_questionLabel];
    _questionLabel.textColor = [UIColor whiteColor];
    _questionLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [gouImageV setImage:[UIImage imageNamed:@"sel_off"] forState:UIControlStateNormal];
    [gouImageV setImage:[UIImage imageNamed:@"sel_on"] forState:UIControlStateSelected];
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [gouImageV setSelected:selected];
}

@end
