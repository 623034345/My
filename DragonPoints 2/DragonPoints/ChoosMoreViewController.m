//
//  ChoosMoreViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/24.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "ChoosMoreViewController.h"

@interface ChoosMoreViewController ()

@end

@implementation ChoosMoreViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[HttpHelper sharedInstance] removeListener:self];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //    provinceArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"county.plist" ofType:nil]];
    
    //    [_pickerView selectRow:1 inComponent:1 animated:YES];
    self.navigationItem.title = @"请选择商店类别";
    firstArr = [NSMutableArray array];
    secondArr = [NSMutableArray array];
    indexSeleted = 0;
    [[HttpHelper sharedInstance] moreGetdata];
    [self addBackBtnWithImageNormal:@"back" fuction:@selector(backBtn)];

    
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == table1)
    {
        return firstArr.count;
    }
    if (tableView == table2)
    {
        if (firstArr.count >0) {
            MoreOneModel *mod = firstArr[indexSeleted];
            return mod.smallccategoryOfflineList.count;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == table1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        MoreOneModel *mod = firstArr[indexPath.row];
        cell.textLabel.text = mod.largecname;
        return cell;

    }
    if (tableView == table2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
//        if (indexPath.row == currentIndex) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        else
//        {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//
//        }
        MoreOneModel *mod = firstArr[indexSeleted];
        MoreTwoModel *floor = mod.smallccategoryOfflineList[indexPath.row];
        cell.textLabel.text = floor.cname;
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == table1) {
        indexSeleted = indexPath.row;

//        MoreOneModel *mod = firstArr[indexPath.row];
//        _type = mod.largecname;
//        _Z = mod.largecid;
//        
//       
//        if(indexPath.row==indexSeleted){
//            return;
//        }
//        NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:indexSeleted
//                                                       inSection:0];
//        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
//        if (newCell.accessoryType == UITableViewCellAccessoryNone) {
//            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
//        if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
//            oldCell.accessoryType = UITableViewCellAccessoryNone;
//        }
        [table2 reloadData];
    }
    if (tableView == table2) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        if(indexPath.row==currentIndex){
            return;
        }
        NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:currentIndex
                                                       inSection:0];
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        if (newCell.accessoryType == UITableViewCellAccessoryNone) {
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
        if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            oldCell.accessoryType = UITableViewCellAccessoryNone;
        }
        currentIndex=indexPath.row;
        MoreOneModel *mod = firstArr[indexSeleted];
        MoreTwoModel *floor = mod.smallccategoryOfflineList[indexPath.row];
        _type = floor.cname;
        _Z = floor.cid;
    }
}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([MORE isEqualToString:key] )
    {
        NSDictionary *successDic = [notify userInfo][MORE];
        
//                NSLog(@"数据 %@",successDic);
        
        NSArray *sourceArray1 = successDic[@"categoryOfflineList"];
        if (![sourceArray1 isKindOfClass:[NSNull class]]) {
            for (NSDictionary *wdic in sourceArray1)
            {
                MoreOneModel *mod = [[MoreOneModel alloc] init];
                [mod setValuesForKeysWithDictionary:wdic];
                NSArray *huodong  = wdic[@"smallccategoryOfflineList"];
                NSMutableArray *arr1 = [NSMutableArray array];
                [huodong enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MoreTwoModel *floor = [[MoreTwoModel alloc] init];
                    [floor setValuesForKeysWithDictionary:obj];
                    [arr1 addObject:floor];
                }];
                mod.smallccategoryOfflineList = arr1;
                [firstArr addObject:mod];
            }
        }
        [table2 reloadData];
        [table1 reloadData];

        
    }
}
- (void)failure:(NSNotification *)notify
{
    
}

//赋值
- (void)returnTypeInfo:(TypeBlock)block; //赋值的时候回调
{
    _typeInfo = block;
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

- (IBAction)sumitBtn:(id)sender {
    //    _cityInfo(_province1,_city1, _area1);
    if (NULL_STR(_type)) {
        [self showAlertWithPoint:1 text:@"请选择类型" color:UIPINK];
    }
    else
    {
        _typeInfo(_type,_Z);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
