//
//  MarketPackageV.h
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PackageButton;

@protocol MarketPackageVDelegate <NSObject>

-(void)MarketPackageVPackageButtonPressed:(PackageButton *)button;

@end

@interface MarketPackageV : UIView
{
    UIView *itemBtnView;
}

@property (nonatomic,retain) NSArray *packageArray;

@property (nonatomic,retain) id<MarketPackageVDelegate>delegate;

@end





