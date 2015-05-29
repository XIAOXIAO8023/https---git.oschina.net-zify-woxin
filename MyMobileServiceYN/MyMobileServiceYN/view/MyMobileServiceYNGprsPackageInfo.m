//
//  MyMobileServiceYNGprsPackageInfo.m
//  MyMobileServiceYN
//
//  Created by Michelle on 14-3-13.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNGprsPackageInfo.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNCircle.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNOrderGprsVC.h"
#import "MyMobileServiceYNGprsOderInfoVC.h"

@implementation MyMobileServiceYNGprsPackageInfo
@synthesize busicode = _busicode;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void)setView:(NSMutableDictionary *)dic withViewController:(UIViewController *)viewcontroller withNsmutableArray: (NSMutableArray *)elementID
{
    VC = viewcontroller;
    //获取应用程序沙盒的Documents目录
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [path objectAtIndex:0];
    
    //获取文件名
    NSString *configFilePath = [plistPath stringByAppendingPathComponent:@"GprsList.plist"];
    DebugNSLog(@"%@",configFilePath);
    
    monthlyPackage = [[NSArray alloc]init];
    upshiftPackage = [[NSArray alloc]init];
    refuelPackage = [[NSArray alloc]init];
    leisurePackage = [[NSArray alloc]init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:configFilePath] == NO) {
        DebugNSLog(@"GprsList.plist does not exist");
        NSString *path = [[NSBundle mainBundle]pathForResource:@"GprsList" ofType:@"plist"];
        NSMutableDictionary *configDic = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
        [configDic writeToFile:configFilePath atomically:YES];
    }
    
    NSMutableDictionary *packageDic = [[[NSMutableDictionary alloc]initWithContentsOfFile:configFilePath]objectForKey:@"gprsInfo"];
    monthlyPackage = [packageDic objectForKey:@"monthlyGprs"];
    upshiftPackage = [packageDic objectForKey:@"upshiftGprs"];
    refuelPackage = [packageDic objectForKey:@"refuelGprs"];
    leisurePackage = [packageDic objectForKey:@"leisureGprs"];
    
//    UIScrollView *viewBg = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 14, self.frame.size.width-20, self.frame.size.height)];
//    viewBg.contentSize = CGSizeMake(self.frame.size.width-24, 500);
//    if (SCREEN_HEIGHT == 568) {
//        viewBg.scrollEnabled = NO;
//    } else {
//        viewBg.scrollEnabled = YES;
//    }
    
    UIView *viewBg = [[UIView alloc]initWithFrame:CGRectMake(10, 14, self.frame.size.width-20, self.frame.size.height)];
    
    viewBg.backgroundColor = [UIColor whiteColor];
    [viewBg.layer setCornerRadius:5];
    [viewBg.layer setBorderWidth:1];
    [viewBg.layer setBorderColor:[UIColorFromRGB(rgbValue_scrollLine) CGColor]];
    if (SCREEN_HEIGHT == 480) {
        [viewBg.layer setBorderColor:[UIColorFromRGB(rgbValue_scrollLine2) CGColor]];
    }
    [viewBg.layer setMasksToBounds:YES];
    [self addSubview:viewBg];
    
    UILabel *TitleNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, viewBg.frame.size.width, 30)];
    if (SCREEN_HEIGHT == 480) {
            TitleNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 18, viewBg.frame.size.width, 28)];
    }
    TitleNameLabel.textAlignment = NSTextAlignmentCenter;
    TitleNameLabel.font = [UIFont fontWithName:appTypeFace size:20.0];
    TitleNameLabel.text = [dic objectForKey:@"TitleName"];
    TitleNameLabel.textColor = UIColorFromRGB(rgbValue_titleName);
    [viewBg addSubview:TitleNameLabel];
    
    UIImageView *flowLIne1 = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-223.5)/2, 30+TitleNameLabel.frame.size.height, 223.5, 1)];
    if (SCREEN_HEIGHT == 480) {
        flowLIne1 = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-223.5)/2, 19+TitleNameLabel.frame.size.height, 223.5, 1)];
    }
    flowLIne1.image = [UIImage imageNamed:[dic objectForKey:@"FlowLine"]];
    [viewBg addSubview:flowLIne1];
    
    UILabel *TitlePromptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 32+TitleNameLabel.frame.size.height+1, viewBg.frame.size.width, 30)];
    if (SCREEN_HEIGHT == 480) {
        TitlePromptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20+TitleNameLabel.frame.size.height+1, viewBg.frame.size.width, 28)];
    }
    TitlePromptLabel.textAlignment = NSTextAlignmentCenter;
    TitlePromptLabel.font = [UIFont fontWithName:appTypeFace size:15.0];
    TitlePromptLabel.text = [dic objectForKey:@"TitlePrompt"];
    TitlePromptLabel.textColor = UIColorFromRGB(rgbValue_titlePrompt);
    [viewBg addSubview:TitlePromptLabel];
    
    UIImageView *flowPic = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-145)/2, 40+TitleNameLabel.frame.size.height+1+TitlePromptLabel.frame.size.height, 133, 133)];
    if (SCREEN_HEIGHT == 480) {
        flowPic = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-145)/2, 19+TitleNameLabel.frame.size.height+1+TitlePromptLabel.frame.size.height, 133, 133)];
    }
    flowPic.image = [UIImage imageNamed:[dic objectForKey:@"FlowPic"]];
    [viewBg addSubview:flowPic];
    
    UIImageView *flowfs = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-210)/2, 44+TitleNameLabel.frame.size.height+1+TitlePromptLabel.frame.size.height+flowPic.frame.size.height+5, 200, 16)];
    if (SCREEN_HEIGHT == 480) {
        flowfs = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-210)/2, 21+TitleNameLabel.frame.size.height+1+TitlePromptLabel.frame.size.height+flowPic.frame.size.height+5, 200, 16)];
    }
    flowfs.image = [UIImage imageNamed:[dic objectForKey:@"FlowFs"]];
    [viewBg addSubview:flowfs];
    
