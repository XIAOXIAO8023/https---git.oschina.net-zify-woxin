//
//  FirstView.m
//  YearBill
//
//  Created by 陆楠 on 15/2/11.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "FirstView.h"
#import "FirstView01.h"
#import "FirstView02.h"
#import "SpinView.h"
#import "YearBillUserInfo.h"


@interface UILabel (a)

-(void)setTextColor:(UIColor *)textColor range:(NSRange) range;

-(void)setFont:(UIFont *)font range:(NSRange) range ;

-(void)setFont:(UIFont *)font textColor:(UIColor *)color range:(NSRange)range;

@end


@implementation UILabel (a)

-(void)setTextColor:(UIColor *)textColor range:(NSRange) range
{
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self.text];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithAttributedString:str];
    [text addAttribute:NSForegroundColorAttributeName
                 value:textColor
                 range:range];
    
    [self setAttributedText:text];
}

-(void)setFont:(UIFont *)font range:(NSRange) range
{
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self.text];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithAttributedString:str];
    [text addAttribute:NSFontAttributeName
                 value:font
                 range:range];
    [self setAttributedText:text];
}

-(void)setFont:(UIFont *)font textColor:(UIColor *)color range:(NSRange)range
{
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self.text];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithAttributedString:str];
    [text addAttribute:NSFontAttributeName
                 value:font
                 range:range];
    [self setAttributedText:text];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:color
                 range:range];
    
    [self setAttributedText:text];
    
}

@end
@implementation FirstView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self load2Views];
    
    [self addDayView];
    
    return self;
}


-(void)load2Views
{
    view_01 = [[FirstView01 alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    view_01.alpha = 0.0f;
    [self addSubview:view_01];
    
    view_02 = [[FirstView02 alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:view_02];
    
    [UIView animateWithDuration:6.0f
                     animations:^(void){
                         view_01.alpha = 1.0f;
                         view_02.alpha = 0.0f;
                     } completion:^(BOOL isFinished){
                         SpinView *sun = (SpinView *)[view_02 viewWithTag:11111];
                         [sun stopSpin];
                         [view_02 removeFromSuperview];
                     }
     ];
    
}


#pragma -
#pragma 添加天数统计
-(void)addDayView
{
    UIView *dayView = [[UIView alloc]initWithFrame:CGRectMake(0, ([[UIScreen mainScreen] bounds].size.height - 64) * 1 / 2, 320, 40)];
    [self addSubview:dayView];
    
    UILabel *label01 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    [dayView addSubview:label01];
    label01.textColor = [UIColor whiteColor];
    label01.text = @"不知不觉,";
    [label01 setTextAlignment:NSTextAlignmentCenter];
    label01.font = [UIFont fontWithName:@"Arial" size:18];
    
    UILabel *label02 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 20)];
    [dayView addSubview:label02];
    label02.textColor = [UIColor whiteColor];
    label02.text = [NSString stringWithFormat:@"我们携手走过%.0f天...",[YearBillUserInfo getOnlineYear]* 365];
    [label02 setTextAlignment:NSTextAlignmentCenter];
    label02.font = [UIFont fontWithName:@"Arial" size:18];
    
    NSMutableArray *a = [self getRangesOfNumberInString:label02.text];
    NSValue *value = [a objectAtIndex:0];
    NSRange r;
    [value getValue:&r];
    
    [label02 setFont:[UIFont fontWithName:@"Arial" size:24] textColor:[UIColor orangeColor] range:r];
    
    
    dayView.transform =CGAffineTransformMakeScale(0.1 ,0.1);
    
    [UIView animateWithDuration:5.0f
                     animations:^(void){
                         dayView.transform =CGAffineTransformMakeScale(1 ,1);
                     }
     ];
}

- (void)fallSnow
{
    if (view_01) {
        if (!view_01.isSnowing) {
            [view_01 fallSnow];
        }
    }else{
        NSLog(@"view_01 not exists...");
    }
}

-(void)stopSnow
{
    if (view_01) {
        if (view_01.isSnowing) {
            [view_01 stopSnow];
        }
    }else{
        NSLog(@"view_01 not exists...");
    }
}

-(NSMutableArray *)getRangesOfNumberInString:(NSString *)string
{
    NSMutableArray *rangeArr = [[NSMutableArray alloc]init];
    
    string = [string stringByAppendingString:@"#"];//加个结束字符
    
    NSString *temp = nil;
    NSUInteger location = 0;
    NSUInteger length = 0;
    int currentBit = 0;//0表示非数字字符，1表示数字字符
    BOOL isFirstNum = YES;
    NSRange range = NSMakeRange(0, 0);
    
    for(int i =0; i < [string length]; i++)
    {
        temp = [string substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"0"] || [temp isEqualToString:@"1"] ||
            [temp isEqualToString:@"2"] || [temp isEqualToString:@"3"] ||
            [temp isEqualToString:@"4"] || [temp isEqualToString:@"5"] ||
            [temp isEqualToString:@"6"] || [temp isEqualToString:@"7"] ||
            [temp isEqualToString:@"8"] || [temp isEqualToString:@"9"] ||
            [temp isEqualToString:@"."]
            ) {
            currentBit = 1;//当前字符是数字
            if (isFirstNum) {//第一次遇到数字
                location = i;//记录位置
            }
            length ++ ;//长度加1
            isFirstNum = NO;//以后就不是第一个数字了
            range = NSMakeRange(location, length);//记录range
        }else{
            if (currentBit == 1) {//前一字符是数字才处理
                if (range.length != 0){
                    NSValue *value = [NSValue valueWithRange:range];
                    [rangeArr addObject:value];
                    range = NSMakeRange(0, 0);
                    length = 0;//length清0
                    location = 0;
                }
            }
            currentBit = 0;//当前字符不是数字
            isFirstNum = YES;//下次遇到数字就是第一个数字，需要记录一个range
        }
    }
    
    return rangeArr;
}

@end




