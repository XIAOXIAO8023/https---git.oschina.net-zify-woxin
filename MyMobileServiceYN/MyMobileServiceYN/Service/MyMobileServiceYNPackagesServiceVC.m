//
//  MyMobileServiceYNPackagesServiceVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-4-28.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNPackagesServiceVC.h"
#import "MyMobileServiceYNPackagesServiceDetailVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNPackagesServiceVC ()

@end

@implementation MyMobileServiceYNPackagesServiceVC

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
    self.title = @"套餐服务";
//    httpRequest = [[MyMobileServiceYNHttpRequest alloc]init];
//    requestBeanDic=[[NSMutableDictionary alloc]init];
//    
//    //查询用户可办理服务，如果不全部不可办理，则不显示改选项。
//    [HUD showTextHUDWithVC:self.navigationController.view];
//    //登录
//    requestBeanDic=[httpRequest getHttpPostParamData:@"orderService"];
//    [requestBeanDic setObject:@"S" forKey:@"ELEMENT_TYPE_CODE"];
//    [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
//    [requestBeanDic setObject:@"00" forKey:@"PRODUCT_MODE"];
//    [httpRequest startAsynchronous:@"orderService" requestParamData:requestBeanDic viewController:self];
    
    selectProductListItem = @"shenZhouXingList";
    productListArray = [self setProductListArrayByPlist:selectProductListItem];
    //通过按钮来实现
    
    UIButton *shenZhouXingListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shenZhouXingListButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/4, 44);
    shenZhouXingListButton.tag = BUTTON_TAG + 1;
    shenZhouXingListButton.backgroundColor = [UIColor whiteColor];
    shenZhouXingListButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:18];
    [shenZhouXingListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shenZhouXingListButton setTitle:@"神州行" forState:UIControlStateNormal];
    [shenZhouXingListButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shenZhouXingListButton];
    
    UIView *blockLine1 = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4-70)/2, 40, 70, 4)];
    blockLine1.tag = VIEW_TAG +1;
    blockLine1.backgroundColor = UIColorFromRGB(rgbValueButtonGreen);
    [self.view addSubview:blockLine1];
    
    UIButton *quanQiuTongListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    quanQiuTongListButton.frame = CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 44);
    quanQiuTongListButton.tag = BUTTON_TAG + 2;
    quanQiuTongListButton.backgroundColor = [UIColor whiteColor];
    quanQiuTongListButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:18];
    [quanQiuTongListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [quanQiuTongListButton setTitle:@"全球通" forState:UIControlStateNormal];
    [quanQiuTongListButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quanQiuTongListButton];
    
    UIView *blockLine2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4 + (SCREEN_WIDTH/4-70)/2, 40, 70, 4)];
    blockLine2.tag = VIEW_TAG +2;
    blockLine2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:blockLine2];
    
    UIButton *dongGanDiDaiListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dongGanDiDaiListButton.frame = CGRectMake(SCREEN_WIDTH/4*2, 0, SCREEN_WIDTH/4, 44);
    dongGanDiDaiListButton.tag = BUTTON_TAG + 3;
    dongGanDiDaiListButton.backgroundColor = [UIColor whiteColor];
    dongGanDiDaiListButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:18];
    [dongGanDiDaiListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dongGanDiDaiListButton setTitle:@"动感地带" forState:UIControlStateNormal];
    [dongGanDiDaiListButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dongGanDiDaiListButton];
    
    UIView *blockLine3 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*2 + (SCREEN_WIDTH/4-70)/2, 40, 70, 4)];
    blockLine3.tag = VIEW_TAG +3;
    blockLine3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:blockLine3];
    
    UIButton *fourGListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fourGListButton.frame = CGRectMake(SCREEN_WIDTH/4*3, 0, SCREEN_WIDTH/4, 44);
    fourGListButton.tag = BUTTON_TAG + 4;
    fourGListButton.backgroundColor = [UIColor whiteColor];
    fourGListButton.titleLabel.font = [UIFont fontWithName:appTypeFace size:18];
    [fourGListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fourGListButton setTitle:@"4G" forState:UIControlStateNormal];
    [fourGListButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fourGListButton];
    
    UIView *blockLine4 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*3 + (SCREEN_WIDTH/4-70)/2, 40, 70, 4)];
    blockLine4.tag = VIEW_TAG +4;
    blockLine4.backgroundColor = [UIColor clearColor];
    [self.view addSubview:blockLine4];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    line.tag = VIEW_TAG + 5;
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    dataProductListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20-45)];
    dataProductListTableView.dataSource = self;
    dataProductListTableView.delegate = self;
    dataProductListTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dataProductListTableView];
}