//    UIImageView *flowLIne2 = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-223.5)/2, 5+TitleNameLabel.frame.size.height+1+TitlePromptLabel.frame.size.height+flowPic.frame.size.height+5+flowfs.frame.size.height+5, 223.5, 1)];
//    flowLIne2.image = [UIImage imageNamed:[dic objectForKey:@"FlowLine"]];
//    [viewBg addSubview:flowLIne2];
    
    UIView *viewBg1 = [[UIView alloc]initWithFrame:CGRectMake(0, 60+TitleNameLabel.frame.size.height+1+TitlePromptLabel.frame.size.height+flowPic.frame.size.height+5+flowfs.frame.size.height +1, SCREEN_WIDTH, viewBg.frame.size.height - 5+TitleNameLabel.frame.size.height+1+TitlePromptLabel.frame.size.height+flowPic.frame.size.height+5+flowfs.frame.size.height +1)];
    if (SCREEN_HEIGHT == 480) {
        viewBg1 = [[UIView alloc]initWithFrame:CGRectMake(0, 30+TitleNameLabel.frame.size.height+1+TitlePromptLabel.frame.size.height+flowPic.frame.size.height+5+flowfs.frame.size.height +1, SCREEN_WIDTH, viewBg.frame.size.height - 5+TitleNameLabel.frame.size.height+1+TitlePromptLabel.frame.size.height+flowPic.frame.size.height+5+flowfs.frame.size.height +1)];
    }
    viewBg1.backgroundColor = UIColorFromRGB(rgbValue_backColorBottom);
    [viewBg addSubview:viewBg1];
    
    UIImage *arrowLeft = [UIImage imageNamed:@"flow_jtleft"];
    UIImageView *touchLeft = [[UIImageView alloc]initWithFrame:CGRectMake(10, 140, 97, 15)];
    if (SCREEN_HEIGHT == 480) {
        touchLeft = [[UIImageView alloc]initWithFrame:CGRectMake(10, 108, 97, 15)];
    }
    [touchLeft setImage:arrowLeft];
    [viewBg1 addSubview:touchLeft];
    
    UIImage *arrowRight = [UIImage imageNamed:@"flow_jtright"];
    UIImageView *touchRight = [[UIImageView alloc]initWithFrame:CGRectMake(190, 140, 97, 15)];
    if (SCREEN_HEIGHT == 480) {
        touchRight = [[UIImageView alloc]initWithFrame:CGRectMake(190, 108, 97, 15)];
    }
    [touchRight setImage:arrowRight];
    [viewBg1 addSubview:touchRight];
    
    UIScrollView *circleView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-20, 100)];
    if (SCREEN_HEIGHT == 480) {
        circleView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 8, SCREEN_WIDTH-20, 100)];
    }
    circleView.delegate = self;
    circleView.pagingEnabled = YES;
    circleView.showsHorizontalScrollIndicator = NO;
    NSString *iTag = [dic objectForKey:@"button"];
    int scrollTag = [iTag integerValue];
    switch (scrollTag) {
        case BUTTON_TAG+1:
            circleView.contentSize = CGSizeMake(100*3*(monthlyPackage.count/3)+100*3*(monthlyPackage.count%3==0?0:1), 100);
            break;
        case BUTTON_TAG+101:
            circleView.contentSize = CGSizeMake(100*3*(upshiftPackage.count/3)+100*3*(upshiftPackage.count%3==0?0:1), 100);
            //DebugNSLog(@"contentsize--------------%f",circleView.contentSize.width);
            break;
        case BUTTON_TAG+1001:
            circleView.contentSize = CGSizeMake(100*3*(refuelPackage.count/3)+100*3*(refuelPackage.count%3==0?0:1), 100);
            break;
        case BUTTON_TAG+10001:
            circleView.contentSize = CGSizeMake(100*3*(leisurePackage.count/3)+100*3*(leisurePackage.count%3==0?0:1), 100);
            break;
        default:
            break;
    }
    [circleView setBackgroundColor:[UIColor clearColor]];
    [viewBg1 addSubview:circleView];
    
    monthly1 = [[NSDictionary alloc]init];
    monthly2 = [[NSDictionary alloc]init];
    monthly3 = [[NSDictionary alloc]init];
    
    upshift1 = [[NSDictionary alloc]init];
    upshift2 = [[NSDictionary alloc]init];
    upshift3 = [[NSDictionary alloc]init];
    
    refuel1 = [[NSDictionary alloc]init];
    refuel2 = [[NSDictionary alloc]init];
    refuel3 = [[NSDictionary alloc]init];
    
    switch (scrollTag) {
        case BUTTON_TAG+1:
            if (elementID.count == 0) {
                for (int i=0; i<monthlyPackage.count; i++) {
                    UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 80, 80)];
                    Package1.backgroundColor = [UIColor clearColor];
                    Package1.tag = BUTTON_TAG + 1 + i;
                    //circle1.tag = Package1.tag + 10000;
                    [Package1 setImage:[UIImage imageNamed:@"flow_center1"] forState:UIControlStateNormal];
                    [Package1 setImage: [UIImage imageNamed:@"flow_circleon"]forState:UIControlStateHighlighted];
                    [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
                    [circleView addSubview:Package1];
                    
                    UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                    gprs1.backgroundColor = [UIColor clearColor];
                    gprs1.textAlignment = NSTextAlignmentCenter;
                    monthly1 = [monthlyPackage objectAtIndex:i];
                    gprs1.text = [monthly1 objectForKey:@"GPRS"];
                    gprs1.textColor = UIColorFromRGB(rgbValue_titleName);
                    gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                    
                    [Package1 addSubview:gprs1];
                    
                    UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                    gprsFee1.backgroundColor = [UIColor clearColor];
                    gprsFee1.textAlignment = NSTextAlignmentCenter;
                    gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                    gprsFee1.text = [monthly1 objectForKey:@"money"];
                    gprsFee1.textColor = UIColorFromRGB(rgbValue_titleName);
                    
                    [Package1 addSubview:gprsFee1];
                }

                } else {
                for (int i=0; i<monthlyPackage.count; i++) {
                    for (int j =0 ; j<elementID.count; j++) {
                        if ([[[monthlyPackage objectAtIndex:i] objectForKey:@"SVC_DESC"] isEqualToString:[elementID objectAtIndex:j]]) {
                            [(UIButton *)[self viewWithTag:BUTTON_TAG + 1 + i] removeFromSuperview];
                            UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 80, 80)];
                            Package1.backgroundColor = [UIColor clearColor];
                            Package1.tag = BUTTON_TAG + 1 + i;
                            Package1.enabled = NO;
                            [Package1 setImage:[UIImage imageNamed:@"flow_circle_gray"] forState:UIControlStateNormal];
                            [Package1 setImage: [UIImage imageNamed:@"flow_circleon"]forState:UIControlStateHighlighted];
                            [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
                            [circleView addSubview:Package1];
                            
                            UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                            gprs1.backgroundColor = [UIColor clearColor];
                            gprs1.textAlignment = NSTextAlignmentCenter;
                            monthly1 = [monthlyPackage objectAtIndex:i];
                            gprs1.text = [monthly1 objectForKey:@"GPRS"];
                            gprs1.textColor = UIColorFromRGB(rgbValue_titlePrompt);
                            gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                            
                            [Package1 addSubview:gprs1];
                            
                            UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                            gprsFee1.backgroundColor = [UIColor clearColor];
                            gprsFee1.textAlignment = NSTextAlignmentCenter;
                            gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                            gprsFee1.text = [monthly1 objectForKey:@"money"];
                            gprsFee1.textColor = UIColorFromRGB(rgbValue_titlePrompt);
                            
                            [Package1 addSubview:gprsFee1];
                            break;
                        } else {
                            UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 80, 80)];
                            Package1.backgroundColor = [UIColor clearColor];
                            Package1.tag = BUTTON_TAG + 1 + i;
                            //circle1.tag = Package1.tag + 10000;
                            [Package1 setImage:[UIImage imageNamed:@"flow_center1"] forState:UIControlStateNormal];
                            [Package1 setImage: [UIImage imageNamed:@"flow_circleon"]forState:UIControlStateHighlighted];
                            [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
                            [circleView addSubview:Package1];
                            
                            UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                            gprs1.backgroundColor = [UIColor clearColor];
                            gprs1.textAlignment = NSTextAlignmentCenter;
                            monthly1 = [monthlyPackage objectAtIndex:i];
                            gprs1.text = [monthly1 objectForKey:@"GPRS"];
                            gprs1.textColor = UIColorFromRGB(rgbValue_titleName);
                            gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                            
                            [Package1 addSubview:gprs1];
                            
                            UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                            gprsFee1.backgroundColor = [UIColor clearColor];
                            gprsFee1.textAlignment = NSTextAlignmentCenter;
                            gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                            gprsFee1.text = [monthly1 objectForKey:@"money"];
                            gprsFee1.textColor = UIColorFromRGB(rgbValue_titleName);
                            
                            [Package1 addSubview:gprsFee1];
                        }
                    }
                }
            }
            

            break;
        case BUTTON_TAG+101:
            if (elementID.count == 0) {
                for (int i=0; i<upshiftPackage.count; i++) {
                    UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 80, 80)];
                    Package1.backgroundColor = [UIColor clearColor];
                    Package1.tag = BUTTON_TAG + 101 + i;
                    //circle1.tag = Package1.tag + 10000;
                    [Package1 setImage:[UIImage imageNamed:@"flow_center1"] forState:UIControlStateNormal];
                    [Package1 setImage: [UIImage imageNamed:@"flow_circleon"]forState:UIControlStateHighlighted];
                    [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
                    [circleView addSubview:Package1];
                    
                    UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                    gprs1.backgroundColor = [UIColor clearColor];
                    gprs1.textAlignment = NSTextAlignmentCenter;
                    upshift1 = [upshiftPackage objectAtIndex:i];
                    gprs1.text = [upshift1 objectForKey:@"GPRS"];
                    gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                    //gprs1.textColor = [UIColor whiteColor];
                    gprs1.textColor = UIColorFromRGB(rgbValue_titleName);
                    
                    [Package1 addSubview:gprs1];
                    
                    UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                    gprsFee1.backgroundColor = [UIColor clearColor];
                    gprsFee1.textAlignment = NSTextAlignmentCenter;
                    gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                    //gprsFee1.textColor = [UIColor whiteColor];
                    gprsFee1.text = [upshift1 objectForKey:@"money"];
                    gprsFee1.textColor = UIColorFromRGB(rgbValue_titleName);
                    
                    [Package1 addSubview:gprsFee1];

                }
            }else
            {
                for (int i=0; i<upshiftPackage.count; i++) {
                    for (int j =0 ; j<elementID.count; j++) {
                        if ([[[upshiftPackage objectAtIndex:i] objectForKey:@"SVC_DESC"] isEqualToString:[elementID objectAtIndex:j]]) {
                            [(UIButton *)[self viewWithTag:BUTTON_TAG + 101 + i] removeFromSuperview];
                            UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 80, 80)];
                            Package1.backgroundColor = [UIColor clearColor];
                            Package1.tag = BUTTON_TAG + 101 + i;
                            Package1.enabled = NO;
                            [Package1 setImage:[UIImage imageNamed:@"flow_circle_gray"] forState:UIControlStateNormal];
                            [Package1 setImage: [UIImage imageNamed:@"flow_circleon"]forState:UIControlStateHighlighted];
                            [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
                            [circleView addSubview:Package1];
                            
                            UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                            gprs1.backgroundColor = [UIColor clearColor];
                            gprs1.textAlignment = NSTextAlignmentCenter;
                            upshift1 = [upshiftPackage objectAtIndex:i];
                            gprs1.text = [upshift1 objectForKey:@"GPRS"];
                            DebugNSLog(@"--------------------%@",gprs1.text);
                            gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                            //gprs1.textColor = [UIColor whiteColor];
                            gprs1.textColor = UIColorFromRGB(rgbValue_titlePrompt);
                            
                            [Package1 addSubview:gprs1];
                            
                            UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                            gprsFee1.backgroundColor = [UIColor clearColor];
                            gprsFee1.textAlignment = NSTextAlignmentCenter;
                            gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                            //gprsFee1.textColor = [UIColor whiteColor];
                            gprsFee1.text = [upshift1 objectForKey:@"money"];
                            gprsFee1.textColor = UIColorFromRGB(rgbValue_titlePrompt);
                            
                            [Package1 addSubview:gprsFee1];
                            break;

                        } else {
                            UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 80, 80)];
                            Package1.backgroundColor = [UIColor clearColor];
                            Package1.tag = BUTTON_TAG + 101 + i;
                            //circle1.tag = Package1.tag + 10000;
                            [Package1 setImage:[UIImage imageNamed:@"flow_center1"] forState:UIControlStateNormal];
                            [Package1 setImage: [UIImage imageNamed:@"flow_circleon"]forState:UIControlStateHighlighted];
                            [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
                            [circleView addSubview:Package1];
                            
                            UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                            gprs1.backgroundColor = [UIColor clearColor];
                            gprs1.textAlignment = NSTextAlignmentCenter;
                            upshift1 = [upshiftPackage objectAtIndex:i];
                            gprs1.text = [upshift1 objectForKey:@"GPRS"];
                            gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                            //gprs1.textColor = [UIColor whiteColor];
                            gprs1.textColor = UIColorFromRGB(rgbValue_titleName);
                            
                            [Package1 addSubview:gprs1];
                            
                            UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                            gprsFee1.backgroundColor = [UIColor clearColor];
                            gprsFee1.textAlignment = NSTextAlignmentCenter;
                            gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                            //gprsFee1.textColor = [UIColor whiteColor];
                            gprsFee1.text = [upshift1 objectForKey:@"money"];
                            gprsFee1.textColor = UIColorFromRGB(rgbValue_titleName);
                            
                            [Package1 addSubview:gprsFee1];

                        }
                    }
                }
            }
            
            
                break;
        case BUTTON_TAG+1001:
            for (int i=0; i<refuelPackage.count; i++) {
            
                UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 80, 80)];
                Package1.backgroundColor = [UIColor clearColor];
                Package1.tag = BUTTON_TAG + 1001 + i;
                //circle1.tag = Package1.tag + 10000;
                [Package1 setImage:[UIImage imageNamed:@"flow_center1"] forState:UIControlStateNormal];
                [Package1 setImage: [UIImage imageNamed:@"flow_circleon"]forState:UIControlStateHighlighted];
                [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
                [circleView addSubview:Package1];
                
                UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                gprs1.backgroundColor = [UIColor clearColor];
                gprs1.textAlignment = NSTextAlignmentCenter;
                refuel1 = [refuelPackage objectAtIndex:i];
                gprs1.text = [refuel1 objectForKey:@"GPRS"];
                gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                //gprs1.textColor = [UIColor whiteColor];
                gprs1.textColor = UIColorFromRGB(rgbValue_titleName);
                
                [Package1 addSubview:gprs1];
                
                UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                gprsFee1.backgroundColor = [UIColor clearColor];
                gprsFee1.textAlignment = NSTextAlignmentCenter;
                gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                //gprsFee1.textColor = [UIColor whiteColor];
                gprsFee1.text = [refuel1 objectForKey:@"money"];
                gprsFee1.textColor = UIColorFromRGB(rgbValue_titleName);
                [Package1 addSubview:gprsFee1];
            }
            break;
        case BUTTON_TAG+10001:
            if (elementID.count == 0) {
                for (int i=0; i<leisurePackage.count; i++) {
                    UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 80, 80)];
                    Package1.backgroundColor = [UIColor clearColor];
                    Package1.tag = BUTTON_TAG + 10001 + i;
                    //circle1.tag = Package1.tag + 10000;
                    [Package1 setImage:[UIImage imageNamed:@"flow_center1"] forState:UIControlStateNormal];
                    [Package1 setImage: [UIImage imageNamed:@"flow_circleon"]forState:UIControlStateHighlighted];
                    [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
                    [circleView addSubview:Package1];
                    
                    UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                    gprs1.backgroundColor = [UIColor clearColor];
                    gprs1.textAlignment = NSTextAlignmentCenter;
                    monthly1 = [leisurePackage objectAtIndex:i];
                    gprs1.text = [monthly1 objectForKey:@"GPRS"];
                    gprs1.textColor = UIColorFromRGB(rgbValue_titleName);
                    gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                    
                    [Package1 addSubview:gprs1];
                    
                    UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                    gprsFee1.backgroundColor = [UIColor clearColor];
                    gprsFee1.textAlignment = NSTextAlignmentCenter;
                    gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                    gprsFee1.text = [monthly1 objectForKey:@"money"];
                    gprsFee1.textColor = UIColorFromRGB(rgbValue_titleName);
                    
                    [Package1 addSubview:gprsFee1];
                }
                
            } else {
                for (int i=0; i<leisurePackage.count; i++) {
                    for (int j =0 ; j<elementID.count; j++) {
                        if ([[[leisurePackage objectAtIndex:i] objectForKey:@"SVC_DESC"] isEqualToString:[elementID objectAtIndex:j]]) {
                            [(UIButton *)[self viewWithTag:BUTTON_TAG + 10001 + i] removeFromSuperview];
                            UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 80, 80)];
                            Package1.backgroundColor = [UIColor clearColor];
                            Package1.tag = BUTTON_TAG + 10001 + i;
                            Package1.enabled = NO;
                            [Package1 setImage:[UIImage imageNamed:@"flow_circle_gray"] forState:UIControlStateNormal];
                            [Package1 setImage: [UIImage imageNamed:@"flow_circleon"]forState:UIControlStateHighlighted];
                            [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
                            [circleView addSubview:Package1];
                            
                            UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                            gprs1.backgroundColor = [UIColor clearColor];
                            gprs1.textAlignment = NSTextAlignmentCenter;
                            refuel1 = [leisurePackage objectAtIndex:i];
                            gprs1.text = [refuel1 objectForKey:@"GPRS"];
                            gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                            //gprs1.textColor = [UIColor whiteColor];
                            gprs1.textColor = UIColorFromRGB(rgbValue_titlePrompt);
                            
                            [Package1 addSubview:gprs1];
                            
                            UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                            gprsFee1.backgroundColor = [UIColor clearColor];
                            gprsFee1.textAlignment = NSTextAlignmentCenter;
                            gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                            //gprsFee1.textColor = [UIColor whiteColor];
                            gprsFee1.text = [refuel1 objectForKey:@"money"];
                            gprsFee1.textColor = UIColorFromRGB(rgbValue_titlePrompt);
                            [Package1 addSubview:gprsFee1];
                            break;

                            
                        } else {
                            UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(100*i, 10, 80, 80)];
                            Package1.backgroundColor = [UIColor clearColor];
                            Package1.tag = BUTTON_TAG + 10001 + i;
                            //circle1.tag = Package1.tag + 10000;
                            [Package1 setImage:[UIImage imageNamed:@"flow_center1"] forState:UIControlStateNormal];
                            [Package1 setImage: [UIImage imageNamed:@"flow_circleon"]forState:UIControlStateHighlighted];
                            [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
                            [circleView addSubview:Package1];
                            
                            UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
                            gprs1.backgroundColor = [UIColor clearColor];
                            gprs1.textAlignment = NSTextAlignmentCenter;
                            refuel1 = [leisurePackage objectAtIndex:i];
                            gprs1.text = [refuel1 objectForKey:@"GPRS"];
                            gprs1.font = [UIFont fontWithName:appTypeFace size:20];
                            //gprs1.textColor = [UIColor whiteColor];
                            gprs1.textColor = UIColorFromRGB(rgbValue_titleName);
                            
                            [Package1 addSubview:gprs1];
                            
                            UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
                            gprsFee1.backgroundColor = [UIColor clearColor];
                            gprsFee1.textAlignment = NSTextAlignmentCenter;
                            gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
                            //gprsFee1.textColor = [UIColor whiteColor];
                            gprsFee1.text = [refuel1 objectForKey:@"money"];
                            gprsFee1.textColor = UIColorFromRGB(rgbValue_titleName);
                            [Package1 addSubview:gprsFee1];

                        }
                    }
                }
            }

            break;
            
        default:
            break;
    }
    
