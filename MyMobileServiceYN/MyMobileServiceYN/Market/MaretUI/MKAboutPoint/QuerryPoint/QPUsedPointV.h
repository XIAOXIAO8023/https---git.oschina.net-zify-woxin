//
//  QPUsedPointV.h
//  Market
//
//  Created by 陆楠 on 15/3/25.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPUsedPointV : UIView
{
    UIScrollView *pointDetailV;
}

@property (nonatomic, retain) NSArray *pointArry;

@end





@interface PointUsedListItem : UIView
{
    UILabel *pointL; //积分
    
    UILabel *usedTimeL; //使用时间
    
    UILabel *reasonL;// 使用原因
}

@property (nonatomic, retain) NSDictionary *infoDic;

@end