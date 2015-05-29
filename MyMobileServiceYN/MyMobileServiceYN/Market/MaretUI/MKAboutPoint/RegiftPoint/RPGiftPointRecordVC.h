//
//  RPGiftPointRecordVC.h
//  Market
//
//  Created by 陆楠 on 15/3/26.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"
#import "MyMobileServiceYNHttpRequest.h"
@class CirclePointV;

@interface RPGiftPointRecordVC : MyMobileServiceYNBaseVC<ASIHTTPRequestDelegate>
{
    UILabel *outPointL;
    UILabel *inPointL;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    
    NSString *busiCode;
    
    UIScrollView *recordList;
    
    CirclePointV *c;
    
    UIView *grayV;
}

@end


typedef enum {
    CirclePointTypeIn,
    CirclePointTypeOut
}CirclePointType;


@interface CirclePointV : UIImageView
{
    UILabel *pointL;
    
    UILabel *typeL;
}

@property (nonatomic, assign, readonly) NSInteger point;

@property (nonatomic, assign, readonly) CirclePointType type;

-(void)setPoint:(NSInteger)point withType:(CirclePointType)type;

@end



typedef enum {
    RecordItemTypeIn,
    RecordItemTypeOut
}RecordItemType;

@interface RecordItem : UIView
{
    UILabel *pointL;
    
    UIImageView *infoLimageV;
    UILabel *infoL;
    
    UILabel *infoL2;
    
    UILabel *infoLRight;
    
}

@property (nonatomic, retain) NSDictionary *infoDic;

@property (nonatomic, assign, readonly) RecordItemType type;

@end




