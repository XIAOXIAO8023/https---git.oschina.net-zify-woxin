//
//  MyMobileServiceYNPackageDetailInfoGauges.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-11.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNPackageDetailInfoGauges.h"
#import "GlobalDef.h"
#import "PercentageBar.h"
#import "PNChart.h"
#import "MyMobileServiceYNCircle.h"

#import "WaterBallView.h"
#import "ZLProgressView.h"
#import "CommonUtils.h"


@implementation MyMobileServiceYNPackageDetailInfoGauges

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPackageDetailInfoView:(PackageElementsType) type andDetailInfo:(NSArray *)detailInfo
{
    currThemeColor = [CommonUtils getCurrentThemeColor];
    
    NSString *surplusLableText = @"";
    NSString *unitLableText = @"";
    NSString *surplusValueLableText = @"0";
    NSString *totalLableText = @"0";
    NSString *useLableText = @"0";
//    NSString *promptLableText = @"";
    if (type == PackageElementsTypeCall) {
        surplusLableText = @"语音剩余";
        unitLableText = @"分钟";
    }else if(type == PackageElementsTypeGprs) {
        surplusLableText = @"流量剩余";
        unitLableText = @"M";
    }else if(type == PackageElementsTypeSms) {
        surplusLableText = @"短信剩余";
        unitLableText = @"条";
    }else if(type == PackageElementsTypeMsms) {
        surplusLableText = @"彩信剩余";
        unitLableText = @"条";
    }else if(type == PackageElementsTypeWlan) {
        surplusLableText = @"WLAN剩余";
        unitLableText = @"分钟";
    }
    
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
    
    //如果是GPRS，返回的是KB，需要进行处理
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
    
    UIView *surplusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    surplusView.backgroundColor = UIColorFromRGB(rgbColor_userInfoScrollViewBg);
    
    /**
    UIImageView *mabiaoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow_mabiao"]];
    mabiaoView.frame = CGRectMake(0, 20, SCREEN_WIDTH, 188);
    [surplusView addSubview:mabiaoView];
    
    self.minimalGauge = [[MSSimpleGauge alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 180)];
//    self.minimalGauge.value = 50;
    self.minimalGauge.startAngle = 0;
    self.minimalGauge.endAngle = 180;
    self.minimalGauge.minValue = 0;
    self.minimalGauge.maxValue = [totalLableText intValue];
    [self.minimalGauge setValue:[useLableText intValue] animated:YES];
//    self.minimalGauge.backgroundArcFillColor = UIColorFromRGB(rgbValue_OdometerFrameBg);
//    self.minimalGauge.backgroundArcStrokeColor = UIColorFromRGB(rgbValue_OdometerFrame);
    self.minimalGauge.backgroundArcFillColor = [UIColor clearColor];
    self.minimalGauge.backgroundArcStrokeColor = [UIColor clearColor];
//    self.minimalGauge.fillArcFillColor = UIColorFromRGB(rgbValue_OdometerContent);
    self.minimalGauge.fillArcFillColor =  [UIColor clearColor];
    self.minimalGauge.backgroundColor = [UIColor clearColor];
    self.minimalGauge.needleView.needleColor = UIColorFromRGB(rgbValue_OdometerNeedle);
    [surplusView addSubview:self.minimalGauge];
    
    
    UIImageView *centerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow_center"]];
    centerView.frame = CGRectMake(100, 110, 120, 120);
    [surplusView addSubview:centerView];
    
    UILabel *usedNameLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 80, 20)];
    usedNameLable.backgroundColor = [UIColor clearColor];
    usedNameLable.textColor = [UIColor lightGrayColor];
    usedNameLable.textAlignment = NSTextAlignmentCenter;
    usedNameLable.text = @"已用流量";
    [centerView addSubview:usedNameLable];
    
    UILabel *usedLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 100, 30)];
    usedLable.backgroundColor = [UIColor clearColor];
    usedLable.textColor = [UIColor lightGrayColor];
    usedLable.textAlignment = NSTextAlignmentCenter;
    usedLable.text = useLableText;
    usedLable.font = [UIFont fontWithName:appTypeFace size:30];
    [centerView addSubview:usedLable];

    //起始LABLE
    UILabel *minLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 190, 60, 20)];
    minLable.backgroundColor = [UIColor clearColor];
    minLable.textColor = [UIColor lightGrayColor];
    minLable.textAlignment = NSTextAlignmentCenter;
    minLable.font = [UIFont fontWithName:appTypeFace size:15];
    minLable.text = [NSString stringWithFormat:@"0%@",unitLableText];
    [surplusView addSubview:minLable];
    
    UILabel *maxLable = [[UILabel alloc]initWithFrame:CGRectMake(235, 190, 60, 20)];
    maxLable.backgroundColor = [UIColor clearColor];
    maxLable.textColor = [UIColor lightGrayColor];
    maxLable.adjustsFontSizeToFitWidth=YES;
    maxLable.textAlignment = NSTextAlignmentCenter;
    maxLable.font = [UIFont fontWithName:appTypeFace size:15];
    maxLable.text = [NSString stringWithFormat:@"%@%@",totalLableText,unitLableText];
    [surplusView addSubview:maxLable];

    UIView *overGprsView = [[UIView alloc]initWithFrame:CGRectMake(30, 240, 260, 40)];
    overGprsView.backgroundColor = UIColorFromRGB(rgbValue_packageDetailInfoSurplusBg);
    [overGprsView.layer setCornerRadius:15];
    [overGprsView.layer setBorderWidth:0];
    [overGprsView.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [overGprsView.layer setMasksToBounds:YES];
    
    UILabel *overNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 120, 40)];
    overNameLabel.textAlignment = NSTextAlignmentCenter;
    overNameLabel.textColor = [UIColor whiteColor];
    overNameLabel.backgroundColor = [UIColor clearColor];
    overNameLabel.text = @"流量剩余(M):";
    [overGprsView addSubview:overNameLabel];
    
    UILabel *overGprsLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 0, 125, 40)];
    overGprsLabel.textAlignment = NSTextAlignmentCenter;
    overGprsLabel.textColor = [UIColor whiteColor];
    overGprsLabel.font = [UIFont fontWithName:appTypeFace size:35];
    overGprsLabel.backgroundColor = [UIColor clearColor];
    overGprsLabel.text = surplusValueLableText;
    [overGprsView addSubview:overGprsLabel];
    
    [surplusView addSubview:overGprsView];
    **/
    
    float ballWith = 110;//ball的宽度
    float waterHeight = 0;//水的高度
    NSString *titleStr = @"";//标题
    float percent = -1;//百分比
    
    percent = ([totalLableText floatValue]-[useLableText floatValue])/[totalLableText floatValue] *100;
    titleStr = @"剩余流量";
    waterHeight = ballWith*(1-percent/100);
    if(waterHeight < 5){waterHeight = 5;}
    UIColor *waveColorBg = UIColorFromRGB(rgbColor_userInfoScrollViewBg);
    UIColor * waveColor = UIColorFromRGB(0xd5d3d3);
    WaterBallView *waterView = [[WaterBallView alloc]initWithFrame:CGRectMake(0, 0, ballWith, ballWith)];
    waterView.circleLineColor = currThemeColor;
    waterView.circleOuterColor = UIColorFromRGB(rgbColor_userInfoScrollViewBg);
    waterView.backgroundColor = waveColorBg;
    [waterView setCurrentWaterColor:waveColor];
    [waterView reloadWater:waterHeight];
    waterView.center = CGPointMake(SCREEN_WIDTH/2,150/2);
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, ballWith, 20)];
    title.backgroundColor = [UIColor clearColor];
    title.text = titleStr;
    title.font = [UIFont fontWithName:appTypeFace size:12];
    title.textColor = currThemeColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.numberOfLines = 0;
    [waterView addSubview:title];
    
    UILabel *percentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ballWith, 40)];
    percentLabel.backgroundColor = [UIColor clearColor];
    NSMutableString* percentLabelStr = [[NSMutableString alloc]initWithFormat:@"%.0f",roundf(percent)];
    [percentLabelStr appendString:@"%"];
    percentLabel.text = percentLabelStr;
    percentLabel.font = [UIFont fontWithName:appTypeFace size:37];
    percentLabel.textColor = currThemeColor;
    percentLabel.textAlignment = NSTextAlignmentCenter;
    percentLabel.numberOfLines = 0;
    CGSize kSize = CGSizeMake(200 ,50);
    CGSize percentLabelSize = [percentLabel.text
                               sizeWithFont:percentLabel.font
                               constrainedToSize:kSize
                               lineBreakMode:NSLineBreakByWordWrapping];
    percentLabel.frame = CGRectMake(0, 40, ballWith, percentLabelSize.height);
    [waterView addSubview:percentLabel];
    [surplusView addSubview:waterView];
    
    [self addSubview:surplusView];
    
    //使用明细
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0,surplusView.frame.size.height, SCREEN_WIDTH, 40+80*detailInfo.count)];
    //    gprsDetailView.backgroundColor = [UIColor lightGrayColor];
    
