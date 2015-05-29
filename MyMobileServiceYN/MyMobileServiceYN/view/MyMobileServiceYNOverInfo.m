//
//  MyMobileServiceYNOverInfo.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNOverInfo.h"
#import "PNChart.h"
#import "GlobalDef.h"
#import "DateDeal.h"

@implementation MyMobileServiceYNOverInfo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setOverInfoView:(PackageElementsType) type andTotal:(NSInteger)total andCurrent:(NSInteger)current
{
    NSString *nameText = @"";
    NSString *promptText = @"";
    UIColor *color = PNRed;
    NSString *unit = @"";
    CGFloat a=current;
    CGFloat b=total;
    CGFloat c=[DateDeal getDays];
    CGFloat d=[DateDeal getDay];
    if (PackageElementsTypeGprs == type) {
        nameText = @"剩余（M）";
        if(a>b){
            promptText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptText =@"真是原始人的节奏啊，竟没有使用通话~~";
        }
        color = UIColorFromRGB(rgbValue_overInfoBule);
        unit = @"M";
    }
    if (PackageElementsTypeCall == type) {
        nameText = @"剩余（分）";
        if(a>b){
            promptText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptText =@"真是原始人的节奏啊，竟没有使用通话~~";
        }
        color = UIColorFromRGB(rgbValue_overInfoGreen);
        unit = @"分";
    }
    if (PackageElementsTypeSms == type) {
        nameText = @"剩余（条）";
        if(a>b){
            promptText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptText =@"真是原始人的节奏啊，竟没有使用通话~~";
        }
        color = UIColorFromRGB(rgbValue_overInfoYellow);
        unit = @"条";
    }
    if (PackageElementsTypeMsms == type) {
        nameText = @"剩余（条）";
        if(a>b){
            promptText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptText =@"真是原始人的节奏啊，竟没有使用通话~~";
        }
        color = UIColorFromRGB(rgbValue_overInfoYellow);
        unit = @"条";
    }
    if (PackageElementsTypeWlan == type) {
        nameText = @"剩余（分）";
        if(a>b){
            promptText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptText =@"真是原始人的节奏啊，竟没有使用通话~~";
        }
        color = UIColorFromRGB(rgbValue_overInfoBule);
        unit = @"分";
    }
    if (PackageElementsTypeWlanM == type) {
        nameText = @"剩余（M）";
        if(a>b){
            promptText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptText =@"真是原始人的节奏啊，竟没有使用通话~~";
        }        color = UIColorFromRGB(rgbValue_overInfoBule);
        unit = @"M";
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    
    PNCircleChart * overInfoCircleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(5, 7, 90, 90) andTotal:[NSNumber numberWithInt:total] andCurrent:[NSNumber numberWithInt:current]];
    overInfoCircleChart.backgroundColor = [UIColor clearColor];
    
    if (current > 0.75*total) {
        [overInfoCircleChart setStrokeColor:UIColorFromRGB(rgbValue_overInfoOrange)];
    }else{
         [overInfoCircleChart setStrokeColor:UIColorFromRGB(rgbValue_overInfoGreen)];
    }
    [overInfoCircleChart strokeChart];
    [view addSubview:overInfoCircleChart];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(35, 30, 40, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font =[UIFont fontWithName:appTypeFace size:15];
    label.textColor = UIColorFromRGB(rgbValueLightGrey);
    label.text = @"已用";
    [view addSubview:label];
    
    UIView *textView =[[UIView alloc]initWithFrame:CGRectMake(120, 0, 200, self.frame.size.height)];
    textView.backgroundColor = [UIColor clearColor];
    
    UILabel *overInfoNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 20)];
    overInfoNameLabel.backgroundColor =[UIColor clearColor];
    overInfoNameLabel.text = nameText;
    overInfoNameLabel.textColor = UIColorFromRGB(rgbValue_packageInfo_headerLabel);
    overInfoNameLabel.font = [UIFont fontWithName:appTypeFace size:18.0];
    [textView addSubview:overInfoNameLabel];
    
    UILabel *overInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 140, 40)];
    overInfoLabel.textAlignment = NSTextAlignmentLeft;
    overInfoLabel.backgroundColor =[UIColor clearColor];
    if (total-current<=0) {
        overInfoLabel.text = @"0";
    }else{
        overInfoLabel.text = [NSString stringWithFormat:@"%d",total - current];
    }
    overInfoLabel.textColor = UIColorFromRGB(rgbValue_packageInfo_headerLabel);
    overInfoLabel.font = [UIFont fontWithName:appTypeFace size:40.0];
    [textView addSubview:overInfoLabel];
    CGSize size=CGSizeMake(140, 40);
    UIFont *font=[UIFont fontWithName:appTypeFace size:40];
    CGSize labelSize=[overInfoLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    overInfoLabel.frame=CGRectMake(10, 40, labelSize.width, 40);
    
    UILabel *overInfoUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelSize.width+10, 55, 180-labelSize.width, 20)];
    overInfoUnitLabel.textAlignment = NSTextAlignmentLeft;
    overInfoUnitLabel.backgroundColor =[UIColor clearColor];
    overInfoUnitLabel.text = [NSString stringWithFormat:@"/%d",total];
    overInfoUnitLabel.textColor = UIColorFromRGB(rgbValueLightGrey);
    overInfoUnitLabel.font = [UIFont fontWithName:appTypeFace size:20.0];
    overInfoUnitLabel.adjustsFontSizeToFitWidth=YES;
    [textView addSubview:overInfoUnitLabel];
    
    if (![promptText isEqualToString:@""]) {
        UILabel *overInfoPromptLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 190, 20)];
        overInfoPromptLabel.textAlignment = NSTextAlignmentLeft;
        overInfoPromptLabel.backgroundColor =[UIColor clearColor];
        overInfoPromptLabel.text = promptText;
        overInfoPromptLabel.textColor = UIColorFromRGB(rgbValue_overInfoOrange);
        overInfoPromptLabel.font = [UIFont fontWithName:appTypeFace size:14.0];
        overInfoPromptLabel.adjustsFontSizeToFitWidth=YES;
        [textView addSubview:overInfoPromptLabel];
    }
    [view addSubview:textView];

    [self addSubview:view];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
