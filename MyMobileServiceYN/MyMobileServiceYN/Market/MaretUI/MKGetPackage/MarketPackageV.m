//
//  MarketPackageV.m
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "MarketPackageV.h"
#import "SomeViewHeightDef.h"
#import "MarketMoreVC.h"
#import "ControllerUtils.h"
#import "PackageButton.h"
#import "GlobalDef.h"

@implementation MarketPackageV

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadTitleView];
    
    return self;
}

-(void)loadTitleView
{
    
    UIView *blueV = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 8, 20)];
    [self addSubview:blueV];
    blueV.backgroundColor = UIColorFromRGB(0x28abe8);
    blueV.layer.cornerRadius = 2.0f;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 200, 30)];
    [self addSubview:titleLabel];
    titleLabel.text = @"兑换基础通信礼包";
    titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    titleLabel.textColor = UIColorFromRGB(0x595959);
    
    UIButton *more = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self addSubview:more];
    more.frame = CGRectMake(250, 12, 50, 20);
    [more setBackgroundColor:[UIColor whiteColor]];
    [more setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [more setTitle:@"更多>>" forState:UIControlStateNormal];
    more.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    more.titleLabel.textAlignment = NSTextAlignmentCenter;
    more.tag = 1000;
    [more addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setPackageArray:(NSArray *)packageArray
{
    if (itemBtnView) {
        [itemBtnView removeFromSuperview];
    }
    itemBtnView = [[UIView alloc]initWithFrame:CGRectMake(10, 35, 300, JF_PACKAGE_VIEW_HEIGHT - 40)];
    [self addSubview:itemBtnView];
    itemBtnView.layer.borderColor = UIColorFromRGB(0xcecece).CGColor;
    itemBtnView.layer.borderWidth = 0.5f;
    itemBtnView.layer.cornerRadius = 5.0f;
    NSInteger tempW = 0;
    for (NSInteger i = 0; i < 3; i++) {
        PackageButton *itemBtn = [[PackageButton alloc]initWithFrame:CGRectMake(tempW, 0, 93.5, 103.5)];
        [itemBtnView addSubview:itemBtn];
        itemBtn.packageInfo = [packageArray objectAtIndex:i];
        itemBtn.tag = 100 + i;
        [itemBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        tempW += 103.5;
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, JF_PACKAGE_VIEW_HEIGHT);
}

-(void)btnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1000) {
        MarketMoreVC *more = [[MarketMoreVC alloc]init];
        UINavigationController *na = [ControllerUtils findViewControllerWithSourceView:self];
        [na pushViewController:more animated:YES];
    }else{
        PackageButton *pb = (PackageButton *)sender;
        [self.delegate MarketPackageVPackageButtonPressed:pb];
    }
}

@end










