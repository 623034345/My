//
//  EstoreViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/8.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "EstoreViewController.h"

@interface EstoreViewController ()<SDCycleScrollViewDelegate>

@end

@implementation EstoreViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    b = 1;
    referralArr = [NSMutableArray arrayWithObjects:@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa", nil];
    
    // Do any additional setup after loading the view from its nib.
    imagesURLStrings = @[
                         @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                         @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                         @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self creatView];
}
-(void)creatView
{
    self.navigationItem.title =@"店铺详情";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 30)];
    view.backgroundColor = UICOLOR_HEXA(0x2d3e52, 0.5);
    [self.view addSubview:view];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];
    //消息
    [self addNextBtnWithImageNormal:@"xiaoxi1"
                            fuction:@selector(xiaoxi)];
    //    UILabel *lab = [[UILabel alloc] init];
    //    lab.frame = CGRectMake(SCREEN_WIDTH / 2 - 40, 0, 80, 30);
    //    lab.text = @"店铺详情";
    //    lab.textColor = UIWHITE;
    //    [view addSubview:lab];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DetailOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailOneTableViewCell"];
        if (!cell ) {
            cell   = [[[NSBundle mainBundle] loadNibNamed:@"DetailOneTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        cell.scrollImg.delegate = self;
        cell.scrollImg.imageURLStringsGroup = imagesURLStrings;
        [cell.Rating displayRating:3.5];
        return cell;
        
    }
    if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
                        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        btn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 30);
                        [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
                        [btn setTitle:@"特价商品" forState:UIControlStateNormal];
                        btn.tag = 1;
                        [btn addTarget:self action:@selector(oneBtn:) forControlEvents:UIControlEventTouchUpInside];
                        [cell addSubview:btn];
                        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                        btn1.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 30);
                        [btn1 setTitleColor:UIBLACK forState:UIControlStateNormal];
                        [btn1 setTitle:@"兑换商品" forState:UIControlStateNormal];
                        btn1.tag = 2;
                        [btn1 addTarget:self action:@selector(oneBtn:) forControlEvents:UIControlEventTouchUpInside];
                        [cell addSubview:btn1];
            /////////////////////////////////////////////
//            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn2.frame = CGRectMake(0, 0, SCREEN_WIDTH / 4, 30);
//            [btn2 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn2 setTitle:@"默认" forState:UIControlStateNormal];
//            btn2.tag = 4;
//            [btn2 addTarget:self action:@selector(twoBtn:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:btn2];
//            
//            UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn3.frame = CGRectMake(SCREEN_WIDTH / 4, 0, SCREEN_WIDTH / 4, 30);
//            [btn3 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn3 setTitle:@"销量" forState:UIControlStateNormal];
//            btn3.tag = 5;
//            [btn3 addTarget:self action:@selector(twoBtn:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:btn3];
//            
//            UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn4.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 4, 30);
//            [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn4 setTitle:@"价格" forState:UIControlStateNormal];
//            btn4.tag = 6;
//            [btn4 addTarget:self action:@selector(twoBtn:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:btn4];
//            
//            UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn5.frame = CGRectMake(SCREEN_WIDTH / 2 +SCREEN_WIDTH / 4, 0, SCREEN_WIDTH / 4, 30);
//            [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn5 setTitle:@"最新" forState:UIControlStateNormal];
//            btn5.tag = 7;
//            [btn5 addTarget:self action:@selector(twoBtn:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:btn5];
            
                        [btn.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
                        [btn.layer setBorderWidth:1];
                        [btn.layer setMasksToBounds:YES];
                        [btn1.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
                        [btn1.layer setBorderWidth:1];
                        [btn1.layer setMasksToBounds:YES];
            
//            [btn2.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
//            [btn2.layer setBorderWidth:1];
//            [btn2.layer setMasksToBounds:YES];
//            [btn3.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
//            [btn3.layer setBorderWidth:1];
//            [btn3.layer setMasksToBounds:YES];
//            [btn4.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
//            [btn4.layer setBorderWidth:1];
//            [btn4.layer setMasksToBounds:YES];
//            [btn5.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
//            [btn5.layer setBorderWidth:1];
//            [btn5.layer setMasksToBounds:YES];
        }
                UIButton *btn = (UIButton *)[cell viewWithTag:1];
                UIButton *btn2 = (UIButton *)[cell viewWithTag:2];
        
//        UIButton *btn4 = (UIButton *)[cell viewWithTag:4];
//        UIButton *btn5 = (UIButton *)[cell viewWithTag:5];
//        UIButton *btn6 = (UIButton *)[cell viewWithTag:6];
//        UIButton *btn7 = (UIButton *)[cell viewWithTag:7];
        
                if (a == 1) {
                    [btn setTitleColor:UIRED forState:UIControlStateNormal];
                    [btn2 setTitleColor:UIBLACK forState:UIControlStateNormal];
        
                }if (a == 2) {
                    [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
                    [btn2 setTitleColor:UIRED forState:UIControlStateNormal];
                }
//        if (b == 1) {
//            [btn4 setTitleColor:UIRED forState:UIControlStateNormal];
//            [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn6 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn7 setTitleColor:UIBLACK forState:UIControlStateNormal];
//        }
//        if (b == 2) {
//            [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn5 setTitleColor:UIRED forState:UIControlStateNormal];
//            [btn6 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn7 setTitleColor:UIBLACK forState:UIControlStateNormal];
//        }
//        if (b == 3) {
//            [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn6 setTitleColor:UIRED forState:UIControlStateNormal];
//            [btn7 setTitleColor:UIBLACK forState:UIControlStateNormal];
//        }
//        if (b == 4) {
//            [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn6 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn7 setTitleColor:UIRED forState:UIControlStateNormal];
//        }
        
        return cell;
    }
    if (indexPath.row == 2) {
        UIButton *button;
        
        //行间距
        
        int rowLength = 5;
        
        //列间距
        int columnLength = 1;
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"thirdCell"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            for (int n = 0; n < referralArr.count; n ++) {
                int x = (n %2)*((SCREEN_WIDTH - 1)/2 + columnLength) + columnLength;
                
                int y = (n/2)*((SCREEN_WIDTH - 1)/2 +50 + rowLength) + rowLength;
                //                    NSLog(@"X:%d y:%d",x,y);
                button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 1)/2 - 1, (SCREEN_WIDTH - 1)/2 + 50);
                button.tag = n;
                [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
                //                [button setImage:[UIImage imageNamed:[imgArr objectAtIndex:n]] forState:UIControlStateNormal];
                [cell addSubview:button];
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height - 40)];
                img.image = [UIImage imageNamed:@"shiyan"];
                [button addSubview:img];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 40, button.frame.size.width, 20)];
                lab.tag = 101+n;
                lab.text = [referralArr objectAtIndex:n];
                lab.font = [UIFont systemFontOfSize:14];
                lab.textColor = UIBLACK;
                lab.textAlignment = NSTextAlignmentLeft;
                [button addSubview:lab];
                UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 20, button.frame.size.width -6, 20)];
                lab1.text = @"1111云币";
                lab1.font = [UIFont systemFontOfSize:14];
                lab1.textColor = UIBLACK;
                lab1.textAlignment = NSTextAlignmentRight;
                [button addSubview:lab1];
                
            }
            
        }
        for (int n = 0; n <referralArr.count; n ++) {
            UILabel *lab = (UILabel *)[cell viewWithTag:101+ n];
            
            lab.text =[referralArr objectAtIndex:n];
            
        }
        
        return cell;
        
        
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 220;
            
        }

        else if (indexPath.row == 1)
        {
            return 30;
        }
        else if (indexPath.row == 2)
        {
            
            return referralArr.count * (SCREEN_WIDTH - 60)/2;
        }
    }
    if (indexPath.section == 1) {
        return 20;
    }
    
    return 320;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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
