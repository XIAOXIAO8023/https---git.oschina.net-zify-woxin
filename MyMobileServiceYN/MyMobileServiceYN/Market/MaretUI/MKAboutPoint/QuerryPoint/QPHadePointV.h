//
//  QPHadePoint.h
//  Market
//
//  Created by 陆楠 on 15/3/24.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPHadePointV : UIView
{
    UIScrollView *pointDetailV;
    
    UILabel *totalPointL;
}

@property (nonatomic, retain) NSArray *pointArry;

@end






@interface PointListV : UIView

@property (nonatomic, retain) NSArray *pointArry;

@end