//    UILabel *detailLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
//    detailLable.textAlignment = NSTextAlignmentLeft;
//    detailLable.text = @"使用明细";
//    detailLable.backgroundColor = [UIColor clearColor];
//    detailLable.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
//    detailLable.font = [UIFont fontWithName:appTypeFace size:15.0];
//    [detailView addSubview:detailLable];
    
    for (int i=0; i<detailInfo.count; i++) {
        NSDictionary *dic = [detailInfo objectAtIndex:i];
        NSString *highFee =[dic objectForKey:@"HIGH_FEE"];
        NSString *value =[dic objectForKey:@"VALUE"];
        if(type == PackageElementsTypeGprs)
        {
            highFee =[NSString stringWithFormat:@"%lld",([[dic objectForKey:@"HIGH_FEE"] longLongValue]/1024)/1024];
            value =[NSString stringWithFormat:@"%lld",([[dic objectForKey:@"VALUE"] longLongValue]/1024)/1024];
        }else
        {
            highFee =[dic objectForKey:@"HIGH_FEE"];
            value =[dic objectForKey:@"VALUE"];
        }
        UILabel *detailNameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10 + i*80, 180, 40)];
        detailNameLable.textAlignment = NSTextAlignmentLeft;
        detailNameLable.text = [dic objectForKey:@"DISCNT_NAME"];
        detailNameLable.backgroundColor = [UIColor clearColor];
        detailNameLable.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
        detailNameLable.font = [UIFont fontWithName:appTypeFace size:15];
        detailNameLable.numberOfLines =0;
        [detailView addSubview:detailNameLable];
        
