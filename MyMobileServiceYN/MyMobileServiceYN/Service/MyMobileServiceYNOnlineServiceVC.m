//
//  MyMobileServiceYNOnlineServiceVC.m
//  MyMobileServiceYN
//
//  Created by Zhaobs on 14-3-29.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNOnlineServiceVC.h"
#import "MyMobileServiceYNParam.h"
#import "GlobalDef.h"
#import "UIImage+JSMessagesView.h"

@interface MyMobileServiceYNOnlineServiceVC ()

@end

@implementation MyMobileServiceYNOnlineServiceVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"在线客服";
    
    messageArray=[[NSMutableArray alloc]init];
    httpRequest=[[MyMobileServiceYNHttpRequest alloc]init];
    keyboardHeight = 216.0f+44;
    editViewHeight = 0;
    tableViewContentOffSet=0;
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *configFielPath=[plistPath stringByAppendingPathComponent:@"MyMobileServiceYNOnlineChatting.plist"];
    NSMutableDictionary *JscnMbossConfigDicSandbox = [[NSMutableDictionary alloc] initWithContentsOfFile:configFielPath];
    //判断文件是否存在沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:configFielPath]!= NO ) {
        NSArray *tempArray=[JscnMbossConfigDicSandbox objectForKey:@"onlineChattingArray"];
        if(tempArray!=nil){
            messageArray=[[NSMutableArray alloc]initWithArray:tempArray];
        }
    }
    
    onlineServiceTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-44) style:UITableViewStylePlain];
    onlineServiceTableView.delegate=self;
    onlineServiceTableView.dataSource=self;
    onlineServiceTableView.backgroundColor=[UIColor whiteColor];
    onlineServiceTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:onlineServiceTableView];
    [onlineServiceTableView reloadData];
    [self scrollToBottomAnimated:YES];
    
    //增加手势
	UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
	tapGR.cancelsTouchesInView=NO;
	[onlineServiceTableView addGestureRecognizer:tapGR];
    
//    UIButton *BackGroundButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    BackGroundButton.backgroundColor=[UIColor clearColor];
//    [BackGroundButton addTarget:self action:@selector(viewTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:BackGroundButton];
//    back
    
    editView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-44, SCREEN_WIDTH, 44)];
    editView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:editView];
    
    messageTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 5, 240, 34)];
    messageTextView.backgroundColor=[UIColor whiteColor];
    messageTextView.delegate=self;
    messageTextView.font = [UIFont fontWithName:appTypeFace size:16.0];//设置字体名字和字体大小
    messageTextView.returnKeyType = UIReturnKeyGo;//返回键的类型
    messageTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    messageTextView.scrollEnabled = YES;//是否可以拖动
    [editView addSubview:messageTextView];
    
    UIButton *sendButton=[[UIButton alloc]initWithFrame:CGRectMake(260, 5, 50, 34)];
    sendButton.backgroundColor=UIColorFromRGB(rgbValue_navBarBg);
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendRequest) forControlEvents:UIControlEventTouchUpInside];
    [editView addSubview:sendButton];
    
}

