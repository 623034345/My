//
//  MyAppointmentView.m
//  ForNowIosSupper
//
//  Created by chenlei on 15/7/21.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import "MyAppointmentView.h"

@implementation MyAppointmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = UIGRAY;
        [self createTableView];
    }
    return self;
}

#pragma mark - 创建tableView
- (void)createTableView
{
    _appointTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) style:UITableViewStyleGrouped];
    _appointTableView.backgroundColor = UICOLOR_HEX(0xf9f9f9);
    _appointTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.01)];
    if (IS_OS_7_OR_LATER)
    {
        if ([_appointTableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [_appointTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_appointTableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            [_appointTableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    _appointTableView.separatorColor = UICOLOR_HEX(0xe6e6e6);
    _appointTableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:_appointTableView];
}

@end
