//
//  MyMobileServiceYNChangeThemeVC.m
//  MyMobileServiceYN
//
//  Created by 陆楠 on 14/12/5.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "MyMobileServiceYNChangeThemeVC.h"

@interface MyMobileServiceYNChangeThemeVC ()

@end

@implementation MyMobileServiceYNChangeThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主题设置";
    
    int tmp = 8;
    
    for (int i = 0;i < 4;i++)
    {
        UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(18, tmp, 40, 40)];
        [colorView.layer setCornerRadius:colorView.frame.size.width/2];
        [self.view addSubview:colorView];
        UILabel *colorLabel = [[UILabel alloc]initWithFrame:CGRectMake(76, tmp, 120, 40)];
        colorLabel.font = [UIFont fontWithName:appTypeFace size:18];
        [self.view addSubview:colorLabel];
        UIButton *colorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        colorBtn.frame = CGRectMake(SCREEN_WIDTH - 18 - 60, tmp + 5, 60, 30);
        colorBtn.backgroundColor = UIColorFromRGB(rgbValueBaiYan);
        colorBtn.tag = BUTTON_TAG + i + 1;
        [colorBtn setTitle:@"使用" forState:UIControlStateNormal];
        [colorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        colorBtn.titleLabel.font = [UIFont fontWithName:appTypeFace size:15];
        [colorBtn setBounds:CGRectMake(0, 0, 60, 30)];
        [colorBtn.layer setCornerRadius:colorBtn.frame.size.height/2];
        [colorBtn addTarget:self action:@selector(colorBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:colorBtn];
        UILabel *useLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 18 - 60, tmp + 5, 60, 30)];
        [useLabel setTextAlignment:NSTextAlignmentCenter];
        useLabel.text = @"使用中";
        useLabel.font = [UIFont fontWithName:appTypeFace size:15];
        useLabel.textColor = [UIColor lightGrayColor];
        [self.view addSubview:useLabel];
        [self.view sendSubviewToBack:useLabel];
        tmp += 48;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, tmp, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(rgbValueBaiYan);
        [self.view addSubview:lineView];
        tmp += 8;
        
        switch (i) {
            case 0:
                colorView.backgroundColor = UIColorFromRGB(rgbValue_Theme_red);
                colorLabel.text = @"喜庆红";
                break;
            case 1:
                colorView.backgroundColor = UIColorFromRGB(rgbValue_Theme_blue);
                colorLabel.text = @"移动简约蓝";
                break;
            case 2:
                colorView.backgroundColor = UIColorFromRGB(rgbValue_Theme_green);
                colorLabel.text = @"活力4G绿";
                break;
            case 3:
                colorView.backgroundColor = UIColorFromRGB(rgbValue_Theme_pueple);
                colorLabel.text = @"高贵紫";
            default:
                break;
        }
    }
    
    leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(43, tmp + 10, 96, 164)];
    rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 43 - 96, tmp + 10, 96, 164)];
    [self.view addSubview:leftImage];
    [self.view addSubview:rightImage];
    
    [self initBtnAndImage];
}

