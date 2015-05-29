//
//  RPGiftPointV.h
//  Market
//
//  Created by 陆楠 on 15/3/25.
//  Copyright (c) 2015年 lunan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>

@protocol RPGiftPointVDelegate <NSObject>

-(void)RPGiftPointVButtonPressed:(id)info;

@end

@interface RPGiftPointV : UIView<ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate>
{
    UIImageView *head;
    
    ABPeoplePickerNavigationController *personPicker;
    
    NSString *_phoneNumber;
    
    UITextField *personT;
    
    UITextField *pointT;
    
    UITextField *captchaT;
    
    UILabel *wrongL01;
    BOOL correct01;//受让人正确标识
    
    UILabel *wrongL02;
    BOOL correct02;//积分正确标识
    
    UILabel *wrongL03;
    BOOL correct03;//验证码正确标识
    
    UIButton *commitBtn;
}

@property (nonatomic, retain) id<RPGiftPointVDelegate>delegate;

@end




@interface CaptchaButton : UIButton
{
    NSTimeInterval currentTime;
    
    NSTimer *countTimer;
}

@property (nonatomic, assign) NSTimeInterval countdown;


-(void)startCount;

@end











