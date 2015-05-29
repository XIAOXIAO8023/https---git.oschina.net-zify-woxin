//
//  QuerryPointVC.h
//  Market
//
//  Created by 陆楠 on 15/3/24.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNSegment.h"
#import "MyMobileServiceYNBaseVC.h"
#import "ASIHTTPRequest.h"
#import "MyMobileServiceYNHttpRequest.h"
@class QPHadePointV;
@class QPHandOutPointV;
@class QPUsedPointV;

@interface QuerryPointVC : MyMobileServiceYNBaseVC<LNSegmentDelegate,ASIHTTPRequestDelegate>
{
    LNSegment *segmentV;
    
    QPHadePointV *hadePointV;
    
    QPHandOutPointV *handOutPointV;
    
    QPUsedPointV *usedPointV;
    
    MyMobileServiceYNHttpRequest *httpRequest;
    
    NSString *busiCode;
}

@end
