//
//  MyMobileServiceYNGprsOderInfoVC.m
//  MyMobileServiceYN
//
//  Created by Michelle on 14-4-1.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNGprsOderInfoVC.h"
#import "MyMobileServiceYNOrderGprsVC.h"
#import "MyMobileServiceYNGprsPackageInfo.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNHttpRequest.h"
#import "MyMobileServiceYNParam.h"

@interface MyMobileServiceYNGprsOderInfoVC ()

@end

@implementation MyMobileServiceYNGprsOderInfoVC
@synthesize isOpen = _isOpen;
@synthesize array = _array;
@synthesize dic = _dic;
@synthesize pressedTag =_pressedTag;

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
    
    self.title = @"流量订购";
    
    detailScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    detailScroll.delegate = self;
    detailScroll.scrollEnabled = YES;
    if ((_pressedTag-BUTTON_TAG)/100 == 0) {
        detailScroll.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT+100);
    } else {
        if ((_pressedTag-BUTTON_TAG)/100 == 1) {
            detailScroll.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT+300);
        } else {
            if ((_pressedTag-BUTTON_TAG)/100 == 10) {
                detailScroll.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT+120);
            } else {
                detailScroll.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT+80);
            }
        }
    }
    
    detailScroll.showsVerticalScrollIndicator = YES;
    [self.view addSubview:detailScroll];
    
    //显示已订购套餐
//    MyMobileServiceYNOrderGprsVC *gprsVC = [[MyMobileServiceYNOrderGprsVC alloc]init];
//    array = gprsVC.currentOderedPackage;
    
    currentPackageTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, detailScroll.frame.size.width, 30)];
    currentPackageTitle.text = @"当前已订购:";
    currentPackageTitle.textAlignment = UITextAlignmentLeft;
    currentPackageTitle.font = [UIFont fontWithName:appTypeFace size:18];
    [detailScroll addSubview:currentPackageTitle];
    

    if (_isOpen == NO) {
        
        UILabel *currentPackageDetail = [[UILabel alloc]initWithFrame:CGRectMake(17, 15+currentPackageTitle.frame.size.height, detailScroll.frame.size.width, 30)];
        currentPackageDetail.text = @"无";
        currentPackageDetail.textColor = UIColorFromRGB(rgbValueDeepGrey);
        currentPackageDetail.textAlignment = UITextAlignmentLeft;
        currentPackageDetail.font = [UIFont fontWithName:appTypeFace size:16];
        [detailScroll addSubview:currentPackageDetail];
        orderListHeight = 30;
        
    } else {
        for (int i=0; i<(_array.count);i++) {
            UILabel *currentPackageDetail = [[UILabel alloc]initWithFrame:CGRectMake(15, 17+currentPackageTitle.frame.size.height+30*i, detailScroll.frame.size.width, 30)];
            currentPackageDetail.text = [NSString stringWithFormat:@"%d、%@",(i+1),[[_array objectAtIndex:i] objectForKey:@"gprsPackageName"]];
            currentPackageDetail.textAlignment = UITextAlignmentLeft;
            currentPackageDetail.textColor = UIColorFromRGB(rgbValueDeepGrey);
            currentPackageDetail.font = [UIFont fontWithName:appTypeFace size:16];
            [detailScroll addSubview:currentPackageDetail];
            orderListHeight = 30*(i+1);
            
            if ((_pressedTag-BUTTON_TAG)/100 == 0) {
                detailScroll.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT+30*(i+1));
            } else {
                if ((_pressedTag-BUTTON_TAG)/100 == 1) {
                    detailScroll.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT+200+30*(i+1));
                } else {
                    if ((_pressedTag-BUTTON_TAG)/100 == 10) {
                        detailScroll.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT+20+30*(i+1));
                    } else {
                        detailScroll.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT+30*(i+1));
                    }
                }
            }
        }
    }
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15+currentPackageTitle.frame.size.height+orderListHeight+10, SCREEN_WIDTH, 1)];
    line1.backgroundColor = UIColorFromRGB(rgbValue_titlePrompt);
    [detailScroll addSubview:line1];
    
    //显示即将订购的套餐详细信息
