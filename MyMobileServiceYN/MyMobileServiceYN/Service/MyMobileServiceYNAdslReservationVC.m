//
//  MyMobileServiceYNAdslReservationVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-22.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNAdslReservationVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNAdslReservationVC ()

@end

@implementation MyMobileServiceYNAdslReservationVC

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
    self.title = @"宽带预约";
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.backgroundColor = [UIColor clearColor];
    homeScrollView.delegate = self;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [self.view addSubview:homeScrollView];
    
    //手势，用户点击空白区域后 收起键盘
	UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
	tapGR.cancelsTouchesInView=NO;
	[homeScrollView addGestureRecognizer:tapGR];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 30)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = @"姓名：";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = UIColorFromRGB(rgbValueLightGrey);
    [homeScrollView addSubview:nameLabel];
    
    UITextView *nameTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH-40, 30)];
    [nameTextView setBackgroundColor:[UIColor clearColor]];
    nameTextView.tag = TEXTFIELD_TAG + 1;
    nameTextView.font = [UIFont fontWithName:appTypeFace size:20];
    nameTextView.textColor = [UIColor blackColor];
    nameTextView.secureTextEntry = NO;
    nameTextView.text = @"";
    nameTextView.keyboardType = UIKeyboardTypeDefault;
    nameTextView.returnKeyType = UIReturnKeyNext;
    nameTextView.delegate = self;
    [homeScrollView addSubview:nameTextView];
    
    UIView *line1 =[[UIView alloc]initWithFrame:CGRectMake(20,20+60-1, SCREEN_WIDTH-40, 1)];
    line1.backgroundColor = UIColorFromRGB(rgbValueGreyBg);
    [homeScrollView addSubview:line1];
    
    UILabel *idNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH-40, 30)];
    idNameLabel.backgroundColor = [UIColor clearColor];
    idNameLabel.text = @"身份证号码：";
    idNameLabel.textAlignment = NSTextAlignmentLeft;
    idNameLabel.textColor = UIColorFromRGB(rgbValueLightGrey);
    [homeScrollView addSubview:idNameLabel];
    
    UITextView *idTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 80+30, SCREEN_WIDTH-40, 30)];
    [idTextView setBackgroundColor:[UIColor clearColor]];
    idTextView.tag = TEXTFIELD_TAG + 2;
    idTextView.font = [UIFont fontWithName:appTypeFace size:20];
    idTextView.textColor = [UIColor blackColor];
    idTextView.secureTextEntry = NO;
    idTextView.text = @"";
    idTextView.keyboardType = UIKeyboardTypeNamePhonePad;
    idTextView.returnKeyType = UIReturnKeyNext;
    idTextView.delegate = self;
    [homeScrollView addSubview:idTextView];
    
    UIView *line2 =[[UIView alloc]initWithFrame:CGRectMake(20,80+60-1, SCREEN_WIDTH-40, 1)];
    line2.backgroundColor = UIColorFromRGB(rgbValueGreyBg);
    [homeScrollView addSubview:line2];
    
    UILabel *addressNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 80+60, SCREEN_WIDTH-40, 30)];
    addressNameLabel.backgroundColor = [UIColor clearColor];
    addressNameLabel.text = @"装机地址：";
    addressNameLabel.textAlignment = NSTextAlignmentLeft;
    addressNameLabel.textColor = UIColorFromRGB(rgbValueLightGrey);
    [homeScrollView addSubview:addressNameLabel];
    
    UITextView *addressTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 80+60+30, SCREEN_WIDTH-40, 60)];
    [addressTextView setBackgroundColor:[UIColor clearColor]];
    addressTextView.tag = TEXTFIELD_TAG + 3;
    addressTextView.font = [UIFont fontWithName:appTypeFace size:20];
    addressTextView.textColor = [UIColor blackColor];
    addressTextView.secureTextEntry = NO;
    addressTextView.scrollEnabled =  NO;//是否可以拖动
    addressTextView.text = @"";
    addressTextView.keyboardType = UIKeyboardTypeDefault;
    addressTextView.returnKeyType = UIReturnKeyDone;
    addressTextView.delegate = self;
    [homeScrollView addSubview:addressTextView];
    
    UIView *line3 =[[UIView alloc]initWithFrame:CGRectMake(20,80+60+30+60-1, SCREEN_WIDTH-40, 1)];
    line3.backgroundColor = UIColorFromRGB(rgbValueGreyBg);
    [homeScrollView addSubview:line3];
    
    LeeSegmentedControl *segment = [[LeeSegmentedControl alloc]initWithFrame:CGRectMake(20, 80+60+30+60+10, SCREEN_WIDTH-40, 44) items:@[               @{@"text":@"2M",@"icon":@"icon"},@{@"text":@"4M",@"icon":@"icon"},@{@"text":@"8M",@"icon":@"icon"},@{@"text":@"20M",@"icon":@"icon"}                               ] iconPosition:IconPositionLeft andSelectionBlock:^(NSUInteger segmentIndex) {}];
    segment.delegate = self;
    segment.backgroundColor = UIColorFromRGB(rgbValueGreyBg);
    segment.borderWidth = 1.0f;
    segment.borderColor = [UIColor lightGrayColor];
    segment.color = [UIColor blackColor];
    segment.textColor = [UIColor lightGrayColor];
    segment.lineColor = [UIColor lightGrayColor];
    segment.selectedColor = UIColorFromRGB(rgbValueButtonGreen);
    segment.textFont = [UIFont fontWithName:appTypeFace size:20.0f];
    [homeScrollView addSubview:segment];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame =CGRectMake(20, 80+60+30+60+10+44+20, SCREEN_WIDTH-40, 44);
    button.tag = BUTTON_TAG +1;
    button.titleLabel.font = [UIFont fontWithName:appTypeFace size:25.0];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.textColor = [UIColor whiteColor];
    UIImage *image =[self createImageWithColor:UIColorFromRGB(rgbValueButtonGreen)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:@"宽带预约提交" forState:UIControlStateNormal];
    [self setButtonBorder:button];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [homeScrollView addSubview:button];
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