-(void)go:(UIButton *)btn
{
    ShopDatailViewController *ovc = [[ShopDatailViewController alloc] init];
    [self.navigationController pushViewController:ovc animated:YES];
}
//消息
-(void)xiaoxi
{
    
}
-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSMutableArray *photos = [NSMutableArray array];
    for (int i=0; i<imagesURLStrings.count; i ++) {
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[imagesURLStrings objectAtIndex:i]]]];
    }
    self.photosImg = photos;
    //创建MWPhotoBrowser ，要使用initWithDelegate方法，要遵循MWPhotoBrowserDelegate协议
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    //设置当前要显示的图片
    [browser setCurrentPhotoIndex:0];
    
    //push到MWPhotoBrowser
    [self.navigationController pushViewController:browser animated:YES];
}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photosImg.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photosImg.count) {
        return [self.photosImg objectAtIndex:index];
    }
    return nil;
}

-(void)oneBtn:(UIButton *)btn
{
    if (btn.tag == 1) {
        [btn setTitleColor:UIRED forState:UIControlStateNormal];
        a = 1;
        referralArr = [NSMutableArray arrayWithObjects:@"到货时间按客户",@"都是",@"大数",@"DSA",@"达到",@"爱上",@"大数",@"DSA",@"而非", nil];
        
    }
    else
    {
        [btn setTitleColor:UIRED forState:UIControlStateNormal];
        a = 2;
        referralArr = [NSMutableArray arrayWithObjects:@"23431",@".21.21",@"2132", nil];
        
    }
    [table reloadData];
    
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
