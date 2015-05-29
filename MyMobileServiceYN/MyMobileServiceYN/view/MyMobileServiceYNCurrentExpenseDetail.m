//
//  MyMobileServiceYNCurrentExpenseDetail.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-22.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNCurrentExpenseDetail.h"
#import "GlobalDef.h"
#import "DateDeal.h"

#define fheight 44
#define fspacing 10

@implementation MyMobileServiceYNCurrentExpenseDetail

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setCurrentExpenseDetailView:(NSDictionary *)detail
{
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, self.frame.size.height-20)];
    detailView.backgroundColor = [UIColor clearColor];
    [self addSubview:detailView];
    
    UIView *detailBlockView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, 10, 20)];
    detailBlockView.backgroundColor = UIColorFromRGB(rgbValueButtonGreen);
    [detailView addSubview:detailBlockView];
    
    UILabel *detailNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 270, 30)];
    detailNameLabel.backgroundColor = [UIColor clearColor];
    detailNameLabel.textColor = UIColorFromRGB(rgbValueDeepGrey);
    detailNameLabel.textAlignment = NSTextAlignmentLeft;
    detailNameLabel.adjustsFontSizeToFitWidth=YES;
    detailNameLabel.text = [NSString stringWithFormat:@"%@%.2f",[detail objectForKey:@"DetailName"],(float)[[detail objectForKey:@"DetailFee"]floatValue]/100];
    [detailView addSubview:detailNameLabel];
    
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, fheight)];
    nameView.backgroundColor = UIColorFromRGB(rgbValueBgGrey);
    [detailView addSubview:nameView];
    
    UILabel *productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, fheight)];
    productNameLabel.backgroundColor = [UIColor clearColor];
    productNameLabel.text = @"活动名称";
    productNameLabel.textColor = UIColorFromRGB(rgbValueLightGrey);
    [nameView addSubview:productNameLabel];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, 80, fheight)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = [detail objectForKey:@"DetailFeeName"];
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.textColor = UIColorFromRGB(rgbValueLightGrey);
    [nameView addSubview:nameLabel];
    
    NSArray *detailArray = [detail objectForKey:@"DetailArray"];
    
    UIView *detailFeeView = [[UIView alloc]initWithFrame:CGRectMake(0, 30+fheight, self.frame.size.width, fheight*1.5*detailArray.count)];
    [detailView addSubview:detailFeeView];
    for (int i= 0; i<detailArray.count; i++) {
        UILabel *feeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, fheight*1.5*i, 140, fheight*1.5)];
        feeNameLabel.backgroundColor = [UIColor clearColor];
        feeNameLabel.font = [UIFont fontWithName:appTypeFace size:15];
        feeNameLabel.textColor =UIColorFromRGB(rgbValueLightGrey);
        feeNameLabel.numberOfLines =0;
        if ([[[detailArray objectAtIndex:i]objectForKey:@"REMARK2"] isEqualToString:@""]) {
            feeNameLabel.text = [[detailArray objectAtIndex:i]objectForKey:@"PAYMENT"];
        }else
        {
            feeNameLabel.text = [[detailArray objectAtIndex:i]objectForKey:@"REMARK2"];
        }
        [detailFeeView addSubview:feeNameLabel];
        
        UILabel *feeLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, fheight*1.5*i, 80, fheight*1.5)];
        feeLabel.backgroundColor = [UIColor clearColor];
        feeLabel.font = [UIFont fontWithName:appTypeFace size:15];
        feeLabel.textColor =UIColorFromRGB(rgbValueLightGrey);
        NSString *fee =[[detailArray objectAtIndex:i]objectForKey:@"RECV_FEE"];
        int l =[fee intValue];
        if (l<0) {
            l = 0-l;
        }
        feeLabel.text = [NSString stringWithFormat:@"%.2f",(float)l/100];
        feeLabel.textAlignment=NSTextAlignmentCenter;
        [detailFeeView addSubview:feeLabel];
        
        if([[detail objectForKey:@"DetailName"] isEqualToString:@"预存未返还总额(元)"]){
//            nameLabel.frame=CGRectMake(160, 0, 80, fheight);
//            feeNameLabel.frame=CGRectMake(10, fheight*1.5*i, 140, fheight*1.5);
//            feeLabel.frame=CGRectMake(160, fheight*1.5*i, 80, fheight*1.5);
            
            UILabel *yuncunNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 0, 80, fheight)];
            yuncunNameLabel.backgroundColor = [UIColor clearColor];
            yuncunNameLabel.text = @"未返还(期)";
            yuncunNameLabel.textColor = UIColorFromRGB(rgbValueLightGrey);
            [nameView addSubview:yuncunNameLabel];
            
            UILabel *yucunLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, fheight*1.5*i, 80, fheight*1.5)];
            yucunLabel.backgroundColor = [UIColor clearColor];
            yucunLabel.font = [UIFont fontWithName:appTypeFace size:15];
            yucunLabel.textColor =UIColorFromRGB(rgbValueLightGrey);
            NSString *fee =[[detailArray objectAtIndex:i]objectForKey:@"END_CYCLE_ID"];
            yucunLabel.textAlignment=NSTextAlignmentCenter;
            yucunLabel.text = [NSString stringWithFormat:@"%d",[DateDeal getCurrentMonthFromMonth:fee]];
            
            [detailFeeView addSubview:yucunLabel];
        }else
        {
            UILabel *recvTimeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 0, 80, fheight)];
            recvTimeNameLabel.backgroundColor = [UIColor clearColor];
            recvTimeNameLabel.text = @"日期";
            recvTimeNameLabel.textAlignment=NSTextAlignmentCenter;
            recvTimeNameLabel.textColor = UIColorFromRGB(rgbValueLightGrey);
            [nameView addSubview:recvTimeNameLabel];
            
            UILabel *recvTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, fheight*1.5*i, 80, fheight*1.5)];
            recvTimeLabel.backgroundColor = [UIColor clearColor];
            recvTimeLabel.font = [UIFont fontWithName:appTypeFace size:15];
            recvTimeLabel.textColor =UIColorFromRGB(rgbValueLightGrey);
            
            recvTimeLabel.textAlignment=NSTextAlignmentCenter;
            recvTimeLabel.text = [[detailArray objectAtIndex:i]objectForKey:@"RECV_TIME"];
            
            [detailFeeView addSubview:recvTimeLabel];
        }
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, fheight*1.5*(1+i)-1, self.frame.size.width, 1)];
        line.backgroundColor = UIColorFromRGB(rgbValueBgGrey);
        [detailFeeView addSubview:line];
    }
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
