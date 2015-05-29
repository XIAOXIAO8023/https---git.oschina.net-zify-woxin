//
//  QPHandOutPointV.h
//  Market
//
//  Created by 陆楠 on 15/3/25.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPHandOutPointV : UIView
{
    UIScrollView *pointDetailV;
}

@property (nonatomic, retain) NSArray *pointArry;

@end


@interface PointHandOutListItem : UIView
{
    UILabel *pointL; //积分
    
    UILabel *outTimeL; //到期时间
    
    UILabel *GivenTimeL; // 发放时间
    
    UILabel *reasonL; // 发放原因
}

@property (nonatomic, retain) NSDictionary *infoDic;

@end