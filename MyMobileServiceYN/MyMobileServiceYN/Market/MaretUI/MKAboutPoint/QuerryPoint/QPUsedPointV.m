//
//  QPUsedPointV.m
//  Market
//
//  Created by 陆楠 on 15/3/25.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "QPUsedPointV.h"
#import "GlobalDef.h"

@implementation QPUsedPointV

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContentV];
    
    return self;
}


-(void)setPointArry:(NSArray *)pointArry
{
    _pointArry = pointArry;
    
    if (pointDetailV) {
        [pointDetailV removeFromSuperview];
    }
    
    pointDetailV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 35, 320, self.frame.size.height - 35)];
    [self addSubview:pointDetailV];
    
    CGFloat tmpH = 0;
    for (NSInteger i = 0; i < _pointArry.count; i++) {
        PointUsedListItem *item = [[PointUsedListItem alloc]initWithFrame:CGRectMake(-0.5, tmpH, 321, 60)];
        [pointDetailV addSubview:item];
        item.layer.borderWidth = 0.5f;
        item.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        item.infoDic = [_pointArry objectAtIndex:i];
        tmpH += 59.5;
    }
    pointDetailV.contentSize = CGSizeMake(320, tmpH);
}


-(void)loadContentV
{
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
    [self addSubview:l];
    l.text = @"近半年内使用明细:";
    l.font = [UIFont fontWithName:@"Arial" size:14];
    l.textColor = UIColorFromRGB(0x595959);
}

@end








@implementation PointUsedListItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContent];
    
    return self;
}



-(void)loadContent
{
    pointL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, self.frame.size.height * 0.6)];
    [self addSubview:pointL];
    pointL.textAlignment = NSTextAlignmentCenter;
    pointL.font = [UIFont fontWithName:@"Arial" size:24];
    pointL.textColor = UIColorFromRGB(0x88bd18);
    
    usedTimeL = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.6, 120, self.frame.size.height * 0.4)];
    [self addSubview:usedTimeL];
    usedTimeL.textAlignment = NSTextAlignmentCenter;
    usedTimeL.font = [UIFont fontWithName:@"Arial" size:12];
    usedTimeL.textColor = UIColorFromRGB(0x595959);
    
    reasonL = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 200, self.frame.size.height)];
    [self addSubview:reasonL];
    reasonL.textAlignment = NSTextAlignmentCenter;
    reasonL.numberOfLines = 0;
    reasonL.lineBreakMode = UILineBreakModeWordWrap;
    reasonL.font = [UIFont fontWithName:@"Arial" size:14];
    reasonL.textColor = UIColorFromRGB(0x595959);
}

-(void)setInfoDic:(NSDictionary *)infoDic
{
    _infoDic = infoDic;
    
    pointL.text = [NSString stringWithFormat:@"-%@",[_infoDic objectForKey:@"SCORE_VALUE"]];
    
    reasonL.text = [_infoDic objectForKey:@"TRADE_TYPE"];
    
    usedTimeL.text = [NSString stringWithFormat:@"%@使用",[((NSString *)[_infoDic objectForKey:@"TRADE_DATE"]) substringWithRange:NSMakeRange(0, 10)]];
}

@end













