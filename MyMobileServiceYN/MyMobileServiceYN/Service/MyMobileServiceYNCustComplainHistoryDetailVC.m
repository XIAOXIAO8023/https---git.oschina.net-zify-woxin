//
//  MyMobileServiceYNCustComplainHistoryDetailVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNCustComplainHistoryDetailVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNCustComplainHistoryDetailVC ()

@end

@implementation MyMobileServiceYNCustComplainHistoryDetailVC
@synthesize sheetNumber=_sheetNumber;

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
    self.title = @"投诉详情";
    httpRequest=[[MyMobileServiceYNHttpRequest alloc]init];
    complainDetailInfo=[[NSMutableDictionary alloc]init];
    complainDetailHeight=0;
    complainDetailCurrentHeight=0;

    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-StatusBar_HEIGHT)];
    homeScrollView.backgroundColor = UIColorFromRGB(rgbValueBgGrey);
    homeScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:homeScrollView];
    
    UIView *complainHearderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    complainHearderView.backgroundColor=[UIColor clearColor];
    [homeScrollView addSubview:complainHearderView];
    
    UIImageView *complainImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    complainImageView.image=[UIImage imageNamed:@"msg_lishitousuico"];
    [complainHearderView addSubview:complainImageView];
    
    UILabel *complainHeaderLabel=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 140, 44)];
    complainHeaderLabel.backgroundColor=[UIColor clearColor];
    complainHeaderLabel.font=[UIFont fontWithName:appTypeFace size:18];
    complainHeaderLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    complainHeaderLabel.text=@"历史投诉详情";
    [complainHearderView addSubview:complainHeaderLabel];

    [HUD showTextHUDWithVC:self.navigationController.view];
    
    busiCode=@"queryComplainDetail";
    NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
    [requestBeanDic setObject:_sheetNumber forKey:@"sheetNumber"];
    [requestBeanDic setObject:@"123456" forKey:@"SERIAL_NUMBER"];
    [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[request responseData];
    DebugNSLog(@"%@",[request responseString]);
    
    NSDictionary *dic = [[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil] objectAtIndex:0];
    if([busiCode isEqualToString:@"queryComplainDetail"]){
        if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
            complainDetailInfo = [[NSMutableDictionary alloc]initWithDictionary:dic];
            
            busiCode = @"queryWorkState";
            NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
            [requestBeanDic setObject:@"30" forKey:@"acceptFrom"];
            [requestBeanDic setObject:_sheetNumber forKey:@"sheetNumber"];
            [requestBeanDic setObject:@"123456" forKey:@"SERIAL_NUMBER"];
            [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
        }else{
            NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG_RETURN+1;
            [alertView show];
        }
    }else{
        if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
            [complainDetailInfo setObject:[dic objectForKey:@"workStateDesc"] forKey:@"workState"];
            [self setComplainDetailView];
        }else{
            NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG_RETURN+1;
            [alertView show];
        }
        if(HUD){
            [HUD removeHUD];
        }
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSString *returnMessage = [returnMessageDeal returnMessage:@"网络异常" andreturnMessage:@""];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN+2;
    [alertView show];
    if(HUD){
        [HUD removeHUD];
    }
}


