//
//  MyMobileServiceYNPackageDetailInfo.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNPackageDetailInfo.h"
#import "GlobalDef.h"
#import "PercentageBar.h"
#import "PNChart.h"
#import "DateDeal.h"

@implementation MyMobileServiceYNPackageDetailInfo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPackageDetailInfoView:(PackageElementsType) type andDetailInfo:(NSArray *)detailInfo andPage:(NSInteger)page
{
    NSString *surplusLableText = @"";
    NSString *unitLableText = @"";
    NSString *surplusValueLableText = @"0";
    NSString *totalLableText = @"0";
    NSString *useLableText = @"0";
    NSString *promptLableText = @"";
    for (int i = 0; i<detailInfo.count; i++) {
        NSDictionary *dic = [detailInfo objectAtIndex:i];
        long long j = [surplusValueLableText longLongValue];
        j += [[dic objectForKey:@"BALANCE"] longLongValue];
        surplusValueLableText = [NSString stringWithFormat:@"%lld",j];
        
        long long k = [totalLableText longLongValue];
        k += [[dic objectForKey:@"HIGH_FEE"] longLongValue];
        totalLableText = [NSString stringWithFormat:@"%lld",k];
        
        long long l = [useLableText longLongValue];
        l += [[dic objectForKey:@"VALUE"] longLongValue];
        useLableText = [NSString stringWithFormat:@"%lld",l];
    }
    //如果是GPRS，返回的是字节，需要进行处理，变成M
    if (type == PackageElementsTypeGprs) {
        long long k = [totalLableText longLongValue];
        k = (k/1024)/1024;
        totalLableText = [NSString stringWithFormat:@"%lld",k];
        
        long long l = [useLableText longLongValue];
        l = (l/1024)/1024;
        useLableText = [NSString stringWithFormat:@"%lld",l];
        
        long long j = k - l;
        if (j<0) {
            j = 0;
        }
        surplusValueLableText = [NSString stringWithFormat:@"%lld",j];
        
    }
    
    //如果是WLAN流量，返回的是字节，需要进行处理，变成M
    if (type == PackageElementsTypeWlanM) {
        long long k = [totalLableText longLongValue];
        k = (k/1024)/1024;
        totalLableText = [NSString stringWithFormat:@"%lld",k];
        
        long long l = [useLableText longLongValue];
        l = (l/1024)/1024;
        useLableText = [NSString stringWithFormat:@"%lld",l];
        
        long long j = k - l;
        if (j<0) {
            j = 0;
        }
        surplusValueLableText = [NSString stringWithFormat:@"%lld",j];
        
    }
    CGFloat a=[useLableText floatValue];
    CGFloat b=[totalLableText floatValue];
    CGFloat c=[DateDeal getDays];
    CGFloat d=[DateDeal getDay];
    if (type == PackageElementsTypeCall) {
        surplusLableText = @"语音通话";
        unitLableText = @"分钟";
        if(a>b){
            promptLableText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptLableText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptLableText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptLableText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptLableText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptLableText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptLableText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptLableText =@"真是原始人的节奏啊，竟没有使用通话~~";
        }
    }else if(type == PackageElementsTypeGprs) {
        surplusLableText = @"流量";
        unitLableText = @"M";
        if(a>b){
            promptLableText =@"超支了，赶紧入手一个流量包吧！！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptLableText =@"使用过多，赶紧入手一个流量包吧！！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptLableText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptLableText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptLableText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptLableText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptLableText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptLableText =@"真是原始人的节奏啊，竟没有使用流量~~";
        }
    }else if(type == PackageElementsTypeSms) {
        surplusLableText = @"短信";
        unitLableText = @"条";
        if(a>b){
            promptLableText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptLableText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptLableText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptLableText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptLableText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptLableText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptLableText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptLableText =@"真是原始人的节奏啊，竟没有使用SMS~~";
        }
    }else if(type == PackageElementsTypeMsms) {
        surplusLableText = @"彩信";
        unitLableText = @"条";
        if(a>b){
            promptLableText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptLableText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptLableText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptLableText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptLableText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptLableText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptLableText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptLableText =@"真是原始人的节奏啊，竟没有使用SMS~~";
        }
    }else if(type == PackageElementsTypeWlan) {
        surplusLableText = @"WLAN(分钟)";
        unitLableText = @"分钟";
        if(a>b){
            promptLableText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptLableText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptLableText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptLableText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptLableText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptLableText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptLableText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptLableText =@"真是原始人的节奏啊，竟没有使用WLAN~~";
        }
    }else if(type == PackageElementsTypeWlanM) {
        surplusLableText = @"WLAN(M)";
        unitLableText = @"M";
        if(a>b){
            promptLableText =@"超支严重，墙裂建议省着点用！";
        }else if((b-a)/(c-d)<=b/c*0.5&&a<b&&c!=d){
            promptLableText =@"使用过多，墙裂建议省着点用！";
        }else if(b/c*0.5<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*0.8&&a<b&&c!=d){
            promptLableText =@"使用的稍稍过多，还是省着点用吧！";
        }else if(b/c*0.8<=(b-a)/(c-d)&&(b-a)/(c-d)<=b/c*1.2&&a<b&&c!=d){
            promptLableText =@"不紧不慢，使用的刚刚好。";
        }else if(b==a&&c==d){
            promptLableText =@"这是神的节奏啊，刚好用完！";
        }else if(b/c*1.2<(b-a)/(c-d)&&(b-a)/(c-d)<b/c*1.5&&a<b&&c!=d){
            promptLableText =@"这是小资的节奏啊，稍稍有点剩余！";
        }else if((b-a)/(c-d)>=b/c*1.5&&a<b&&c!=d){
            promptLableText =@"剩余较多，可尽情发挥~~";
        }else if(c<d&&a==0){
            promptLableText =@"真是原始人的节奏啊，竟没有使用WLAN~~";
        }
    }
    
    UIView *surplusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    surplusView.backgroundColor = [UIColor clearColor];
    
    UIImageView *sanView = [[UIImageView alloc]init];
    sanView.frame = CGRectMake((surplusView.frame.size.width-23)/2, 0, 23, 11.5);
    [surplusView addSubview:sanView];
    
    UIView *surplusViewBg = [[UIView alloc]initWithFrame:CGRectMake(0, 11.5, SCREEN_WIDTH, 168.5)];
    if(page%2==0){
        sanView.image=[UIImage imageNamed:@"flow_sangreen"];
        surplusViewBg.backgroundColor = UIColorFromRGB(rgbValue_valueBg);
    }else{
        sanView.image=[UIImage imageNamed:@"flow_sanblue"];
        surplusViewBg.backgroundColor = UIColorFromRGB(rgbValue_packageDetailInfoSurplusBg1);
    }
    
    UILabel *surplusLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 160, 30)];
    surplusLable.textAlignment = NSTextAlignmentLeft;
    surplusLable.text = [NSString stringWithFormat:@"%@剩余",surplusLableText];
    surplusLable.textColor = [UIColor whiteColor];
    surplusLable.backgroundColor = [UIColor clearColor];
    surplusLable.font = [UIFont fontWithName:appTypeFace size:20.0];
    [surplusViewBg addSubview:surplusLable];
    
    CGSize size=CGSizeMake(300, 100);
    UIFont *font=[UIFont fontWithName:appTypeFace size:60];
    CGSize labelSize=[surplusValueLableText sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *surplusValueLable = [[UILabel alloc]initWithFrame:CGRectMake((320-labelSize.width)/2, 40, labelSize.width, 100)];
    surplusValueLable.textAlignment = NSTextAlignmentCenter;
    surplusValueLable.text = surplusValueLableText;
    surplusValueLable.textColor = [UIColor whiteColor];
    surplusValueLable.backgroundColor = [UIColor clearColor];
    surplusValueLable.font = [UIFont fontWithName:appTypeFace size:60.0];
    [surplusViewBg addSubview:surplusValueLable];
    
    UILabel *unitLable = [[UILabel alloc]initWithFrame:CGRectMake((320-labelSize.width)/2+labelSize.width+20, 100, 40, 20)];
    unitLable.textAlignment = NSTextAlignmentLeft;
    unitLable.text = unitLableText;
    unitLable.textColor = [UIColor whiteColor];
    unitLable.backgroundColor = [UIColor clearColor];
    unitLable.font = [UIFont fontWithName:appTypeFace size:20.0];
    [surplusViewBg addSubview:unitLable];
    
    UILabel *promptLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, SCREEN_WIDTH-20, 20)];
    promptLable.textAlignment = NSTextAlignmentCenter;
    promptLable.text = promptLableText;
    promptLable.textColor = UIColorFromRGB(rgbValue_packageDetailInfoPromptText);
    promptLable.backgroundColor = [UIColor clearColor];
    promptLable.font = [UIFont fontWithName:appTypeFace size:14.0];
    promptLable.adjustsFontSizeToFitWidth=YES;
    [surplusViewBg addSubview:promptLable];
    [surplusView addSubview:surplusViewBg];
    [self addSubview:surplusView];
    
    UIView *totleView = [[UIView alloc]initWithFrame:CGRectMake(0, surplusView.frame.size.height, SCREEN_WIDTH, 40)];
    totleView.backgroundColor = [UIColor clearColor];
    
    //总共和已用展示
    UILabel *totalNameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 45, 30)];
    totalNameLable.textAlignment = NSTextAlignmentRight;
    totalNameLable.text = @"总共:";
    totalNameLable.textColor = [UIColor lightGrayColor];
    totalNameLable.backgroundColor = [UIColor clearColor];
    totalNameLable.font = [UIFont fontWithName:appTypeFace size:15.0];
    [totleView addSubview:totalNameLable];
    UILabel *totalLable = [[UILabel alloc]initWithFrame:CGRectMake(55, 5, 100, 30)];
    totalLable.textAlignment = NSTextAlignmentCenter;
    totalLable.text = [NSString stringWithFormat:@"%@%@",totalLableText,unitLableText];
    if(page%2==0){
        surplusViewBg.backgroundColor = UIColorFromRGB(rgbValue_valueBg);
    }else{
        surplusViewBg.backgroundColor = UIColorFromRGB(rgbValue_packageDetailInfoSurplusBg1);
    }
    totalLable.textColor = surplusViewBg.backgroundColor;
    totalLable.backgroundColor = [UIColor clearColor];
    totalLable.font = [UIFont fontWithName:appTypeFace size:25.0];
    [totleView addSubview:totalLable];
    
    UILabel *useNameLable = [[UILabel alloc]initWithFrame:CGRectMake(170, 5, 45, 30)];
    useNameLable.textAlignment = NSTextAlignmentRight;
    useNameLable.text = @"已用:";
    useNameLable.textColor = [UIColor lightGrayColor];
    useNameLable.backgroundColor = [UIColor clearColor];
    useNameLable.font = [UIFont fontWithName:appTypeFace size:15.0];
    [totleView addSubview:useNameLable];
    UILabel *useLable = [[UILabel alloc]initWithFrame:CGRectMake(215, 5, 100, 30)];
    useLable.textAlignment = NSTextAlignmentCenter;
    useLable.text = [NSString stringWithFormat:@"%@%@",useLableText,unitLableText];
    if(page%2==0){
        surplusViewBg.backgroundColor = UIColorFromRGB(rgbValue_valueBg);
    }else{
        surplusViewBg.backgroundColor = UIColorFromRGB(rgbValue_packageDetailInfoSurplusBg1);
    }
    useLable.textColor = surplusViewBg.backgroundColor;
    useLable.backgroundColor = [UIColor clearColor];
    useLable.font = [UIFont fontWithName:appTypeFace size:25.0];
    [totleView addSubview:useLable];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 1, 40)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [totleView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [totleView addSubview:line2];
    
    [self addSubview:totleView];
    
    //使用明细
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0,surplusView.frame.size.height+totleView.frame.size.height, SCREEN_WIDTH, 40+80*detailInfo.count)];
    //    gprsDetailView.backgroundColor = [UIColor lightGrayColor];
    