//如果没有可办理的基础业务，则隐藏响应的按钮
-(void)resetViewByNoBaseProduct
{
    dataProductListTableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    
    UIButton *button1 = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 1];
    UIButton *button2 = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 2];
    UIButton *button3 = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 3];
    UIButton *button4 = (UIButton *)[self.view viewWithTag:BUTTON_TAG + 4];
    UIView *view1 = (UIView *)[self.view viewWithTag:VIEW_TAG + 1];
    UIView *view2 = (UIView *)[self.view viewWithTag:VIEW_TAG + 2];
    UIView *view3 = (UIView *)[self.view viewWithTag:VIEW_TAG + 3];
    UIView *view4 = (UIView *)[self.view viewWithTag:VIEW_TAG + 4];
    UIView *view5 = (UIView *)[self.view viewWithTag:VIEW_TAG + 5];
    
    
    button1.frame = CGRectMake(0, 0, 0, 0);
    button2.frame = CGRectMake(0, 0, 0, 0);
    button3.frame = CGRectMake(0, 0, 0, 0);
    button4.frame = CGRectMake(0, 0, 0, 0);
    view1.frame = CGRectMake(0, 0, 0, 0);
    view2.frame = CGRectMake(0, 0, 0, 0);
    view3.frame = CGRectMake(0, 0, 0, 0);
    view4.frame = CGRectMake(0, 0, 0, 0);
    view5.frame = CGRectMake(0, 0, 0, 0);
}


