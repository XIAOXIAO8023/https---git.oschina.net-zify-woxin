//
//  MarketTicket.m
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年. All rights reserved.
//

#import "MarketTicket.h"
#import "UIButton+WebCache.h"
#import "MKTicketDetailVC.h"
#import "ControllerUtils.h"
#import "GlobalDef.h"

@implementation MarketTicket

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
    titleLabel.text = @"积分兑换电子券";
    titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    titleLabel.textColor = UIColorFromRGB(0x595959);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 35);
}

-(void)setTicketArry:(NSArray *)ticketArry
{
    _ticketArry = ticketArry;
    if (itemBtnView) {
        [itemBtnView removeFromSuperview];
    }
    
    itemBtnView = [[UIView alloc]initWithFrame:CGRectMake(10, 35, 300, 0)];
    [self addSubview:itemBtnView];
    itemBtnView.layer.borderColor = UIColorFromRGB(0xcecece).CGColor;
    itemBtnView.layer.borderWidth = 0.5f;
    itemBtnView.layer.cornerRadius = 5.0f;
    
    NSInteger tmph = 10;
    for (NSInteger i = 0; i < _ticketArry.count; i++) {
        ticketV *tv = [[ticketV alloc]initWithFrame:CGRectMake(10, tmph, itemBtnView.frame.size.width - 20, 90)];
        [itemBtnView addSubview:tv];
        tv.backgroundColor = [UIColor whiteColor];
        tv.ticketInfo = [ticketArry objectAtIndex:i];
        tmph += 100;
    }
    itemBtnView.frame = CGRectMake(itemBtnView.frame.origin.x, itemBtnView.frame.origin.y, itemBtnView.frame.size.width, tmph);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, tmph + 35);
}

@end





@implementation ticketV


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContent];
    
    return self;
}

-(void)loadContent
{
    imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height )];
    [self addSubview:imageBtn];
    imageBtn.tag = 100;
    [imageBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)setTicketUrl:(NSString *)ticketUrl
{
    _ticketUrl = ticketUrl;
//    [imageBtn setBackgroundImageWithURL:[NSURL URLWithString:_ticketUrl]
//                       placeholderImage:[UIImage imageNamed:@"ad_loading"]
//                                options:SDWebImageProgressiveDownload];
    [imageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_ticketUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ad_loading"] options:SDWebImageProgressiveDownload];
}

-(void)setTicketInfo:(NSDictionary *)ticketInfo
{
    _ticketInfo = ticketInfo;
    self.ticketUrl = [[ticketInfo objectForKey:@"IMAGE_PATH"] stringByAppendingString:[ticketInfo objectForKey:@"IMAGE_NAME"]];
}

-(void)buttonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 100) {
        MKTicketDetailVC *td = [[MKTicketDetailVC alloc]init];
        td.infoDic = _ticketInfo;
        UINavigationController *na = [ControllerUtils findViewControllerWithSourceView:self];
        [na pushViewController:td animated:YES];
    }

}

@end











