//
//  CartViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"购物车";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tabBarController.tabBar setHidden:NO];
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
    shopArr = [NSMutableArray array];
//    shopArr = @[@"10",@"20",@"30",@"40"];
    referralArr = [NSMutableArray arrayWithObjects:@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa", nil];
    self.view.backgroundColor = UIWHITE;
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    if (shopArr.count > 0) {
        [self creatBtnBotm];

    }
    
    
}
-(void)creatBtnBotm
{
    All =NO;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 79, SCREEN_WIDTH, 30)];
    view.backgroundColor = UIWHITE;
    [self.view addSubview:view];
    UIButton *seleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seleBtn.frame = CGRectMake(0, 0, 60, 30);
    [seleBtn setImage:[UIImage imageNamed:@"nosele"] forState:UIControlStateNormal];
    [seleBtn setTitle:@"全选" forState:UIControlStateNormal];
    [seleBtn setTitleColor:UIBLACK forState:UIControlStateNormal];
    seleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [seleBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    seleBtn.tag = -10;
    [view addSubview:seleBtn];
    labPrice = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 170, 15)];
    labPrice.text = [NSString stringWithFormat:@"你将支付:￥0元"];
    labPrice.font = [UIFont systemFontOfSize:15];
    labPrice.textAlignment = NSTextAlignmentRight;
    [view addSubview:labPrice];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, SCREEN_WIDTH - 170, 15)];
    lab1.font = [UIFont systemFontOfSize:15];
    lab1.text = @"200云币";
    lab1.textAlignment = NSTextAlignmentRight;
    [view addSubview:lab1];
    
    payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(SCREEN_WIDTH - 80, 0, 80, 30);
    [payBtn setTitle:[NSString stringWithFormat:@"结算%lu",(unsigned long)loca.count] forState:UIControlStateNormal];
 
    [payBtn setBackgroundImage:[UIImage imageNamed:@"smallbotton"] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:payBtn];
    
}
-(void)allBtn
{

    
}
-(void)payBtn
{
    PayViewController *pvc =[[PayViewController alloc] init];
    pvc.numText = [NSString stringWithFormat:@"%@",[self decimalwithfloatV:priceNum]];
    [self.navigationController pushViewController:pvc animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (shopArr.count > 0) {
        return 1;
    }
//    else
//    {
//        return 1;
//        
//    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (shopArr.count > 0) {
        return shopArr.count;
    }
    else
    {
        return 1;
        
    }
    return 0;
}
-(void)chooseBtn:(UIButton *)button
{
    BOOL isSelected =NO;
    
    //遍历记录索引的数组  如果数组里面的索引和当前点击单元格的indexPath相等
    for (NSNumber *number in _selectedArr)
    {
        //拿出刚才点击单元格的索引
        NSInteger i =[number integerValue];
        //比较
        if (i==button.tag)
        {
            //进到此处表示刚才操作过
            isSelected =YES;
        }
        
    }
//    OnlineTableViewCell * cell = (OnlineTableViewCell *)[[button superview] superview];

    //1.找单元格
    if (isSelected)
    {
        NSString *num = shopArr[button.tag];

        //2.反选
        NSNumber *number =[NSNumber numberWithInteger:button.tag];
        [loca removeObject:num];

        //删掉
        [_selectedArr removeObject:number];
        [button setImage:[UIImage imageNamed:@"nosele"] forState:UIControlStateNormal];
        if (button.tag == -10) {
            [button setImage:[UIImage imageNamed:@"nosele"] forState:UIControlStateNormal];

        }
    }
    else
    {
        if (button.tag !=-10) {
            NSString *num = shopArr[button.tag];
            [loca addObject:num];
            //数组字典之类的存的都是对象数据类型 >>>如果遇到整数类型的可以考虑转换成NSNumber
            //NSNumber  数字类型
            NSNumber *number =[NSNumber numberWithInteger:button.tag];
            
            //添加到数组上
            [_selectedArr addObject:number];
            
            //记录当前单元格的索引
            [button setImage:[UIImage imageNamed:@"sele"] forState:UIControlStateNormal];
        }
       
    }
    
    if (button.tag == -10)
    {
        //遍历记录索引的数组  如果数组里面的索引和当前点击单元格的indexPath相等
        //1.找单元格
        if (All)
        {
            //2.反选
            [loca removeAllObjects];
            //删掉
            [_selectedArr removeAllObjects];
            [button setImage:[UIImage imageNamed:@"nosele"] forState:UIControlStateNormal];
            All = NO;
        }
        else
        {
            All = YES;

        
            for (int a =0; a <shopArr.count; a++) {
                if (_selectedArr.count > 0)
                {
                    [loca removeAllObjects];
                    for (NSString *num in shopArr)
                    {
                        [loca addObject:num];
                        
                        
                    }
                    NSNumber *number =[NSNumber numberWithInteger:a];
                        //添加到数组上
                    [_selectedArr addObject:number];
                    //记录当前单元格的索引
                    [button setImage:[UIImage imageNamed:@"sele"] forState:UIControlStateNormal];
              
                }
                else
                {
                    for (NSString *num in shopArr) {
                        [loca addObject:num];
                        
                        
                    }
                    NSNumber *number =[NSNumber numberWithInteger:a];
                    //添加到数组上
                    [_selectedArr addObject:number];
                    //记录当前单元格的索引
                    [button setImage:[UIImage imageNamed:@"sele"] forState:UIControlStateNormal];
                }
                

            }
   
        }

        [table reloadData];

    }
    priceNum = 0;
    for (int a=0; a<loca.count; a++)
    {
        priceNum = [loca[a] floatValue] + priceNum;
    }
  
    
    NSLog(@"钱数还有多少$%f",priceNum);
    labPrice.text = [NSString stringWithFormat:@"你将支付:￥%@元",[self decimalwithfloatV:priceNum]];
    [payBtn setTitle:[NSString stringWithFormat:@"结算%lu",(unsigned long)loca.count] forState:UIControlStateNormal];


    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (shopArr.count > 0)
    {
        OnlineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OnlineTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OnlineTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        cell.chooseBtn.tag = indexPath.row;
        [cell.chooseBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.chooseBtn setImage:[UIImage imageNamed:@"nosele"] forState:UIControlStateNormal];
        cell.img.image = [UIImage imageNamed:@"shiyan"];

        for (NSNumber *number in _selectedArr)
        {
            if (indexPath.row ==[number integerValue])
            {
                [cell.chooseBtn setImage:[UIImage imageNamed:@"sele"] forState:UIControlStateNormal];
            }
        }
        return cell;
    
    }
    if (shopArr.count == 0)
    {
        if (indexPath.section == 0) {
            NcartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NcartTableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"NcartTableViewCell" owner:self options:nil] lastObject];
            }
