//
//  MyMobileServiceYNCustComplainHistoryListVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-7.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNCustComplainHistoryListVC.h"
#import "MyMobileServiceYNCustComplainHistoryDetailVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNCustComplainHistoryListVC ()

@end

@implementation MyMobileServiceYNCustComplainHistoryListVC
@synthesize complainHistoryArray=_complainHistoryArray;

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
    self.title = @"历史投诉列表";
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor=[UIColor clearColor];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.dataSource=self;
    tableView.delegate=self;
    [self.view addSubview:tableView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _complainHistoryArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return  cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UIView *backgroundView=[[UIView alloc]init];
        backgroundView.tag=VIEW_TAG+1;
        backgroundView.backgroundColor=[UIColor whiteColor];
        [backgroundView.layer setBorderColor:[UIColorFromRGB(rgbValueLightGrey) CGColor]];
        [backgroundView.layer setBorderWidth:0.5];  //边框宽度
        [backgroundView.layer setCornerRadius:3.0f]; //边框弧度
        [backgroundView.layer setMasksToBounds:YES];
        [cell.contentView addSubview:backgroundView];
        
        UILabel *complainCodeText=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 80, 30)];
        complainCodeText.backgroundColor=[UIColor clearColor];
        complainCodeText.font=[UIFont fontWithName:appTypeFace size:16];
        complainCodeText.textColor=UIColorFromRGB(rgbValueDeepGrey);
        complainCodeText.text=@"工单编号：";
        [cell.contentView addSubview:complainCodeText];
        
        UILabel *complainCode=[[UILabel alloc]initWithFrame:CGRectMake(100, 20, 200, 30)];
        complainCode.backgroundColor=[UIColor clearColor];
        complainCode.font=[UIFont fontWithName:appTypeFace size:16];
        complainCode.textColor=UIColorFromRGB(rgbValueDeepGrey);
        complainCode.tag=1;
        [cell.contentView addSubview:complainCode];
        
        UILabel *complainTimeText=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 80, 30)];
        complainTimeText.backgroundColor=[UIColor clearColor];
        complainTimeText.font=[UIFont fontWithName:appTypeFace size:16];
        complainTimeText.textColor=UIColorFromRGB(rgbValueDeepGrey);
        complainTimeText.text=@"受理时间：";
        [cell.contentView addSubview:complainTimeText];
        
        UILabel *complainTime=[[UILabel alloc]initWithFrame:CGRectMake(100, 50, 200, 30)];
        complainTime.backgroundColor=[UIColor clearColor];
        complainTime.font=[UIFont fontWithName:appTypeFace size:16];
        complainTime.textColor=UIColorFromRGB(rgbValueDeepGrey);
        complainTime.tag=2;
        [cell.contentView addSubview:complainTime];
        
//        UILabel *complainStatusText=[[UILabel alloc]initWithFrame:CGRectMake(30, 88, 80, 44)];
//        complainStatusText.backgroundColor=[UIColor clearColor];
//        complainStatusText.font=[UIFont fontWithName:appTypeFace size:16];
//        complainStatusText.textColor=UIColorFromRGB(rgbValueDeepGrey);
//        complainStatusText.text=@"工单状态：";
//        [cell.contentView addSubview:complainStatusText];
//        
//        UILabel *complainStatus=[[UILabel alloc]initWithFrame:CGRectMake(110, 88, 180, 44)];
//        complainStatus.backgroundColor=[UIColor clearColor];
//        complainStatus.font=[UIFont fontWithName:appTypeFace size:16];
//        complainStatus.textColor=UIColorFromRGB(rgbValueDeepGrey);
//        complainStatus.tag=3;
//        [cell.contentView addSubview:complainStatus];
        
        UILabel *complainDetailText=[[UILabel alloc]initWithFrame:CGRectMake(20, 85, 80, 20)];
        complainDetailText.backgroundColor=[UIColor clearColor];
        complainDetailText.font=[UIFont fontWithName:appTypeFace size:16];
        complainDetailText.textColor=UIColorFromRGB(rgbValueDeepGrey);
        complainDetailText.text=@"投诉内容：";
        [cell.contentView addSubview:complainDetailText];
        
        UILabel *complainDetail=[[UILabel alloc]initWithFrame:CGRectMake(100, 85, 200, 60)];
        complainDetail.backgroundColor=[UIColor clearColor];
        complainDetail.font=[UIFont fontWithName:appTypeFace size:16];
        complainDetail.textColor=UIColorFromRGB(rgbValueDeepGrey);
        complainDetail.numberOfLines=3;
        complainDetail.tag=4;
        [cell.contentView addSubview:complainDetail];

    }
    
    NSDictionary *rowData=[_complainHistoryArray objectAtIndex:[indexPath row]];
    
    UILabel *complainCode=(UILabel *)[cell.contentView viewWithTag:1];
    complainCode.text=[rowData objectForKey:@"sheetNumber"];
    
    UILabel *complainTime=(UILabel *)[cell.contentView viewWithTag:2];
    complainTime.text=[rowData objectForKey:@"acceptTime"];
    
//    UILabel *complainStatus=(UILabel *)[cell.contentView viewWithTag:3];
//    complainStatus.text=[rowData objectForKey:@""];
    
    UILabel *complainDetail=(UILabel *)[cell.contentView viewWithTag:4];
    complainDetail.text=[rowData objectForKey:@"complainContent"];
    CGSize size=CGSizeMake(200, 60);
    UIFont *font=[UIFont fontWithName:appTypeFace size:16];
    CGSize labelSize=[complainDetail.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    complainDetail.frame=CGRectMake(100, 85, 200, (NSInteger)labelSize.height+1);
    
    UIView *backView=(UIView *)[cell.contentView viewWithTag:VIEW_TAG+1];
    backView.frame=CGRectMake(10, 10, SCREEN_WIDTH-20, 85+labelSize.height);
    
    CGRect cellFrame = [cell frame];
    cellFrame.size.height = 95+labelSize.height;
    [cell setFrame:cellFrame];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyMobileServiceYNCustComplainHistoryDetailVC *custComplainHistoryDetailVC=[[MyMobileServiceYNCustComplainHistoryDetailVC alloc]init];
    custComplainHistoryDetailVC.sheetNumber=[[_complainHistoryArray objectAtIndex:[indexPath row]] objectForKey:@"sheetNumber"];
    [self.navigationController pushViewController:custComplainHistoryDetailVC animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headerView.backgroundColor=UIColorFromRGB(rgbValueBgGrey);
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    imageView.image=[UIImage imageNamed:@"msg_listico"];
    [headerView addSubview:imageView];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 266, 44)];
    title.text=@"以下是您的历史投诉与建议";
    title.backgroundColor=[UIColor clearColor];
    title.textColor=UIColorFromRGB(rgbValueDeepGrey);
    title.font=[UIFont fontWithName:appTypeFace size:18];
    [headerView addSubview:title];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
