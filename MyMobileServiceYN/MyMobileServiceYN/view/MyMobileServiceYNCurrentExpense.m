//
//  MyMobileServiceYNTest.m
//  MyMobileServiceYN
//
//  Created by CRMac on 14-3-12.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNCurrentExpense.h"
#import "GlobalDef.h"

@implementation MyMobileServiceYNCurrentExpense

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setUIViewforCurrentExpense:(NSMutableDictionary *)dic
{
    UIView *balanceView = [[UIView alloc]init];
    balanceView.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelDiamond = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 10, 20)];
    labelDiamond.backgroundColor = UIColorFromRGB(rgbValue_greenDiamond);
    [balanceView addSubview:labelDiamond];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 150, 40)];
    label3.text = [dic objectForKey:@"label"];
    label3.textAlignment = UITextAlignmentLeft;
    label3.backgroundColor = [UIColor clearColor];
    label3.textColor = UIColorFromRGB(rgbValue_buttonNameBlack);
    label3.font = [UIFont fontWithName:appTypeFace size:20];
    [balanceView addSubview:label3];
    
    UILabel *data2 = [[UILabel alloc]initWithFrame:CGRectMake(180, 0, 140, 40)];
    data2.text = [dic objectForKey:@"data"];
    data2.textAlignment = UITextAlignmentCenter;
    data2.backgroundColor = [UIColor clearColor];
    data2.textColor = UIColorFromRGB(rgbValue_buttonNameBlack);
    data2.font = [UIFont fontWithName:appTypeFaceBold size:23];
    [balanceView addSubview:data2];
    
//    UILabel *data3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/3, 0, SCREEN_WIDTH/3, 40)];
//    data3.textAlignment = UITextAlignmentCenter;
//    data3.backgroundColor = [UIColor clearColor];
//    data3.textColor = [UIColor blackColor];
//    [balanceView addSubview:data3];
    
    UILabel *balanceLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH/3, 40)];
    balanceLabel1.text = [dic objectForKey:@"label1"];
    balanceLabel1.textAlignment = UITextAlignmentCenter;
    balanceLabel1.textColor = [UIColor lightGrayColor];
    balanceLabel1.backgroundColor = UIColorFromRGB(rgbValue_grayBackground);
    balanceLabel1.font = [UIFont fontWithName:appTypeFace size:18];
    [balanceView addSubview:balanceLabel1];
    
    
    UILabel *balanceLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 40, SCREEN_WIDTH/3, 40)];
    balanceLabel2.text = [dic objectForKey:@"label2"];
    balanceLabel2.textAlignment = UITextAlignmentCenter;
    balanceLabel2.textColor = [UIColor lightGrayColor];
    balanceLabel2.backgroundColor = UIColorFromRGB(rgbValue_grayBackground);
    balanceLabel2.font = [UIFont fontWithName:appTypeFace size:18];
    [balanceView addSubview:balanceLabel2];
    
    UILabel *balanceLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/3-2, 40, SCREEN_WIDTH/3+2, 40)];
    balanceLabel3.text = [dic objectForKey:@"label3"];
    balanceLabel3.textAlignment = UITextAlignmentCenter;
    balanceLabel3.textColor = [UIColor lightGrayColor];
    balanceLabel3.backgroundColor = UIColorFromRGB(rgbValue_grayBackground);
    balanceLabel3.font = [UIFont fontWithName:appTypeFace size:18];
    [balanceView addSubview:balanceLabel3];
    
    UILabel *balanceData1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH/3, 40)];
    balanceData1.text = [dic objectForKey:@"data1"];
    balanceData1.textAlignment = UITextAlignmentCenter;
    balanceData1.textColor = [UIColor lightGrayColor];
    balanceData1.backgroundColor = UIColorFromRGB(rgbValue_grayBackground);
    balanceData1.font = [UIFont fontWithName:appTypeFace size:20];
    [balanceView addSubview:balanceData1];
    
    
    UILabel *balanceData2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 80, SCREEN_WIDTH/3, 40)];
    balanceData2.text = [dic objectForKey:@"data2"];
    balanceData2.textAlignment = UITextAlignmentCenter;
    balanceData2.textColor = [UIColor lightGrayColor];
    balanceData2.backgroundColor = UIColorFromRGB(rgbValue_grayBackground);
    balanceData2.font = [UIFont fontWithName:appTypeFace size:20];
    [balanceView addSubview:balanceData2];
    
    UILabel *balanceData3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/3-2, 80, SCREEN_WIDTH/3+2, 40)];
    balanceData3.text = [dic objectForKey:@"data3"];
    balanceData3.textAlignment = UITextAlignmentCenter;
    balanceData3.textColor = [UIColor lightGrayColor];
    balanceData3.backgroundColor = UIColorFromRGB(rgbValue_grayBackground);
    balanceData3.font = [UIFont fontWithName:appTypeFace size:20];
    [balanceView addSubview:balanceData3];
    
    UILabel *labelLine1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 45, 1, 70)];
    labelLine1.backgroundColor = UIColorFromRGB(rgbValue_grayLine);
    [balanceView addSubview:labelLine1];
    
    UILabel *labelLine2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/3, 45, 1, 70)];
    labelLine2.backgroundColor = UIColorFromRGB(rgbValue_grayLine);
    [balanceView addSubview:labelLine2];
    
    if([[dic objectForKey:@"data2"] isEqualToString:@""]){
        balanceLabel1.frame=CGRectMake(0, 40, SCREEN_WIDTH/2, 40);
        balanceLabel2.frame=CGRectMake(0, 0, 0, 0);
        balanceLabel3.frame=CGRectMake(SCREEN_WIDTH*1/2-2, 40, SCREEN_WIDTH/2+2, 40);
        balanceData1.frame=CGRectMake(0, 80, SCREEN_WIDTH/2, 40);
        balanceData2.frame=CGRectMake(0, 0, 0, 0);
        balanceData3.frame=CGRectMake(SCREEN_WIDTH*1/2-2, 80, SCREEN_WIDTH/2+2, 40);
        labelLine1.frame=CGRectMake(SCREEN_WIDTH/2, 45, 1, 70);
        labelLine2.frame=CGRectMake(0, 0, 0, 0);
    }
    
//    UIView *viewLine2 = [[UIView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 1)];
//    viewLine2.backgroundColor = [UIColor grayColor];
//    [ balanceView addSubview:viewLine2];
    
    [self addSubview:balanceView];
    //NSLog(@"dddddddddddddddddd");
    
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