-(void)sendRequest{
    if(messageTextView.text!=nil){
        NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]init];
        [tempDic setObject:messageTextView.text forKey:@"message"];
        [tempDic setObject:@"client" forKey:@"type"];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [tempDic setObject:[dateformatter stringFromDate:[NSDate date]] forKey:@"sendTime"];
        [messageArray addObject:tempDic];
        
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath = [paths objectAtIndex:0];
        //得到完整的文件名
        NSString *configFielPath=[plistPath stringByAppendingPathComponent:@"MyMobileServiceYNOnlineChatting.plist"];
        //建立文件管理
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSMutableDictionary *MyMobileServiceYNOnlineChattingDic = [[NSMutableDictionary alloc] initWithContentsOfFile:configFielPath];
        if([fileManager fileExistsAtPath:configFielPath]==NO){
            //开始创建文件
            [fileManager createFileAtPath:configFielPath contents:nil attributes:nil];
            MyMobileServiceYNOnlineChattingDic=[[NSMutableDictionary alloc]init];
            [MyMobileServiceYNOnlineChattingDic setValue:messageArray forKey:@"onlineChattingArray"];
        }else{
            [MyMobileServiceYNOnlineChattingDic removeObjectForKey:@"onlineChattingArray"];
            [MyMobileServiceYNOnlineChattingDic setValue:messageArray forKey:@"onlineChattingArray"];
        }
        DebugNSLog(@"%@",MyMobileServiceYNOnlineChattingDic);
        //复制到沙盒中
        [MyMobileServiceYNOnlineChattingDic writeToFile:configFielPath atomically:YES];
        
        NSMutableDictionary *requestParamData = [httpRequest getHttpPostParamData:@"CustomerService"];
        [requestParamData setObject:[MyMobileServiceYNParam getCityName] forKey:@"city"];
        [requestParamData setObject:[MyMobileServiceYNParam getBrandName] forKey:@"sBrand"];
        [requestParamData setObject:[MyMobileServiceYNParam getSerialNumber] forKey:@"SERIAL_NUMBER"];
        [requestParamData setObject:messageTextView.text forKey:@"smsBody"];
        [httpRequest startAsynchronous:@"CustomerService" requestParamData:requestParamData viewController:self];
        messageTextView.text=@"";
    }
    
    [onlineServiceTableView reloadData];
    [self scrollToBottomAnimated:YES];
    
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger rows = [onlineServiceTableView numberOfRowsInSection:0];
    
    if(rows > 0) {
        [onlineServiceTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:animated];
    }
}

