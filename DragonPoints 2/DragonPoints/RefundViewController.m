//
//  RefundViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/16.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "RefundViewController.h"

@interface RefundViewController ()
{
    NSMutableArray *compArr;  //投诉信息数组
 
}
@end

@implementation RefundViewController
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
    self.navigationItem.title = @"退款申请";
    compArr = [NSMutableArray array];
    _selectedArr = [NSMutableArray array];
    compArr = @[@"买错了1",@"买错了2",@"买错了3",@"买错了4",@"买错了5",@"买错了6",@"买错了7",@"买错了8",@"买错了9"];
    loca = [NSMutableArray array];
    NSFileManager *manager =[NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:[self getFilePath]])
    {
        //有
        _selectedArr =[[NSMutableArray alloc]initWithContentsOfFile:[self getFilePath]];
        
    }
    else
    {
        _selectedArr =[[NSMutableArray alloc]initWithCapacity:0];
    }
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [table registerNib:[UINib nibWithNibName:@"SingleTickTableViewCell"
                                      bundle:nil]
                                      forCellReuseIdentifier:@"SingleTickTableViewCell"];
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
    [btn setBackgroundColor:UIRED];
    [btn setTitle:@"申请退款" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
-(void)nextBtn
{
    
}
//调用该方法返回路径
-(NSString *)getFilePath
{
    NSString *filePath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/game.txt"];
    return filePath;
}
#pragma mark-------tableView
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_OS_7_OR_LATER)
    {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return compArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleTickTableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"SingleTickTableViewCell" forIndexPath:indexPath];
    [cell.tipView setHidden:YES];
    for (NSNumber *number in _selectedArr)
    {
        if (indexPath.row ==[number integerValue])
        {
            [cell.tipView setHidden:NO];
        }
    }
//    NSDictionary *dic = compArr[indexPath.row];
    cell.tipLab.font = UIFONT(15);
    cell.tipLab.textColor = UIBLACK;
    cell.tipLab.text = compArr[indexPath.row];

//    cell.tipLab.text = [dic objectForKey:@"content"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    SingleTickTableViewCell *cell = (SingleTickTableViewCell *)[tableView cellForRowAtIndexPath:
                                                                           indexPath];

    BOOL isSelected =NO;
    
    //遍历记录索引的数组  如果数组里面的索引和当前点击单元格的indexPath相等
    for (NSNumber *number in _selectedArr)
    {
        //拿出刚才点击单元格的索引
        NSInteger i =[number integerValue];
        //比较
        if (i==indexPath.row)
        {
            //进到此处表示刚才操作过
            isSelected =YES;
        }
        
    }
    //    OnlineTableViewCell * cell = (OnlineTableViewCell *)[[button superview] superview];
    
    //1.找单元格
    if (isSelected)
    {
        NSString *num = compArr[indexPath.row];
        
        //2.反选
        NSNumber *number =[NSNumber numberWithInteger:indexPath.row];
        [loca removeObject:num];
        
        //删掉
        [_selectedArr removeObject:number];
        [cell.tipView setHidden:YES];
    }
    else
    {
            NSString *num = compArr[indexPath.row];
            [loca addObject:num];
            //数组字典之类的存的都是对象数据类型 >>>如果遇到整数类型的可以考虑转换成NSNumber
            //NSNumber  数字类型
            NSNumber *number =[NSNumber numberWithInteger:indexPath.row];
            
            //添加到数组上
            [_selectedArr addObject:number];
            
            //记录当前单元格的索引
            [cell.tipView setHidden:NO];
        
    }
}


#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    //    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    NSDictionary *successDic = [notify userInfo][key];
}

- (void)failure:(NSNotification *)notify
{
    //    [self dismissIndicatorView];
    //    [self showAlertWithPoint:0
    //                        text:[notify userInfo][FAILURE]
    //                       color:UIPINK];
    InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                text:[notify userInfo][FAILURE]
                                                               color:UIPINK];
    [KEYWINDOW addSubview:infoAlert];
    [infoAlert showView];
    
    
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
