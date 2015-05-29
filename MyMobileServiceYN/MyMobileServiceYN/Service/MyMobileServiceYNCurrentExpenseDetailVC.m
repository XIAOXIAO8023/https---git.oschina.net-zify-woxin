//
//  MyMobileServiceYNCurrentExpenseDetailVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-22.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNCurrentExpenseDetailVC.h"
#import "GlobalDef.h"
#import "MyMobileServiceYNCurrentExpenseDetail.h"
#import "MyMobileServiceYNParam.h"
#import "DateDeal.h"

@interface MyMobileServiceYNCurrentExpenseDetailVC ()

@end

@implementation MyMobileServiceYNCurrentExpenseDetailVC
@synthesize DetailArray = _DetailArray;

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
    self.title = @"近3个月话费明细";
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.backgroundColor = [UIColor clearColor];
    homeScrollView.delegate = self;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [self.view addSubview:homeScrollView];
    
    //解析数据，重组
    NSMutableDictionary *fanhuanDic = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *zengsongDic = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *weifanhuanDic = [[NSMutableDictionary alloc]init];
    
    NSMutableArray *fanhuanArray =[[NSMutableArray alloc]init];
    NSMutableArray *zengsongArray =[[NSMutableArray alloc]init];
    NSMutableArray *weifanhuanArray =[[NSMutableArray alloc]init];
    
    for (int i=0; i<_DetailArray.count; i++) {
        NSDictionary *dic = [_DetailArray objectAtIndex:i];
        if ([[dic objectForKey:@"CONSUME_TYPE"] isEqualToString:@"返还"]) {
            [fanhuanArray addObject:dic];
        }else if ([[dic objectForKey:@"CONSUME_TYPE"] isEqualToString:@"赠送"]) {
            [zengsongArray addObject:dic];
        }
    }
    
    NSArray *currentCostArray =[MyMobileServiceYNParam getCurrentCostArray];
    for (int j=0; j<currentCostArray.count; j++) {
        NSDictionary *dic = [currentCostArray objectAtIndex:j];
        if (![[dic objectForKey:@"X_RECORDNUM"] isEqualToString:@"0"]) {
            int iMonth = [[DateDeal getYearMonthNow]intValue];
            int iEndCycleId = [[dic objectForKey:@"END_CYCLE_ID"]intValue];
            DebugNSLog(@"%@,%d",[DateDeal getYearMonthNow],iMonth);
            DebugNSLog(@"%@,%d",[dic objectForKey:@"END_CYCLE_ID"],iEndCycleId);
            if (iEndCycleId - iMonth >0) {
                [dic setValue:[dic objectForKey:@"ACTION_NAME"] forKey:@"REMARK2"];
                [dic setValue:[dic objectForKey:@"ACTION_NAME"] forKey:@"PAYMENT"];
                [dic setValue:[dic objectForKey:@"MONEY"] forKey:@"RECV_FEE"];
                [weifanhuanArray addObject:dic];
            }
        }
    }
    
    float height = 0;
    
    if (zengsongArray.count >0) {
        [zengsongDic setObject:@"近3个月赠送总额(元)" forKey:@"DetailName"];
        [zengsongDic setObject:[[zengsongArray objectAtIndex:0]objectForKey:@"NEW_PRESENT_FEE"] forKey:@"DetailFee"];
        [zengsongDic setObject:@"赠送(元)" forKey:@"DetailFeeName"];
        [zengsongDic setObject:zengsongArray forKey:@"DetailArray"];
        MyMobileServiceYNCurrentExpenseDetail *detailView = [[MyMobileServiceYNCurrentExpenseDetail alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 20+30+44+44*1.5*zengsongArray.count)];
        height += 20+30+44+44*1.5*zengsongArray.count;
        [detailView setCurrentExpenseDetailView:zengsongDic];
        [homeScrollView addSubview:detailView];
        if (height > homeScrollView.frame.size.height) {
            homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, height);
        }
    }
    
    if (fanhuanArray.count >0) {
        [fanhuanDic setObject:@"近3个月返还总额(元)" forKey:@"DetailName"];
        int l = [[[fanhuanArray objectAtIndex:0] objectForKey:@"NEW_CASH_DIVIDED_FEE"] intValue];
        int m = [[[fanhuanArray objectAtIndex:0] objectForKey:@"NEW_PRESENT_DIVIDED_FEE"] intValue];
        if (l<0) {
            l = 0-l;
        }
        if (m<0) {
            m = 0-m;
        }
        [fanhuanDic setObject:[NSString stringWithFormat:@"%d",(l+m)] forKey:@"DetailFee"];
        [fanhuanDic setObject:@"返还(元)" forKey:@"DetailFeeName"];
        [fanhuanDic setObject:fanhuanArray forKey:@"DetailArray"];
        MyMobileServiceYNCurrentExpenseDetail *detailView = [[MyMobileServiceYNCurrentExpenseDetail alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 20+30+44+44*1.5*fanhuanArray.count)];
        height += 20+30+44+44*1.5*fanhuanArray.count;
        [detailView setCurrentExpenseDetailView:fanhuanDic];
        
        [homeScrollView addSubview:detailView];
        if (height > homeScrollView.frame.size.height) {
            homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, height);
        }
    }
    
    
    if (weifanhuanArray.count >0) {
        [weifanhuanDic setObject:@"预存未返还总额(元)" forKey:@"DetailName"];
        [weifanhuanDic setObject:[[weifanhuanArray objectAtIndex:0]objectForKey:@"FREEZE_FEE"] forKey:@"DetailFee"];
        [weifanhuanDic setObject:@"未返还(元)" forKey:@"DetailFeeName"];
        [weifanhuanDic setObject:weifanhuanArray forKey:@"DetailArray"];
        MyMobileServiceYNCurrentExpenseDetail *detailView = [[MyMobileServiceYNCurrentExpenseDetail alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 20+30+44+44*1.5*weifanhuanArray.count)];
        height += 20+30+44+44*1.5*weifanhuanArray.count;
        [detailView setCurrentExpenseDetailView:weifanhuanDic];
        
        [homeScrollView addSubview:detailView];
        if (height > homeScrollView.frame.size.height) {
            homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, height);
        }
    }
    
    //如果没有任何明细，提示用户
    if (height == 0) {
        UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH -40, 60)];
        promptLabel.backgroundColor = [UIColor clearColor];
        promptLabel.textAlignment = NSTextAlignmentCenter;
        promptLabel.text = @"没有查询到相关明细信息！";
        [homeScrollView addSubview:promptLabel];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