//    MyMobileServiceYNCircle *circle1 = [[MyMobileServiceYNCircle alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
//    [circle1 setCircleBgColor:UIColorFromRGB(rgbValue_circleBg)];
//    [circleView addSubview:circle1];
//    
//    UIButton *Package1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
//    Package1.backgroundColor = [UIColor clearColor];
//    NSString *buttonTag1 = [dic objectForKey:@"button"];
//    int Tag1 = [buttonTag1 integerValue];
//    Package1.tag = Tag1;
//    [Package1 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
//    [circle1 addSubview:Package1];
//    
//    UILabel *gprs1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
//    gprs1.backgroundColor = [UIColor clearColor];
//    gprs1.textAlignment = NSTextAlignmentCenter;
//    gprs1.font = [UIFont fontWithName:appTypeFace size:20];
//    gprs1.textColor = [UIColor whiteColor];
//    if (Package1.tag == BUTTON_TAG+1) {
//        gprs1.text = [monthly1 objectForKey:@"GPRS"];
//    }
//    if (Package1.tag == BUTTON_TAG+2) {
//        gprs1.text = [upshift1 objectForKey:@"GPRS"];
//    }
//    if (Package1.tag == BUTTON_TAG+3) {
//        gprs1.text = [refuel1 objectForKey:@"GPRS"];
//    }
//    [circle1 addSubview:gprs1];
//    
//    UILabel *gprsFee1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
//    gprsFee1.backgroundColor = [UIColor clearColor];
//    gprsFee1.textAlignment = NSTextAlignmentCenter;
//    gprsFee1.font = [UIFont fontWithName:appTypeFace size:15];
//    gprsFee1.textColor = [UIColor whiteColor];
//    if (Package1.tag == BUTTON_TAG+1) {
//            gprsFee1.text = [monthly1 objectForKey:@"money"];
//    }
//    if (Package1.tag == BUTTON_TAG+2) {
//        gprsFee1.text = [upshift1 objectForKey:@"money"];
//    }
//    if (Package1.tag == BUTTON_TAG+3) {
//        gprsFee1.text = [refuel1 objectForKey:@"money"];
//    }
//
//    [circle1 addSubview:gprsFee1];
    
