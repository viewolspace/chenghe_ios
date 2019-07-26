//
//  BaseViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "BaseViewController.h"
#import "PTSearchViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.pageSize = 10;
    self.pageIndex = 1;
    
    [self setLeftItemBtnWithColor:[PTTool colorFromHexRGB:@"#282828"]];
}

- (void)dealloc
{
    NSLog(@"%@ 销毁了",[self class]);
}

- (void)setLeftItemBtnWithColor:(UIColor *)color
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction:)];
    [leftItem setTintColor:color];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)popAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setMjFooterView:(UITableView *)tableView
{
    __weak typeof(self)weakSelf = self;
    MJRefreshBackNormalFooter *footerView = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf footerReloadAction];
    }];
    
    tableView.mj_footer = footerView;
}

- (void)setMJHeaderView:(UITableView *)tableView
{
    __weak typeof(self)weakSelf = self;
    MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headerReoladAction];
    }];
    
    tableView.mj_header = headerView;
}

- (void)footerReloadAction
{
    NSLog(@"父视图 上拉刷新 脚部");
}

- (void)headerReoladAction
{
    NSLog(@"父视图 下拉刷新 头部");
}

#pragma mark - getter and setter
- (PTSearchView *)searchView
{
    if (!_searchView) {
        CGFloat statusBarHeight = [PTManager shareManager].statusBarHeight;
        if (statusBarHeight < 27) {
            statusBarHeight = 27;
        }
        _searchView = [[PTSearchView alloc] initWithFrame:CGRectMake(0, statusBarHeight, WIDTH_OF_SCREEN, 44.f)];
        //_searchView.backgroundColor = [UIColor orangeColor];
        _searchView.delegate = self;
        [self.view addSubview:_searchView];
    }
    
    return _searchView;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

- (UIView *)lineView
{
    if (!_lineView) {
        CGFloat navBarHeight = self.navigationController.navigationBar.height;
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, navBarHeight - 0.5, WIDTH_OF_SCREEN, 0.5)];
        _lineView.backgroundColor = [PTTool colorFromHexRGB:@"#f1f3f4"];
    }
    
    return _lineView;
}

- (void)searchBtnTapAction
{
    PTSearchViewController *vc = [[PTSearchViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
