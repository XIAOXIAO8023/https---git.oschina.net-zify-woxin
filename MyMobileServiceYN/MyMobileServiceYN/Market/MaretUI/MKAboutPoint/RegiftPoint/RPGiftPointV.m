//
//  RPGiftPointV.m
//  Market
//
//  Created by 陆楠 on 15/3/25.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "RPGiftPointV.h"
#import "MKImageAndLabelButton.h"
#import "RPGiftPointRecordVC.h"
#import "ControllerUtils.h"
#import "RPRuleV.h"
#import "LNAnimationUtils.h"
#import "ImageUtils.h"
#import "MKUserInfo.h"
#import "GlobalDef.h"

@implementation RPGiftPointV

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContent];
    
    return self;
}

-(void)SetPhoneNumber:(NSString *)phoneNumber
{
    _phoneNumber = phoneNumber;
    personT.text = _phoneNumber;
}

-(void)loadContent
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(totalPointChanged:) name:@"totalPointChanged" object:nil];
    
    [self setUpForDismissKeyboard];
    
    [self loadHeadV];
    
    [self loadBtnBelowHead];
    
    [self loadMainScroll];
    
}

-(void)loadHeadV
{
    head = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 78)];
    [self addSubview:head];
    head.image = [UIImage imageNamed:@"top_bg"];
    
    UILabel *headL = [[UILabel alloc]initWithFrame:head.bounds];
    [head addSubview:headL];
    headL.textAlignment = NSTextAlignmentCenter;
    headL.font = [UIFont fontWithName:@"Arial" size:20];
    headL.textColor = [UIColor whiteColor];
    headL.tag = 10000;
    [self setHeadL];
}

-(void)setHeadL
{
    UILabel *l = (UILabel *)[head viewWithTag:10000];
    NSString *s = [NSString stringWithFormat:@"我的积分: %ld",(long)[MKUserInfo getTotalPoint]];
    NSMutableAttributedString *ss = [[NSMutableAttributedString alloc]initWithString:s];
    NSRange range = [s rangeOfString:[NSString stringWithFormat:@"%ld",(long)[MKUserInfo getTotalPoint]]];
    
    [ss addAttribute:NSFontAttributeName
               value:[UIFont fontWithName:@"Arial" size:34]
               range:range];
    [l setAttributedText:ss];
}

