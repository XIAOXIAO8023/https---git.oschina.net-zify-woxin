//
//  MyMobileServiceYN10086SupportVC.h
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-17.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "MyMobileServiceYNBaseVC.h"

@interface MyMobileServiceYN10086SupportVC : MyMobileServiceYNBaseVC<AVAudioRecorderDelegate,UIScrollViewDelegate>
{
    AVAudioRecorder *recorder;
    NSTimer *timer;
    NSURL *urlPlay;
    UIScrollView *homeScrollView;
    UIScrollView *detailScrollView;
    
    int number;
    
    UIView *enterView;
    
    float fHeight;
}
@property (retain, nonatomic) AVAudioPlayer *avPlay;

@end