-(void)buttonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    //神州行
    if (button.tag == BUTTON_TAG +1) {
        selectProductListItem = @"shenZhouXingList";
        productListArray = [self setProductListArrayByPlist:selectProductListItem];
        
        UIView *blockLine1 = (UIView *)[self.view viewWithTag:VIEW_TAG +1];
        UIView *blockLine2 = (UIView *)[self.view viewWithTag:VIEW_TAG +2];
        UIView *blockLine3 = (UIView *)[self.view viewWithTag:VIEW_TAG +3];
        UIView *blockLine4 = (UIView *)[self.view viewWithTag:VIEW_TAG +4];
        
        [blockLine1 setBackgroundColor:UIColorFromRGB(rgbValueButtonGreen)];
        [blockLine2 setBackgroundColor:[UIColor clearColor]];
        [blockLine3 setBackgroundColor:[UIColor clearColor]];
        [blockLine4 setBackgroundColor:[UIColor clearColor]];
        [dataProductListTableView reloadData];
    }
    
    //全球通
    if (button.tag == BUTTON_TAG +2) {
        selectProductListItem = @"quanQiuTongList";
        productListArray = [self setProductListArrayByPlist:selectProductListItem];
        
        UIView *blockLine1 = (UIView *)[self.view viewWithTag:VIEW_TAG +1];
        UIView *blockLine2 = (UIView *)[self.view viewWithTag:VIEW_TAG +2];
        UIView *blockLine3 = (UIView *)[self.view viewWithTag:VIEW_TAG +3];
        UIView *blockLine4 = (UIView *)[self.view viewWithTag:VIEW_TAG +4];
        
        [blockLine1 setBackgroundColor:[UIColor clearColor]];
        [blockLine2 setBackgroundColor:UIColorFromRGB(rgbValueButtonGreen)];
        [blockLine3 setBackgroundColor:[UIColor clearColor]];
        [blockLine4 setBackgroundColor:[UIColor clearColor]];
        [dataProductListTableView reloadData];
    }
    
    //动感地带
    if (button.tag == BUTTON_TAG +3) {
        selectProductListItem = @"dongGanDiDaiList";
        productListArray = [self setProductListArrayByPlist:selectProductListItem];
        
        UIView *blockLine1 = (UIView *)[self.view viewWithTag:VIEW_TAG +1];
        UIView *blockLine2 = (UIView *)[self.view viewWithTag:VIEW_TAG +2];
        UIView *blockLine3 = (UIView *)[self.view viewWithTag:VIEW_TAG +3];
        UIView *blockLine4 = (UIView *)[self.view viewWithTag:VIEW_TAG +4];
        
        [blockLine1 setBackgroundColor:[UIColor clearColor]];
        [blockLine2 setBackgroundColor:[UIColor clearColor]];
        [blockLine3 setBackgroundColor:UIColorFromRGB(rgbValueButtonGreen)];
        [blockLine4 setBackgroundColor:[UIColor clearColor]];
        [dataProductListTableView reloadData];
    }
    
    //4G
    if (button.tag == BUTTON_TAG +4) {
        selectProductListItem = @"fourGProductList";
        productListArray = [self setProductListArrayByPlist:selectProductListItem];
        
        UIView *blockLine1 = (UIView *)[self.view viewWithTag:VIEW_TAG +1];
        UIView *blockLine2 = (UIView *)[self.view viewWithTag:VIEW_TAG +2];
        UIView *blockLine3 = (UIView *)[self.view viewWithTag:VIEW_TAG +3];
        UIView *blockLine4 = (UIView *)[self.view viewWithTag:VIEW_TAG +4];
        
        [blockLine1 setBackgroundColor:[UIColor clearColor]];
        [blockLine2 setBackgroundColor:[UIColor clearColor]];
        [blockLine3 setBackgroundColor:[UIColor clearColor]];
        [blockLine4 setBackgroundColor:UIColorFromRGB(rgbValueButtonGreen)];
        [dataProductListTableView reloadData];
    }
    
}

-(NSArray *)setProductListArrayByPlist:(NSString *)listName
{
    //关于dataProductList plist文件，需要先判断沙盒里面是否存在，如果存在判断版本是否为当前版本。
    //版本不对，则替换为最新版本。如果存在且版本正确，则不做任何操作，直接读取。
    //读取dataProductList plist文件，获取业务菜单
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *productListFielPath=[plistPath1 stringByAppendingPathComponent:@"dataProductList.plist"];
    DebugNSLog(@"%@",productListFielPath);
    
    //判断文件是否存在沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:productListFielPath]== NO ) {
        DebugNSLog(@"dataProductList.plist is not exists");
        //方法二
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dataProductList"ofType:@"plist"];
        NSMutableDictionary *productListDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        [productListDic writeToFile:productListFielPath atomically:YES];
    }else{
        DebugNSLog(@"dataProductList.plist is exists");
        //获取版本字段并比较，如果不相同，则将自带复制到沙盒里面去
        //获取沙盒数据版本
        NSMutableDictionary *listDicSandbox = [[NSMutableDictionary alloc] initWithContentsOfFile:productListFielPath];
        NSString *versionSandbox = [listDicSandbox objectForKey:@"Version"];
        
        //获取自带数据版本
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dataProductList"ofType:@"plist"];
        NSMutableDictionary *productListDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        NSString *version = [productListDic objectForKey:@"Version"];
        
        //判断数据版本是否相同
        if (![versionSandbox isEqualToString:version]) {//不相同
            //先删除沙盒中原有文件
            [fileManager removeItemAtPath:productListFielPath error:nil];
            //复制到沙盒中
            [productListDic writeToFile:productListFielPath atomically:YES];
        }
    }
    
    //截止到目前位置沙盒中已经存在dataProductList.plist，读取menulist.plist文件，并展示到桌面
    
    NSDictionary *productListDicSandbox = [[NSMutableDictionary alloc] initWithContentsOfFile:productListFielPath];
    
    NSArray *tempArray=[productListDicSandbox objectForKey:listName];
    NSMutableArray *resultArray=[[NSMutableArray alloc]init];
    for (int i=0; i<tempArray.count; i++) {
        if(![[[tempArray objectAtIndex:i] objectForKey:@"BusiDesc"] isEqualToString:@""]){
            [resultArray addObject:[tempArray objectAtIndex:i]];
        }
    }
    return resultArray;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return productListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 200, 30)];
        lable.tag = LABEL_TAG + 1;
        [cell.contentView addSubview:lable];
        
        UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(220, 15, 90, 30)];
        lable2.tag = LABEL_TAG + 2;
        lable2.font=[UIFont fontWithName:appTypeFace size:16];
        lable2.textColor=UIColorFromRGB(rgbValueDeepGrey);
        lable2.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:lable2];
    }
    NSDictionary *rowData=[productListArray objectAtIndex:[indexPath row]];
    
    UILabel *lable = (UILabel *)[cell.contentView viewWithTag:LABEL_TAG + 1];
    lable.text=[rowData objectForKey:@"BusiName"];
    
    UILabel *lable2 = (UILabel *)[cell.contentView viewWithTag:LABEL_TAG + 2];
    lable2.text=[rowData objectForKey:@"BusiFee"];
    
    return cell;
}

