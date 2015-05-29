//
//  MyMobileServiceYNBillTrendVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-6.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNBillTrendVC.h"
#import "GlobalDef.h"


@interface MyMobileServiceYNBillTrendVC ()

@end

@implementation MyMobileServiceYNBillTrendVC

@synthesize cycleArray = _cycleArray;
@synthesize billInfoArray = _billInfoArray;

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
    self.title = @"近6个月账单走势图";
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.delegate = self;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [self.view addSubview:homeScrollView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
    titleLabel.font = [UIFont fontWithName:appTypeFace size:16.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"近6个月消费走势图(元)";
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [homeScrollView addSubview:titleLabel];
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 200.0)];
    lineChart.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
    
    for (int i=0; i<_cycleArray.count; i++) {
        NSString *string = [[_cycleArray objectAtIndex:i] substringFromIndex:4];
        string = [NSString stringWithFormat:@"%@月",string];
        [array1 addObject:string];
    }
    [lineChart setXLabels:array1];
    
    NSMutableArray *array2 = [[NSMutableArray alloc]init];
    
    for (int i=0; i<_cycleArray.count; i++) {
        for (int j=0; j<_billInfoArray.count; j++) {
            if ([[_cycleArray objectAtIndex:i]isEqualToString:[[_billInfoArray objectAtIndex:j] objectForKey:@"CycleId"]]) {
//                NSString *sTotel = [[_billInfoArray objectAtIndex:j] objectForKey:@"Totle"];
                float f1 = [[[_billInfoArray objectAtIndex:j] objectForKey:@"Totle"] floatValue];
                float f2 = f1/100;
                NSString *sTotel  = [NSString stringWithFormat:@"%.2f",f2];
                [array2 addObject:sTotel];
            }
        }
    }
    
    // Line Chart Nr.1
    NSArray * data01Array = array2;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data01Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    
    lineChart.delegate = self;
    
    [homeScrollView addSubview:lineChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
