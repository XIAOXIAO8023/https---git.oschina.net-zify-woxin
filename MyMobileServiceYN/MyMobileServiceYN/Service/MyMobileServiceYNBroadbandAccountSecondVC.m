//
//  MyMobileServiceYNBroadbandAccountSecondVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-1.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBroadbandAccountSecondVC.h"
#import "MyMobileServiceYNBroadbandAccountThirdVC.h"
#import "MyMobileServiceYNStepCircleView.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNBroadbandAccountSecondVC ()

@end

@implementation MyMobileServiceYNBroadbandAccountSecondVC
@synthesize broadBandDic=_broadBandDic;

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
    
    self.title=@"新装宽带";
    
    httpRequest=[[MyMobileServiceYNHttpRequest alloc]init];
    selectedTypeRow=[[NSMutableDictionary alloc]init];
    
    UIView *firstView=[MyMobileServiceYNStepCircleView setStepView:2 withString:@"选择宽带"];
    [self.view addSubview:firstView];
    
    UIView *homeView=[[UIView alloc]initWithFrame:CGRectMake(0, 88, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-88-64)];
    homeView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:homeView];
    
    UIView *selectType=[[UIView alloc]initWithFrame:CGRectMake(20, 10, 280, 25)];
    selectType.backgroundColor=[UIColor clearColor];
    [selectType.layer setBorderColor:[UIColorFromRGB(rgbValueTitleBlue) CGColor]];
    [selectType.layer setBorderWidth:1.0];  //边框宽度
    [selectType.layer setCornerRadius:4.0f]; //边框弧度
    [selectType.layer setMasksToBounds:YES];
    [homeView addSubview:selectType];
    
    UIButton *singleButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 130, 25)];
    singleButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
    [singleButton setTitle:@"宽带单产品" forState:UIControlStateNormal];
    singleButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:18];
    [singleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [singleButton addTarget:self action:@selector(toSelectedType:) forControlEvents:UIControlEventTouchUpInside];
    singleButton.tag=BUTTON_TAG +1;
    [selectType addSubview:singleButton];

    UIButton *markingButton=[[UIButton alloc]initWithFrame:CGRectMake(130, 0, 150, 25)];
    markingButton.backgroundColor=[UIColor whiteColor];
    [markingButton setTitle:@"宽带开户营销活动" forState:UIControlStateNormal];
    [markingButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    markingButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:16];
    [markingButton setTitleColor:UIColorFromRGB(rgbValueLightGrey) forState:UIControlStateNormal];
    [markingButton addTarget:self action:@selector(toSelectedType:) forControlEvents:UIControlEventTouchUpInside];
    markingButton.tag=BUTTON_TAG+2;
    [selectType addSubview:markingButton];
    
    packageTypeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, homeView.frame.size.height-44)];
    packageTypeScrollView.delegate = self;
    packageTypeScrollView.showsHorizontalScrollIndicator = NO;//水平
    packageTypeScrollView.showsVerticalScrollIndicator = NO;//垂直
    packageTypeScrollView.scrollEnabled = NO;
    packageTypeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, homeView.frame.size.height-44);
    [packageTypeScrollView setBackgroundColor:[UIColor whiteColor]];
    packageTypeScrollView.pagingEnabled= YES;
    [homeView addSubview:packageTypeScrollView];
    
    for(int i=0;i<2;i++){
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, packageTypeScrollView.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.backgroundColor=[UIColor clearColor];
        tableView.tag=TABLE_TAG+i+1;
        [packageTypeScrollView addSubview:tableView];
    }
    
    UIView *thirdView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-64, SCREEN_WIDTH, 64)];
    thirdView.backgroundColor=UIColorFromRGB(rgbValue_packageInfo_headerViewBG);
    [self.view addSubview:thirdView];
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor=UIColorFromRGB(rgbValue_scrollLine);
    [thirdView addSubview:line];
    
    nextButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 44)];
    nextButton.backgroundColor=UIColorFromRGB(rgbValue_broadBand_noButtonBg);
    [nextButton setTitle:@"下一步:输入个人信息" forState:UIControlStateNormal];
    nextButton.titleLabel.font=[UIFont fontWithName:appTypeFace size:20];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //4个参数是上边界，左边界，下边界，右边界
    [nextButton addTarget:self action:@selector(toNextVC) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonBorder:nextButton];
    nextButton.enabled=NO;
    [thirdView addSubview:nextButton];
    
    [HUD showTextHUDWithVC:self.navigationController.view];
    
    [self sendSingeHttpRequest];
    
}

