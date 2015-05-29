//
//  MyMobileServiceYNMoreGprsOption.m
//  MyMobileServiceYN
//
//  Created by CRMac on 14-3-14.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNMoreGprsOptionVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNMoreGprsOption.h"
#import "MyMobileServiceYNCircle.h"
#import "MyMobileServiceYNHttpRequest.h"

@interface MyMobileServiceYNMoreGprsOptionVC ()

@end

@implementation MyMobileServiceYNMoreGprsOptionVC
@synthesize arrayWithPackage = _arrayWithPackage;
@synthesize pageTag = _pageTag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    switch (_pageTag) {
            
        case BUTTON_TAG+1:
            self.title = @"包月套餐";
            break;
        case BUTTON_TAG+2:
            self.title = @"自动升级";
        case BUTTON_TAG+3:
            self.title = @"流量叠加包";
        default:
            break;
    }
    
    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
    requestBeanDic=[[NSMutableDictionary alloc]init];
    
    requestBeanDic=[httpRequest getHttpPostParamData:@"GetAllElementEC"];
    [requestBeanDic setObject:@"13887268707" forKey:@"SERIAL_NUMBER"];
    [requestBeanDic setObject:@"D" forKey:@"ELEMENT_TYPE_CODE"];
    [httpRequest startAsynchronous:@"GetAllElementEC" requestParamData:requestBeanDic viewController:self];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+50);
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    //已定套餐
    UILabel *currentOrderLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 40)];
    currentOrderLabel1.text = @"当前已订购：";
    currentOrderLabel1.textAlignment = UITextAlignmentRight;
    currentOrderLabel1.font = [UIFont fontWithName:appTypeFace size:15];
    currentOrderLabel1.textColor = UIColorFromRGB(rgbValue_buttonNameBlack);
    [scrollView addSubview:currentOrderLabel1];
    
    UILabel *currentOrderLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH*2/3, 40)];
    currentOrderLabel2.text = @"GPRS 10元套餐";
    currentOrderLabel2.textAlignment = UITextAlignmentLeft;
    currentOrderLabel2.font = [UIFont fontWithName:appTypeFace size:20];
    currentOrderLabel2.textColor = UIColorFromRGB(rgbValue_buttonNameBlack);
    [scrollView addSubview:currentOrderLabel2];
    
    //可选套餐
    NSMutableArray *array = [[NSMutableArray alloc]init];
    //NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"3",@"4",nil];
    int row = array.count/6;
    if (array.count/6!=0) {
        row = row +1;
    }