//    UILabel *detailLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
//    detailLable.textAlignment = NSTextAlignmentLeft;
//    detailLable.text = @"使用明细";
//    detailLable.backgroundColor = [UIColor clearColor];
//    detailLable.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
//    detailLable.font = [UIFont fontWithName:appTypeFace size:15.0];
//    [detailView addSubview:detailLable];
    
    NSInteger height=0;
    for (int i=0; i<detailInfo.count; i++) {
        NSDictionary *dic = [detailInfo objectAtIndex:i];
        NSString *highFee =[dic objectForKey:@"HIGH_FEE"];
        NSString *value =[dic objectForKey:@"VALUE"];
        if((type == PackageElementsTypeGprs)||(type == PackageElementsTypeWlanM))
        {
            highFee =[NSString stringWithFormat:@"%lld",([[dic objectForKey:@"HIGH_FEE"] longLongValue]/1024)/1024];
            value =[NSString stringWithFormat:@"%lld",([[dic objectForKey:@"VALUE"] longLongValue]/1024)/1024];
        }else
        {
            highFee =[dic objectForKey:@"HIGH_FEE"];
            value =[dic objectForKey:@"VALUE"];
        }
        UILabel *detailNameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10 + height, 180, 40)];
        detailNameLable.textAlignment = NSTextAlignmentLeft;
        detailNameLable.text = [dic objectForKey:@"DISCNT_NAME"];
        detailNameLable.backgroundColor = [UIColor clearColor];
        detailNameLable.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
        detailNameLable.font = [UIFont fontWithName:appTypeFace size:15];
        detailNameLable.numberOfLines = 0;
        [detailView addSubview:detailNameLable];
        
        UILabel *detailLable = [[UILabel alloc]initWithFrame:CGRectMake(190, 10 + height, 120, 40)];
        detailLable.textAlignment = NSTextAlignmentRight;
        detailLable.text = [NSString stringWithFormat:@"共%@%@",highFee,unitLableText];
        detailLable.backgroundColor = [UIColor clearColor];
        detailLable.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
        detailLable.font = [UIFont fontWithName:appTypeFace size:15];
        detailLable.numberOfLines = 0;
        [detailView addSubview:detailLable];
        
        PercentageBar *barChart = [[PercentageBar alloc] initWithFrame:CGRectMake(10,10+40 + height,300,40)];
        barChart.backgroundColor = [UIColor clearColor];
        barChart.barBackgroundColor = [UIColor clearColor];
        if([value integerValue]>=[highFee integerValue]){
            [barChart setPerValue:[highFee integerValue] PerValueMax:[highFee integerValue]];
        }else{
            [barChart setPerValue:[value integerValue] PerValueMax:[highFee integerValue]];
        }
