//
//  MarketTicket.h
//  Market
//
//  Created by 陆楠 on 15/3/19.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketTicket : UIView
{
    UIView *itemBtnView;
}

@property (nonatomic, retain) NSArray *ticketArry;

@end









@interface ticketV : UIView
{
    UIButton *imageBtn;
}

@property (nonatomic, retain) NSString *ticketUrl;

@property (nonatomic, retain) NSDictionary *ticketInfo;

@end