-(void)colorBtnPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == BUTTON_TAG + 1) {
        [[self.view viewWithTag:BUTTON_TAG + 1]setHidden:YES];
        [[self.view viewWithTag:BUTTON_TAG + 2]setHidden:NO];
        [[self.view viewWithTag:BUTTON_TAG + 3]setHidden:NO];
        [[self.view viewWithTag:BUTTON_TAG + 4]setHidden:NO];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(rgbValue_Theme_red)];
        }else{
            [self.navigationController.navigationBar setTintColor:UIColorFromRGB(rgbValue_Theme_red)];
        }
        UIImage *image = [UIImage imageNamed:@"IMG_1236"];
        UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
        leftImage.image = stretchableImage;
        UIImage *image2 = [UIImage imageNamed:@"IMG_1237"];
        UIImage* stretchableImage2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width / 2 topCapHeight:image2.size.height / 2];
        rightImage.image = stretchableImage2;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeThemeColor" object:@"red"];
    }else if (button.tag == BUTTON_TAG + 2) {
        [[self.view viewWithTag:BUTTON_TAG + 1]setHidden:NO];
        [[self.view viewWithTag:BUTTON_TAG + 2]setHidden:YES];
        [[self.view viewWithTag:BUTTON_TAG + 3]setHidden:NO];
        [[self.view viewWithTag:BUTTON_TAG + 4]setHidden:NO];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(rgbValue_Theme_blue)];
        }else{
            [self.navigationController.navigationBar setTintColor:UIColorFromRGB(rgbValue_Theme_blue)];
        }
        UIImage *image = [UIImage imageNamed:@"IMG_1238"];
        UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
        leftImage.image = stretchableImage;
        UIImage *image2 = [UIImage imageNamed:@"IMG_1239"];
        UIImage* stretchableImage2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width / 2 topCapHeight:image2.size.height / 2];
        rightImage.image = stretchableImage2;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeThemeColor" object:@"blue"];
    }else if (button.tag == BUTTON_TAG + 3) {
        [[self.view viewWithTag:BUTTON_TAG + 1]setHidden:NO];
        [[self.view viewWithTag:BUTTON_TAG + 2]setHidden:NO];
        [[self.view viewWithTag:BUTTON_TAG + 3]setHidden:YES];
        [[self.view viewWithTag:BUTTON_TAG + 4]setHidden:NO];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(rgbValue_Theme_green)];
        }else{
            [self.navigationController.navigationBar setTintColor:UIColorFromRGB(rgbValue_Theme_green)];
        }
        UIImage *image = [UIImage imageNamed:@"IMG_1240"];
        UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
        leftImage.image = stretchableImage;
        UIImage *image2 = [UIImage imageNamed:@"IMG_1241"];
        UIImage* stretchableImage2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width / 2 topCapHeight:image2.size.height / 2];
        rightImage.image = stretchableImage2;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeThemeColor" object:@"green"];
    }else if (button.tag == BUTTON_TAG + 4) {
        [[self.view viewWithTag:BUTTON_TAG + 1]setHidden:NO];
        [[self.view viewWithTag:BUTTON_TAG + 2]setHidden:NO];
        [[self.view viewWithTag:BUTTON_TAG + 3]setHidden:NO];
        [[self.view viewWithTag:BUTTON_TAG + 4]setHidden:YES];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(rgbValue_Theme_pueple)];
        }else{
            [self.navigationController.navigationBar setTintColor:UIColorFromRGB(rgbValue_Theme_pueple)];
        }
        UIImage *image = [UIImage imageNamed:@"IMG_1242"];
        UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
        leftImage.image = stretchableImage;
        UIImage *image2 = [UIImage imageNamed:@"IMG_1243"];
        UIImage* stretchableImage2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width / 2 topCapHeight:image2.size.height / 2];
        rightImage.image = stretchableImage2;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeThemeColor" object:@"pueple"];
    }
    
}

-(void)initBtnAndImage
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"currentTheme.plist"];
    NSMutableDictionary *currentTheme = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    
    if ([[currentTheme objectForKey:@"currentTheme"]isEqualToString:@"red"]) {
        [[self.view viewWithTag:BUTTON_TAG + 1]setHidden:YES];
        UIImage *image = [UIImage imageNamed:@"IMG_1236"];
        UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
        leftImage.image = stretchableImage;
        UIImage *image2 = [UIImage imageNamed:@"IMG_1237"];
        UIImage* stretchableImage2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width / 2 topCapHeight:image2.size.height / 2];
        rightImage.image = stretchableImage2;
    }else if ([[currentTheme objectForKey:@"currentTheme"]isEqualToString:@"blue"]) {
        [[self.view viewWithTag:BUTTON_TAG + 2]setHidden:YES];
        UIImage *image = [UIImage imageNamed:@"IMG_1238"];
        UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
        leftImage.image = stretchableImage;
        UIImage *image2 = [UIImage imageNamed:@"IMG_1239"];
        UIImage* stretchableImage2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width / 2 topCapHeight:image2.size.height / 2];
        rightImage.image = stretchableImage2;
    }else if ([[currentTheme objectForKey:@"currentTheme"]isEqualToString:@"green"]) {
        [[self.view viewWithTag:BUTTON_TAG + 3]setHidden:YES];
        UIImage *image = [UIImage imageNamed:@"IMG_1240"];
        UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
        leftImage.image = stretchableImage;
        UIImage *image2 = [UIImage imageNamed:@"IMG_1241"];
        UIImage* stretchableImage2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width / 2 topCapHeight:image2.size.height / 2];
        rightImage.image = stretchableImage2;
    }else if ([[currentTheme objectForKey:@"currentTheme"]isEqualToString:@"pueple"]) {
        [[self.view viewWithTag:BUTTON_TAG + 4]setHidden:YES];
        UIImage *image = [UIImage imageNamed:@"IMG_1242"];
        UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
        leftImage.image = stretchableImage;
        UIImage *image2 = [UIImage imageNamed:@"IMG_1243"];
        UIImage* stretchableImage2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width / 2 topCapHeight:image2.size.height / 2];
        rightImage.image = stretchableImage2;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
