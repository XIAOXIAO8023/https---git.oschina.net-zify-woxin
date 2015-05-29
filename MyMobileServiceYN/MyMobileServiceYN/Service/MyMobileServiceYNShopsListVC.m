//
//  MyMobileServiceYNShopsListVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-5-9.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNShopsListVC.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"

@interface MyMobileServiceYNShopsListVC ()

@end

@implementation MyMobileServiceYNShopsListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setShopLocationArray
{
    shopLocationArray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:@"0871" forKey:@"cityCode"];
    [dic1 setObject:@"昆明" forKey:@"cityName"];
    [shopLocationArray addObject:dic1];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
    [dic2 setObject:@"0883" forKey:@"cityCode"];
    [dic2 setObject:@"临沧" forKey:@"cityName"];
    [shopLocationArray addObject:dic2];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
    [dic3 setObject:@"0874" forKey:@"cityCode"];
    [dic3 setObject:@"曲靖" forKey:@"cityName"];
    [shopLocationArray addObject:dic3];
    
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc]init];
    [dic4 setObject:@"0876" forKey:@"cityCode"];
    [dic4 setObject:@"文山" forKey:@"cityName"];
    [shopLocationArray addObject:dic4];
    
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc]init];
    [dic5 setObject:@"0692" forKey:@"cityCode"];
    [dic5 setObject:@"德宏" forKey:@"cityName"];
    [shopLocationArray addObject:dic5];
    
    NSMutableDictionary *dic6 = [[NSMutableDictionary alloc]init];
    [dic6 setObject:@"0887" forKey:@"cityCode"];
    [dic6 setObject:@"迪庆" forKey:@"cityName"];
    [shopLocationArray addObject:dic6];
    
    NSMutableDictionary *dic7 = [[NSMutableDictionary alloc]init];
    [dic7 setObject:@"0879" forKey:@"cityCode"];
    [dic7 setObject:@"普洱" forKey:@"cityName"];
    [shopLocationArray addObject:dic7];
    
    NSMutableDictionary *dic8 = [[NSMutableDictionary alloc]init];
    [dic8 setObject:@"0878" forKey:@"cityCode"];
    [dic8 setObject:@"楚雄" forKey:@"cityName"];
    [shopLocationArray addObject:dic8];
    
    NSMutableDictionary *dic9 = [[NSMutableDictionary alloc]init];
    [dic9 setObject:@"0877" forKey:@"cityCode"];
    [dic9 setObject:@"玉溪" forKey:@"cityName"];
    [shopLocationArray addObject:dic9];
    
    NSMutableDictionary *dic10 = [[NSMutableDictionary alloc]init];
    [dic10 setObject:@"0886" forKey:@"cityCode"];
    [dic10 setObject:@"怒江" forKey:@"cityName"];
    [shopLocationArray addObject:dic10];
    
    NSMutableDictionary *dic11 = [[NSMutableDictionary alloc]init];
    [dic11 setObject:@"0873" forKey:@"cityCode"];
    [dic11 setObject:@"红河" forKey:@"cityName"];
    [shopLocationArray addObject:dic11];
    
    NSMutableDictionary *dic12 = [[NSMutableDictionary alloc]init];
    [dic12 setObject:@"0888" forKey:@"cityCode"];
    [dic12 setObject:@"丽江" forKey:@"cityName"];
    [shopLocationArray addObject:dic12];
    
    NSMutableDictionary *dic13 = [[NSMutableDictionary alloc]init];
    [dic13 setObject:@"0870" forKey:@"cityCode"];
    [dic13 setObject:@"昭通" forKey:@"cityName"];
    [shopLocationArray addObject:dic13];
    
    NSMutableDictionary *dic14 = [[NSMutableDictionary alloc]init];
    [dic14 setObject:@"0691" forKey:@"cityCode"];
    [dic14 setObject:@"西双版纳" forKey:@"cityName"];
    [shopLocationArray addObject:dic14];
    
    NSMutableDictionary *dic15 = [[NSMutableDictionary alloc]init];
    [dic15 setObject:@"0875" forKey:@"cityCode"];
    [dic15 setObject:@"保山" forKey:@"cityName"];
    [shopLocationArray addObject:dic15];
    
    NSMutableDictionary *dic16 = [[NSMutableDictionary alloc]init];
    [dic16 setObject:@"0872" forKey:@"cityCode"];
    [dic16 setObject:@"大理" forKey:@"cityName"];
    [shopLocationArray addObject:dic16];
}


