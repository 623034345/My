//
//  AuditShopViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/31.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "AuditShopViewController.h"

@interface AuditShopViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSString *contentStr;
}
@end

@implementation AuditShopViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏TabBar
    [self.tabBarController.tabBar setHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
    
    [[HttpHelper sharedInstance]removeListener:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商家审核";
    self.view.backgroundColor = UIWHITE;
    [self addBackBtnWithImageNormal:@"back" fuction:@selector(backBtn)];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewAutomaticDimension;
    [self.view addSubview:table];
    [self creatBtn];
}
-(void)creatBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:UIRED];
    [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
    [btn setTitle:@"拒绝" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH/2, 49);
    [btn addTarget:self action:@selector(juj) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundColor:UICYAN];
    [btn1 setTitleColor:UIWHITE forState:UIControlStateNormal];
    [btn1 setTitle:@"通过" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - 49, SCREEN_WIDTH/2, 49);
    [btn1 addTarget:self action:@selector(tong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}
//拒绝
-(void)juj
{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"拒绝理由不能为空" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    okAction.enabled = NO;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    //如果是UIAlertControllerStyleActionSheet 不能使用添加输入框的方法
    [alertControl addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //添加输入框(已经自动add，不需要手动)
        textField.placeholder = @"请输入拒绝理由";
        
        //监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listeningTextField:) name:UITextFieldTextDidChangeNotification object:textField];
        
    }];
    //添加按钮（按钮的排列与添加顺序一样，唯独取消按钮会一直在最下面）
    [alertControl addAction:okAction];//ok
//    [alertControl addAction:aaaAction];//aaa
    [alertControl addAction:cancelAction];//cancel
    
    //显示警报框
    [self presentViewController:alertControl animated:YES completion:nil];

}
-(void)listeningTextField:(NSNotification *)notionfication
{
    UITextField *thisTextField = (UITextField*)notionfication.object;
    contentStr = thisTextField.text;
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    
    if (alertController) {
        
        UITextField *login = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.firstObject;
        okAction.enabled = login.text.length > 2;
        
    }
}
//通过
-(void)tong
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }
    else
    {
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            line.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:line];
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 80, 44)];
            name.font = [UIFont systemFontOfSize:15];
            name.tag = 111;
            [cell addSubview:name];
            UILabel *name1 = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, SCREEN_WIDTH - 90, 44)];
            name1.font = [UIFont systemFontOfSize:15];
            name1.tag = 112;
            [cell addSubview:name1];
        }
        NSArray *arr = @[@"高级账户",@"注册手机",@"申请类别",@"申请人",@"店铺座机",@"优惠折扣",@"位置",@"资质",];
        UILabel *lab = (UILabel *)[cell viewWithTag:111];
        UILabel *lab1 = (UILabel *)[cell viewWithTag:112];

        lab.text = arr[indexPath.row];
        lab1.text = @"这是名字或店铺";

        return cell;
 
    }
    if (indexPath.section == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellon"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellon"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            line.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:line];
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, 5, 200, 100)];
            img.tag = 561;
            [cell addSubview:img];

        }
        UIImageView *img = (UIImageView *)[cell viewWithTag:561];
        img.image = [UIImage imageNamed:@"shiyan"];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }
    return 110;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(void)show:(UIButton *)button
{
    
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    //    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    NSDictionary *successDic = [notify userInfo][key];
    
}

- (void)failure:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [self showAlertWithPoint:0
                        text:[notify userInfo][FAILURE]
                       color:UIPINK];
    
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
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
