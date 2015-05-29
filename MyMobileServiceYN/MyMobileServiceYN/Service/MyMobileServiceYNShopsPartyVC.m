//
//  MyMobileServiceYNShopsPartyVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-9.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNShopsPartyVC.h"
#import "MyMobileServiceYNShopsListVC.h"
#import "MyMobileServiceYNParam.h"
#import "UIImageView+WebCache.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNShopsPartyVC ()

@end

@implementation MyMobileServiceYNShopsPartyVC

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
    
    self.title = @"商家联盟";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSetCurrentPage:) name:@"toSetCurrentPage2" object:nil];
    
    homeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20)];
    homeScrollView.backgroundColor = [UIColor clearColor];
    homeScrollView.showsVerticalScrollIndicator = NO;
    homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-20);
    [self.view addSubview:homeScrollView];

    bannerScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 150) animationDuration:5];
    bannerScrollView.backgroundColor = [UIColor clearColor];
    [self setViewBorder:bannerScrollView];
    [homeScrollView addSubview:bannerScrollView];
    
    NSMutableArray *tempArray=[[NSMutableArray alloc]init];
    for (int i = 0; i < 2; ++i) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        imageView.userInteractionEnabled=YES;
        NSString *urlString=[NSString stringWithFormat:@"http://218.202.0.168:8099/sm_ad_0000%d.png",i+1];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"ad_loading"]];
        
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(toViewAdvertiseMent:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=BUTTON_TAG+50 +i;
        [imageView addSubview:button];
        
        [tempArray addObject:imageView];
    }
    
    bannerScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return [tempArray objectAtIndex:pageIndex];
    };
    bannerScrollView.totalPagesCount = ^NSInteger(void){
        return tempArray.count;
    };
    bannerScrollView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%ld个",(long)pageIndex);
    };
    
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 20)];
    tempView.backgroundColor=[UIColor blackColor];
    tempView.alpha=0.5;
    [bannerScrollView addSubview:tempView];
    
    pageControl = [[GrayPageControl alloc] init];
    pageControl.frame = CGRectMake(120, 0, 80, 20);
    pageControl.numberOfPages = tempArray.count;
    pageControl.currentPage = 0;
    [tempView addSubview:pageControl];
    
    UIView *recommendShopsTitleView=[[UIView alloc]initWithFrame:CGRectMake(0, bannerScrollView.frame.size.height, SCREEN_WIDTH, 44)];
    recommendShopsTitleView.backgroundColor=UIColorFromRGB(rgbValueGreyBg);
    [self setViewBorder:recommendShopsTitleView];
    [homeScrollView addSubview:recommendShopsTitleView];
    
    UILabel *logo=[[UILabel alloc]initWithFrame:CGRectMake(0, 12, 10, 20)];
    logo.backgroundColor=UIColorFromRGB(rgbValueButtonGreen);
    [recommendShopsTitleView addSubview:logo];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 150, 44)];
    title.text=@"推荐好商家";
    title.textColor=UIColorFromRGB(rgbValueDeepGrey);
    title.font=[UIFont fontWithName:appTypeFace size:18];
    title.backgroundColor=[UIColor clearColor];
    [recommendShopsTitleView addSubview:title];
    
    UILabel *allShops=[[UILabel alloc]initWithFrame:CGRectMake(180, 0, 130, 44)];
    allShops.text=@"所有商家>>";
    allShops.textColor=UIColorFromRGB(rgbValueLightGrey);
    allShops.font=[UIFont fontWithName:appTypeFace size:16];
    allShops.backgroundColor=[UIColor clearColor];
    allShops.textAlignment=NSTextAlignmentRight;
    [recommendShopsTitleView addSubview:allShops];
    
    UIButton *allShopsButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    allShopsButton.backgroundColor=[UIColor clearColor];
    [allShopsButton addTarget:self action:@selector(toSeeAllShops) forControlEvents:UIControlEventTouchUpInside];
    [recommendShopsTitleView addSubview:allShopsButton];
    
    UIView *recommendShopsView=[[UIView alloc]initWithFrame:CGRectMake(0, bannerScrollView.frame.size.height+44, SCREEN_WIDTH, 310)];
    recommendShopsView.backgroundColor=UIColorFromRGB(rgbValueGreyBg);
    [homeScrollView addSubview:recommendShopsView];
    
    UIImageView *shopImageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 175)];
    shopImageView1.image=[UIImage imageNamed:@"sm_subad1"];
    [self setViewBorder:shopImageView1];
    [recommendShopsView addSubview:shopImageView1];
    
    UIImageView *shopImageView2=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 87.5)];
    shopImageView2.image=[UIImage imageNamed:@"sm_subad2"];
    [self setViewBorder:shopImageView2];
    [recommendShopsView addSubview:shopImageView2];
    
    UIImageView *shopImageView3=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 87.5, SCREEN_WIDTH/2, 87.5)];
    shopImageView3.image=[UIImage imageNamed:@"sm_subad3"];
    [self setViewBorder:shopImageView3];
    [recommendShopsView addSubview:shopImageView3];
    
    UIImageView *shopImageView4=[[UIImageView alloc]initWithFrame:CGRectMake(0, 175, SCREEN_WIDTH/2, 135)];
    shopImageView4.image=[UIImage imageNamed:@"sm_subad4"];
    [self setViewBorder:shopImageView4];
    [recommendShopsView addSubview:shopImageView4];
    
    UIImageView *shopImageView5=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 175, SCREEN_WIDTH/2, 135)];
    shopImageView5.image=[UIImage imageNamed:@"sm_subad5"];
    [self setViewBorder:shopImageView5];
    [recommendShopsView addSubview:shopImageView5];
    
    [homeScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 504)];
}

-(void)toSetCurrentPage:(id)sender{
    NSInteger page=[(NSString *)[sender object] integerValue];
    pageControl.currentPage=page;
}

-(void)toViewAdvertiseMent:(id)sender{
    
}

-(void)toSeeAllShops{
    MyMobileServiceYNShopsListVC *shopsListVC=[[MyMobileServiceYNShopsListVC alloc]init];
    [self.navigationController pushViewController:shopsListVC animated:YES];
}

-(void)setViewBorder:(UIView *)view{
    [view.layer setBorderColor:[UIColorFromRGB(rgbValueLineGrey) CGColor]];
    [view.layer setBorderWidth:0.5];  //边框宽度
    [view.layer setCornerRadius:1.0]; //边框弧度
    [view.layer setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