//-(void)setShopsArray
//{
//    shopsArray = [[NSMutableArray alloc]init];
//    
//    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
//    [dic1 setObject:@"sm_subad1" forKey:@"image"];
//    [dic1 setObject:@"旺旺超市" forKey:@"name"];
//    [dic1 setObject:@"生活的橱窗 精彩每一天" forKey:@"desc"];
//    [shopsArray addObject:dic1];
//    
//    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
//    [dic2 setObject:@"sm_subad2" forKey:@"image"];
//    [dic2 setObject:@"天生祥超市" forKey:@"name"];
//    [dic2 setObject:@"全场一元秒杀" forKey:@"desc"];
//    [shopsArray addObject:dic2];
//    
//    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
//    [dic3 setObject:@"sm_subad3" forKey:@"image"];
//    [dic3 setObject:@"鹏飞家电商行" forKey:@"name"];
//    [dic3 setObject:@"全场5折" forKey:@"desc"];
//    [shopsArray addObject:dic3];
//    
//    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc]init];
//    [dic4 setObject:@"sm_subad4" forKey:@"image"];
//    [dic4 setObject:@"左岸咖啡馆" forKey:@"name"];
//    [dic4 setObject:@"咖啡之翼 奇幻之旅" forKey:@"desc"];
//    [shopsArray addObject:dic4];
//    
//    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc]init];
//    [dic5 setObject:@"sm_subad5" forKey:@"image"];
//    [dic5 setObject:@"西柚烘焙" forKey:@"name"];
//    [dic5 setObject:@"烘焙妙趣 小资生活" forKey:@"desc"];
//    [shopsArray addObject:dic5];
//    
//    NSMutableDictionary *dic6 = [[NSMutableDictionary alloc]init];
//    [dic6 setObject:@"sm_subad1" forKey:@"image"];
//    [dic6 setObject:@"旺旺超市" forKey:@"name"];
//    [dic6 setObject:@"生活的橱窗 精彩每一天" forKey:@"desc"];
//    [shopsArray addObject:dic6];
//    
//    NSMutableDictionary *dic7 = [[NSMutableDictionary alloc]init];
//    [dic7 setObject:@"sm_subad2" forKey:@"image"];
//    [dic7 setObject:@"天生祥超市" forKey:@"name"];
//    [dic7 setObject:@"全场一元秒杀" forKey:@"desc"];
//    [shopsArray addObject:dic2];
//    
//    NSMutableDictionary *dic8 = [[NSMutableDictionary alloc]init];
//    [dic8 setObject:@"sm_subad3" forKey:@"image"];
//    [dic8 setObject:@"鹏飞家电商行" forKey:@"name"];
//    [dic8 setObject:@"全场5折" forKey:@"desc"];
//    [shopsArray addObject:dic8];
//    
//    NSMutableDictionary *dic9 = [[NSMutableDictionary alloc]init];
//    [dic9 setObject:@"sm_subad4" forKey:@"image"];
//    [dic9 setObject:@"左岸咖啡馆" forKey:@"name"];
//    [dic9 setObject:@"咖啡之翼 奇幻之旅" forKey:@"desc"];
//    [shopsArray addObject:dic9];
//    
//    NSMutableDictionary *dic10 = [[NSMutableDictionary alloc]init];
//    [dic10 setObject:@"sm_subad5" forKey:@"image"];
//    [dic10 setObject:@"西柚烘焙" forKey:@"name"];
//    [dic10 setObject:@"烘焙妙趣 小资生活" forKey:@"desc"];
//    [shopsArray addObject:dic10];
//}

-(void)setShopsArray{
    shopsArray = [[NSMutableArray alloc]init];
    for (int i=1; i<=9; i++) {
        NSString *urlString=[NSString stringWithFormat:@"http://218.202.0.168:8099/sm_listpic%d.png",i];
//        UIImage *cachedImage = [[SDWebImageManager sharedManager] imageWithURL:[NSURL URLWithString:urlString]]; // 将需要缓存的图片加载进来
        NSData *imageDate = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:urlString]];
        UIImage *cachedImage = [UIImage imageWithData:imageDate];
        
        if (cachedImage) {
            [shopsArray addObject:cachedImage];
            [shopsQuiltView reloadData];
        }else{
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlString]
                                                    options:0
                                                    progress:nil
             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                 if(image){
                     [shopsArray addObject:image];
                     [shopsQuiltView reloadData];
                 }
             }];
