//
//  MarketGift.m
//  Market
//
//  Created by 陆楠 on 15/3/23.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import "MarketGift.h"
#import "UIImageView+WebCache.h"
#import "MyMobileServiceYNWebViewVC.h"
#import "ControllerUtils.h"
#import "MyMobileServiceYNBaseVC.h"
#import "MarketVC.h"
#import "GlobalDef.h"

@implementation MarketGift

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
    titleLabel.text = @"兑换实物礼品";
    titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    titleLabel.textColor = UIColorFromRGB(0x595959);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 35);
}

-(void)setGiftArry:(NSArray *)giftArry
{
    _giftArry = giftArry;
    if (itemBtnView) {
        [itemBtnView removeFromSuperview];
    }
    
    itemBtnView = [[UIView alloc]initWithFrame:CGRectMake(10, 35, 300, 0)];
    [self addSubview:itemBtnView];
    
    NSInteger tmpH = 0;
    if (_giftArry.count) {
        for (NSInteger i = 0; i < _giftArry.count / 2 + 1; i++) {
            NSInteger tmpW = 0;
            for (NSInteger j = 0; j < ((_giftArry.count - 2*i)<2?(_giftArry.count - 2*i):2); j++) {
                GiftV *gv = [[GiftV alloc]initWithFrame:CGRectMake(tmpW, tmpH, 145, 185)];
                [itemBtnView addSubview:gv];
                gv.backgroundColor = [UIColor whiteColor];
                gv.giftInfo = [_giftArry objectAtIndex:i * 2 + j];
                
                gv.layer.borderWidth = 0.5f;
                gv.layer.borderColor = UIColorFromRGB(0xcecece).CGColor;
                gv.layer.cornerRadius = 5.0f;
                
                [gv addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                tmpW += 155;
            }
            tmpH += 195;
        }
    }
    if (!(_giftArry.count % 2)) {
        tmpH -= 195;
    }
    itemBtnView.frame = CGRectMake(itemBtnView.frame.origin.x, itemBtnView.frame.origin.y, itemBtnView.frame.size.width, tmpH);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 35 + tmpH);

}

-(void)buttonPressed:(id)sender
{
    GiftV *btn = (GiftV *)sender;
    MyMobileServiceYNWebViewVC *web = [[MyMobileServiceYNWebViewVC alloc]init];
    web.webUrlString = btn.giftUrl;
    MarketVC *ma = [ControllerUtils findMarketVCWithSourceView:self];
    [ma presentWebVC:web animated:YES];
}

@end




@implementation GiftV

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadContent];
    
    return self;
}


-(void)loadContent
{
    giftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 40)];
    [self addSubview:giftImageV];
    
    _giftNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 20)];
    [self addSubview:_giftNameLabel];
    
    _giftScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
    [self addSubview:_giftScoreLabel];
}

-(void)setGiftImage:(UIImage *)giftImage
{
    _giftImage = giftImage;
    giftImageV.image = _giftImage;
}

-(void)setGiftInfo:(NSDictionary *)giftInfo
{
    self.giftUrl = [giftInfo objectForKey:@"DESCRIPTION"];
    
    [giftImageV sd_setImageWithURL:[NSURL URLWithString:[[giftInfo objectForKey:@"IMAGE_PATH"] stringByAppendingString:[giftInfo objectForKey:@"IMAGE_NAME"]]]
               placeholderImage:[UIImage imageNamed:@"ad_loading"]
                        options:SDWebImageProgressiveDownload];
    
    self.giftNameLabel.text = [giftInfo objectForKey:@"TRADE_NAME"];
    self.giftNameLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.giftNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.giftScoreLabel.text = [NSString stringWithFormat:@"%@积分",[giftInfo objectForKey:@"INTEGRAL_VALUE"]];
    self.giftScoreLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.giftScoreLabel.textAlignment = NSTextAlignmentCenter;
    self.giftScoreLabel.textColor = UIColorFromRGB(0xfc6b9f);
}

@end










