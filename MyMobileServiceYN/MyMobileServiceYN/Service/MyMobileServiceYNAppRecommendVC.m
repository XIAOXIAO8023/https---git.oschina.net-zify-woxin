//
//  MyMobileServiceYNAppRecommendVC.m
//  MyMobileServiceYN
//
//  Created by 陆楠 on 14/12/10.
//  Copyright (c) 2014年 asiainfo-linkage. All rights reserved.
//

#import "MyMobileServiceYNAppRecommendVC.h"

@interface MyMobileServiceYNAppRecommendVC ()

@end

@implementation MyMobileServiceYNAppRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"应用推荐";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AppRecommend" ofType:@"plist"];
    infoArray = [[NSMutableArray alloc]initWithContentsOfFile:path];
    NSLog(@"%@",infoArray);
    
    mainTableView = [[UITableView alloc]init];
    mainTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBar_HEIGHT - NavigationBar_HEIGHT);
    mainTableView.backgroundColor = [UIColor whiteColor];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    [self.view addSubview:mainTableView];
    [mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        icon.tag = IMAGE_TAG + 1;
        [cell.contentView addSubview:icon];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 200, 20)];
        nameLabel.font = [UIFont fontWithName:appTypeFace size:15];
        nameLabel.tag = LABEL_TAG + 1;
        [cell.contentView addSubview:nameLabel];
        
        UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 25, 240, 20)];
        descriptionLabel.font = [UIFont fontWithName:appTypeFace size:13];
        descriptionLabel.tag = LABEL_TAG + 2;
        descriptionLabel.textColor = UIColorFromRGB(rgbValueLightGrey);
        [cell.contentView addSubview:descriptionLabel];
        
        UIView *sepView = [[UIView alloc]initWithFrame:CGRectMake(15, 49, SCREEN_WIDTH - 15, 1)];
        sepView.backgroundColor = UIColorFromRGB(rgbValueBaiYan);
        [cell addSubview:sepView];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[infoArray objectAtIndex:indexPath.row]];
    UIImageView *icon = (UIImageView *)[cell.contentView viewWithTag:IMAGE_TAG + 1];
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:LABEL_TAG + 1];
    UILabel *description = (UILabel *)[cell.contentView viewWithTag:LABEL_TAG + 2];
    
    [icon setImage:[UIImage imageNamed:[dic objectForKey:@"AppIcon"]]];
    nameLabel.text = [dic objectForKey:@"AppName"];
    description.text = [dic objectForKey:@"AppDescription"];
    
    return cell;
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