//            [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:urlString] delegate:self options:SDWebImageLowPriority success:^(UIImage *image, BOOL cached) {
//                [shopsArray addObject:image];
//                [shopsQuiltView reloadData];
//            } failure:^(NSError *error) {
//                
//            }];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"商家列表";
    [self setShopLocationArray];
    [self setShopsArray];

    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headerView.backgroundColor=UIColorFromRGB(rgbValueBgGrey);
    [self.view addSubview:headerView];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    imageView.image=[UIImage imageNamed:@"msg_listico"];
    [headerView addSubview:imageView];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 200, 44)];
    title.text=[MyMobileServiceYNParam getCityName];
    title.backgroundColor=[UIColor clearColor];
    title.textColor=UIColorFromRGB(rgbValueDeepGrey);
    title.font=[UIFont fontWithName:appTypeFace size:18];
    title.tag=LABEL_TAG+1;
    [headerView addSubview:title];
    
    UIButton *shopLocationButton=[[UIButton alloc]initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH, 44)];
    shopLocationButton.backgroundColor=[UIColor clearColor];
    [shopLocationButton addTarget:self action:@selector(showShopLocationPicker) forControlEvents:UIControlEventTouchUpInside];
    shopLocationButton.tag=BUTTON_TAG+1;
    [headerView addSubview:shopLocationButton];
    
    shopsQuiltView=[[TMQuiltView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-44)];
    shopsQuiltView.delegate=self;
    shopsQuiltView.dataSource=self;
    shopsQuiltView.backgroundColor=[UIColor clearColor];
    [shopsQuiltView reloadData];
    [self.view addSubview:shopsQuiltView];
    
    backSelectShopsLocationView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-216-44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT)];
    backSelectShopsLocationView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:backSelectShopsLocationView];
    backSelectShopsLocationView.hidden=YES;
    
    UIToolbar *selectComplainTypeTooler = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UIPickerView *selectComplainTypePicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 216)];
    
    [selectComplainTypeTooler setBarStyle:UIBarStyleDefault];
    [selectComplainTypeTooler setBackgroundColor:[UIColor blackColor]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [selectComplainTypePicker setBackgroundColor:[UIColor whiteColor]];
    }
    
    NSMutableArray *buttons1 = [[NSMutableArray alloc] initWithCapacity:3];
    UIBarButtonItem *locationBarButtonItemButtonCan1 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(selectShopLocationPickerCancel)];
    [buttons1 addObject:locationBarButtonItemButtonCan1];
    
    
    UIBarButtonItem *flexibleSpaceItem1;
    flexibleSpaceItem1 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self  action:NULL];
    [buttons1 addObject:flexibleSpaceItem1];
    
    
    UIBarButtonItem *locationBarButtonItemButtonCom1 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectShopLocationPickerSure)];
    [buttons1 addObject:locationBarButtonItemButtonCom1];
    [selectComplainTypeTooler setItems:buttons1 animated:NO];
    selectComplainTypePicker.delegate=self;
    selectComplainTypePicker.tag=2001;
    selectComplainTypePicker.showsSelectionIndicator = YES;
    [backSelectShopsLocationView addSubview:selectComplainTypeTooler];
    [backSelectShopsLocationView addSubview:selectComplainTypePicker];
}

-(void)sendRequest{
    NSMutableDictionary *requestBeanDic=[httpRequest getHttpPostParamData:@"queryComplainList"];
    [requestBeanDic setObject:@"30" forKey:@"acceptFrom"];
    [requestBeanDic setObject:@"123456" forKey:@"SERIAL_NUMBER"];
    [httpRequest startAsynchronous:@"queryComplainList" requestParamData:requestBeanDic viewController:self];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    NSData *jsonData =[request responseData];
    DebugNSLog(@"%@",[request responseString]);
    
    NSDictionary *dic = [[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil] objectAtIndex:0];
    if([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]){
        
        
    }else{
        NSString *returnMessage = [returnMessageDeal returnMessage:[dic objectForKey:@"X_RESULTCODE"] andreturnMessage:[dic objectForKey:@"X_RESULTINFO"]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        alertView.tag = ALERTVIEW_TAG_RETURN+1;
        [alertView show];
    }
    if(HUD){
        [HUD removeHUD];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSString *returnMessage = [returnMessageDeal returnMessage:@"网络异常" andreturnMessage:@""];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:returnMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN+2;
    [alertView show];
    if(HUD){
        [HUD removeHUD];
    }
}

#pragma mark - Standard TMQuiltView delegates
- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)quiltView {
    return 9;
}

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TMQuiltViewCell *cell = [quiltView dequeueReusableCellWithReuseIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[TMQuiltViewCell alloc] initWithReuseIdentifier:CellIdentifier] ;
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = 1;
        [cell addSubview:imageView];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textColor=UIColorFromRGB(rgbValueDeepGrey);
        nameLabel.tag = 2;
        nameLabel.textAlignment=NSTextAlignmentCenter;
        nameLabel.backgroundColor = [UIColor clearColor];
        [cell addSubview:nameLabel];
        
        UILabel *descLabel = [[UILabel alloc]init];
        descLabel.font = [UIFont systemFontOfSize:12];
        descLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
        descLabel.tag = 3;
        descLabel.textAlignment=NSTextAlignmentCenter;
        descLabel.backgroundColor = [UIColor clearColor];
        [cell addSubview:descLabel];
    }
    NSInteger row = [indexPath row];
    
