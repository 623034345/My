//
//  ScrollView.m
//  DingDCommunity
//
//  Created by Thomas on 14-12-29.
//  Copyright (c) 2014年 com.dingdong. All rights reserved.
//

#import "ScrollView.h"
@implementation ScrollView

@synthesize delegate;

//初始化
- (id)initWithFrame:(CGRect)frame
           ImageArr:(NSMutableArray *)arr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        for (UIView *view in [scrolledView subviews])
        {
            [view removeFromSuperview];
        }
        
        //图片数组
        imageArr = [[NSMutableArray alloc] init];
        
        if (arr.count == 0)
        {
        }
        else
        {
            //循环
            for (int i = 0; i < arr.count; i++)
            {
                [self updateImageArrWithDic:[arr objectAtIndex:i]];
            }
            [self initScrolledView];
            [self initPageControl];
            if (arr.count == 1)
            {
            }
            else
            {
                //计时器
                timer = [NSTimer scheduledTimerWithTimeInterval:4
                                                         target:self
                                                       selector:@selector(scrollToNextPage:)
                                                       userInfo:Nil
                                                        repeats:YES];
            }
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSMutableArray *)images {
    self = [super initWithFrame:frame];
    if (self)
    {
        for (UIView *view in [scrolledView subviews])
        {
            [view removeFromSuperview];
        }
        
        //图片数组
        imageArr = [[NSMutableArray alloc] init];
        imageArr = images;
        if (imageArr.count == 0)
        {
        }
        else
        {
            [self initScrolledView];
            [self initPageControl];
            if (images.count == 1)
            {
            }
            else
            {
                //计时器
                timer = [NSTimer scheduledTimerWithTimeInterval:4
                                                         target:self
                                                       selector:@selector(scrollToNextPage:)
                                                       userInfo:Nil
                                                        repeats:YES];
            }
        }
    }
    return self;
}

//初始化焦点图数组
-(void)updateImageArrWithDic:(NSDictionary *)dic
{
  
    //焦点图
    Picture *picture = [[Picture alloc] initPictureWithDic:dic];
    [imageArr addObject:[picture.ImgSrc stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    /*NSString *str = @"上海";
     把这个转成UTF8以前我们使用的是
     NSString *str3 = [str stringByAddingPercentEscapesUsingEncoding:
     NSUTF8StringEncoding];
     但是在ios9这个方法废弃了
     用如下方法转
     NSString *str1 = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
     
     那如果想转成“上海”这个字符串怎么办呢 ，不用担心有方法的
     还是说以前我们用的方法是
     NSString *str3 = [str1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
     ios9同样废弃了这个方法 现在使用
     NSString *str2 = [str1 stringByRemovingPercentEncoding];*/

 
}

//初始化滑动界面
-(void)initScrolledView
{
    //焦点图滑动界面
    scrolledView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrolledView.showsHorizontalScrollIndicator = NO;
    scrolledView.showsVerticalScrollIndicator = NO;
    scrolledView.pagingEnabled = YES;
    scrolledView.scrollEnabled = YES;
    scrolledView.bounces = YES;
    scrolledView.delegate =  self;
    scrolledView.userInteractionEnabled = YES;
    scrolledView.contentSize = CGSizeMake(self.frame.size.width * imageArr.count, self.frame.size.height);
    
    //添加图片
    UIImageView *firstView = [[UIImageView alloc] init];
    [firstView sd_setImageWithURL:[NSURL URLWithString:[imageArr lastObject]]
              placeholderImage:[UIImage imageNamed:@"t_placeholderimage"]];
    CGFloat width = scrolledView.frame.size.width;
    CGFloat height = scrolledView.frame.size.height;
    firstView.frame = CGRectMake(0, 0, width, height);
    firstView.tag = 0;
    firstView.userInteractionEnabled = YES;
    
    //触摸手势
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(tapRecognizer:)];
    [firstView addGestureRecognizer:tapRecognizer];
    [scrolledView addSubview:firstView];
    
    //循环
    for (int i = 0; i < imageArr.count; i++)
    {
        UIImageView *middleView = [[UIImageView alloc] init];
        [middleView sd_setImageWithURL:[NSURL URLWithString:[imageArr objectAtIndex:i] ]
                   placeholderImage:[UIImage imageNamed:@"t_placeholderimage"]];
        middleView.frame = CGRectMake(width * (i + 1), 0, width, height);
        middleView.tag = i;
        middleView.userInteractionEnabled = YES;
        
        //触摸手势
        tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(tapRecognizer:)];
        [middleView addGestureRecognizer:tapRecognizer];
        [scrolledView addSubview:middleView];
    }
    
    UIImageView *lastView = [[UIImageView alloc] init];
    @try
    {
        [lastView sd_setImageWithURL:[NSURL URLWithString:[imageArr objectAtIndex:0]]
                    placeholderImage:[UIImage imageNamed:@"t_placeholderimage"]];
    }
    @catch (NSException * e)
    {
        NSLog(@"Exception: %@", e);
    }
    lastView.frame = CGRectMake(width * (imageArr.count + 1), 0, width, height);
    lastView.tag = imageArr.count - 1;
    lastView.userInteractionEnabled = YES;
    
    //触摸手势
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(tapRecognizer:)];
    [lastView addGestureRecognizer:tapRecognizer];
    [scrolledView addSubview:lastView];
    [scrolledView setContentSize:CGSizeMake(width * (imageArr.count + 2), height)];
    [scrolledView scrollRectToVisible:CGRectMake(width, 0, width, height)
                             animated:NO];
    [self addSubview:scrolledView];
}

