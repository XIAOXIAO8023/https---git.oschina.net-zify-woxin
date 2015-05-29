//
//  MyMobileServiceYNAboutUSVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-28.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNAboutUSVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNParam.h"

#define fHeight 44

@interface MyMobileServiceYNAboutUSVC ()

@end

@implementation MyMobileServiceYNAboutUSVC
@synthesize background;

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
    
    self.title=@"关于我们";
    
    //根据屏幕大小适配
    NSInteger fSeqHeight = 10;
    if(SCREEN_HEIGHT>480){
        fSeqHeight = 20;
        background = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-40-fSeqHeight)];
    }else{
        fSeqHeight = 15;
        background = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-50-fSeqHeight)];;
    }
    
    background.image = [UIImage imageNamed:@"splash_bg"];
    [self.view addSubview:background];
    
    UILabel *clientName=[[UILabel alloc]initWithFrame:CGRectMake(0,30, SCREEN_WIDTH, 30)];
    clientName.text=@"云南移动手机营业厅";
    clientName.textAlignment=NSTextAlignmentCenter;
    clientName.backgroundColor=[UIColor clearColor];
    clientName.textColor=UIColorFromRGB(rgbValueDeepGrey);
    clientName.font=[UIFont fontWithName:appTypeFace size:20];
    [self.view addSubview:clientName];
    
    UILabel *version=[[UILabel alloc]initWithFrame:CGRectMake(0, clientName.frame.origin.y+clientName.frame.size.height+fSeqHeight, SCREEN_WIDTH, 15)];
    version.text=[NSString stringWithFormat:@"For iPhone %@",[MyMobileServiceYNParam getVersion]];
    version.textAlignment=NSTextAlignmentCenter;
    version.backgroundColor=[UIColor clearColor];
    version.textColor=UIColorFromRGB(rgbValueDeepGrey);
    version.font=[UIFont fontWithName:appTypeFace size:12];
    [self.view addSubview:version];
    
    UILabel *descText=[[UILabel alloc]initWithFrame:CGRectMake(20, version.frame.origin.y+version.frame.size.height+fSeqHeight, SCREEN_WIDTH-40, 80)];
    descText.text=@"    云南移动手机营业厅是面向云南移动智能终端用户的官方客户端软件，为您提供快速便捷的查询、办理和交费等自助功能，方便您随时随地、随心随行地享受云南移动服务。";
    descText.numberOfLines=0;
    descText.textAlignment=NSTextAlignmentLeft;
    descText.backgroundColor=[UIColor clearColor];
    descText.textColor=UIColorFromRGB(rgbValueDeepGrey);
    descText.font=[UIFont fontWithName:appTypeFace size:12];
    [self.view addSubview:descText];
    
    UILabel *servicePhoneText=[[UILabel alloc]initWithFrame:CGRectMake(80, descText.frame.origin.y+descText.frame.size.height+fSeqHeight*2, 120, 20)];
    servicePhoneText.text=@"24小时客服热线：";
    servicePhoneText.backgroundColor=[UIColor clearColor];
    servicePhoneText.textColor=UIColorFromRGB(rgbValueDeepGrey);
    servicePhoneText.font=[UIFont fontWithName:appTypeFace size:14];
    [self.view addSubview:servicePhoneText];
    
    UILabel *servicePhone=[[UILabel alloc]initWithFrame:CGRectMake(200, descText.frame.origin.y+descText.frame.size.height+fSeqHeight*2, 40, 20)];
    servicePhone.text=@"10086";
    servicePhone.backgroundColor=[UIColor clearColor];
    servicePhone.textColor=UIColorFromRGB(rgbValueDeepGrey);
    servicePhone.font=[UIFont fontWithName:appTypeFace size:14];
    [self.view addSubview:servicePhone];
    
//    UILabel *copyrightChinese=[[UILabel alloc]initWithFrame:CGRectMake(0, servicePhone.frame.origin.y+servicePhone.frame.size.height+fSeqHeight, SCREEN_WIDTH, 20)];
//    copyrightChinese.text=@"中国移动    版权所有";
//    copyrightChinese.textAlignment=NSTextAlignmentCenter;
//    copyrightChinese.backgroundColor=[UIColor clearColor];
//    copyrightChinese.textColor=UIColorFromRGB(rgbValueDeepGrey);
//    copyrightChinese.font=[UIFont fontWithName:appTypeFace size:16];
//    [self.view addSubview:copyrightChinese];
//    
//    UILabel *copyrightEnglish=[[UILabel alloc]initWithFrame:CGRectMake(0, copyrightChinese.frame.origin.y+copyrightChinese.frame.size.height+fSeqHeight, SCREEN_WIDTH, 15)];
//    copyrightEnglish.text=@"Copyright @ 2014 China Mobile All Rights Reserved";
//    copyrightEnglish.textAlignment=NSTextAlignmentCenter;
//    copyrightEnglish.backgroundColor=[UIColor clearColor];
//    copyrightEnglish.textColor=UIColorFromRGB(rgbValueDeepGrey);
//    copyrightEnglish.font=[UIFont fontWithName:appTypeFace size:10];
//    [self.view addSubview:copyrightEnglish];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
