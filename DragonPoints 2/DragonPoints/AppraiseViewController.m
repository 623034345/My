//
//  AppraiseViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/6.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "AppraiseViewController.h"

@interface AppraiseViewController ()

@end

@implementation AppraiseViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"评价";
    self.automaticallyAdjustsScrollViewInsets = NO;

    //    [self hideNavigationBarLine];
    [self.tabBarController.tabBar setHidden:YES];
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    table =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];

}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UILabel *conteLab;
    
    NSString *name = [NSString stringWithFormat:@"cellO%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        UIImageView *touImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
        touImg.layer.masksToBounds = YES;
        touImg.layer.cornerRadius = 15;
        touImg.tag = 10;
        [cell addSubview:touImg];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, SCREEN_WIDTH - 55, 30)];
        nameLab.font = [UIFont systemFontOfSize:13];
        nameLab.tag = 11;
        [cell addSubview:nameLab];
        rating = [[RatingBarView alloc] initWithFrame:CGRectMake(40, 40, 150, 60)];
        [rating setImageDeselected:@"star2"
                      halfSelected:@"starB"
                      fullSelected:@"rating_show"
                       andDelegate:self];
        rating.isIndicator = YES;
        [cell addSubview:rating];
        UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(190, 30, 50, 30)];
        numLab.textColor = [UIColor yellowColor];
        numLab.tag = 12;
        [cell addSubview:numLab];
        
        
        conteLab = [[UILabel alloc] init];
        conteLab.font = [UIFont systemFontOfSize:13];
        conteLab.numberOfLines = 0;
        [cell addSubview:conteLab];
    }
    UILabel *nameLab = (UILabel *) [cell viewWithTag:11];
    nameLab.text = @"21545642414***2321     2016.8.1";
    UIImageView *touImg = (UIImageView *)[cell viewWithTag:10];
    touImg.image = [UIImage imageNamed:@"shiyan"];
    UILabel *numLab = (UILabel *) [cell viewWithTag:12];
    numLab.text = @"4.9分";
    [rating displayRating:4.9];

    NSString * aaaa = @"大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是";
    CGSize size = CGSizeMake(SCREEN_WIDTH-20, 10000);
    float b = [[GlobalCenter sharedInstance] TextHeightSize:size Font:13 Text:aaaa];
    
    conteLab.frame = CGRectMake(10, 60, SCREEN_WIDTH-20, b);
    conteLab.text = aaaa;
    int columnLength = 2;
    for (int n = 0; n < 4; n ++)
    {
        UIImageView *img = [[UIImageView alloc] init];
        img.tag = 40+n;
        [cell addSubview:img];
        int x = (n %4)*((SCREEN_WIDTH - 1)/4 + columnLength) + columnLength;
        img.frame = CGRectMake(x, 75 + b + 10, (SCREEN_WIDTH - 2)/4 - 6, (SCREEN_WIDTH - 2)/4 - 6);
        img.image = [UIImage imageNamed:@"shiyan"];
        
        
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * aaaa = @"大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是大家萨克的凯萨琳萨洛克爱上地方撒谎发那么高发的呢就看他也让热环境为性支出大数大煞风景广东省熊出没vgids 高考了多少我你每次V型回来看个图来看 减肥的开始了连哭都是";
    CGSize size = CGSizeMake(SCREEN_WIDTH-20, 10000);
    float b = [[GlobalCenter sharedInstance] TextHeightSize:size Font:15 Text:aaaa];
    return b + 60 + (SCREEN_WIDTH - 2)/4 - 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    if ([JUDGE isEqualToString:key])
    //    {
    //        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
    //                                                                    text:@"评论成功"
    //                                                                   color:UICYAN];
    //        [KEYWINDOW addSubview:infoAlert];
    //        [infoAlert showView];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            if (self.typeOne == 1)
    //            {
    //
    //            }
    //
    //            [self.navigationController popViewControllerAnimated:YES];
    //
    //        });
    //
    //
    //    }
    
}

- (void)failure:(NSNotification *)notify
{
    //    [self dismissView];
    //    [self showAlertWithPoint:0
    //                        text:[notify userInfo][FAILURE]
    //                       color:UIPINK];
}
- (void)ratingChanged:(float)newRating
{
    
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
