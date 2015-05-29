//
//  MyMobileServiceYNCustomerServiceVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-6.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNCustomerServiceVC.h"
#import "MyMobileServiceYNOnlineServiceVC.h"
#import "MyMobileServiceYNCustComplainVC.h"
#import "MyMobileServiceYNCustComplainHistoryQueryVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNCustomerServiceVC ()

@end

@implementation MyMobileServiceYNCustomerServiceVC

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
    self.title = @"客服";

    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT) style:UITableViewStyleGrouped];
    tableView.backgroundColor=UIColorFromRGB(rgbValueGreyBg);
    tableView.dataSource=self;
    tableView.delegate=self;
    
    //判断当前ios版本是否小于5.0 小于5.0只需要设置背景为空白，大于等于5.0需要同时设置view为空
    if ( [[UIDevice currentDevice].systemVersion floatValue] < 5.0){
        
        tableView.backgroundColor=[UIColor clearColor];
    }
    else{
        // use this mehod on ios6
        tableView.backgroundColor=[UIColor clearColor];
        tableView.backgroundView = nil;
    }
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }else if(section==1){
        return 1;
    }else{
        return 8;
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
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
        image.tag=1;
        [cell.contentView addSubview:image];
        
        UILabel *anlabel=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 190, 44)];
        anlabel.backgroundColor=[UIColor clearColor];
        anlabel.font=[UIFont fontWithName:appTypeFace size:16];
        anlabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
        anlabel.tag=2;
        [cell.contentView addSubview:anlabel];
        
        UILabel *anlabel2=[[UILabel alloc]initWithFrame:CGRectMake(220, 0, 80, 44)];
        anlabel2.backgroundColor=[UIColor clearColor];
        anlabel2.font=[UIFont fontWithName:appTypeFace size:16];
        anlabel2.textColor=UIColorFromRGB(rgbValueDeepGrey);
        anlabel2.tag=3;
        [cell.contentView addSubview:anlabel2];
    }
    
    UIImageView *image=(UIImageView *)[cell.contentView viewWithTag:1];
    UILabel *anlabel=(UILabel *)[cell.contentView viewWithTag:2];
    UILabel *anlabel2=(UILabel *)[cell.contentView viewWithTag:3];
    if([indexPath section]==0){
        image.image=[UIImage imageNamed:@"msg_online"];
        anlabel.text=@"在线客服";
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if([indexPath section]==1){
        if([indexPath row]==0){
            image.image=[UIImage imageNamed:@"msg_tousu"];
            anlabel.text=@"投诉建议";
        }else{
            image.image=[UIImage imageNamed:@"msg_lishitousu"];
            anlabel.text=@"历史投诉";
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        if([indexPath row]==0){
            image.image=[UIImage imageNamed:@"msg_telephone"];
            anlabel.text=@"服务热线";
            anlabel2.text=@"10086";
        }else if([indexPath row]==1){
            image.image=[UIImage imageNamed:@"msg_telephone"];
            anlabel.text=@"话费流量查询";
            anlabel2.text=@"1008611";
        }else if([indexPath row]==2){
            image.image=[UIImage imageNamed:@"msg_telephone"];
            anlabel.text=@"手机上网流量查询";
            anlabel2.text=@"1008612";
        }else if([indexPath row]==3){
            image.image=[UIImage imageNamed:@"msg_telephone"];
            anlabel.text=@"账单查询";
            anlabel2.text=@"1008613";
        }else if([indexPath row]==4){
            image.image=[UIImage imageNamed:@"msg_telephone"];
            anlabel.text=@"最新营销活动办理";
            anlabel2.text=@"1008621";
        }else if([indexPath row]==5){
            image.image=[UIImage imageNamed:@"msg_telephone"];
            anlabel.text=@"来电显示办理";
            anlabel2.text=@"1008631";
        }else if([indexPath row]==6){
            image.image=[UIImage imageNamed:@"msg_telephone"];
            anlabel.text=@"彩铃办理";
            anlabel2.text=@"1008632";
        }else if([indexPath row]==7){
            image.image=[UIImage imageNamed:@"msg_telephone"];
            anlabel.text=@"上网功能及套餐办理";
            anlabel2.text=@"1008633";
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if([indexPath section]==0){
        MyMobileServiceYNOnlineServiceVC *onlineServiceVC=[[MyMobileServiceYNOnlineServiceVC alloc]init];
        [self.navigationController pushViewController:onlineServiceVC animated:YES];
    }else if([indexPath section]==1){
        if([indexPath row]==0){
            MyMobileServiceYNCustComplainVC *custComplainVC=[[MyMobileServiceYNCustComplainVC alloc]init];
            [self.navigationController pushViewController:custComplainVC animated:YES];
        }else{
            MyMobileServiceYNCustComplainHistoryQueryVC *custComplainHistoryQueryVC=[[MyMobileServiceYNCustComplainHistoryQueryVC alloc]init];
            [self.navigationController pushViewController:custComplainHistoryQueryVC animated:YES];
        }
    }else{
        if([indexPath row]==0){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
        }else if([indexPath row]==1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1008611"]];
        }else if([indexPath row]==2){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1008612"]];
        }else if([indexPath row]==3){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1008613"]];
        }else if([indexPath row]==4){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1008621"]];
        }else if([indexPath row]==5){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1008631"]];
        }else if([indexPath row]==6){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1008632"]];
        }else if([indexPath row]==7){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1008633"]];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