//设置点击行的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyMobileServiceYNPackagesServiceDetailVC *dataProductDetailVC = [[MyMobileServiceYNPackagesServiceDetailVC alloc]init];
    NSMutableDictionary *tempDic=[productListArray objectAtIndex:[indexPath row]];
    [tempDic setObject:selectProductListItem forKey:@"SelectItem"];
    dataProductDetailVC.productDetail =[[NSDictionary alloc]initWithDictionary:tempDic];
    [self.navigationController pushViewController:dataProductDetailVC animated:YES];
}

//设置行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

//#pragma mark---ASIHTTPRequestDelegate
////返回成功
//-(void)requestFinished:(ASIHTTPRequest *)request
//{
//    NSArray *cookies = [request responseCookies];
//    DebugNSLog(@"%@",cookies);
//    NSData *jsonData =[request responseData];
//    DebugNSLog(@"%@",[request responseString]);
//    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//    NSDictionary *dic = [array objectAtIndex:0];
//    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
//    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
//        if (![[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {
//            //获取配置文件中的数据
//            NSArray *baseProductArray = [self setProductListArrayByPlist:@"BaseProductList"];
//            NSMutableArray *temp = [[NSMutableArray alloc]init];
//            for (int i =0; i<baseProductArray.count; i++) {
//                for (int j = 0; j<array.count; j++) {
//                    //循环判断配置文件中的serviceID是否存在可办理数据中，存在现实，不存在不显示。
//                    if ([[[array objectAtIndex:j] objectForKey:@"ELEMENT_ID"]isEqualToString:[[baseProductArray objectAtIndex:i] objectForKey:@"BusiServiceId"]]) {
//                        [temp addObject:[baseProductArray objectAtIndex:i]];
//                        break;
//                    }
//                }
//            }
//            
//            canSelectArray = temp;
//            if (canSelectArray.count == 0) {
//                [self resetViewByNoBaseProduct];
//            }
//            
//        }else{
//            [self resetViewByNoBaseProduct];
//        }
//    }
//    else{
//        NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//        alertView.tag = ALERTVIEW_TAG_RETURN+1;
//        [alertView show];
//    }
//    if(HUD){
//        [HUD removeHUD];
//    }
//}
////返回失败
//-(void)requestFailed:(ASIHTTPRequest *)request
//{
//    //    NSError *error = [request error];
//    NSString *returnMessage = [returnMessageDeal returnMessage:@"" andreturnMessage:@""];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//    alertView.tag = ALERTVIEW_TAG_RETURN+2;
//    [alertView show];
//    
//    if(HUD){
//        [HUD removeHUD];
//    }
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
//    [httpRequest setRequestDelegatNil];
}

@end
