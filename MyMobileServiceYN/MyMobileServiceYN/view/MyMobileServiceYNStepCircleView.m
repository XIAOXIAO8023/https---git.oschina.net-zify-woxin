//
//  MyMobileServiceYNStepCircleView.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-2.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNStepCircleView.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNStepCircleView ()

@end

@implementation MyMobileServiceYNStepCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(UIView *)setStepView:(NSInteger)stepNumber withString:(NSString *)title{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    view.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    
    for (int i=0; i<4; i++) {
        UIView *baseView=[[UIView alloc]initWithFrame:CGRectMake(40+70*i, 0, 70, 60)];
        baseView.backgroundColor=[UIColor clearColor];
        [view addSubview: baseView];
        
        UIImageView *circle=[[UIImageView alloc]initWithFrame:CGRectMake(0, 15, 30, 30)];
        circle.backgroundColor=[UIColor clearColor];
        if(stepNumber==i+1){
            circle.image=[UIImage imageNamed:@"step_on"];
        }else{
            circle.image=[UIImage imageNamed:@"step_off"];
        }
        [baseView addSubview:circle];
        
        UILabel *stepNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        stepNumLabel.text=[NSString stringWithFormat:@"%d",i+1];
        stepNumLabel.backgroundColor=[UIColor clearColor];
        stepNumLabel.textColor=[UIColor whiteColor];
        stepNumLabel.font=[UIFont fontWithName:appTypeFace size:20];
        stepNumLabel.textAlignment=NSTextAlignmentCenter;
        [circle addSubview:stepNumLabel];
        
        if(i<3){
            UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 40, 1)];
            lineImageView.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
            [baseView addSubview:lineImageView];
        }
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake((stepNumber-1)*60, 55, 130, 24)];
        titleLabel.text=title;
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textColor=UIColorFromRGB(rgbValueTitleBlue);
        titleLabel.font=[UIFont fontWithName:appTypeFace size:18];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [view addSubview:titleLabel];
        
    }
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 87, SCREEN_WIDTH, 1)];
    line.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [view addSubview:line];
    
    return view;
}


@end
