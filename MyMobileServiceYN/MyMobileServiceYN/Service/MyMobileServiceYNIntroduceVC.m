//
//  MyMobileServiceYNIntroduceVC.m
//  MyMobileServiceYN
//
//  Created by yingmeng on 14-8-11.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNIntroduceVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNIntroduceVC ()

@end

@implementation MyMobileServiceYNIntroduceVC
@synthesize scrollView;
@synthesize pageControl;

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
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    scrollView.directionalLockEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*4,0); //设置为4页宽度
    scrollView.pagingEnabled = YES;  //允许翻页
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;
    //将image放在scrollview上
    for(int i = 0; i < 4; i++)
    {
        UIImageView *image = [[UIImageView alloc]init];
        NSString *img = [NSString stringWithFormat:@"Intro_%d",i+1];
        NSLog(@"%@",img);
        image.image = [UIImage imageNamed:img];
        image.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60);
        [scrollView addSubview:image];
    }
    //设置pagecontroller
    pageControl = [[GrayPageControl alloc] init];
    pageControl.frame = CGRectMake(120, scrollView.frame.size.height-50, 80, 20);
    //pagecontroller位置适配7.0，
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        pageControl.frame = CGRectMake(120, scrollView.frame.size.height-50, 80, 20);

    }else
    {
        pageControl.frame = CGRectMake(120, scrollView.frame.size.height-110, 80, 20);

    }
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];//定义响应事件
    [self.view addSubview:scrollView];
    [self.view addSubview:pageControl];
    //定义关闭按钮
    UIImage *btnclose = [UIImage imageNamed:@"btn_close"];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:btnclose forState:UIControlStateNormal];
    [closeBtn setImage:btnclose forState:UIControlStateSelected];
    [closeBtn setBackgroundColor:[UIColor clearColor]];
    //按钮放置位置适配7.0
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
          closeBtn.frame = CGRectMake(SCREEN_WIDTH-50, scrollView.frame.origin.y+60, 50, 50);
    }else
    {
          closeBtn.frame = CGRectMake(SCREEN_WIDTH-50, scrollView.frame.origin.y, 50, 50);
    }
    [closeBtn addTarget:self action:@selector(btnClose:) forControlEvents:UIControlEventTouchUpInside];//定义按钮响应事件
    
    [self.view addSubview:closeBtn];
}

- (void)scrollViewDidScroll:(UIScrollView *)scroll
{
    int page = scroll.contentOffset.x / SCREEN_WIDTH;
    pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
    [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*page, -60)];
}

- (IBAction)btnClose:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
