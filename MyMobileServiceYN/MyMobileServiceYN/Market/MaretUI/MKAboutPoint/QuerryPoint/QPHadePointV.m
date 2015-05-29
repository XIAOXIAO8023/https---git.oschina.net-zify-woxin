//
//  QPHadePoint.m
//  Market
//
//  Created by 陆楠 on 15/3/24.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "QPHadePointV.h"
#import "MKUserInfo.h"
#import "GlobalDef.h"

@implementation QPHadePointV

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContentV];
    
    return self;
}

-(void)setPointArry:(NSArray *)pointArry
{
    _pointArry = pointArry;
    
    if (totalPointL) {
        [totalPointL removeFromSuperview];
    }
    
    totalPointL = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 200, 30)];
    [self addSubview:totalPointL];
    totalPointL.font = [UIFont fontWithName:@"Arial" size:14];
    totalPointL.textColor = UIColorFromRGB(0x595959);
    NSString *s = [NSString stringWithFormat:@"可兑换积分: %ld",(long)[MKUserInfo getTotalPoint]];
    NSMutableAttributedString *ss = [[NSMutableAttributedString alloc]initWithString:s];
    NSRange range = [s rangeOfString:[NSString stringWithFormat:@"%ld",(long)[MKUserInfo getTotalPoint]]];
    
    [ss addAttribute:NSFontAttributeName
               value:[UIFont fontWithName:@"Arial" size:18]
               range:range];
    [ss addAttribute:NSForegroundColorAttributeName
               value:UIColorFromRGB(0xfc6b9f)
               range:range];
    [totalPointL setAttributedText:ss];
    
    if (pointDetailV) {
        [pointDetailV removeFromSuperview];
    }
    
    pointDetailV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, 320, self.frame.size.height - 70)];
    [self addSubview:pointDetailV];
    
    PointListV *list = [[PointListV alloc]initWithFrame:CGRectMake(20, 0, 280, 100)];
    list.pointArry = _pointArry;
    [pointDetailV addSubview:list];
    pointDetailV.contentSize = list.bounds.size;
}


-(void)loadContentV
{
//    UIButton *goBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, self.frame.size.height - 40, 280, 30)];
//    [self addSubview:goBtn];
//    goBtn.backgroundColor = [UIColor blueColor];
//    [goBtn setTitle:@"去兑换流量话费吧" forState:UIControlStateNormal];
    
}


@end





@implementation PointListV

-(void)setPointArry:(NSArray *)pointArry
{
    _pointArry = pointArry;
    
    UILabel *labelPoint = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, 40)];
    [self addSubview:labelPoint];
    labelPoint.text = @"积分值";
    labelPoint.textAlignment = NSTextAlignmentCenter;
    labelPoint.layer.borderWidth = 0.4f;
    labelPoint.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    labelPoint.textColor = UIColorFromRGB(0x595959);
    
    UILabel *labelDate = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 0.5f, 0, self.frame.size.width / 2 + 0.5f, 40)];
    [self addSubview:labelDate];
    labelDate.text = @"到期日";
    labelDate.textAlignment = NSTextAlignmentCenter;
    labelDate.layer.borderWidth = 0.4f;
    labelDate.layer.borderColor = [UIColor lightGrayColor].CGColor;
    labelDate.textColor = UIColorFromRGB(0x595959);
    
    CGFloat tmpH = 39.5;
    
    NSMutableArray *afterArry = [[NSMutableArray alloc]init];
    [afterArry addObject:@{@"SCORE_VALUE":@"0",@"END_DATE":@"2050-01-01",@"NAME":@"消费积分"}];
    for (NSDictionary *dic in _pointArry) {
        if (![[dic objectForKey:@"NAME"] isEqualToString:@"促销积分"]) {
            NSString *e = [[dic objectForKey:@"END_DATE"] substringWithRange:NSMakeRange(0, 4)];
            if (e.integerValue >= 2050) {
                NSString *score = [NSString stringWithFormat:@"%ld",(long)([(NSString *)[[afterArry objectAtIndex:0] objectForKey:@"SCORE_VALUE"] integerValue] + [(NSString *)[dic objectForKey:@"SCORE_VALUE"] integerValue])];
                NSMutableDictionary *mudic = [[NSMutableDictionary alloc]initWithDictionary:[afterArry objectAtIndex:0]];
                [mudic setObject:score forKey:@"SCORE_VALUE"];
                [afterArry setObject:mudic atIndexedSubscript:0];
            }else{
                [afterArry addObject:dic];
            }
        }else{
            [afterArry addObject:dic];
        }
    }
    
    for (NSInteger i = 0; i < afterArry.count; i ++) {
        UILabel *labelL = [[UILabel alloc]initWithFrame:CGRectMake(0, tmpH, self.frame.size.width / 2, 40)];
        [self addSubview:labelL];
        labelL.text = [[afterArry objectAtIndex:i] objectForKey:@"SCORE_VALUE"];
        labelL.textAlignment = NSTextAlignmentCenter;
        labelL.layer.borderWidth = 0.4f;
        labelL.layer.borderColor = [UIColor lightGrayColor].CGColor;
        labelL.textColor = UIColorFromRGB(0x595959);
        
        UILabel *labelR = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 0.5f, tmpH, self.frame.size.width / 2 + 0.5f, 40)];
        [self addSubview:labelR];
        
        NSString *endDate = [[[afterArry objectAtIndex:i] objectForKey:@"END_DATE"]substringWithRange:NSMakeRange(0, 10)];
        if (![[[afterArry objectAtIndex:i] objectForKey:@"NAME"] isEqualToString:@"促销积分"]) {
            NSString *e = [endDate substringWithRange:NSMakeRange(0, 4)];
            if (e.integerValue >= 2050) {
                endDate = @"无";
            }
        }
        labelR.text = endDate;
        labelR.textAlignment = NSTextAlignmentCenter;
        labelR.layer.borderWidth = 0.4f;
        labelR.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        labelR.textColor = UIColorFromRGB(0x595959);
        tmpH += 39.5;
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, tmpH);
    
}

@end