#pragma mark---手势对应的触发时间
//手势对应的触发事件
//在空白处点击，收起键盘
-(void)viewTapped:(UITapGestureRecognizer *)tapGR
{
	[(UITextView *)[self.view viewWithTag:TEXTFIELD_TAG + 1] resignFirstResponder];
    [(UITextView *)[self.view viewWithTag:TEXTFIELD_TAG + 2] resignFirstResponder];
    [(UITextView *)[self.view viewWithTag:TEXTFIELD_TAG + 3] resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:homeScrollView];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    homeScrollView.frame = CGRectMake(homeScrollView.frame.origin.x, 0, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
    [UIView commitAnimations];
}
#pragma mark---UITextFieldDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //移动试图位置保证输入内容不被键盘遮挡
    CGFloat keyboardHeight = 216.0f;
    float moveHeight = 0.0f;
    
    if(!(homeScrollView.frame.size.height - keyboardHeight > (textView.tag-TEXTFIELD_TAG)*100))
    {
        if(homeScrollView.contentOffset.y==0){
            moveHeight = (textView.tag-TEXTFIELD_TAG)*100 - (homeScrollView.frame.size.height - keyboardHeight);
        }else{
            moveHeight = (textView.tag-TEXTFIELD_TAG)*100 - homeScrollView.contentOffset.y - (homeScrollView.frame.size.height - keyboardHeight);
        }
        // [UIView beginAnimations:@"scrollView" context:nil];
        //切换动画效果
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:homeScrollView];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.275f];
        homeScrollView.frame = CGRectMake(homeScrollView.frame.origin.x, -moveHeight, homeScrollView.frame.size.width, homeScrollView.frame.size.height);
        [UIView commitAnimations];
    }
    
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    //当开始点击textField会调用的方法
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    //当textField编辑结束时调用的方法
    //编辑完成后设置输入框内文本值，需要校验的也再这里进行校验
    
    
}

//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textViewShouldReturn:(UITextView *)textView{
    //判断return按钮状态并执行响应的操作
    if(textView.returnKeyType == UIReturnKeyNext){
        // Make something else first responder
        if (textView.tag>TEXTFIELD_TAG && textView.tag<TEXTFIELD_TAG+3) {
            [(UITextView *)[self.view viewWithTag:(textView.tag + 1)] becomeFirstResponder];
        }
    }else if(textView.returnKeyType == UIReturnKeyGo){
        // Do something
    }else{//done
        [textView resignFirstResponder];
    }
    return YES;
}

//判断超过多少字不允许输入
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.tag == TEXTFIELD_TAG + 1) {
        if (range.location >= 10)
            return NO; // return NO to not change text
        return YES;
    }else if (textView.tag == TEXTFIELD_TAG + 2) {
        if (range.location >= 18)
            return NO; // return NO to not change text
        return YES;
    }
    else{
        if (range.location >= 50)
            return NO; // return NO to not change text
        return YES;
    }
}

//segment代理方法
-(void)SelectSegmentedControlAtIndex:(NSInteger)index
{
    if(index==0){//
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonPressed:(id)sender
{
    UITextView *name = (UITextView *)[self.view viewWithTag:TEXTFIELD_TAG + 1];
    UITextView *idNumber = (UITextView *)[self.view viewWithTag:TEXTFIELD_TAG + 2];
    UITextView *address = (UITextView *)[self.view viewWithTag:TEXTFIELD_TAG + 3];
    
    //判断三个字段不为空，且IDNmuber为18位
    if ([name.text isEqualToString:@""]||[idNumber.text isEqualToString:@""]||[address.text isEqualToString:@""]) {
        NSString *message =[NSString stringWithFormat:@"用户信息不可为空，请填写后在提交!"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
        alertView.tag = ALERTVIEW_TAG+1;
        [alertView show];
    }else{
        if (idNumber.text.length != 18) {
            NSString *message =[NSString stringWithFormat:@"用户身份证号码输入有误，请确认后再提交!"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG+1;
            [alertView show];
        }else
        {
            NSString *message =[NSString stringWithFormat:@"是否确认提交宽带预约：\n姓名：%@\n身份证：%@\n装机地址：%@",name.text,idNumber.text,address.text];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
            alertView.tag = ALERTVIEW_TAG+2;
            [alertView show];
        }
    }
    
    
}


#pragma mark  -- AlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    DebugNSLog(@"test buttonIndex:%i",buttonIndex);
    if (ALERTVIEW_TAG + 1 == alertView.tag)
    {
        if (buttonIndex == 1) {
            
        }
    }
    else if (ALERTVIEW_TAG + 2 == alertView.tag)
    {
        if (buttonIndex == 1) {
            NSString *message =[NSString stringWithFormat:@"您的宽带预约已提交成功!"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG+1;
            [alertView show];
        }
    }
}


@end
