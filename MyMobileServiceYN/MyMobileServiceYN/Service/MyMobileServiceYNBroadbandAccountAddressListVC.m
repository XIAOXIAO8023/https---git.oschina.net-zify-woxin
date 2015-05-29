//
//  MyMobileServiceYNBroadbandAccountAddressListVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-12.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBroadbandAccountAddressListVC.h"
#import "MyMobileServiceYNBroadbandAccountFirstVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNBroadbandAccountAddressListVC ()

@end

@implementation MyMobileServiceYNBroadbandAccountAddressListVC
@synthesize addressList=_addressList;

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
    
    self.title=@"查询地址结果";
    
    queryTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH  , SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT) style:UITableViewStylePlain];
    queryTableView.backgroundColor = [UIColor clearColor];
    queryTableView.delegate=self;
    queryTableView.dataSource=self;
    [self.view addSubview:queryTableView];
    
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//    searchBar.placeholder=@"请输入门牌号";
//    searchBar.delegate = self;
//    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
//    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    searchBar.showsCancelButton = YES;
//    searchBar.barStyle=UIBarStyleDefault;
//    queryTableView.tableHeaderView=searchBar;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _addressList.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UILabel *clientMessage=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 66)];
        clientMessage.backgroundColor=[UIColor clearColor];
        clientMessage.font=[UIFont fontWithName:appTypeFace size:16];
        clientMessage.textColor=UIColorFromRGB(rgbValueDeepGrey);
        clientMessage.tag=1;
        clientMessage.numberOfLines=0;
        [cell.contentView addSubview:clientMessage];
        
    }
    
    NSDictionary *rowData=[_addressList objectAtIndex:[indexPath row]];
    
    UILabel *anlabel=(UILabel *)[cell.contentView viewWithTag:1];
    anlabel.text=[rowData objectForKey:@"RES_NAME"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *selectAddressInfo=[_addressList objectAtIndex:[indexPath row]];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"toSelectAddress" object:selectAddressInfo];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MyMobileServiceYNBroadbandAccountFirstVC class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.5)];
//    headerView.backgroundColor=[UIColor clearColor];
//
//
//    return headerView;
//}
//
//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.5;
//}
//
//-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.5;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.5)];
//    footerView.backgroundColor=[UIColor clearColor];
//
//    return footerView;
//}

//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    
//}
//
//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    if(searchBar.text!=nil&&![searchBar.text isEqualToString:@""]){
//        [searchBar resignFirstResponder];
//        [HUD showTextHUDWithVC:self.navigationController.view];
//        
//        NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:@"WidenetAdderssInfo"];
//        [requestBeanDic setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
//        [requestBeanDic setObject:[MyMobileServiceYNParam getCityCode] forKey:@"EPARCHY_CODE"];
//        [requestBeanDic setObject:searchBar.text forKey:@"MISS_ADD"];
//        [requestBeanDic setObject:_hourID forKey:@"HOUS_ID"];
//        [httpRequest startAsynchronous:@"WidenetAdderssInfo" requestParamData:requestBeanDic viewController:self];
//    }
//}
//
//-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    [searchBar resignFirstResponder];
//}
//
//-(void)requestFinished:(ASIHTTPRequest *)request{
//    NSArray *cookies = [request responseCookies];
//    DebugNSLog(@"%@",cookies);
//    NSData *jsonData =[request responseData];
//    DebugNSLog(@"%@",[request responseString]);
//    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//    if([[[array objectAtIndex:0] objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
//        if ([[[array objectAtIndex:0] objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {
//            NSString *returnMessage = @"请检查地址输入是否正确或该地址暂未覆盖，敬请期待。";
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//            alertView.tag = ALERTVIEW_TAG_RETURN+1;
//            [alertView show];
//        }else{
//            queryAddressArray=[[NSMutableArray alloc]initWithArray:array];
//            [queryTableView reloadData];
//        }
//    }
//    else{
//        NSString *returnMessage = [returnMessageDeal returnMessage:[[array objectAtIndex:0] objectForKey:@"X_RESULTCODE"] andreturnMessage:[[array objectAtIndex:0] objectForKey:@"X_RESULTINFO"]];
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//        alertView.tag = ALERTVIEW_TAG_RETURN+1;
//        [alertView show];
//    }
//    if(HUD){
//        [HUD removeHUD];
//    }
//}
//
//-(void)requestFailed:(ASIHTTPRequest *)request{
//    DebugNSLog(@"------------requestFailed------------------");
//    NSError *error = [request error];
//    DebugNSLog(@"----------2---------%@",error);
//    NSString *returnMessage = [returnMessageDeal returnMessage:@"网络异常" andreturnMessage:@""];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
//    alertView.tag = ALERTVIEW_TAG_RETURN+2;
//    [alertView show];
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

//-(void)dealloc{
//    [httpRequest setRequestDelegatNil];
//}
@end