//初始化焦点图指示
- (void)initPageControl
{
    //焦点图指示
    pageControl = [[DDPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 40, scrolledView.frame.size.width, 30)];
    [pageControl setCenter: CGPointMake(self.center.x, self.bounds.size.height - 8)];
    [pageControl setNumberOfPages:imageArr.count];
    [pageControl setCurrentPage:0];
    [pageControl setDefersCurrentPageDisplay:YES];
    [pageControl setType:DDPageControlTypeOnFullOffFull];
    [pageControl setOnColor:UIColorWithRGBA(255, 255, 255, 0.9)];
    [pageControl setOffColor:UIColorWithRGBA(0, 0, 0, 0.6)];
    [pageControl setIndicatorDiameter:10];
    [pageControl setIndicatorSpace:10];
    [pageControl addTarget:self
                    action:@selector(pageTurn:)
          forControlEvents:UIControlEventValueChanged];
    pageControl.userInteractionEnabled = NO;
    [self addSubview:pageControl];
}

//滑动至下一张图片
-(void)scrollToNextPage:(id)sender
{
    long pageNum = pageControl.currentPage;
    [UIView beginAnimations:@"ViewFlip"
                    context:nil];
    
    //动画持续时间
    [UIView setAnimationDuration:0.8];
    
    //设置动画的回调函数,设置后可以使用回调方法
    [UIView setAnimationDelegate:self];
    if (pageNum == imageArr.count - 1)
    {
        [UIView setAnimationDidStopSelector:@selector(updateCircleData)];
    }
    
    //设置动画曲线,控制动画速度
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    //设置动画方式,并指出动画发生的位置
    [scrolledView setContentOffset:CGPointMake((pageNum + 2) * scrolledView.frame.size.width, 0)];
    
    //提交UIView动画
    [UIView commitAnimations];
    [pageControl updateCurrentPageDisplay];
}

//更新滑动界面
- (void)updateCircleData
{
    [scrolledView setContentOffset:CGPointMake(scrolledView.frame.size.width, 0)];
}

//设置动画
- (void)configureTransition
{
    transition = [CATransition animation];
    transition.duration = 0.8;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionPush;
    transition.delegate = self;
}

//设置焦点图指示
- (void)pageTurn:(UIPageControl *)sender
{
    long pageNum = pageControl.currentPage;
    [scrolledView setContentOffset:CGPointMake((pageNum + 1) * pageControl.frame.size.width, 0)];
    [timer invalidate];
}

- (void)tapRecognizer:(UITapGestureRecognizer *)gesture
{
    NSLog(@"tag: %ld", (long)gesture.view.tag);
    if (self.delegate != nil)
    {
        [self.delegate scrollImageClick:gesture.view.tag];
    }
}

#pragma mark----UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrolledView.frame.size.width;
    long currentPage = floor((scrolledView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (currentPage == 0)
    {
        [pageControl setCurrentPage:imageArr.count - 1];
    }
    else if (currentPage == imageArr.count + 1)
    {
        [pageControl setCurrentPage:0];
    }
    [pageControl setCurrentPage:currentPage - 1];
    [pageControl updateCurrentPageDisplay] ;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //计时器停止
    [timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //计时器
    timer = [NSTimer scheduledTimerWithTimeInterval:4
                                             target:self
                                           selector:@selector(scrollToNextPage:)
                                           userInfo:nil
                                            repeats:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = scrolledView.frame.size.width;
    CGFloat heigth = scrolledView.frame.size.height;
    long currentPage = floor((scrolledView.contentOffset.x - width / 2) / width) + 1;
    if (currentPage == 0)
    {
        [scrolledView scrollRectToVisible:CGRectMake(width * imageArr.count, 0, width, heigth)
                                 animated:NO];
        pageControl.currentPage = imageArr.count - 1;
        [pageControl updateCurrentPageDisplay];
        return;
    }
    else  if (currentPage == [imageArr count] + 1)
    {
        [scrolledView scrollRectToVisible:CGRectMake(width, 0, width, heigth)
                                 animated:NO];
        [pageControl setCurrentPage:0];
        [pageControl updateCurrentPageDisplay];
        return;
    }
    [pageControl setCurrentPage:currentPage - 1];
    if (scrollView.dragging)
    {
        [pageControl updateCurrentPageDisplay];
    }
}

@end