-(void)toSelectedType:(id)sender{
    if(BUTTON_TAG+1==[sender tag]){
        UIButton *singleButton=(UIButton *)[self.view viewWithTag:BUTTON_TAG+1];
        singleButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
        [singleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIButton *markingButton=(UIButton *)[self.view viewWithTag:BUTTON_TAG+2];
        markingButton.backgroundColor=[UIColor clearColor];
        [markingButton setTitleColor:UIColorFromRGB(rgbValueLightGrey) forState:UIControlStateNormal];
        
        [packageTypeScrollView setContentOffset:CGPointMake(0, 0)];
        [(UITableView *)[self.view viewWithTag:TABLE_TAG+1] reloadData];
        
    }else{
        UIButton *singleButton=(UIButton *)[self.view viewWithTag:BUTTON_TAG+1];
        singleButton.backgroundColor=[UIColor clearColor];
        [singleButton setTitleColor:UIColorFromRGB(rgbValueLightGrey) forState:UIControlStateNormal];
        
        UIButton *markingButton=(UIButton *)[self.view viewWithTag:BUTTON_TAG+2];
        markingButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
        [markingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [packageTypeScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        [(UITableView *)[self.view viewWithTag:TABLE_TAG+2] reloadData];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int contentOffsetX = packageTypeScrollView.contentOffset.x;
    if(contentOffsetX <= CGRectGetWidth(scrollView.frame)) {
        UIButton *singleButton=(UIButton *)[self.view viewWithTag:BUTTON_TAG+1];
        singleButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
        [singleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIButton *markingButton=(UIButton *)[self.view viewWithTag:BUTTON_TAG+2];
        markingButton.backgroundColor=[UIColor clearColor];
        [markingButton setTitleColor:UIColorFromRGB(rgbValueLightGrey) forState:UIControlStateNormal];
        
        [(UITableView *)[self.view viewWithTag:TABLE_TAG+1] reloadData];
        
    }
    if(contentOffsetX >= CGRectGetWidth(scrollView.frame)) {
        UIButton *singleButton=(UIButton *)[self.view viewWithTag:BUTTON_TAG+1];
        singleButton.backgroundColor=[UIColor clearColor];
        [singleButton setTitleColor:UIColorFromRGB(rgbValueLightGrey) forState:UIControlStateNormal];
        
        UIButton *markingButton=(UIButton *)[self.view viewWithTag:BUTTON_TAG+2];
        markingButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
        [markingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [(UITableView *)[self.view viewWithTag:TABLE_TAG+2] reloadData];
    }
}

-(void)sendSingeHttpRequest{
    busiCode=@"WidenetProductInfo";
    NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
    [requestBeanDic setValue:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [requestBeanDic setValue:[MyMobileServiceYNParam getCityCode] forKey:@"EPARCHY_CODE"];
    [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
}

-(void)sendMarkingHttpRequest{
    busiCode=@"WidenetSaleActivePackageInfo";
    NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
    [requestBeanDic setValue:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
    [requestBeanDic setValue:[MyMobileServiceYNParam getCityCode] forKey:@"EPARCHY_CODE"];
    [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
}

#pragma mark---ASIHTTPRequestDelegate
//返回成功
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[request responseData];
    DebugNSLog(@"%@",[request responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
    if([busiCode isEqualToString:@"WidenetProductInfo"]){
        if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
            singlePackageArray=[[NSMutableArray alloc]initWithArray:array];
//            [(UITableView *)[self.view viewWithTag:TABLE_TAG+1] reloadData];
            [self sendMarkingHttpRequest];
        }
        else{
            NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG_RETURN+1;
            [alertView show];
            if(HUD){
                [HUD removeHUD];
            }
        }
    }else if([busiCode isEqualToString:@"WidenetSaleActivePackageInfo"]){
        if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
            marketingPackageArray=[[NSMutableArray alloc]initWithArray:array];
            [(UITableView *)[self.view viewWithTag:TABLE_TAG+1] reloadData];
            [(UITableView *)[self.view viewWithTag:TABLE_TAG+2] reloadData];
        }
        else{
            NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alertView.tag = ALERTVIEW_TAG_RETURN+1;
            [alertView show];
        }
        if(HUD){
            [HUD removeHUD];
        }
    }else if ([busiCode isEqualToString:@"SaleActiveTradeCheck"]){
        if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
            MyMobileServiceYNBroadbandAccountThirdVC *thirdVC=[[MyMobileServiceYNBroadbandAccountThirdVC alloc]init];
            [self.navigationController pushViewController:thirdVC animated:YES];
        }
        else{
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
//返回失败
-(void)requestFailed:(ASIHTTPRequest *)request
{
    DebugNSLog(@"------------requestFailed------------------");
    NSError *error = [request error];
    DebugNSLog(@"----------2---------%@",error);
    NSString *returnMessage = [returnMessageDeal returnMessage:@"网络异常" andreturnMessage:@""];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN+2;
    [alertView show];
    if(HUD){
        [HUD removeHUD];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==TABLE_TAG+1){
        return singlePackageArray.count;
    }else {
        return marketingPackageArray.count;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
        UILabel *clientMessage=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 250, 44)];
        clientMessage.backgroundColor=[UIColor clearColor];
        clientMessage.font=[UIFont fontWithName:appTypeFace size:16];
        clientMessage.textColor=UIColorFromRGB(rgbValueDeepGrey);
        clientMessage.tag=LABEL_TAG+[indexPath row];
        clientMessage.numberOfLines=0;
        [cell.contentView addSubview:clientMessage];
        
        UIImageView *selectedImage=[[UIImageView alloc]initWithFrame:CGRectMake(280, 7, 30, 30)];
        selectedImage.backgroundColor=[UIColor clearColor];
        selectedImage.tag=IMAGE_TAG+[indexPath row];
        [cell.contentView addSubview:selectedImage];
        
    }
    
    NSDictionary *rowData=[[NSDictionary alloc]init];
    if(TABLE_TAG+1==tableView.tag){
        rowData=[singlePackageArray objectAtIndex:[indexPath row]];
    }else{
        rowData=[marketingPackageArray objectAtIndex:[indexPath row]];
    }
    
    UILabel *anlabel=(UILabel *)[cell.contentView viewWithTag:LABEL_TAG+[indexPath row]];
    if(tableView.tag==TABLE_TAG+1){//单产品
        anlabel.text=[rowData objectForKey:@"PRODUCT_NAME"];
    }else
    {//营销活动
        anlabel.text=[rowData objectForKey:@"PACKAGE_NAME"];
    }
    if([[selectedTypeRow objectForKey:[NSString stringWithFormat:@"%d",tableView.tag*100+[indexPath row]]] isEqualToString:@"YES"]){
        anlabel.textColor=UIColorFromRGB(rgbValueButtonGreen);
        UIImageView *anImage=(UIImageView *)[cell.contentView viewWithTag:IMAGE_TAG+[indexPath row]];
        anImage.image=[UIImage imageNamed:@"check"];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UILabel *anLabel=(UILabel *)[self.view viewWithTag:LABEL_TAG+[indexPath row]];
    anLabel.textColor=UIColorFromRGB(rgbValueButtonGreen);
    UIImageView *anImage=(UIImageView *)[self.view viewWithTag:IMAGE_TAG+[indexPath row]];
    anImage.image=[UIImage imageNamed:@"check"];
    [selectedTypeRow removeAllObjects];
    [selectedTypeRow setValue:@"YES" forKey:[NSString stringWithFormat:@"%d",tableView.tag*100+[indexPath row]]];
    if(tableView.tag==TABLE_TAG+1){
        [selectedTypeRow setValue:[singlePackageArray objectAtIndex:[indexPath row]] forKey:@"rowData"];
        [selectedTypeRow setValue:@"single" forKey:@"type"];
    }else{
        [selectedTypeRow setValue:[marketingPackageArray objectAtIndex:[indexPath row]] forKey:@"rowData"];
        [selectedTypeRow setValue:@"marking" forKey:@"type"];
    }
    nextButton.backgroundColor=UIColorFromRGB(rgbValueTitleBlue);
    nextButton.enabled=YES;
    [tableView reloadData];
}

//{"CAMPN_ID":"2013091901000016", "PRODUCT_ID":"69900073","PACKAGE_ID":"72900475" }
//SERIAL_NUMBER CAMPN_ID PRODUCT_ID PACKAGE_ID
//{"X_RESULTINFO":"OK","PROD_SPEC_TYPE":"1001","PRODUCT_ID":"72100023","PRODUCT_NAME":"大理有线宽带26元包28小时套餐","PROD_SPEC_DESC":"2MRADIUS宽带","FEE":"26","X_RESULTCODE":"0","X_RECORDNUM":"15"}
-(void)toNextVC{
    NSDictionary *rowData=[selectedTypeRow objectForKey:@"rowData"];
    if(rowData!=nil){
        if([[selectedTypeRow objectForKey:@"type"]isEqualToString:@"marking"]){
//            [HUD showTextHUDWithVC:self.navigationController.view];
//            
//            busiCode=@"SaleActiveTradeCheck";
//            NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:busiCode];
//            [requestBeanDic setValue:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
//            [requestBeanDic setValue:[MyMobileServiceYNParam getCityCode] forKey:@"EPARCHY_CODE"];
//            if([rowData objectForKey:@"CAMPN_ID"]!=nil){
//                [requestBeanDic setValue:[rowData objectForKey:@"CAMPN_ID"] forKey:@"CAMPN_ID"];
//            }else{
//                [requestBeanDic setValue:@"" forKey:@"CAMPN_ID"];
//            }
//            if([rowData objectForKey:@"PACKAGE_ID"]!=nil){
//                [requestBeanDic setValue:[rowData objectForKey:@"PACKAGE_ID"] forKey:@"PACKAGE_ID"];
//            }else{
//                [requestBeanDic setValue:@"" forKey:@"PACKAGE_ID"];
//            }
//            [requestBeanDic setValue:[rowData objectForKey:@"PRODUCT_ID"] forKey:@"PRODUCT_ID"];
//            [httpRequest startAsynchronous:busiCode requestParamData:requestBeanDic viewController:self];
            
            MyMobileServiceYNBroadbandAccountThirdVC *thirdVC=[[MyMobileServiceYNBroadbandAccountThirdVC alloc]init];
            [_broadBandDic setObject:rowData forKey:@"productInfo"];
            [_broadBandDic setObject:@"2" forKey:@"productType"];//2：营销活动
            thirdVC.broadBandDic=_broadBandDic;
            [self.navigationController pushViewController:thirdVC animated:YES];
        }else{
            MyMobileServiceYNBroadbandAccountThirdVC *thirdVC=[[MyMobileServiceYNBroadbandAccountThirdVC alloc]init];
            [_broadBandDic setObject:rowData forKey:@"productInfo"];
            [_broadBandDic setObject:@"1" forKey:@"productType"];//1：单产品
            thirdVC.broadBandDic=_broadBandDic;
            [self.navigationController pushViewController:thirdVC animated:YES];
        }
    }else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"请选择一种宽带" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag=ALERTVIEW_TAG+1;
        [alertView show];
    }
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==ALERTVIEW_TAG+1){
        
    }else if(alertView.tag==ALERTVIEW_TAG+2){
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [httpRequest setRequestDelegatNil];
}


@end