//            if (All) {
//                [cell.strollBtn setBackgroundImage:[UIImage imageNamed:@"sele"] forState:UIControlStateNormal];
//            }
//            else
//            {
//                [cell.strollBtn setBackgroundImage:[UIImage imageNamed:@"nosele"] forState:UIControlStateNormal];
//            }
            [cell.strollBtn addTarget:self action:@selector(strollBtn) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
//        if (indexPath.section ==1) {
//            UIButton *button;
//            
//            //行间距
//            
//            int rowLength = 5;
//            
//            //列间距
//            int columnLength = 1;
//            
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell"];
//            if (!cell) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"thirdCell"];
//                cell.selectionStyle = UITableViewCellAccessoryNone;
//                for (int n = 0; n < referralArr.count; n ++) {
//                    int x = (n %2)*((SCREEN_WIDTH - 1)/2 + columnLength) + columnLength;
//                    
//                    int y = (n/2)*((SCREEN_WIDTH - 1)/2 +50 + rowLength) + rowLength;
//                    //                    NSLog(@"X:%d y:%d",x,y);
//                    button = [UIButton buttonWithType:UIButtonTypeCustom];
//                    button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 1)/2 - 1, (SCREEN_WIDTH - 1)/2 + 50);
//                    button.tag = n;
//                    [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
//                    //                [button setImage:[UIImage imageNamed:[imgArr objectAtIndex:n]] forState:UIControlStateNormal];
//                    [cell addSubview:button];
//                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height - 40)];
//                    img.image = [UIImage imageNamed:@"shiyan"];
//                    [button addSubview:img];
//                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 40, button.frame.size.width, 20)];
//                    lab.text = @"我是一个特商品的名字";
//                    lab.font = [UIFont systemFontOfSize:14];
//                    lab.textColor = UIBLACK;
//                    lab.textAlignment = NSTextAlignmentLeft;
//                    [button addSubview:lab];
//                    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 20, button.frame.size.width -6, 20)];
//                    lab1.text = @"￥:222元 赠积分222";
//                    lab1.font = [UIFont systemFontOfSize:14];
//                    lab1.textColor = UIBLACK;
//                    lab1.textAlignment = NSTextAlignmentRight;
//                    [button addSubview:lab1];
//                    
//                }
//
//        }
//            
//            return cell;
//
//    }
    
    }
    
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (shopArr.count > 0) {
        return 160;
    }
    else
    {
        if (indexPath.section == 0) {
            return 220;
        }
        else
        {
            return referralArr.count * (SCREEN_WIDTH - 1)/2;
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }
    return 0.00000000001;
}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([LOGIN isEqualToString:key] )
    {
        NSDictionary *successDic = [notify userInfo][LOGIN];
        NSDictionary *data = successDic[DATAS];
        
        NSArray *sourceArray = data[@"AdvertisementViewList"];
        
        [sourceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             //             FirstRcmdModel *mod =[[FirstRcmdModel alloc]init];
             //             [mod setValuesForKeysWithDictionary:obj];
             //             [scrollerArray addObject:mod];
         }];
    }
    
    
}
- (void)failure:(NSNotification *)notify
{
    
}
-(void)go:(UIButton *)button
{
    
}
//去逛逛
-(void)strollBtn
{
    
}
//调用该方法返回路径
-(NSString *)getFilePath
{
    NSString *filePath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/game.txt"];
    return filePath;
}
//格式话小数 四舍五入类型
- (NSString *) decimalwithfloatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:@"0.00"];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
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