//    MyMobileServiceYNCircle *circle2 = [[MyMobileServiceYNCircle alloc]initWithFrame:CGRectMake(110, 10, 80, 80)];
//    [circle2 setCircleBgColor:UIColorFromRGB(rgbValue_circleBg)];
//    [circleView addSubview:circle2];
//    
//    UIButton *Package2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
//    Package2.backgroundColor = [UIColor clearColor];
//    NSString *buttonTag2 = [dic objectForKey:@"button"];
//    int Tag2 = [buttonTag2 integerValue];
//    Package2.tag = Tag2+100;
//    [Package2 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
//    [circle2 addSubview:Package2];
//    //DebugNSLog(@"----------------------%d",Package2.tag);
//    
//    UILabel *gprs2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
//    gprs2.backgroundColor = [UIColor clearColor];
//    gprs2.textAlignment = NSTextAlignmentCenter;
//    gprs2.font = [UIFont fontWithName:appTypeFace size:20];
//    gprs2.textColor = [UIColor whiteColor];
//    if (Package2.tag == BUTTON_TAG+101) {
//        gprs2.text = [monthly2 objectForKey:@"GPRS"];
//    }
//    if (Package2.tag == BUTTON_TAG+102) {
//        gprs2.text = [upshift2 objectForKey:@"GPRS"];
//    }
//    if (Package2.tag == BUTTON_TAG+103) {
//        gprs2.text = [refuel2 objectForKey:@"GPRS"];
//    }
//    [circle2 addSubview:gprs2];
//    
//    UILabel *gprsFee2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
//    gprsFee2.backgroundColor = [UIColor clearColor];
//    gprsFee2.textAlignment = NSTextAlignmentCenter;
//    gprsFee2.font = [UIFont fontWithName:appTypeFace size:15];
//    gprsFee2.textColor = [UIColor whiteColor];
//    if (Package2.tag == BUTTON_TAG+101) {
//        gprsFee2.text = [monthly2 objectForKey:@"money"];
//    }
//    if (Package2.tag == BUTTON_TAG+102) {
//        gprsFee2.text = [upshift2 objectForKey:@"money"];
//    }
//    if (Package2.tag == BUTTON_TAG+103) {
//        gprsFee2.text = [refuel2 objectForKey:@"money"];
//    }
//    [circle2 addSubview:gprsFee2];
//    
//    
//    MyMobileServiceYNCircle *circle3 = [[MyMobileServiceYNCircle alloc]initWithFrame:CGRectMake(210, 10, 80, 80)];
//    [circle3 setCircleBgColor:UIColorFromRGB(rgbValue_circleBg)];
//    [circleView addSubview:circle3];
//    
//    UIButton *Package3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
//    Package3.backgroundColor = [UIColor clearColor];
//    NSString *buttonTag3 = [dic objectForKey:@"button"];
//    int Tag3 = [buttonTag3 integerValue];
//    Package3.tag = Tag3+1000;
//    [Package3 addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
//    [circle3 addSubview:Package3];
//    
//    UILabel *gprs3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 25)];
//    gprs3.backgroundColor = [UIColor clearColor];
//    gprs3.textAlignment = NSTextAlignmentCenter;
//    gprs3.font = [UIFont fontWithName:appTypeFace size:20];
//    gprs3.textColor = [UIColor whiteColor];
//    if (Package3.tag == BUTTON_TAG+1001) {
//        gprs3.text = [monthly3 objectForKey:@"GPRS"];
//    }
//    if (Package3.tag == BUTTON_TAG+1002) {
//        gprs3.text = [upshift3 objectForKey:@"GPRS"];
//    }
//    if (Package3.tag == BUTTON_TAG+1003) {
//        gprs3.text = [refuel3 objectForKey:@"GPRS"];
//    }
//    [circle3 addSubview:gprs3];
//    
//    UILabel *gprsFee3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, 80, 20)];
//    gprsFee3.backgroundColor = [UIColor clearColor];
//    gprsFee3.textAlignment = NSTextAlignmentCenter;
//    gprsFee3.font = [UIFont fontWithName:appTypeFace size:15];
//    gprsFee3.textColor = [UIColor whiteColor];
//    if (Package3.tag == BUTTON_TAG+1001) {
//        gprsFee3.text = [monthly3 objectForKey:@"money"];
//    }
//    if (Package3.tag == BUTTON_TAG+1002) {
//        gprsFee3.text = [upshift3 objectForKey:@"money"];
//    }
//    if (Package3.tag == BUTTON_TAG+1003) {
//        gprsFee3.text = [refuel3 objectForKey:@"money"];
//    }    [circle3 addSubview:gprsFee3];
    
}