#pragma mark---;
//返回成功
-(void)requestFinished:(ASIHTTPRequest *)request
{
    DebugNSLog(@"------------requestFinished------------------");
    NSData *jsonData = [request responseData];
    NSArray *cookies = [request responseCookies];
    DebugNSLog(@"%@",cookies);
    DebugNSLog(@"%@",[request responseString]);
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = [array objectAtIndex:0];
    //返回为数组，取第一个OBJECT判断X_RESULTCODE是否为0
   
    if ([[dic objectForKey:@"X_RESULTCODE"] isEqualToString:@"0"]) {
        NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]init];
        [tempDic setObject:[dic objectForKey:@"resultMessage"] forKey:@"message"];
        [tempDic setObject:@"service" forKey:@"type"];
        [messageArray addObject:tempDic];
        
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath = [paths objectAtIndex:0];
        //得到完整的文件名
        NSString *configFielPath=[plistPath stringByAppendingPathComponent:@"MyMobileServiceYNOnlineChatting.plist"];
        //建立文件管理
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSMutableDictionary *MyMobileServiceYNOnlineChattingDic = [[NSMutableDictionary alloc] initWithContentsOfFile:configFielPath];
        if([fileManager fileExistsAtPath:configFielPath]==NO){
            //开始创建文件
            [fileManager createFileAtPath:configFielPath contents:nil attributes:nil];
            MyMobileServiceYNOnlineChattingDic=[[NSMutableDictionary alloc]init];
            [MyMobileServiceYNOnlineChattingDic setValue:messageArray forKey:@"onlineChattingArray"];
        }else{
            [MyMobileServiceYNOnlineChattingDic removeObjectForKey:@"onlineChattingArray"];
            [MyMobileServiceYNOnlineChattingDic setValue:messageArray forKey:@"onlineChattingArray"];
        }
        DebugNSLog(@"%@",MyMobileServiceYNOnlineChattingDic);
        //复制到沙盒中
        [MyMobileServiceYNOnlineChattingDic writeToFile:configFielPath atomically:YES];
        
        [onlineServiceTableView reloadData];
        [self scrollToBottomAnimated:YES];
        
    }
    else  {//不是最新版本，不强制更新
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"X_RESULTINFO"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新",nil];
        alertView.tag = ALERTVIEW_TAG_RETURN + 10;
        [alertView show];
    }
    
}
//返回失败
-(void)requestFailed:(ASIHTTPRequest *)request
{
    DebugNSLog(@"------------requestFailed------------------");
    NSError *error = [request error];
    DebugNSLog(@"%@",error);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"" delegate:self cancelButtonTitle:@"确认退出" otherButtonTitles:nil,nil];
    alertView.tag = ALERTVIEW_TAG_RETURN + 15;
    [alertView show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messageArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UIImageView *clientImage=[[UIImageView alloc]init];
        clientImage.tag=3;
        [cell.contentView addSubview:clientImage];
        
        UILabel *clientMessage=[[UILabel alloc]init];
        clientMessage.backgroundColor=[UIColor clearColor];
        clientMessage.font=[UIFont fontWithName:appTypeFace size:16];
        clientMessage.textColor=[UIColor whiteColor];
        clientMessage.tag=1;
        clientMessage.numberOfLines=0;
        [clientMessage.layer setBorderColor:[[UIColor clearColor] CGColor]];
        [clientMessage.layer setBorderWidth:5.0];  //边框宽度
        [clientMessage.layer setCornerRadius:10.0f]; //边框弧度
        [clientMessage.layer setMasksToBounds:YES];
        [cell.contentView addSubview:clientMessage];
        
        UIImageView *serviceImage=[[UIImageView alloc]init];
        serviceImage.tag=4;
        [cell.contentView addSubview:serviceImage];
        
        UILabel *serviceMessage=[[UILabel alloc]init];
        serviceMessage.backgroundColor=[UIColor clearColor];
        serviceMessage.font=[UIFont fontWithName:appTypeFace size:16];
        serviceMessage.textColor=[UIColor blackColor];
        serviceMessage.tag=2;
        serviceMessage.numberOfLines=0;
        [serviceMessage.layer setBorderColor:[[UIColor clearColor] CGColor]];
        [serviceMessage.layer setBorderWidth:5.0];  //边框宽度
        [serviceMessage.layer setCornerRadius:10.0f]; //边框弧度
        [serviceMessage.layer setMasksToBounds:YES];
        [cell.contentView addSubview:serviceMessage];
    }
    
    NSDictionary *rowData=[messageArray objectAtIndex:[indexPath row]];
    
    if([[rowData objectForKey:@"type"] isEqualToString:@"client"]){
        UILabel *clientMessage=(UILabel *)[cell.contentView viewWithTag:1];
        clientMessage.text=[rowData objectForKey:@"message"];
        CGSize size=CGSizeMake(200, 2000);
        UIFont *font=[UIFont fontWithName:appTypeFace size:16];
        CGSize labelSize=[clientMessage.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        clientMessage.frame=CGRectMake(SCREEN_WIDTH-35-labelSize.width-20, 20, labelSize.width+10, labelSize.height+15);

        UIImageView *clientImage=(UIImageView *)[cell.contentView viewWithTag:3];
        clientImage.image=[UIImage bubbleFlatOutgoing];
        clientImage.frame=CGRectMake(SCREEN_WIDTH-35-labelSize.width-30, 20, labelSize.width+30, labelSize.height+15);
        
        UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
        timeLabel.textColor=UIColorFromRGB(rgbValueLightGrey);
        timeLabel.font=[UIFont fontWithName:appTypeFaceBold size:10];
        timeLabel.textAlignment=NSTextAlignmentCenter;
        timeLabel.text=[rowData objectForKey:@"sendTime"];
        [cell.contentView addSubview:timeLabel];
        
        CGRect cellFrame = [cell frame];
        cellFrame.size.height = labelSize.height+45;
        [cell setFrame:cellFrame];
        
        UIImageView *peoplePhone=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35, cell.frame.size.height-50, 30, 30)];
        peoplePhone.image=[UIImage imageNamed:@"msg_user"];
        [cell.contentView addSubview:peoplePhone];
        
    }else{
        UILabel *serviceMessage=(UILabel *)[cell.contentView viewWithTag:2];
        serviceMessage.text=[rowData objectForKey:@"message"];
        CGSize size=CGSizeMake(200, 2000);
        UIFont *font=[UIFont fontWithName:appTypeFace size:16];
        CGSize labelSize=[serviceMessage.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        serviceMessage.frame=CGRectMake(55, 7.5, labelSize.width+10, labelSize.height+15);
        
        UIImageView *serviceImage=(UIImageView *)[cell.contentView viewWithTag:3];
        serviceImage.image=[UIImage bubbleFlatIncoming];
        serviceImage.frame=CGRectMake(45, 7.5, labelSize.width+30, labelSize.height+15);
        
        CGRect cellFrame = [cell frame];
        cellFrame.size.height = labelSize.height+35;
        [cell setFrame:cellFrame];
        
        UIImageView *xiaoE=[[UIImageView alloc]initWithFrame:CGRectMake(5, cell.frame.size.height-30, 30, 30)];
        xiaoE.image=[UIImage imageNamed:@"msg_cser"];
        [cell.contentView addSubview:xiaoE];
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//手势对应的触发事件
-(void)viewTapped:(UITapGestureRecognizer *)tapGR
{
    [messageTextView resignFirstResponder];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:editView];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    editView.frame = CGRectMake(editView.frame.origin.x, editViewHeight+keyboardHeight, editView.frame.size.width, messageTextView.frame.size.height+10);
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:onlineServiceTableView];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    onlineServiceTableView.frame = CGRectMake(onlineServiceTableView.frame.origin.x, 0, onlineServiceTableView.frame.size.width, editViewHeight+keyboardHeight);
    [UIView commitAnimations];
}