//    pressedTag = gprsVC.alertTag;
//    dic = gprsVC.alertDic;
    
    changePackageTip = [[UILabel alloc]initWithFrame:CGRectMake(10, 35+currentPackageTitle.frame.size.height+orderListHeight, SCREEN_WIDTH, 30)];
    changePackageTip.text = @"订购信息";
    changePackageTip.textAlignment = UITextAlignmentLeft;
    changePackageTip.font = [UIFont fontWithName:appTypeFace size:18];
    [detailScroll addSubview:changePackageTip];
    
    changeTitleWidth = 80;
    changeInfoWidth = 220;
    changeInfoXPosition = 100;
    
    changeNameTitle = [[UILabel alloc]initWithFrame:CGRectMake(17, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height, changeTitleWidth, 30)];
    changeNameTitle.text = @"名       称:";
    changeNameTitle.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
    changeNameTitle.textAlignment = UITextAlignmentLeft;
    changeNameTitle.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changeNameTitle];
    
    changeNameInfo = [[UILabel alloc]initWithFrame:CGRectMake(changeInfoXPosition, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height, changeInfoWidth, 30)];
    changeNameInfo.text = [_dic objectForKey:@"gprsPackageName"];
    changeNameInfo.textColor = UIColorFromRGB(rgbValueDeepGrey);
    changeNameInfo.textAlignment = UITextAlignmentLeft;
    changeNameInfo.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changeNameInfo];
    
    changePriceTitle = [[UILabel alloc]initWithFrame:CGRectMake(17, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height, changeTitleWidth, 30)];
    changePriceTitle.text =@"价       格:";
    changePriceTitle.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
    changePriceTitle.textAlignment = UITextAlignmentLeft;
    changePriceTitle.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changePriceTitle];
    
    changePriceInfo = [[UILabel alloc]initWithFrame:CGRectMake(changeInfoXPosition, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameInfo.frame.size.height, changeInfoWidth, 30)];
    changePriceInfo.text = [_dic objectForKey:@"money"];
    changePriceInfo.textColor = UIColorFromRGB(rgbValueDeepGrey);
    changePriceInfo.textAlignment = UITextAlignmentLeft;
    changePriceInfo.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changePriceInfo];
    
    changeFlowTitle = [[UILabel alloc]initWithFrame:CGRectMake(17, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height, changeTitleWidth, 30)];
    changeFlowTitle.text =@"包含流量:";
    changeFlowTitle.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
    changeFlowTitle.textAlignment = UITextAlignmentLeft;
    changeFlowTitle.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changeFlowTitle];
    
    changeFlowInfo = [[UILabel alloc]initWithFrame:CGRectMake(changeInfoXPosition, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameInfo.frame.size.height+changePriceInfo.frame.size.height, changeInfoWidth, 30)];
    changeFlowInfo.text = [_dic objectForKey:@"GPRS"];
    changeFlowInfo.textColor = UIColorFromRGB(rgbValueDeepGrey);
    changeFlowInfo.textAlignment = UITextAlignmentLeft;
    changeFlowInfo.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changeFlowInfo];
    
    changeEffectTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(17, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height, changeTitleWidth, 30)];
    changeEffectTimeTitle.text =@"有效时间:";
    changeEffectTimeTitle.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
    changeEffectTimeTitle.textAlignment = UITextAlignmentLeft;
    changeEffectTimeTitle.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changeEffectTimeTitle];
    
    changeEffectTimeInfo = [[UILabel alloc]initWithFrame:CGRectMake(changeInfoXPosition, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameInfo.frame.size.height+changePriceInfo.frame.size.height+changeFlowInfo.frame.size.height, changeInfoWidth, 30)];
    changeEffectTimeInfo.text = @"次月生效";
    changeEffectTimeInfo.textColor = UIColorFromRGB(rgbValueDeepGrey);
    changeEffectTimeInfo.textAlignment = UITextAlignmentLeft;
    changeEffectTimeInfo.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changeEffectTimeInfo];
    
    changeUseTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(17, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height, changeTitleWidth, 30)];
    changeUseTimeTitle.text = @"使用时间:";
    changeUseTimeTitle.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
    changeUseTimeTitle.textAlignment = UITextAlignmentLeft;
    changeUseTimeTitle.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changeUseTimeTitle];
    
    changeUseTimeInfo = [[UILabel alloc]initWithFrame:CGRectMake(changeInfoXPosition, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameInfo.frame.size.height+changePriceInfo.frame.size.height+changeFlowInfo.frame.size.height+changeEffectTimeInfo.frame.size.height, changeInfoWidth, 30)];
    changeUseTimeInfo.text = @"全天可用";
    changeUseTimeInfo.textColor = UIColorFromRGB(rgbValueDeepGrey);
    if ((_pressedTag-BUTTON_TAG)/100 == 100) {
        changeUseTimeInfo.text = @"23:00至次日8:00可用";
    }
    changeUseTimeInfo.textAlignment = UITextAlignmentLeft;
    changeUseTimeInfo.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changeUseTimeInfo];
    
    changeChargeTypeTitle = [[UILabel alloc]initWithFrame:CGRectMake(17, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height+changeUseTimeTitle.frame.size.height, changeTitleWidth, 30)];
    changeChargeTypeTitle.text = @"收费类型:";
    changeChargeTypeTitle.textColor = UIColorFromRGB(rgbValue_packageDetailInfoTotal);
    changeChargeTypeTitle.textAlignment = UITextAlignmentLeft;
    changeChargeTypeTitle.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changeChargeTypeTitle];
    
    changeChargeTypeInfo = [[UILabel alloc]initWithFrame:CGRectMake(changeInfoXPosition, 35+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameInfo.frame.size.height+changePriceInfo.frame.size.height+changeFlowInfo.frame.size.height+changeEffectTimeInfo.frame.size.height+changeUseTimeInfo.frame.size.height, changeInfoWidth, 30)];
    if ((_pressedTag-BUTTON_TAG)/1000 == 1) {
        changeChargeTypeInfo.text = @"一次性收费，下月自动失效";
    } else {
        changeChargeTypeInfo.text = @"每月定期扣费";
    }
    changeChargeTypeInfo.textAlignment = UITextAlignmentLeft;
    changeChargeTypeInfo.textColor = UIColorFromRGB(rgbValueDeepGrey);
    changeChargeTypeInfo.font = [UIFont fontWithName:appTypeFace size:16];
    [detailScroll addSubview:changeChargeTypeInfo];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameInfo.frame.size.height+changePriceInfo.frame.size.height+changeFlowInfo.frame.size.height+changeEffectTimeInfo.frame.size.height+changeUseTimeInfo.frame.size.height+changeChargeTypeInfo.frame.size.height, SCREEN_WIDTH, 1)];
    line2.backgroundColor = UIColorFromRGB(rgbValue_titlePrompt);
    [detailScroll addSubview:line2];
    
    //温馨提示
    if ((_pressedTag-BUTTON_TAG)/100 == 0) {
        orderPackageTip = [[UILabel alloc]initWithFrame:CGRectMake(10, 55+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height+changeUseTimeTitle.frame.size.height+changeChargeTypeInfo.frame.size.height, SCREEN_WIDTH, 30)];
        orderPackageTip.text = @"温馨提示:";
        orderPackageTip.textAlignment = UITextAlignmentLeft;
        orderPackageTip.font = [UIFont fontWithName:appTypeFace size:18];
        [detailScroll addSubview:orderPackageTip];
        
        orderPackageRule = [[UILabel alloc]initWithFrame:CGRectMake(17, 55+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height+changeUseTimeTitle.frame.size.height+changeChargeTypeInfo.frame.size.height+orderPackageTip.frame.size.height, SCREEN_WIDTH-30, 90)];
        orderPackageRule.text = @"1、超出流量按0.29元/M收取费用.次月生效全天可用每月定期扣费\n2、办理成功后次月使用的上网流量将按新套餐资费收取。";
        orderPackageRule.numberOfLines = 0;
        orderPackageRule.lineBreakMode = UILineBreakModeWordWrap;
        orderPackageRule.textAlignment = UITextAlignmentLeft;
        orderPackageRule.font = [UIFont fontWithName:appTypeFace size:14];
        [detailScroll addSubview:orderPackageRule];
        
    } else {
        if ((_pressedTag - BUTTON_TAG)/100 == 1) {
            orderPackageTip = [[UILabel alloc]initWithFrame:CGRectMake(10, 55+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height+changeUseTimeTitle.frame.size.height+changeChargeTypeInfo.frame.size.height, SCREEN_WIDTH, 30)];
            orderPackageTip.text = @"自动升档套餐规则:";
            orderPackageTip.textAlignment = UITextAlignmentLeft;
            orderPackageTip.font = [UIFont fontWithName:appTypeFace size:18];
            [detailScroll addSubview:orderPackageTip];
            
            orderPackageRule = [[UILabel alloc]initWithFrame:CGRectMake(17, 55+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height+changeUseTimeTitle.frame.size.height+changeChargeTypeInfo.frame.size.height+orderPackageTip.frame.size.height, SCREEN_WIDTH-30, 280)];
            orderPackageRule.text = @"1、必须订购任意一档流量套餐才能享受套餐自动升档服务，如客户之前已经订购包月套餐也不能享受自动升档服务。\n2、自动升档流量套餐与现有的手机上网包月套餐互斥，针对自由流量套餐及订购10元、20元、30元、40元、50元、70元、100元、130、180元、280元手机上网包月套餐客户，订购自动升档套餐后套餐立即生效，当月内订购套餐前产生流量可回溯；订购其余资费手机上网套餐客户订购自动升档套餐后套餐将在次月生效。\n3、订购流量自动升档包客户，仍可订购加油包。\n4、系统为客户自动升档后的流量套餐包，仅当前账期生效。";
            orderPackageRule.numberOfLines = 0;
            orderPackageRule.textAlignment = UITextAlignmentLeft;
            orderPackageRule.font = [UIFont fontWithName:appTypeFace size:14];
            [detailScroll addSubview:orderPackageRule];
        } else {
            if ((_pressedTag - BUTTON_TAG)/100 == 10) {
                orderPackageTip = [[UILabel alloc]initWithFrame:CGRectMake(10, 55+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height+changeUseTimeTitle.frame.size.height+changeChargeTypeInfo.frame.size.height, SCREEN_WIDTH, 30)];
                orderPackageTip.text = @"加油包规则:";
                orderPackageTip.textAlignment = UITextAlignmentLeft;
                orderPackageTip.font = [UIFont fontWithName:appTypeFace size:18];
                [detailScroll addSubview:orderPackageTip];
                
                orderPackageRule = [[UILabel alloc]initWithFrame:CGRectMake(17, 45+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height+changeUseTimeTitle.frame.size.height+changeChargeTypeInfo.frame.size.height+orderPackageTip.frame.size.height, SCREEN_WIDTH-30, 120)];
                orderPackageRule.text = @"1、订购加油包，当天申请，当天生效。\n2、流量加油包订购生效后收取全月费用，当前账期加油包不能取消，下个账期起，流量加油包自动取消。";
                orderPackageRule.numberOfLines = 0;
                orderPackageRule.textAlignment = UITextAlignmentLeft;
                orderPackageRule.font = [UIFont fontWithName:appTypeFace size:16];
                [detailScroll addSubview:orderPackageRule];
            } else {
                orderPackageTip = [[UILabel alloc]initWithFrame:CGRectMake(10, 55+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height+changeUseTimeTitle.frame.size.height+changeChargeTypeInfo.frame.size.height, SCREEN_WIDTH, 30)];
                orderPackageTip.text = @"温馨提示:";
                orderPackageTip.textAlignment = UITextAlignmentLeft;
                orderPackageTip.font = [UIFont fontWithName:appTypeFace size:18];
                [detailScroll addSubview:orderPackageTip];
                
                orderPackageRule = [[UILabel alloc]initWithFrame:CGRectMake(17, 55+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height+changeUseTimeTitle.frame.size.height+changeChargeTypeInfo.frame.size.height+orderPackageTip.frame.size.height, SCREEN_WIDTH-10, 80)];
                orderPackageRule.text = @"1、闲时时间段：23:00至次日8:00。\n2、闲时包订购后，立即生效。";
                orderPackageRule.numberOfLines = 0;
                orderPackageRule.textAlignment = UITextAlignmentLeft;
                orderPackageRule.font = [UIFont fontWithName:appTypeFace size:14];
                [detailScroll addSubview:orderPackageRule];
            }
            
        }
    }
    orderPackageRule.textColor = UIColorFromRGB(rgbValueDeepGrey);
    
    confirmChange = [[UIButton alloc]initWithFrame:CGRectMake(40, 50+currentPackageTitle.frame.size.height+orderListHeight+changePackageTip.frame.size.height+changeNameTitle.frame.size.height+changePriceTitle.frame.size.height+changeFlowTitle.frame.size.height+changeEffectTimeTitle.frame.size.height+changeUseTimeTitle.frame.size.height+changeChargeTypeInfo.frame.size.height+orderPackageTip.frame.size.height+orderPackageRule.frame.size.height, SCREEN_WIDTH-80, 40)];
    confirmChange.tag = _pressedTag - BUTTON_TAG;
    if (_isOpen == YES &&confirmChange.tag/1000!=1) {
        [confirmChange setTitle:@"确 认 变 更" forState:UIControlStateNormal];
    }else
    {
        [confirmChange setTitle:@"确 认 订 购" forState:UIControlStateNormal];
    }
    
    [confirmChange addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
    [confirmChange.layer setCornerRadius:6.0f];
    [confirmChange setBackgroundColor:UIColorFromRGB(rgbValueTitleBlue)];
    [detailScroll addSubview:confirmChange];
    
    orderPackageString = [_dic objectForKey:@"gprsPackageName"];
    orderElementId = [_dic objectForKey:@"SVC_DESC"];
    orderLevel = [_dic objectForKey:@"LEVEL"];
    
    detailScroll.contentSize = CGSizeMake(SCREEN_WIDTH, confirmChange.frame.origin.y + confirmChange.frame.size.height +20);
    
}