//        [barChart setStrokeColor:UIColorFromRGB(rgbValue_packageDetailInfoSurplusBg)];
        if(page%2==0){
            [barChart setStrokeColor:UIColorFromRGB(rgbValue_valueBg)];
        }else{
            [barChart setStrokeColor:UIColorFromRGB(rgbValue_packageDetailInfoSurplusBg1)];
        }
        [barChart strokeChartForPercentage];
        [detailView addSubview:barChart];
        
         height=height+80;
    }
    
    if([useLableText longLongValue]>[totalLableText longLongValue]){
        UILabel *promptLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+height, SCREEN_WIDTH-20, 20)];
        promptLable.textAlignment = NSTextAlignmentLeft;
        promptLable.text = [NSString stringWithFormat:@"%@超出:%lld%@",surplusLableText,[useLableText longLongValue]-[totalLableText longLongValue],unitLableText];
        promptLable.textColor = [UIColor redColor];
        promptLable.backgroundColor = [UIColor clearColor];
        promptLable.font = [UIFont fontWithName:appTypeFace size:14.0];
        promptLable.adjustsFontSizeToFitWidth=YES;
        [detailView addSubview:promptLable];
    }
    
    detailView.frame=CGRectMake(0,surplusView.frame.size.height+totleView.frame.size.height, SCREEN_WIDTH, 40+80*detailInfo.count+20);
    