//        UILabel *detailLable = [[UILabel alloc]initWithFrame:CGRectMake(190, 10 + i*80, 120, 40)];
//        detailLable.textAlignment = NSTextAlignmentRight;
//        detailLable.text = [NSString stringWithFormat:@"共%@%@",highFee,unitLableText];
//        detailLable.backgroundColor = [UIColor clearColor];
//        detailLable.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
//        detailLable.font = [UIFont fontWithName:appTypeFace size:15.0];
//        [detailView addSubview:detailLable];
        
//        PercentageBar *barChart = [[PercentageBar alloc] initWithFrame:CGRectMake(10,10+40 + i*80,300,40)];
//        barChart.backgroundColor = [UIColor clearColor];
//        barChart.barBackgroundColor = [UIColor lightGrayColor];
//        [barChart setPerValue:[value intValue] PerValueMax:[highFee intValue]];
//        [barChart setStrokeColor:UIColorFromRGB(rgbValue_packageDetailInfoSurplusBg)];
//        [barChart strokeChartForPercentage];
//        [detailView addSubview:barChart];
        float progress = ([value floatValue])/[highFee floatValue];
        ZLProgressView *progressView = [[ZLProgressView alloc]initWithFrame:CGRectMake(10,50+i*80,SCREEN_WIDTH-20,20)];
        progressView.progressTintColor = UIColorFromRGB(0x74d2bb);//属性 填充部分的颜色
        progressView.trackTintColor = [UIColor whiteColor];//属性，未填充部分的颜色
        progressView.layer.cornerRadius = 10;
        progressView.layer.borderWidth = 1;
        progressView.layer.borderColor =  UIColorFromRGB(0xb6d6e3).CGColor;
        [progressView loadProgress:progress];
        [detailView addSubview:progressView];
        
//        //已使用
//        CGRect usedLabelframe=progressView.frame;
//        usedLabelframe.origin.y+=20;
//        
//        UILabel *usedLabel = [UILabel new];
//        usedLabel.backgroundColor = [UIColor clearColor];
//        usedLabel.text = [NSString stringWithFormat:@"已用%@",value];
//        usedLabel.textColor = UIColorFromRGB(rgbValue_autoLogin);
//        usedLabel.font = [UIFont fontWithName:appTypeFace size:16];
//        usedLabelframe.size.width = [usedLabel.text sizeWithFont:usedLabel.font].width;
//        usedLabel.frame = usedLabelframe;
//        usedLabel.center = CGPointMake(10+(SCREEN_WIDTH-20)*progress, usedLabel.center.y);
//        if((usedLabelframe.size.width+usedLabel.frame.origin.x)>(SCREEN_WIDTH-10)){
//            usedLabelframe.origin.x = SCREEN_WIDTH-10-usedLabelframe.size.width;
//            usedLabel.frame = usedLabelframe;
//        }else if(usedLabel.frame.origin.x<10){
//            usedLabelframe.origin.x = 10;
//            usedLabel.frame = usedLabelframe;
//        }
//        [detailView addSubview:usedLabel];
        
        UILabel *remain = [[UILabel alloc]initWithFrame:CGRectMake(10,70+i*80,SCREEN_WIDTH-20,20)];
        remain.backgroundColor = [UIColor clearColor];
        remain.text = [NSString stringWithFormat:@"剩%dM",[highFee intValue]-[value intValue]];
        remain.font = [UIFont fontWithName:appTypeFace size:12];
        remain.textColor = UIColorFromRGB(rgbValue_navBarBg);
        remain.numberOfLines = 0;
        [detailView addSubview:remain];
        
        float remainWidth = [remain.text sizeWithFont:remain.font].width;
        
        UILabel *total = [[UILabel alloc]initWithFrame:CGRectMake(remainWidth+10,70+i*80,SCREEN_WIDTH-20,20)];
        total.backgroundColor = [UIColor clearColor];
        total.text = [NSString stringWithFormat:@"/共%@M",highFee];
        total.font = [UIFont fontWithName:appTypeFace size:12];
        total.textColor = UIColorFromRGB(rgbValueLightGrey);
        total.numberOfLines = 0;
        [detailView addSubview:total];
    }
    
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
