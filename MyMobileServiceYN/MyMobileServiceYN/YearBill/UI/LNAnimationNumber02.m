//
//  LNAnimationNumber02.m
//  YearBill
//
//  Created by 陆楠 on 15/3/12.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "LNAnimationNumber02.h"

@implementation LNAnimationNumber02
{
    CGFloat _proNumber;
    CGFloat _proNumber02;
}

#pragma - 初始化函数
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setDefaultSettings];
    
    return self;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    [self setDefaultSettings];
    
    return self;
}


-(instancetype)init
{
    self = [super init];
    
    [self setDefaultSettings];
    
    return self;
}

-(void)setDefaultSettings
{
    _number = 0.0f;
    _duration = 1.0f;
    _proNumber = 0.0f;
    _numberOfDecimalPlaces = numberOfDecimalPlacesZero;
    _specialCharacters = @"";
    _numberColor = self.textColor;
    _numberFont = self.font;
    _followString = @"";
    _midString = @"";
    _foreString = @"";
    isMultColor = NO;
    _numberFont = self.font;
    
    self.text = [NSString stringWithFormat:@"%.0f%@",_number,_specialCharacters];
}

#pragma - 初始化数字以及动画时间
-(void)setNumber:(CGFloat)number number02:(CGFloat)number02 withDuration:(NSTimeInterval)duration
{
    _number = number;
    _number02 = number02;
    _duration = duration;
}

-(void)setNumberColor:(UIColor *)numberColor
{
    _numberColor = numberColor;
    isMultColor = YES;
}

- (void)showInitContent
{
    if (_numberOfDecimalPlaces == numberOfDecimalPlacesZero) {
        self.text = [NSString stringWithFormat:@"%@%.0f%@%@%.0f%@%@",_foreString,0.0,_specialCharacters,_midString,0.0,_specialCharacters,_followString];
    }else if (_numberOfDecimalPlaces == numberOfDecimalPlacesOne){
        self.text = [NSString stringWithFormat:@"%@%.1f%@%@%.1f%@%@",_foreString,0.0,_specialCharacters,_midString,0.0,_specialCharacters,_followString];
    }else{
        self.text = [NSString stringWithFormat:@"%@%.2f%@%@%.2f%@%@",_foreString,0.0,_specialCharacters,_midString,0.0,_specialCharacters,_followString];
    }
    
    if (isMultColor) {
        NSMutableArray *a = [self getRangesOfNumberInString:self.text];
        [self setFont:_numberFont textColor:_numberColor ranges:a];
    }
}

#pragma - 播放动画
-(void)startAnimation
{
    _proNumber = 0.0f;
    _proNumber02 = 0.0f;
    //将数字的跳变放入线程,降低阻塞干扰
    [NSThread detachNewThreadSelector:@selector(animationWithThread) toTarget:self withObject:nil];
}

-(void)animationWithThread
{
    if (_duration == 0.0f) {
        return;
    }
    
    NSTimeInterval duration;
    NSNumber *number;
    NSNumber *number02;
    //如果数字较小，跳变的次数少一点
    if (_number <= 1000) {
        duration = _duration / 15;
        number = @(_number / 15);
        number02 = @(_number02 / 15);
    }else{
        duration = _duration / 20;
        number = @(_number / 20);
        number02 = @(_number02 / 20);
    }
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                      target:self
                                                    selector:@selector(numberProgress:)
                                                    userInfo:[NSArray arrayWithObjects:number,number02,nil]
                                                     repeats:YES];
    //设定线程的生命周期
    [[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:_duration]];
    //当所设定的duration结束以后，释放定时器
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_duration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [timer invalidate];
        if (_numberOfDecimalPlaces == numberOfDecimalPlacesZero) {
            self.text = [NSString stringWithFormat:@"%@%.0f%@%@%.0f%@%@",_foreString,_number,_specialCharacters,_midString,_number02,_specialCharacters,_followString];
        }else if (_numberOfDecimalPlaces == numberOfDecimalPlacesOne){
            self.text = [NSString stringWithFormat:@"%@%.1f%@%@%.1f%@%@",_foreString,_number,_specialCharacters,_midString,_number02,_specialCharacters,_followString];
        }else{
            self.text = [NSString stringWithFormat:@"%@%.2f%@%@%.2f%@%@",_foreString,_number,_specialCharacters,_midString,_number02,_specialCharacters,_followString];
        }
        
        if (isMultColor) {
            NSMutableArray *a = [self getRangesOfNumberInString:self.text];
            [self setFont:_numberFont textColor:_numberColor ranges:a];
        }
    });
}

-(void)numberProgress:(NSTimer *)timer
{
    _proNumber += [[[timer userInfo] objectAtIndex:0] floatValue];
    _proNumber02 += [[[timer userInfo] objectAtIndex:1] floatValue];
    if(_proNumber >= _number){
        _proNumber = _number;
    }
    if(_proNumber02 >= _number02){
        _proNumber02 = _number02;
    }
    
    if (_numberOfDecimalPlaces == numberOfDecimalPlacesZero) {
        self.text = [NSString stringWithFormat:@"%@%.0f%@%@%.0f%@%@",_foreString,_proNumber,_specialCharacters,_midString,_proNumber02,_specialCharacters,_followString];
    }else if (_numberOfDecimalPlaces == numberOfDecimalPlacesOne){
        self.text = [NSString stringWithFormat:@"%@%.1f%@%@%.1f%@%@",_foreString,_proNumber,_specialCharacters,_midString,_proNumber02,_specialCharacters,_followString];
    }else{
        self.text = [NSString stringWithFormat:@"%@%.2f%@%@%.2f%@%@",_foreString,_proNumber,_specialCharacters,_midString,_proNumber02,_specialCharacters,_followString];
    }
    
    if (isMultColor) {
        NSMutableArray *a = [self getRangesOfNumberInString:self.text];
       
        [self setFont:_numberFont textColor:_numberColor ranges:a];
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
            [temp isEqualToString:@"."] || [temp isEqualToString:_specialCharacters]
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
    
    [self setAttributedText:[[NSAttributedString alloc] initWithString:@""]];
    [self setAttributedText:text];
    
}

-(void)setFont:(UIFont *)font textColor:(UIColor *)color ranges:(NSArray *)ranges
{
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self.text];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithAttributedString:str];
    for (int i = 0; i < ranges.count; i++) {
        NSValue *v = [ranges objectAtIndex:i];
        NSRange r;
        [v getValue:&r];
        
        [text addAttribute:NSFontAttributeName
                     value:font
                     range:r];
        
        [text addAttribute:NSForegroundColorAttributeName
                     value:color
                     range:r];
    }
    
    [self setAttributedText:[[NSAttributedString alloc] initWithString:@""]];
    [self setAttributedText:text];
    
}

@end