-(void)pressed:(id)sender
{
    
    
    if ( _isOpen == NO || ([sender tag]/1000) == 1) {
        
        NSString *tips = [NSString stringWithFormat:@"您正在订购:%@，订购后即时生效,是否订购？",orderPackageString];
        
        UIAlertView *addPackage = [[UIAlertView alloc]initWithTitle:nil message:tips delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [addPackage show];
        
        
    } else {
        
        NSString *tips = [NSString stringWithFormat:@"您正在变更:%@。变更后即时生效,是否变更？",orderPackageString];
        
        UIAlertView *changePackage = [[UIAlertView alloc]initWithTitle:nil message:tips delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [changePackage show];
    }

    
}

-(void)dealloc{
    [httpRequest setRequestDelegatNil];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DebugNSLog(@"--------------%d",buttonIndex);
    if (buttonIndex == 1) {
        
        [HUD showTextHUDWithVC:self.navigationController.view];
        
        if ((_pressedTag - BUTTON_TAG)/1000 == 1) {
            httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
            requestBeanDic=[[NSMutableDictionary alloc]init];
            busiCode = @"ChangeOverlying";
            
            requestBeanDic=[httpRequest getHttpPostParamData:@"ChangeOverlying"];
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [requestBeanDic setObject:@"D" forKey:@"ELEMENT_TYPE_CODE"];
            [requestBeanDic setObject:orderLevel forKey:@"LEVEL"];
            [requestBeanDic setObject:orderElementId forKey:@"ELEMENT_ID"];
            [requestBeanDic setObject:@"0" forKey:@"MODIFY_TAG"];
            [httpRequest startAsynchronous:@"ChangeOverlying" requestParamData:requestBeanDic viewController:self];
        } else {
            httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
            requestBeanDic=[[NSMutableDictionary alloc]init];
            busiCode = @"changeProductNew";
            
            requestBeanDic=[httpRequest getHttpPostParamData:@"changeProductNew"];
            [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
            [requestBeanDic setObject:@"D" forKey:@"ELEMENT_TYPE_CODE"];
            [requestBeanDic setObject:orderElementId forKey:@"ELEMENT_ID"];
            [requestBeanDic setObject:@"0" forKey:@"MODIFY_TAG"];
            [httpRequest startAsynchronous:@"changeProductNew" requestParamData:requestBeanDic viewController:self];
        }

    }
}

-(void)requestFinished:(ASIHTTPRequest *)requestBean
{
    //先remove等待框，否则发送广播后容易出现空指针。
    if(HUD){
        [HUD removeHUD];
    }
    
    NSData *jsonData =[requestBean responseData];
    DebugNSLog(@"%@",[requestBean responseString]);
    NSArray *array1 = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableDictionary *fomerDic = [array1 objectAtIndex:0];
    
    if ([busiCode isEqualToString:@"changeProductNew"]) {
        if ([[fomerDic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
            NSString *returnMessage = [returnMessageDeal returnMessage:[fomerDic objectForKey:@"X_RESULTCODE"] andreturnMessage:[fomerDic objectForKey:@"X_RESULTINFO"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"办理成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            [alertView show];
            
//            [HUD showTextHUDWithVC:self.navigationController.view];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refresh" object:Nil];
        } else {
            if ([@"1620" isEqualToString:[fomerDic objectForKey:@"X_RESULTCODE"]])//超时
            {
//                NSString *returnMessage = [returnMessageDeal returnMessage:[fomerDic objectForKey:@"X_RESULTCODE"] andreturnMessage:[fomerDic objectForKey:@"X_RESULTINFO"]];
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//                alertView.tag = ALERTVIEW_TAG_RETURN+10;
//                [alertView show];
                httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
                busiCode = @"HQSM_IntegralQryAcctInfos";
                NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
                [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
                [requestParamData setObject:@"HQSM_IntegralQryAcctInfos" forKey:@"intf_code"];
                [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
            }else
            {
                NSString *returnMessage = [returnMessageDeal returnMessage:[fomerDic objectForKey:@"X_RESULTCODE"] andreturnMessage:[fomerDic objectForKey:@"X_RESULTINFO"]];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                alertView.tag = ALERTVIEW_TAG_RETURN+1;
                [alertView show];
            }
        }
    }
    
    if ([busiCode isEqualToString:@"ChangeOverlying"]) {
        if ([[fomerDic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
            NSString *returnMessage = [returnMessageDeal returnMessage:[fomerDic objectForKey:@"X_RESULTCODE"] andreturnMessage:[fomerDic objectForKey:@"X_RESULTINFO"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"办理成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            [alertView show];
        } else {
            if ([@"1620" isEqualToString:[fomerDic objectForKey:@"X_RESULTCODE"]])//超时
            {
//                NSString *returnMessage = [returnMessageDeal returnMessage:[fomerDic objectForKey:@"X_RESULTCODE"] andreturnMessage:[fomerDic objectForKey:@"X_RESULTINFO"]];
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//                alertView.tag = ALERTVIEW_TAG_RETURN+10;
//                [alertView show];
                httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
                busiCode = @"HQSM_IntegralQryAcctInfos";
                NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:busiCode];
                [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
                [requestParamData setObject:@"HQSM_IntegralQryAcctInfos" forKey:@"intf_code"];
                [httpRequest startAsynchronous:busiCode requestParamData:requestParamData viewController:self];
            }else
            {
                if ([@"201308130001"isEqualToString:[fomerDic objectForKey:@"X_RESULTCODE"]]) {
                    NSString *returnMessage = [returnMessageDeal returnMessage:[fomerDic objectForKey:@"X_RESULTCODE"] andreturnMessage:[fomerDic objectForKey:@"X_RESULTINFO"]];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您本月办理加油叠加优惠已达20次上限，本月不能再办理，感谢您的使用!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    alertView.tag = ALERTVIEW_TAG_RETURN+100;
                    [alertView show];
                } else {
                    NSString *returnMessage = [returnMessageDeal returnMessage:[fomerDic objectForKey:@"X_RESULTCODE"] andreturnMessage:[fomerDic objectForKey:@"X_RESULTINFO"]];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    alertView.tag = ALERTVIEW_TAG_RETURN+1;
                    [alertView show];
                }
            }
        }
    }
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    DebugNSLog(@"----------2---------%@",error);
    NSString *returnMessage = [returnMessageDeal returnMessage:@"" andreturnMessage:@""];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN+2;
    [alertView show];
    if(HUD){
        [HUD removeHUD];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