//    NSDictionary *rowData=[shopsArray objectAtIndex:row];

    UIImageView *imageView=(UIImageView *)[cell viewWithTag:1];
    if(row<shopsArray.count){
        UIImage *image=[shopsArray objectAtIndex:row];
        imageView.image=image;
        imageView.frame=CGRectMake(0, 0, 160, image.size.height/(image.size.width/160));
    }else{
        imageView.image=[UIImage imageNamed:@"sm_loading"];
        imageView.frame=CGRectMake(0, 0, 160, imageView.image.size.height);
    }
    
    
//    UILabel *name=(UILabel *)[cell viewWithTag:2];
//    name.text=[rowData objectForKey:@"name"];
//    [name setNumberOfLines:0];
//    CGSize sizeName = CGSizeMake(150,50);
//    UIFont *fontName = [UIFont systemFontOfSize:16];
//    CGSize labelsizeName = [name.text sizeWithFont:fontName constrainedToSize:sizeName lineBreakMode:NSLineBreakByWordWrapping];
//    name.frame=CGRectMake(5, imageView.frame.size.height+2, 150, labelsizeName.height);
//    
//    UILabel *funcDesc=(UILabel *)[cell viewWithTag:3];
//    funcDesc.text=[rowData objectForKey:@"desc"];
//    [funcDesc setNumberOfLines:0];
//    CGSize sizeFuncDesc = CGSizeMake(150,80);
//    UIFont *fontFuncDesc = [UIFont systemFontOfSize:14];
//    CGSize labelsizeFuncDesc = [funcDesc.text sizeWithFont:fontFuncDesc constrainedToSize:sizeFuncDesc lineBreakMode:NSLineBreakByWordWrapping];
//    funcDesc.frame=CGRectMake(10, imageView.frame.size.height+name.frame.size.height+5, 140, labelsizeFuncDesc.height);
    
    CGRect cellFrame = [cell frame];
    cellFrame.size.height = imageView.frame.size.height;
    [cell setFrame:cellFrame];
    [cell.layer setBorderColor: [UIColorFromRGB(rgbValueLineGrey) CGColor]];
    [cell.layer setBorderWidth: 0.5f];  //边框宽度
    [cell.layer setCornerRadius:1.0f]; //边框弧度
    [cell.layer setMasksToBounds:YES];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}


- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath{

}

- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView{
    return 2;
}

- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath{
    TMQuiltViewCell *cell = [self quiltView:quiltView cellAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

-(void)showShopLocationPicker{
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:NO];
    backSelectShopsLocationView.hidden=NO;
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromTop];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backSelectShopsLocationView.layer addAnimation:animation1 forKey:@"fade"];
}

#pragma mark -
#pragma mark 处理方法
// 返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}
// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return shopLocationArray.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectShopsLocationRow=row;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *locationPiclerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    locationPiclerView.textAlignment = UITextAlignmentCenter;
    locationPiclerView.text = [[shopLocationArray objectAtIndex:row] objectForKey:@"cityName"];
    locationPiclerView.font = [UIFont fontWithName:appTypeFace size:16];
    locationPiclerView.adjustsFontSizeToFitWidth=YES;
    locationPiclerView.backgroundColor = [UIColor clearColor];
    return locationPiclerView;
}


-(void)selectShopLocationPickerSure{
    NSString  *result = [[shopLocationArray objectAtIndex:selectShopsLocationRow] objectForKey:@"cityName"];
    [(UILabel *)[self.view viewWithTag:LABEL_TAG+1] setText:result];
    [self selectShopLocationPickerCancel];
}

-(void)selectShopLocationPickerCancel{
    backSelectShopsLocationView.hidden=YES;
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG+1] setEnabled:YES];
    CATransition *animation1 = [CATransition animation];
    [animation1 setDuration:0.5f];
    [animation1 setType:kCATransitionPush];
    [animation1 setSubtype:kCATransitionFromBottom];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [backSelectShopsLocationView.layer addAnimation:animation1 forKey:@"fade"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