-(void)pressedButton:(id)sender
{
    MyMobileServiceYNOrderGprsVC *GprsVC = (MyMobileServiceYNOrderGprsVC *)VC;
    GprsVC.alertTag = [sender tag];
    GprsVC.alertDic = [[NSMutableDictionary alloc]init];
    
    touchedPackage = [[NSMutableDictionary alloc]init];
    //NSString *sendTag = [NSString stringWithFormat:@"%d",[sender tag]];
    
    if (([sender tag]-BUTTON_TAG)/100 == 0) {
        touchedPackage = [monthlyPackage objectAtIndex:[sender tag]-BUTTON_TAG-1];
    } else {
        if (([sender tag]-BUTTON_TAG)/100 == 1) {
            touchedPackage = [upshiftPackage objectAtIndex:[sender tag]-BUTTON_TAG-101];
        } else {
            if (([sender tag]-BUTTON_TAG)/1000 == 1) {
                touchedPackage = [refuelPackage objectAtIndex:[sender tag]-BUTTON_TAG-1001];
            } else {
                touchedPackage = [leisurePackage objectAtIndex:[sender tag]-BUTTON_TAG-10001];
            }
        }
    }
    
    GprsVC.alertDic = touchedPackage;
    
    MyMobileServiceYNGprsOderInfoVC *packageDetail = [[MyMobileServiceYNGprsOderInfoVC alloc]init];
    packageDetail.isOpen = GprsVC.isOpen;
    packageDetail.array = GprsVC.currentOderedPackage;
    packageDetail.dic = GprsVC.alertDic;
    packageDetail.pressedTag = [sender tag];
    [GprsVC.navigationController pushViewController:packageDetail animated:YES];
//    [packageDetail setNewPackageDetail:GprsVC.alertDic withTagString:sendTag];
    
    

//    if([sender tag] == BUTTON_TAG+1){
//        m1 = [NSDictionary dictionaryWithObjectsAndKeys:monthly1,sendTag, nil];
//        [GprsVC.alertDic addEntriesFromDictionary:m1];
//    }
//    if([sender tag] == BUTTON_TAG+101){
//        m2 = [NSDictionary dictionaryWithObjectsAndKeys:monthly2,sendTag, nil];
//        [GprsVC.alertDic addEntriesFromDictionary:m2];
//        DebugNSLog(@"-----------------%@",[monthly2 objectForKey:@"GPRS"]);
//    }
//    if([sender tag] == BUTTON_TAG+1001){
//        m3 = [NSDictionary dictionaryWithObjectsAndKeys:monthly3,sendTag, nil];
//        [GprsVC.alertDic addEntriesFromDictionary:m3];
//    }
//    
//    NSDictionary *u1 = [[NSDictionary alloc]init];
//    NSDictionary *u2 = [[NSDictionary alloc]init];
//    NSDictionary *u3 = [[NSDictionary alloc]init];
//    
//    if([sender tag] == BUTTON_TAG+2){
//        u1 = [NSDictionary dictionaryWithObjectsAndKeys:upshift1,sendTag, nil];
//        [GprsVC.alertDic addEntriesFromDictionary:u1];
//    }
//    if([sender tag] == BUTTON_TAG+102){
//        u2 = [NSDictionary dictionaryWithObjectsAndKeys:upshift2,sendTag, nil];
//        [GprsVC.alertDic addEntriesFromDictionary:u2];
//    }
//    if([sender tag] == BUTTON_TAG+1002){
//        u3 = [NSDictionary dictionaryWithObjectsAndKeys:upshift3,sendTag, nil];
//        [GprsVC.alertDic addEntriesFromDictionary:u3];
//        
//    }
//    
//    NSDictionary *r1 = [[NSDictionary alloc]init];
//    NSDictionary *r2 = [[NSDictionary alloc]init];
//    NSDictionary *r3 = [[NSDictionary alloc]init];
//    
//    if([sender tag] == BUTTON_TAG+3){
//        r1 = [NSDictionary dictionaryWithObjectsAndKeys:refuel1,sendTag, nil];
//        [GprsVC.alertDic addEntriesFromDictionary:r1];
//    }
//    if([sender tag] == BUTTON_TAG+103){
//        r2 = [NSDictionary dictionaryWithObjectsAndKeys:refuel2,sendTag, nil];
//        [GprsVC.alertDic addEntriesFromDictionary:r2];
//    }
//    if([sender tag] == BUTTON_TAG+1003){
//        r3 = [NSDictionary dictionaryWithObjectsAndKeys:refuel3,sendTag, nil];
//        [GprsVC.alertDic addEntriesFromDictionary:r3];
//    }
    
//    [GprsVC.alertDic addEntriesFromDictionary:m1];
//    [GprsVC.alertDic addEntriesFromDictionary:m2];
//    [GprsVC.alertDic addEntriesFromDictionary:m3];
//    [GprsVC.alertDic addEntriesFromDictionary:u1];
//    [GprsVC.alertDic addEntriesFromDictionary:u2];
//    [GprsVC.alertDic addEntriesFromDictionary:u3];
//    [GprsVC.alertDic addEntriesFromDictionary:r1];
//    [GprsVC.alertDic addEntriesFromDictionary:r2];
//    [GprsVC.alertDic addEntriesFromDictionary:r3];
    
//    
//    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
//    requestBeanDic=[[NSMutableDictionary alloc]init];
//    
//    requestBeanDic=[httpRequest getHttpPostParamData:@"GetAllElementEC"];
//    [requestBeanDic setObject:@"13887268707" forKey:@"SERIAL_NUMBER"];
//    [requestBeanDic setObject:@"D" forKey:@"ELEMENT_TYPE_CODE"];
//    [httpRequest startAsynchronous:@"GetAllElementEC" requestParamData:requestBeanDic viewController:VC];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"toSetBusiCode" object:nil];
    
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