//按下Done按钮的调用方法，我们让键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField.returnKeyType == UIReturnKeyGo){
        [self sendRequest];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - TextView delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    CGSize size=CGSizeMake(240, 100);
    UIFont *font=[UIFont fontWithName:appTypeFace size:16];
    CGSize textViewSize=[textView.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    
    if(textViewSize.height>34){
        textView.frame=CGRectMake(10, 5, 240, textViewSize.height+10);
        editViewHeight=SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-keyboardHeight-textView.frame.size.height-10;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:editView];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.275f];
        editView.frame = CGRectMake(editView.frame.origin.x, editViewHeight, editView.frame.size.width, textView.frame.size.height+10);
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:onlineServiceTableView];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.275f];
        onlineServiceTableView.frame = CGRectMake(onlineServiceTableView.frame.origin.x, 0, onlineServiceTableView.frame.size.width, editViewHeight);
        [UIView commitAnimations];
    }else{
        textView.frame=CGRectMake(10, 5, 240, 34);
        editViewHeight=SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-keyboardHeight-44;
        editView.frame=CGRectMake(0, editViewHeight, SCREEN_WIDTH, 44);
    }
    if(range.location>=30){
        return  NO;
    }
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if(textView.frame.size.height<=34){
        editViewHeight=SCREEN_HEIGHT-StatusBar_HEIGHT-NavigationBar_HEIGHT-keyboardHeight-44;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:editView];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    editView.frame = CGRectMake(editView.frame.origin.x, editViewHeight, editView.frame.size.width, textView.frame.size.height+10);
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:onlineServiceTableView];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.275f];
    onlineServiceTableView.frame = CGRectMake(onlineServiceTableView.frame.origin.x, 0, onlineServiceTableView.frame.size.width, editViewHeight);
    [UIView commitAnimations];
    
    [self scrollToBottomAnimated:YES];
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{

}

-(void)textViewDidChange:(UITextView *)textView {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    [httpRequest setRequestDelegatNil];
}

@end
