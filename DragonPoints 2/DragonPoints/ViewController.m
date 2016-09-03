//
//  ViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "EshopViewController.h"
#import "ShopsViewController.h"
#import "CartViewController.h"
#import "MineViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    自动登录
//        if (!NULL_STR([USER_DEFAULT objectForKey:USERID]))
//        {
//            [ViewController loginHome];
//        }
//        else
//        {
//            LoginViewController *loginView = [[LoginViewController alloc] init];
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginView];
//            APP_DELEGATE_INSTANCE.window.rootViewController =nav;
//        }
    [ViewController loginHome];
}
+(void)loginHome
{
    
    HomeViewController *message =[[HomeViewController alloc]init];
    EshopViewController *eshop =[[EshopViewController alloc]init];
    ShopsViewController * shops =[[ShopsViewController alloc]init];
    CartViewController *health = [[CartViewController alloc] init];
    MineViewController *mine = [[MineViewController alloc] init];

//    NSArray *tabbarImgs =[NSArray arrayWithObjects:@"homeH",@"shopH",@"shopsH",@"cartH",@"mineH", nil];
//    NSArray *tabbarSelectImgs =[NSArray arrayWithObjects:@"homeR",@"shopR",@"shopsR",@"cartR",@"mineR", nil];
//    NSArray *titleArr = [NSArray arrayWithObjects:@"首页",@"商城",@"商家",@"购物车",@"我的", nil];
//    
//    NSArray *views =[NSArray arrayWithObjects:message,eshop,shops,health,mine, nil];
    NSArray *tabbarImgs =[NSArray arrayWithObjects:@"homeH",@"shopsH",@"mineH", nil];
    NSArray *tabbarSelectImgs =[NSArray arrayWithObjects:@"homeR",@"shopsR",@"mineR", nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"首页",@"商家",@"我的", nil];
    
    NSArray *views =[NSArray arrayWithObjects:message,shops,mine, nil];
    
    NSMutableArray *navArr =[[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i = 0; i < 3; i++)
    {
        UIViewController *view =views[i];
        ///'UITextAttributeTextColor' is deprecated: first deprecated in iOS 7.0 - Use NSForegroundColorAttributeName  UITextAttributeTextColor
        view.tabBarItem.selectedImage = [[[UIImage imageNamed:[tabbarSelectImgs objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] stretchableImageWithLeftCapWidth:25 topCapHeight:20];
        view.tabBarItem.image = [[UIImage imageNamed:[tabbarImgs objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   UIGRAY, NSForegroundColorAttributeName,
                                                                   nil] forState:UIControlStateNormal];
//                UIColor *titleHighlightedColor = [UIColor greenColor];
                [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   UIRED, NSForegroundColorAttributeName,
                                                                   nil] forState:UIControlStateSelected];
        view.tabBarItem.title = [titleArr objectAtIndex:i];

        view.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:view];
        
        [navArr addObject:nav];
    }
    
    UITabBarController *tabBarVContro =[[UITabBarController alloc]init];
    //    tabBarVContro.tabBar.barTintColor = UIBLUE;
    //    tabBarVContro.tabBar.tintAdjustmentMode = UICLEAR;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = UIBLACK;
    [backView addSubview:line];
    backView.backgroundColor = UIWHITE;
    [tabBarVContro.tabBar insertSubview:backView atIndex:0];
    tabBarVContro.tabBar.opaque = YES;
    tabBarVContro.viewControllers =navArr;
    APP_DELEGATE_INSTANCE.window.rootViewController =tabBarVContro;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
