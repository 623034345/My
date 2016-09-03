//
//  PayOfflineViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/3.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "PayOfflineViewController.h"

@interface PayOfflineViewController ()

@end

@implementation PayOfflineViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"提交订单";
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    a = 1;
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];
    self.view.backgroundColor = UIWHITE;
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
   
    [self.view addSubview:table];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [btn setBackgroundImage:[UIImage imageNamed:@"bigABtn"] forState:UIControlStateNormal];
    [btn setTitle:@"提交订单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 110;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            return 110;
        }
        if (indexPath.row == 4) {
            return 80;
        }
        return 40;
    }
    return 40;
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.001;
    }
    else
    {
        return 7;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 5;

    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            FrameOnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FrameOnTableViewCell"];
            if (!cell ) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FrameOnTableViewCell" owner:self options:nil] lastObject];
            }
            cell.img.image = [UIImage imageNamed:@"shiyan"];
            cell.oneLab.font = [UIFont systemFontOfSize:13];
            cell.oneLab.textColor = UICOLOR_HEX(0x969fa8);
            cell.oneLab.text = @"多撒谎尽快恢复到什么呢DNS我看了";
            return cell;
            
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellin"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellin"];
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
                img.image = [UIImage imageNamed:@"dd"];
                [cell addSubview:img];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 150, 30)];
                lab.text = @"我的商店";
                [cell addSubview:lab];
            }
            return cell;
            
        }
        if (indexPath.row == 1) {
            FrameOnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FrameOnTableViewCell"];
            if (!cell ) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FrameOnTableViewCell" owner:self options:nil] lastObject];
            }
            cell.img.image = [UIImage imageNamed:@"shiyan"];
            [cell.hight setHighlighted:YES];
            cell.oneLab.text = @"这货是一个商品";
            return cell;
        }
        if (indexPath.row == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOnT"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellOnT"];
 
            }
            cell.textLabel.text = @"邮费";
            cell.detailTextLabel.text = @"￥38";
            return cell;
        }
        if (indexPath.row == 3) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tWcellin"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tWcellin"];
                numLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 5, 30, 30)];
                numLab.tag = 8;
                numLab.textAlignment = NSTextAlignmentCenter;
                [cell addSubview:numLab];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(SCREEN_WIDTH - 90, 5, 30, 30);
                [btn setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(bian:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = 5;
                [cell addSubview:btn];
                UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                btn1.frame = CGRectMake(SCREEN_WIDTH - 30, 5, 30, 30);
                [btn1 setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(bian:) forControlEvents:UIControlEventTouchUpInside];
                btn1.tag = 6;
                [cell addSubview:btn1];

            }
            UILabel *lab = (UILabel *)[cell viewWithTag:8];
            lab.text = [NSString stringWithFormat:@"%d",a];
            cell.textLabel.text = @"数量";
            return cell;
        }
        if (indexPath.row == 4) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celTslOnT"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celTslOnT"];
                fieldYan = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 80)];
                fieldYan.placeholder = @"与商家留言;在这里可以输入商品的规格,或你得特殊需求";
                fieldYan.delegate =self;
                [cell addSubview:fieldYan];
            }
            
            return cell;
        }
    }
    if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aRcelTslOnT"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aRcelTslOnT"];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 250, 5, 220, 30)];
            lab.textColor = UICOLOR_HEX(0xea4b35);
            lab.textAlignment = NSTextAlignmentRight;
            lab.tag = 41;
            [cell addSubview:lab];
        }
        float b = a *24.5;
        UILabel *lab =(UILabel *)[cell viewWithTag:41];
        lab.text = [NSString stringWithFormat:@"共%d件商品,共需要%@元",a,[[GlobalCenter sharedInstance] decimalwithfloatV:b]];
        
        return cell;
    }
    return nil;
}
-(void)bian:(UIButton *)button
{
    if (button.tag == 5) {
        if (a > 0) {
            a --;
            [table reloadData];
        }
        else
        {
            return;
        }
    }
    if (button.tag == 6)
    {
        a++;
        [table reloadData];

    }
}
-(void)nextBtn
{
    PayViewController *pvc = [[PayViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
    
}

-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}
- (void) keyboardWasShown:(NSNotification *) notif
{
    NSDictionary* info = [notif userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.view.frame =  CGRectMake(0,  -kbSize.height+150, SCREEN_WIDTH, SCREEN_HEIGHT - kbSize.height+150);
    
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
    self.view .frame =  SCREEN_BOUNDS;
    
    
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
