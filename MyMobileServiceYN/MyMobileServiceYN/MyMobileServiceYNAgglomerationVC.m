//
//  MyMobileServiceYNAgglomerationVC.m
//  MyMobileServiceYN
//
//  Created by XIAO on 15/4/17.
//  Copyright (c) 2015年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNAgglomerationVC.h"
#import "MyMobileServiceYNBaseVC.h"


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_THREE_WIDTH    ([UIScreen mainScreen].bounds.size.width)/3

@interface MyMobileServiceYNAgglomerationVC ()

@end

@implementation MyMobileServiceYNAgglomerationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //底层scrollView
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44)];
    _scrollView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*2);
    
    [self showBanner];//广告Banner
    [self showRecommendView];//推荐的 定是好的
    [self showNewExerciseView];//最新活动 等你尝鲜
    [self showCliqueProductView];//集团产品 一直都在
    [self showManageTelView];//专属客户
}
-(void)showBanner
{
    //-----------1广告LOGO----------
    bannerScrollView = [[UIScrollView alloc]init];
    bannerScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
    bannerScrollView.pagingEnabled = YES;
    bannerScrollView.bounces = NO;
    bannerScrollView.delegate = self;
    bannerScrollView.showsHorizontalScrollIndicator
    = NO;//水平指示灯
    [self.view addSubview:bannerScrollView];
    
    //视图下端中央的小点，根据图片位置变换
    hPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.frame.size.width-220)/2, bannerScrollView.frame.size.height-20 ,200, 20)];
    
    hPageControl.numberOfPages = 2;//个数暂定
    
    hPageControl.currentPage = 0;
    [hPageControl addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    //设置页面指示灯的颜色
    hPageControl.pageIndicatorTintColor = [UIColor lightGrayColor] ;
    //当前页面指示灯的颜色；
    hPageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:125.0/255.0 green:189.0/255.0 blue:22.0/255.0 alpha:1.0];
    //            UIColorFromRGB(0x222222);
    [hPageControl addTarget:self action:@selector(pageControlMethod) forControlEvents:UIControlEventValueChanged];
    
    [_scrollView addSubview:bannerScrollView];
    [_scrollView addSubview:hPageControl];
    [_scrollView bringSubviewToFront:hPageControl];
    
    bannerScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 130);
    for (int i = 0 ; i<2; i++) {
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        imageButton.frame =CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, 130);
        [imageButton setBackgroundImage:[UIImage imageNamed:@"u20"] forState:UIControlStateNormal];
        [bannerScrollView addSubview:imageButton];
        
    }
    changeHeight+=bannerScrollView.frame.size.height+10;
}
#pragma mark-推荐的 定是好的
-(void)showRecommendView{
    UIView *view = [self setUpView];
    view.frame = CGRectMake(0, changeHeight, SCREEN_WIDTH, 200);
    [_scrollView addSubview:view];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"推荐的 定是好的";
    float titleWidth = [titleLabel.text sizeWithFont:titleLabel.font].width;
    titleLabel.frame = CGRectMake(100, 0, titleWidth, 40);
    [view addSubview:titleLabel];
    for (int i = 0 ; i<2; i++) {//标题两侧的线
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(5+i*(SCREEN_WIDTH-100), 20, 90, 0.5)];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineLabel];
    }
    //推荐button
    for (int j = 0; j<3; j++){
        for (int z = 0; z<2; z++) {
            UIButton *Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            Button.bounds =CGRectMake(SCREEN_THREE_WIDTH, 60+z*(50+30), 50, 50);
            Button.center = CGPointMake(SCREEN_THREE_WIDTH/2+j*SCREEN_THREE_WIDTH, 60+z*(50+30));
            [Button setBackgroundImage:[UIImage imageNamed:@"juTuan_good"] forState:UIControlStateNormal];
            [view addSubview:Button];
            
            //名称
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.text = @"集团彩铃";
            float nameWidth = [nameLabel.text sizeWithFont:nameLabel.font].width;
            nameLabel.frame = CGRectMake(Button.frame.origin.x-10, Button.frame.origin.y+50, nameWidth, 30);
            [view addSubview:nameLabel];
        }
    }
    changeHeight += view.frame.size.height+10;
}
#pragma mark-最新活动 等你尝鲜
-(void)showNewExerciseView{
    UIView *view = [self setUpView];
    view.frame = CGRectMake(0, changeHeight, SCREEN_WIDTH, 200);
    [_scrollView addSubview:view];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"最新活动 等你尝鲜";
    float titleWidth = [titleLabel.text sizeWithFont:titleLabel.font].width;
    titleLabel.frame = CGRectMake(100, 0, titleWidth, 40);
    [view addSubview:titleLabel];
    for (int i = 0 ; i<2; i++) {//标题两侧的线
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(5+i*(SCREEN_WIDTH-100), 20, 90, 0.5)];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineLabel];
    }
    //活动button
    for (int j = 0; j<2; j++){
        for (int z = 0; z<2; z++) {
            UIButton *Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            Button.bounds =CGRectMake(5+j*(100+20), 40+z*(50+20), 100, 50);
            Button.center = CGPointMake(SCREEN_WIDTH/4+j*(SCREEN_WIDTH/2), 60+z*(50+20));
            [Button setBackgroundImage:[UIImage imageNamed:@"juTuan_more"] forState:UIControlStateNormal];
            [view addSubview:Button];
        }
    }
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    moreButton.frame =CGRectMake(0, 165, SCREEN_WIDTH, 30);
    [moreButton setTitle:@"更多活动 挑动你的心>" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreExercise) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:moreButton];
    changeHeight += view.frame.size.height+10;
}
-(void)moreExercise{
    NSLog(@"点击了更多活动");
}
#pragma mark--集团产品 一直都在
-(void)showCliqueProductView{
    UIView *view = [self setUpView];
    view.frame = CGRectMake(0, changeHeight, SCREEN_HEIGHT, 120);
    [_scrollView addSubview:view];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"集团产品 一直都在";
    float titleWidth = [titleLabel.text sizeWithFont:titleLabel.font].width;
    titleLabel.frame = CGRectMake(100, 0, titleWidth, 40);
    [view addSubview:titleLabel];
    for (int i = 0 ; i<2; i++) {//标题两侧的线
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(5+i*(SCREEN_WIDTH-100), 20, 90, 0.5)];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineLabel];
    }
    //产品button
    for(int i = 0;i<4; i++){
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        Button.bounds =CGRectMake(5+i*(50+30), 60, 50, 50);
        Button.center = CGPointMake(SCREEN_WIDTH/4/2+i*(SCREEN_WIDTH/4), 60);
        [Button setBackgroundImage:[UIImage imageNamed:@"juTuan_good"] forState:UIControlStateNormal];
        [view addSubview:Button];
        
        //名称
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"语音通话";
        float nameWidth = [nameLabel.text sizeWithFont:nameLabel.font].width;
        nameLabel.frame = CGRectMake(Button.frame.origin.x-5, Button.frame.origin.y+50, nameWidth, 30);
        [view addSubview:nameLabel];
    }
    changeHeight += view.frame.size.height+10;
}
-(void)showManageTelView{
    UIView *view = [self setUpView];
    view.frame = CGRectMake(0, changeHeight, SCREEN_WIDTH, 120);
    [_scrollView addSubview: view];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"你的专属客户经理";
    float nameWidth = [nameLabel.text sizeWithFont:nameLabel.font].width;
    nameLabel.frame = CGRectMake(50, 20, nameWidth, 30);
    [view addSubview:nameLabel];
    
    UILabel *telLabel = [[UILabel alloc]init];
    telLabel.text = @"10086";
    float telWidth = [telLabel.text sizeWithFont:telLabel.font].width;
    telLabel.frame = CGRectMake(60, nameLabel.frame.size.height+30, telWidth, 30);
    [view addSubview:telLabel];
    
    //电话按钮
    UIButton *telButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    telButton.frame =CGRectMake(telWidth+100, 50, 32, 32);
    [telButton setBackgroundImage:[UIImage imageNamed:@"juTuan_Tel"] forState:UIControlStateNormal];
    [telButton addTarget:self action:@selector(telClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:telButton];
    changeHeight += view.frame.size.height+10;
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44);
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, changeHeight);
    
}
-(void)telClick{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
}
-(UIView *)setUpView{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, changeHeight, SCREEN_WIDTH, 180);
    return view;
}
#pragma  mark - scrollViewdelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //根据滚动视图的偏移量设置pageControl的currentpage;
    hPageControl.currentPage = scrollView.contentOffset.x/320;
}

#pragma  mark - PageControl 方法
-(void)pageControlMethod
{
    //根据pageControl的currentPage设置scrollView的contentOffset；
    bannerScrollView.contentOffset = CGPointMake(hPageControl.currentPage*self.view.frame.size.width, 0);
}

-(void)viewDidAppear:(BOOL)animated{
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, changeHeight);
}


@end
