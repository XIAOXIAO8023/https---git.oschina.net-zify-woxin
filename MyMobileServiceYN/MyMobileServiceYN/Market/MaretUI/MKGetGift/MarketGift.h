//
//  MarketGift.h
//  Market
//
//  Created by 陆楠 on 15/3/23.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketGift : UIView
{
    UIView *itemBtnView;
}

@property (nonatomic, retain) NSArray *giftArry;

@end



@interface GiftV : UIButton
{
    UIImageView *giftImageV;
}

@property (nonatomic, retain) UIImage *giftImage;

@property (nonatomic, retain, readonly) UILabel *giftNameLabel;

@property (nonatomic, retain, readonly) UILabel *giftScoreLabel;

@property (nonatomic, retain) NSString *giftUrl;

@property (nonatomic, retain) NSDictionary *giftInfo;

@end