-(void)loadBtnBelowHead
{
    MKImageAndLabelButton *left = [[MKImageAndLabelButton alloc]initWithFrame:CGRectMake(-0.5, head.frame.size.height + head.frame.origin.y, 160.5, 40)];
    [self addSubview:left];
    left.layer.borderWidth = 0.5f;
    left.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    left.title = @"转赠规则";
    left.titleImage = [UIImage imageNamed:@"icon-help"];
    left.tag = 101;
    [left addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    MKImageAndLabelButton *right = [[MKImageAndLabelButton alloc]initWithFrame:CGRectMake(159.5, head.frame.size.height + head.frame.origin.y, 161, 40)];
    [self addSubview:right];
    right.layer.borderWidth = 0.5f;
    right.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    right.title = @"历史记录";
    right.titleImage = [UIImage imageNamed:@"icon_lsjlcx"];
    right.tag = 102;
    [right addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)loadMainScroll
{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 118, 320, self.frame.size.height - 90)];
    [self addSubview:scroll];
    
    personT = [[UITextField alloc]initWithFrame:CGRectMake(40, 30, 200, 30)];
    [scroll addSubview:personT];
    personT.layer.borderWidth = 0.5f;
    personT.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [personT setKeyboardType:UIKeyboardTypeNumberPad];
    personT.tag = 201;
    personT.delegate = self;
    personT.placeholder = @"  受让人手机号码";
    
    
    UIButton *personB = [[UIButton alloc]initWithFrame:CGRectMake(240, 29.5, 40, 31)];
    [scroll addSubview:personB];
    [personB setImage:[UIImage imageNamed:@"people"] forState:UIControlStateNormal];
    personB.tag = 103;
    [personB addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    wrongL01 = [[UILabel alloc]initWithFrame:CGRectMake(80, 60, 160, 20)];
    [scroll addSubview:wrongL01];
    [wrongL01 setFont:[UIFont fontWithName:@"Arial" size:10]];
    wrongL01.textColor = [UIColor redColor];
    correct01 = NO;
    
    pointT = [[UITextField alloc]initWithFrame:CGRectMake(40, 80, 240, 30)];
    [scroll addSubview:pointT];
    pointT.layer.borderWidth = 0.5f;
    pointT.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [pointT setKeyboardType:UIKeyboardTypeNumberPad];
    pointT.tag = 202;
    pointT.delegate = self;
    pointT.placeholder = [NSString stringWithFormat:@"  本次最多可转%ld",(long)([MKUserInfo getTotalPoint]>20000?20000:[MKUserInfo getTotalPoint])];
    
    wrongL02 = [[UILabel alloc]initWithFrame:CGRectMake(80, 110, 160, 20)];
    [scroll addSubview:wrongL02];
    [wrongL02 setFont:[UIFont fontWithName:@"Arial" size:10]];
    wrongL02.textColor = [UIColor redColor];
    correct02 = NO;
    
    captchaT = [[UITextField alloc]initWithFrame:CGRectMake(40, 130, 150, 30)];
    [scroll addSubview:captchaT];
    captchaT.layer.borderWidth = 0.5f;
    captchaT.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [captchaT setKeyboardType:UIKeyboardTypeNumberPad];
    captchaT.tag = 203;
    captchaT.delegate = self;
    captchaT.placeholder = @"  验证码";
    
    CaptchaButton *captchaB = [[CaptchaButton alloc]initWithFrame:CGRectMake(190, 130, 90, 30)];
    [scroll addSubview:captchaB];
    captchaB.countdown = 60;
    captchaB.tag = 104;
    [captchaB addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    correct03 = NO;
    
    wrongL03 = [[UILabel alloc]initWithFrame:CGRectMake(80, 160, 90, 20)];
    [scroll addSubview:wrongL03];
    [wrongL03 setFont:[UIFont fontWithName:@"Arial" size:10]];
    wrongL03.textColor = [UIColor redColor];
    
    commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 200, 240, 40)];
    [scroll addSubview:commitBtn];
    commitBtn.layer.cornerRadius = commitBtn.frame.size.height / 2;
    commitBtn.clipsToBounds = YES;
    [commitBtn setTitle:@"确认转赠" forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:[ImageUtils imageWithColor:UIColorFromRGB(0x3dc1ef) size:self.bounds.size] forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:[ImageUtils imageWithColor:UIColorFromRGB(0xe7e7e7) size:self.bounds.size] forState:UIControlStateSelected];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setUserInteractionEnabled:NO];
    [commitBtn setSelected:YES];
    commitBtn.tag = 105;
    [commitBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 按钮事件响应
-(void)buttonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 101) {
        RPRuleV *r = [[RPRuleV alloc]initWithFrame:self.bounds];
        [self addSubview:r];
        [LNAnimationUtils view:r showWithType:LNAnimationUtilsShowTypeFrom70Percent options:UIViewAnimationOptionCurveEaseIn inTime:0.2f completion:nil];
    }else if (btn.tag == 102){
        RPGiftPointRecordVC *gpr = [[RPGiftPointRecordVC alloc]init];
        UINavigationController *na = [ControllerUtils findViewControllerWithSourceView:self];
        [na pushViewController:gpr animated:YES];
    }else if (btn.tag == 103){
        personPicker = [[ABPeoplePickerNavigationController alloc]init];
        personPicker.peoplePickerDelegate = self;
        [personPicker setDisplayedProperties:[NSArray arrayWithObject:[NSNumber numberWithInteger:kABPersonPhoneProperty]]];
        UINavigationController *na = [ControllerUtils findViewControllerWithSourceView:self];
        [na presentViewController:personPicker animated:YES completion:nil];
    }else if (btn.tag == 104){
        NSLog(@"获取验证码...");
        [((CaptchaButton *)btn) startCount];
        [self.delegate RPGiftPointVButtonPressed:@{@"action":@"getCaptcha"}];
    }else if (btn.tag == 105){
        NSLog(@"提交转赠信息...");
        [self endEditing:YES];
        [self.delegate RPGiftPointVButtonPressed:@{@"action":@"commit",
                                                   @"person":personT.text,
                                                   @"point":pointT.text,
                                                   @"captcha":captchaT.text}];
    }
}