-(void)setComplainDetailView{
    UIView *complainDetailView=[[UIView alloc]init];
    complainDetailView.backgroundColor=[UIColor whiteColor];
    [complainDetailView.layer setBorderColor:[UIColorFromRGB(rgbValue_scrollLine) CGColor]];
    [complainDetailView.layer setBorderWidth:1.0];  //边框宽度
    [complainDetailView.layer setCornerRadius:10.0f]; //边框弧度
    [complainDetailView.layer setMasksToBounds:YES];
    [homeScrollView addSubview:complainDetailView];
    
    UIView *complainCodeView=[[UIView alloc]init];
    complainCodeView.backgroundColor=[UIColor clearColor];
    [self setView:complainCodeView withTitle:@"工单编号：" withValue:[complainDetailInfo objectForKey:@"sheetNumber"]];
    complainCodeView.frame=CGRectMake(0, 0, SCREEN_WIDTH-20, complainDetailCurrentHeight);
    [complainDetailView addSubview:complainCodeView];
    
    UIView *complainPhoneView=[[UIView alloc]init];
    complainPhoneView.backgroundColor=[UIColor clearColor];
    [self setView:complainPhoneView withTitle:@"投诉号码：" withValue:[complainDetailInfo objectForKey:@"serviceNumber"]];
    complainPhoneView.frame=CGRectMake(0, complainDetailHeight-complainDetailCurrentHeight, SCREEN_WIDTH-20, complainDetailCurrentHeight);
    [complainDetailView addSubview:complainPhoneView];
    
    UIView *complainAddressView=[[UIView alloc]init];
    complainAddressView.backgroundColor=[UIColor clearColor];
    if([[complainDetailInfo objectForKey:@"acceptFrom"] integerValue]==30){
        [self setView:complainAddressView withTitle:@"受理渠道：" withValue:@"网站投诉"];
    }else{
        [self setView:complainAddressView withTitle:@"受理渠道：" withValue:@"短信营业厅投诉"];
    }
    complainAddressView.frame=CGRectMake(0, complainDetailHeight-complainDetailCurrentHeight, SCREEN_WIDTH-20, complainDetailCurrentHeight);
    [complainDetailView addSubview:complainAddressView];
    
    UIView *complainTimeView=[[UIView alloc]init];
    complainTimeView.backgroundColor=[UIColor clearColor];
    if([[complainDetailInfo objectForKey:@"sheetType"] integerValue]==10){
        [self setView:complainTimeView withTitle:@"工单类型：" withValue:@"投诉"];
    }else if([[complainDetailInfo objectForKey:@"sheetType"] integerValue]==20){
        [self setView:complainTimeView withTitle:@"工单类型：" withValue:@"建议"];
    }else{
        [self setView:complainTimeView withTitle:@"工单类型：" withValue:@"咨询"];
    }
    complainTimeView.frame=CGRectMake(0, complainDetailHeight-complainDetailCurrentHeight, SCREEN_WIDTH-20, complainDetailCurrentHeight);
    [complainDetailView addSubview:complainTimeView];
    
    UIView *complainStatusView=[[UIView alloc]init];
    complainStatusView.backgroundColor=[UIColor clearColor];
    [self setView:complainStatusView withTitle:@"工单状态：" withValue:[complainDetailInfo objectForKey:@"workState"]];
    complainStatusView.frame=CGRectMake(0, complainDetailHeight-complainDetailCurrentHeight, SCREEN_WIDTH-20, complainDetailCurrentHeight);
    [complainDetailView addSubview:complainStatusView];
    
    UIView *complainContentView=[[UIView alloc]init];
    complainContentView.backgroundColor=[UIColor clearColor];
    [self setView:complainContentView withTitle:@"投诉内容：" withValue:[complainDetailInfo objectForKey:@"complainContent"]];
    complainContentView.frame=CGRectMake(0, complainDetailHeight-complainDetailCurrentHeight, SCREEN_WIDTH-20, complainDetailCurrentHeight);
    [complainDetailView addSubview:complainContentView];
    
    UIView *complainResponseView=[[UIView alloc]init];
    complainResponseView.backgroundColor=[UIColor clearColor];
    [self setView:complainResponseView withTitle:@"回复内容：" withValue:[complainDetailInfo objectForKey:@"replyContent"]];
    complainResponseView.frame=CGRectMake(0, complainDetailHeight-complainDetailCurrentHeight, SCREEN_WIDTH-20, complainDetailCurrentHeight);
    [complainDetailView addSubview:complainResponseView];
    
    complainDetailView.frame=CGRectMake(10, 44, SCREEN_WIDTH-20, complainDetailHeight+20);
    
}

-(void)setView:(UIView *)view withTitle:(NSString *)title withValue:(NSString *)value{
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.font=[UIFont fontWithName:appTypeFace size:16];
    titleLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    titleLabel.text=title;
    titleLabel.textAlignment=NSTextAlignmentRight;
    [view addSubview:titleLabel];
    
    UILabel *valueLabel=[[UILabel alloc]init];
    valueLabel.backgroundColor=[UIColor clearColor];
    valueLabel.font=[UIFont fontWithName:appTypeFace size:16];
    valueLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
    valueLabel.text=value;
    valueLabel.numberOfLines=0;
    [view addSubview:valueLabel];
    
    UILabel *line=[[UILabel alloc]init];
    line.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [view addSubview:line];
    
    CGSize size=CGSizeMake(200, 2000);
    UIFont *font=[UIFont fontWithName:appTypeFace size:16];
    CGSize labelSize=[valueLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];

    if(labelSize.height<44){
        labelSize=CGSizeMake(200, 44);
        titleLabel.frame=CGRectMake(10, 10, 80, 30);
        valueLabel.frame=CGRectMake(95, 10, 200, 30);
        line.frame=CGRectMake(90, 44-0.5, 205, 0.5);
        complainDetailCurrentHeight=44;
    }else{
        titleLabel.frame=CGRectMake(10, 10, 80, 20);
        valueLabel.frame=CGRectMake(95, 10, 200, labelSize.height);
        line.frame=CGRectMake(90, labelSize.height+10-0.5, 205, 0.5);
        complainDetailCurrentHeight=labelSize.height+15;
    }
    
    complainDetailHeight+=complainDetailCurrentHeight;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
