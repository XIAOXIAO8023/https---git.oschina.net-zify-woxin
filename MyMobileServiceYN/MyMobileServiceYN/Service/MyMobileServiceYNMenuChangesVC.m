//
//  MyMobileServiceYNMenuChangesVC.m
//  MyMobileServiceYN
//
//  Created by Lee on 14-3-3.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//
//  菜单配置页面，需要再更改后实时刷新页面显示。暂使用uitableview来实现，后续有更好的再替换。
//  uitableview重新加载后的页面刷新由uitableview控件来实现，比手动实现要好一些。

#import "MyMobileServiceYNMenuChangesVC.h"
#import "GlobalDef.h"

@interface MyMobileServiceYNMenuChangesVC ()

@end

@implementation MyMobileServiceYNMenuChangesVC

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
	// Do any additional setup after loading the view.
    self.title = @"自定义菜单";
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    menuListFielPath=[plistPath1 stringByAppendingPathComponent:@"menulist.plist"];
    
    menuListDicSandbox = [[NSMutableDictionary alloc] initWithContentsOfFile:menuListFielPath];
    menuListArray = [menuListDicSandbox objectForKey:@"MenuList"];
    
    //根据MenuChangeStatus判断是否已添加，yes为已添加，no为未题添加
    //过滤menuListArray数据
    NSMutableArray *newmenuSelectList = [[NSMutableArray alloc]init];
    
    for (int i=0; i<menuListArray.count; i++){
        NSDictionary *dic = [menuListArray objectAtIndex:i];
        //plist中bool需要先转成NSNumber 再转成boolValue，写的时候反之NSNumber *testBoolean =[[NSNumber alloc]initWithBool:YES];
        BOOL bMenuChangeStatus = [(NSNumber*)[dic objectForKey:@"MenuChangeStatus"]boolValue];
        if (bMenuChangeStatus) {
            [newmenuSelectList addObject:dic];
        }
    }
    menuSelectList = newmenuSelectList; //已添加
    
    NSMutableArray *newmenuNoSelectList = [[NSMutableArray alloc]init];
    
    for (int i=0; i<menuListArray.count; i++){
        NSDictionary *dic = [menuListArray objectAtIndex:i];
        //plist中bool需要先转成NSNumber 再转成boolValue，写的时候反之NSNumber *testBoolean =[[NSNumber alloc]initWithBool:YES];
        BOOL bMenuChangeStatus = [(NSNumber*)[dic objectForKey:@"MenuChangeStatus"]boolValue];
        if (!bMenuChangeStatus) {
            [newmenuNoSelectList addObject:dic];
        }
    }
    menuNoSelectList = newmenuNoSelectList; //未添加
    
    
    //自定义菜单区域
    menuChangesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 400) style:UITableViewStyleGrouped];
    menuChangesTableView.delegate=self;
	menuChangesTableView.dataSource=self;
	menuChangesTableView.scrollEnabled=YES;
    [self.view addSubview:menuChangesTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 20)];
    firstLabel.backgroundColor = [UIColor clearColor];
    firstLabel.opaque = NO;
    firstLabel.textColor = UIColorFromRGB(rgbValue_menuChangesList_title);
    firstLabel.font = [UIFont boldSystemFontOfSize:16];
    
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 20)];
    secondLabel.backgroundColor = [UIColor clearColor];
    secondLabel.opaque = NO;
    secondLabel.textColor = UIColorFromRGB(rgbValue_menuChangesList_title);
    secondLabel.font = [UIFont systemFontOfSize:12];
    
    if (section == 0) {
        firstLabel.text = @"可选菜单";
        secondLabel.text = @"点击＋号图标即可添加菜单";
    }else{
        firstLabel.text = @"已选菜单";
        secondLabel.text = @"点击－号图标即可删除菜单";
    }
    
    [titleView addSubview:firstLabel];
    [titleView addSubview:secondLabel];
    
    return titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        
        for (int i=0; i<menuNoSelectList.count; i++) {
            UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0+106*(i%3), 0+120*(int)(i/3), 106, 126)];
            
            UIButton *busiButton =[[UIButton alloc]initWithFrame:CGRectMake(13, 13, 80, 80)];
            busiButton.backgroundColor = [UIColor redColor];
            busiButton.tag = 11000+[[[menuNoSelectList objectAtIndex:i] objectForKey:@"MenuID"] intValue];
            [busiButton addTarget:self action:@selector(addMenu:) forControlEvents:UIControlEventTouchUpInside];
            [buttonView addSubview:busiButton];
            [cell.contentView addSubview:buttonView];
            
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(13, 106, 80, 20)];
            lable.text = [[menuNoSelectList objectAtIndex:i] objectForKey:@"MenuName"];
            [buttonView addSubview:lable];
            
        }
        if (menuNoSelectList.count == 0) {
            UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
            firstLabel.backgroundColor = [UIColor clearColor];
            firstLabel.opaque = NO;
            firstLabel.textColor = UIColorFromRGB(rgbValue_menuChangesList_title);
            firstLabel.font = [UIFont boldSystemFontOfSize:16];
            firstLabel.text = @"太棒了，您已添加所有菜单";
            [cell.contentView addSubview:firstLabel];
            CGRect cellFrame = [cell frame];
            cellFrame.size.height = 20;
            [cell setFrame:cellFrame];
            
        }else{
            CGRect cellFrame = [cell frame];
            cellFrame.size.height = 126+126*(int)((menuNoSelectList.count-1)/3);
            [cell setFrame:cellFrame];
            
        }
    }else{
        
        for (int i=0; i<menuSelectList.count; i++) {
            UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0+106*(i%3), 0+120*(int)(i/3), 106, 126)];
            
            UIButton *busiButton =[[UIButton alloc]initWithFrame:CGRectMake(13, 13, 80, 80)];
            busiButton.backgroundColor = [UIColor redColor];
            //根据IsMenuChange判断是否为常驻菜单，常驻菜单不允许删除
            busiButton.tag = 11000+[[[menuSelectList objectAtIndex:i] objectForKey:@"MenuID"] intValue];
            BOOL bIsMenuChange = [(NSNumber*)[[menuSelectList objectAtIndex:i] objectForKey:@"IsMenuChange"] boolValue];
            if (bIsMenuChange) {
                [busiButton addTarget:self action:@selector(deleteMenu:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                busiButton.backgroundColor = [UIColor yellowColor];
            }
            [buttonView addSubview:busiButton];
            [cell.contentView addSubview:buttonView];
            
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(13, 106, 80, 20)];
            lable.text = [[menuSelectList objectAtIndex:i] objectForKey:@"MenuName"];
            [buttonView addSubview:lable];
        }
        if (menuSelectList.count == 0) {
            UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
            firstLabel.backgroundColor = [UIColor clearColor];
            firstLabel.opaque = NO;
            firstLabel.textColor = UIColorFromRGB(rgbValue_menuChangesList_title);
            firstLabel.font = [UIFont boldSystemFontOfSize:16];
            firstLabel.text = @"您还未添加任何菜单";
            [cell.contentView addSubview:firstLabel];
            CGRect cellFrame = [cell frame];
            cellFrame.size.height = 20;
            [cell setFrame:cellFrame];
            
        }else{
            CGRect cellFrame = [cell frame];
            cellFrame.size.height = 126+126*(int)((menuSelectList.count-1)/3);
            [cell setFrame:cellFrame];
            
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

#pragma mark---
#pragma mark - Table view data source
-(void)addMenu:(id)sender
{
    UIButton *button=(UIButton *) sender;
    int menuId = button.tag - 11000;
    for (int i = 0; i < menuListArray.count; i++) {
        if (menuId == [[[menuListArray objectAtIndex:i] objectForKey:@"MenuID"] intValue]) {
            [[menuListArray objectAtIndex:i] setValue:[[NSNumber alloc]initWithBool:YES] forKey:@"MenuChangeStatus"];
        }
    }
    
    [menuListDicSandbox setValue:menuListArray forKey:@"MenuList"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //先删除沙盒中原有文件
    [fileManager removeItemAtPath:menuListFielPath error:nil];
    //复制到沙盒中
    [menuListDicSandbox writeToFile:menuListFielPath atomically:YES];
    
    
    //根据MenuChangeStatus判断是否已添加，yes为已添加，no为未题添加
    //过滤menuListArray数据
    NSMutableArray *newmenuSelectList = [[NSMutableArray alloc]init];
    
    for (int i=0; i<menuListArray.count; i++){
        NSDictionary *dic = [menuListArray objectAtIndex:i];
        //plist中bool需要先转成NSNumber 再转成boolValue，写的时候反之NSNumber *testBoolean =[[NSNumber alloc]initWithBool:YES];
        BOOL bMenuChangeStatus = [(NSNumber*)[dic objectForKey:@"MenuChangeStatus"]boolValue];
        if (bMenuChangeStatus) {
            [newmenuSelectList addObject:dic];
        }
    }
    [menuSelectList removeAllObjects];
    menuSelectList = newmenuSelectList; //已添加
    
    NSMutableArray *newmenuNoSelectList = [[NSMutableArray alloc]init];
    
    for (int i=0; i<menuListArray.count; i++){
        NSDictionary *dic = [menuListArray objectAtIndex:i];
        //plist中bool需要先转成NSNumber 再转成boolValue，写的时候反之NSNumber *testBoolean =[[NSNumber alloc]initWithBool:YES];
        BOOL bMenuChangeStatus = [(NSNumber*)[dic objectForKey:@"MenuChangeStatus"]boolValue];
        if (!bMenuChangeStatus) {
            [newmenuNoSelectList addObject:dic];
        }
    }
    [menuNoSelectList removeAllObjects];
    menuNoSelectList = newmenuNoSelectList; //未添加
    
    [menuChangesTableView reloadData];
}
-(void)deleteMenu:(id)sender
{
    UIButton *button=(UIButton *) sender;
    int menuId = button.tag - 11000;
    for (int i = 0; i < menuListArray.count; i++) {
        if (menuId == [[[menuListArray objectAtIndex:i] objectForKey:@"MenuID"] intValue]) {
            [[menuListArray objectAtIndex:i] setValue:[[NSNumber alloc]initWithBool:NO] forKey:@"MenuChangeStatus"];
        }
    }
    
    [menuListDicSandbox setValue:menuListArray forKey:@"MenuList"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //先删除沙盒中原有文件
    [fileManager removeItemAtPath:menuListFielPath error:nil];
    //复制到沙盒中
    [menuListDicSandbox writeToFile:menuListFielPath atomically:YES];
    
    //根据MenuChangeStatus判断是否已添加，yes为已添加，no为未题添加
    //过滤menuListArray数据
    NSMutableArray *newmenuSelectList = [[NSMutableArray alloc]init];
    
    for (int i=0; i<menuListArray.count; i++){
        NSDictionary *dic = [menuListArray objectAtIndex:i];
        //plist中bool需要先转成NSNumber 再转成boolValue，写的时候反之NSNumber *testBoolean =[[NSNumber alloc]initWithBool:YES];
        BOOL bMenuChangeStatus = [(NSNumber*)[dic objectForKey:@"MenuChangeStatus"]boolValue];
        if (bMenuChangeStatus) {
            [newmenuSelectList addObject:dic];
        }
    }
    [menuSelectList removeAllObjects];
    menuSelectList = newmenuSelectList; //已添加
    
    NSMutableArray *newmenuNoSelectList = [[NSMutableArray alloc]init];
    
    for (int i=0; i<menuListArray.count; i++){
        NSDictionary *dic = [menuListArray objectAtIndex:i];
        //plist中bool需要先转成NSNumber 再转成boolValue，写的时候反之NSNumber *testBoolean =[[NSNumber alloc]initWithBool:YES];
        BOOL bMenuChangeStatus = [(NSNumber*)[dic objectForKey:@"MenuChangeStatus"]boolValue];
        if (!bMenuChangeStatus) {
            [newmenuNoSelectList addObject:dic];
        }
    }
    [menuNoSelectList removeAllObjects];
    menuNoSelectList = newmenuNoSelectList; //未添加
    
    [menuChangesTableView reloadData];
}


@end