//     MyMobileServiceYNMoreGprsOption *circle = [[MyMobileServiceYNMoreGprsOption alloc]initWithFrame:CGRectMake(0, currentOrderLabel1.frame.size.height+10, SCREEN_WIDTH, 100*row)];
//    [circle setFlowOption:array];
//    [scrollView addSubview:circle];
    
    UIView *circleView = [[UIView alloc]initWithFrame:CGRectMake(0, currentOrderLabel1.frame.size.height+10, SCREEN_WIDTH, 100*row)];
    circleView.backgroundColor = [UIColor clearColor];
    circleView.userInteractionEnabled = YES;
    [scrollView addSubview:circleView];

    for (int i=1; i<=row; i++) {
        if (array.count%6==0||i!=row) {
            for (int j=0; j<3; j++) {
//                MyMobileServiceYNCircle *optionCircle1 = [[MyMobileServiceYNCircle alloc]initWithFrame:CGRectMake(20+j*100, 10+100*(i-1), 80, 80)];
//                optionCircle1.tag = BUTTON_TAG+j+i*3+1;
//                [optionCircle1 setCircleBgColor:UIColorFromRGB(rgbValue_circleBg)];
//                optionCircle1.userInteractionEnabled = YES;
//                [circleView addSubview:optionCircle1];
                
                UIImageView *optionCircle1 = [[UIImageView alloc]initWithFrame:CGRectMake(20+j*100, 10+100*(i-1), 80, 80)];
                optionCircle1.tag = BUTTON_TAG+j+i*3+100;
                [optionCircle1 setImage:[UIImage imageNamed:@"flow_circleformer"]];
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
                btn.backgroundColor = [UIColor clearColor];
                [btn addTarget:self action:@selector(Ipressed:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = BUTTON_TAG+j+i*3;
                //btn.userInteractionEnabled = YES;
                //[btn setExclusiveTouch:YES];
                [optionCircle1 addSubview:btn];
            }
            
        } else {
            for (int j=0; j<(array.count%6)/2; j++) {
//                MyMobileServiceYNCircle *optionCircle1 = [[MyMobileServiceYNCircle alloc]initWithFrame:CGRectMake(20+j*100, 10+100*(i-1), 80, 80)];
//                optionCircle1.tag = BUTTON_TAG+j+i*3+100;
//                [optionCircle1 setCircleBgColor:UIColorFromRGB(rgbValue_circleBg)];
//                [circleView addSubview:optionCircle1];
                
                UIImageView *optionCircle1 = [[UIImageView alloc]initWithFrame:CGRectMake(20+j*100, 10+100*(i-1), 80, 80)];
                optionCircle1.tag = BUTTON_TAG+j+i*3+100;
                [optionCircle1 setImage:[UIImage imageNamed:@"flow_circleformer"]];
                optionCircle1.userInteractionEnabled = YES;
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
                [btn addTarget:self action:@selector(Ipressed:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = BUTTON_TAG+j+i*3;
                //[btn setExclusiveTouch:YES];
                [optionCircle1 addSubview:btn];
                //NSLog(@"1111111");
            }
            
        }
        
    }
    

    UIButton *btnChange = [[UIButton alloc]initWithFrame:CGRectMake(40, currentOrderLabel1.frame.size.height+10+circleView.frame.size.height+30, 240, 40)];
    [btnChange setTitle:@"确定变更" forState:UIControlStateNormal];
    btnChange.titleLabel.font = [UIFont fontWithName:appTypeFace size:20];
    btnChange.backgroundColor = UIColorFromRGB(rgbValue_greenDiamond);
    btnChange.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btnChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnChange addTarget:self action:@selector(pressed) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btnChange];
    
    UILabel *labelTip = [[UILabel alloc]initWithFrame:CGRectMake(20, currentOrderLabel1.frame.size.height+10+circleView.frame.size.height+btnChange.frame.size.height+40, 280, 100)];
    labelTip.text = @"不能错过的小提示:\n 1、套餐包变更后,立即生效\n 2、超出流量，按0.29元/M收取费用";
    labelTip.numberOfLines = 0;
    labelTip.textAlignment = NSTextAlignmentLeft;
    labelTip.font = [UIFont fontWithName:appTypeFace size:15];
    labelTip.textColor = [UIColor lightGrayColor];
    [scrollView addSubview:labelTip];
}

-(void)pressed
{
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Nil message:@"套餐更改成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
}

-(void)Ipressed:(id)sender
{
    int tag = [sender tag];
//    int lastPressed;
//    if (tag != lastPressed) {
//        UIImageView *circle1 = (UIImageView *)[self.view viewWithTag:lastPressed+100];
//        [circle1 setImage:[UIImage imageNamed:@"flow_circleformer"]];
//    }
    UIImageView *circle = (UIImageView *)[self.view viewWithTag:tag+100];
    [circle setImage:[UIImage imageNamed:@"flow_circlelater"]];
    //MyMobileServiceYNCircle *circle = (MyMobileServiceYNCircle *)[self.view viewWithTag:tag+100];
    //MyMobileServiceYNCircle *c = (MyMobileServiceYNCircle *)sender;
    //[circle setCircleBgColor:UIColorFromRGB(rgbValue_greenDiamond)];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
