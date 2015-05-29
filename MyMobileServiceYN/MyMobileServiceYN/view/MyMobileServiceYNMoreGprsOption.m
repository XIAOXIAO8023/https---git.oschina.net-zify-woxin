//
//  MyMobileServiceYNMoreGprsOption.m
//  MyMobileServiceYN
//
//  Created by CRMac on 14-3-14.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNMoreGprsOption.h"
#import "MyMobileServiceYNCircle.h"
#import "MyMobileServiceYNMoreGprsOptionVC.h"

#import "GlobalDef.h"

@implementation MyMobileServiceYNMoreGprsOption


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setFlowOption:(NSMutableArray *)array
{
    UIView *circleView = [[UIView alloc]init];
    circleView.backgroundColor = [UIColor clearColor];
    circleView.userInteractionEnabled = YES;
    [self addSubview:circleView];
    
//    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",nil];
//    MyMobileServiceYNMoreGprsOptionVC *vc = [[MyMobileServiceYNMoreGprsOptionVC alloc]init];
//    vc.arrayWithPackage = array;
//    //NSLog(@"%lu",(unsigned long)vc.arrayWithPackage.count);
    
    int row = array.count/6;
    if (array.count%6 != 0) {
        row = row + 1;
    }
    
    for (int i=1; i<=row; i++) {
        if (array.count%6==0||i!=row) {
            for (int j=0; j<3; j++) {
                MyMobileServiceYNCircle *optionCircle1 = [[MyMobileServiceYNCircle alloc]initWithFrame:CGRectMake(20+j*100, 10+100*(i-1), 80, 80)];
                optionCircle1.tag = BUTTON_TAG+j+i*3+1;
                [optionCircle1 setCircleBgColor:UIColorFromRGB(rgbValue_circleBg)];
                optionCircle1.userInteractionEnabled = YES;
                [circleView addSubview:optionCircle1];
                
                UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                gprs1.backgroundColor = [UIColor clearColor];
                gprs1.textAlignment = NSTextAlignmentCenter;
                gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                gprs1.textColor = [UIColor whiteColor];
                gprs1.text = [array objectAtIndex:j+i*3];
                [optionCircle1 addSubview:gprs1];
                
                UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                gprsFee1.backgroundColor = [UIColor clearColor];
                gprsFee1.textAlignment = NSTextAlignmentCenter;
                gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                gprsFee1.textColor = [UIColor whiteColor];
                gprsFee1.text = [array objectAtIndex:j+i*3+1];
                [optionCircle1 addSubview:gprsFee1];
                
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
                btn.backgroundColor = [UIColor redColor];
//                [btn addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
                [btn addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = BUTTON_TAG+j+i*3;
                //btn.userInteractionEnabled = YES;
//                [btn setExclusiveTouch:YES];
                [optionCircle1 addSubview:btn];
            }

        } else {
            for (int j=0; j<(array.count%6)/2; j++) {
                MyMobileServiceYNCircle *optionCircle1 = [[MyMobileServiceYNCircle alloc]initWithFrame:CGRectMake(20+j*100, 10+100*(i-1), 80, 80)];
                optionCircle1.tag = BUTTON_TAG+j+i*3+1;
                [optionCircle1 setCircleBgColor:UIColorFromRGB(rgbValue_circleBg)];
                [circleView addSubview:optionCircle1];
                
                UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                gprs1.backgroundColor = [UIColor clearColor];
                gprs1.textAlignment = NSTextAlignmentCenter;
                gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                gprs1.textColor = [UIColor whiteColor];
                gprs1.text = [array objectAtIndex:j+i*3 ];
                [optionCircle1 addSubview:gprs1];
                
                UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                gprsFee1.backgroundColor = [UIColor clearColor];
                gprsFee1.textAlignment = NSTextAlignmentCenter;
                gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                gprsFee1.textColor = [UIColor whiteColor];
                gprsFee1.text = [array objectAtIndex:j+i*3+1];
                [optionCircle1 addSubview:gprsFee1];
                
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
                btn.backgroundColor = [UIColor clearColor];
                [btn addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = BUTTON_TAG+j+i*3;
                [btn setExclusiveTouch:YES];
                [optionCircle1 addSubview:btn];
                //NSLog(@"1111111");
            }

        }
        
    }
}

    
//    for (int i=0; i<row; i++) {
//        for (int j=0; j<3; j++){
//    
//    MyMobileServiceYNCircle *optionCircle1 = [[MyMobileServiceYNCircle alloc]initWithFrame:CGRectMake(20, 10, 80, 80)];
//    [optionCircle1 setCircleBgColor:UIColorFromRGB(rgbValue_circleBg)];
//    [circleView addSubview:optionCircle1];
//    
//    UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
//    gprs1.backgroundColor = [UIColor clearColor];
//    gprs1.textAlignment = NSTextAlignmentCenter;
//    gprs1.font = [UIFont fontWithName:appTypeFace size:20];
//    gprs1.textColor = [UIColor whiteColor];
//    gprs1.text = [dic objectForKey:@"data1"];
//    [optionCircle1 addSubview:gprs1];
//    
//    UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
//    gprsFee1.backgroundColor = [UIColor clearColor];
//    gprsFee1.textAlignment = NSTextAlignmentCenter;
//    gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
//    gprsFee1.textColor = [UIColor whiteColor];
//    gprsFee1.text = [dic objectForKey:@"money1"];
//    [optionCircle1 addSubview:gprsFee1];
//    
//    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 80, 80)];
//    btn1.backgroundColor = [UIColor clearColor];
//    [btn1 addTarget:self action:@selector(pressed) forControlEvents:UIControlEventTouchUpInside];
//    btn1.tag = BUTTON_TAG+j;
//    [optionCircle1 addSubview:btn1];
//    
//    MyMobileServiceYNCircle *optionCircle2 = [[MyMobileServiceYNCircle alloc]initWithFrame:CGRectMake(120, 10, 80, 80)];
//    [optionCircle2 setCircleBgColor:UIColorFromRGB(rgbValue_circleBg)];
//    [circleView addSubview:optionCircle2];
//    
//    UILabel *gprs2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
//    gprs2.backgroundColor = [UIColor clearColor];
//    gprs2.textAlignment = NSTextAlignmentCenter;
//    gprs2.font = [UIFont fontWithName:appTypeFace size:20];
//    gprs2.textColor = [UIColor whiteColor];
//    gprs2.text = [dic objectForKey:@"data2"];
//    [optionCircle2 addSubview:gprs2];
//    
//    UILabel *gprsFee2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
//    gprsFee2.backgroundColor = [UIColor clearColor];
//    gprsFee2.textAlignment = NSTextAlignmentCenter;
//    gprsFee2.font = [UIFont fontWithName:appTypeFace size:15];
//    gprsFee2.textColor = [UIColor whiteColor];
//    gprsFee2.text = [dic objectForKey:@"money2"];
//    [optionCircle2 addSubview:gprsFee2];
//    
//    MyMobileServiceYNCircle *optionCircle3 = [[MyMobileServiceYNCircle alloc]initWithFrame:CGRectMake(220, 10, 80, 80)];
//    [optionCircle3 setCircleBgColor:UIColorFromRGB(rgbValue_circleBg)];
//    [circleView addSubview:optionCircle3];
//    
//    UILabel *gprs3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
//    gprs3.backgroundColor = [UIColor clearColor];
//    gprs3.textAlignment = NSTextAlignmentCenter;
//    gprs3.font = [UIFont fontWithName:appTypeFace size:20];
//    gprs3.textColor = [UIColor whiteColor];
//    gprs3.text = [dic objectForKey:@"data3"];
//    [optionCircle3 addSubview:gprs3];
//    
//    UILabel *gprsFee3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
//    gprsFee3.backgroundColor = [UIColor clearColor];
//    gprsFee3.textAlignment = NSTextAlignmentCenter;
//    gprsFee3.font = [UIFont fontWithName:appTypeFace size:15];
//    gprsFee3.textColor = [UIColor whiteColor];
//    gprsFee3.text = [dic objectForKey:@"money3"];
//    [optionCircle3 addSubview:gprsFee3];
//    
//    }
//}

-(void)pressed:(id)sender
{
    MyMobileServiceYNCircle *c = (MyMobileServiceYNCircle *)sender;
    [c setCircleBgColor:UIColorFromRGB(rgbValue_greenDiamond)];
    NSLog(@"1111111");
    //int tag = [sender tag];
    //int circleTag = tag - 1;
    
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