//    UILabel *detailNameLable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 180, 20)];
//    detailNameLable2.textAlignment = NSTextAlignmentLeft;
//    detailNameLable2.text = @"30元数据流量月包";
//    detailNameLable2.backgroundColor = [UIColor clearColor];
//    detailNameLable2.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
//    detailNameLable2.font = [UIFont fontWithName:appTypeFace size:20.0];
//    [detailView addSubview:detailNameLable2];
//    
//    UILabel *detailLable2 = [[UILabel alloc]initWithFrame:CGRectMake(190, 120, 120, 20)];
//    detailLable2.textAlignment = NSTextAlignmentRight;
//    detailLable2.text = @"共50M";
//    detailLable2.backgroundColor = [UIColor clearColor];
//    detailLable2.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
//    detailLable2.font = [UIFont fontWithName:appTypeFace size:15.0];
//    [detailView addSubview:detailLable2];
//    
//    PercentageBar *barChart2 = [[PercentageBar alloc] initWithFrame:CGRectMake(10,150,300,40)];
//    barChart2.backgroundColor = [UIColor clearColor];
//    barChart2.barBackgroundColor = [UIColor lightGrayColor];
//    [barChart2 setPerValue:45 PerValueMax:50];
//    [barChart2 setStrokeColor:UIColorFromRGB(rgbValue_packageDetailInfoSurplusBg)];
//    [barChart2 strokeChartForPercentage];
//    [detailView addSubview:barChart2];
    
    [self addSubview:detailView];
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