-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef values=ABRecordCopyValue(person, property);
    CFIndex ix=ABMultiValueGetIndexForIdentifier(values, identifier);
    CFStringRef value=ABMultiValueCopyValueAtIndex(values, ix);
    
    NSMutableString *s = [[NSMutableString alloc]initWithString:(__bridge NSString *)(value)];
    NSString *ss = [s stringByReplacingOccurrencesOfString:@"-" withString:@"" options:NSCaseInsensitiveSearch range:[s rangeOfString:s]];
    
    personT.text = ss;
    
    if (ss.length != 11) {
        wrongL01.text = @"请输入11位电话号码";
        correct01 = NO;
    }else{
        correct01 = YES;
    }
    
    UINavigationController *na = [ControllerUtils findViewControllerWithSourceView:self];
    [na dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    UINavigationController *na = [ControllerUtils findViewControllerWithSourceView:self];
    [na dismissViewControllerAnimated:YES completion:nil];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef values=ABRecordCopyValue(person, property);
    CFIndex ix=ABMultiValueGetIndexForIdentifier(values, identifier);
    CFStringRef value=ABMultiValueCopyValueAtIndex(values, ix);
    
    NSMutableString *s = [[NSMutableString alloc]initWithString:(__bridge NSString *)(value)];
    NSString *ss = [s stringByReplacingOccurrencesOfString:@"-" withString:@"" options:NSCaseInsensitiveSearch range:[s rangeOfString:s]];
    
    personT.text = ss;
    
    if (ss.length != 11) {
        wrongL01.text = @"请输入11位电话号码";
        correct01 = NO;
    }else{
        correct01 = YES;
    }
}

#endif

-(void)totalPointChanged:(NSNotificationCenter *)notification
{
    [self setHeadL];
}


#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 203) {
        [UIView animateWithDuration:0.275f animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 98, self.frame.size.width, self.frame.size.height);
        }];
    }else if (textField.tag == 202){
        [UIView animateWithDuration:0.275f animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 48, self.frame.size.width, self.frame.size.height);
        }];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag != 201) {
        if (self.frame.origin.y != 0) {
            [UIView animateWithDuration:0.275f animations:^{
                self.frame = CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height);
            }];
        }
    }
    
    [self setCommitBtnState];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == 201) {
        if (toBeString.length != 11) {
            wrongL01.text = @"请输入11位电话号码";
            correct01 = NO;
        }else{
            wrongL01.text = @"";
            correct01 = YES;
        }
    }else if (textField.tag == 202){
        if ((toBeString.integerValue > 19890) || (toBeString.integerValue < 1)) {
            NSInteger to = ([MKUserInfo getTotalPoint]>20000)?20000:[MKUserInfo getTotalPoint];
            wrongL02.text = [NSString stringWithFormat:@"请输入 1~%ld 的正整数",(long)to];
            correct02 = NO;
        }else{
            wrongL02.text = @"";
            correct02 = YES;
        }
    }else if (textField.tag == 203){
        if (toBeString.length == 0) {
            wrongL03.text = @"验证码不能为空";
            correct03 = NO;
        }else{
            wrongL03.text = @"";
            correct03 = YES;
        }
    }
    
    return YES;
}

-(void)setCommitBtnState
{
    if (correct01 && correct02 && correct03) {
        [commitBtn setSelected:NO];
        [commitBtn setUserInteractionEnabled:YES];
    }else{
        [commitBtn setSelected:YES];
        [commitBtn setUserInteractionEnabled:NO];
    }
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


#pragma mark -


@implementation CaptchaButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[ImageUtils imageWithColor:UIColorFromRGB(0xe7e7e7) size:self.bounds.size] forState:UIControlStateNormal];
    [self setBackgroundImage:[ImageUtils imageWithColor:UIColorFromRGB(0xe7e7e7) size:self.bounds.size] forState:UIControlStateSelected];
    
    return self;
}

-(void)setCountdown:(NSTimeInterval)countdown
{
    _countdown = countdown;
    currentTime = _countdown;
}

-(void)startCount
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(currentTime == 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setSelected:NO];
                [self setUserInteractionEnabled:YES];
                currentTime = _countdown;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUserInteractionEnabled:NO];
                [self setTitle:[NSString stringWithFormat:@"重新获取(%.0f)",currentTime] forState:UIControlStateSelected];
                [self setSelected:YES];
                currentTime-- ;
            });
        }
    });
    dispatch_resume(_timer);
}


@end









