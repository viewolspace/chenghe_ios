//
//  PTHomePageViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTHomePageViewController.h"
#import "PTHomePageCell.h"
#import "PTDetailViewController.h"
#import "PTHomePageHeaderView.h"
@interface PTHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,PTSearchViewDelegate>
{
    UITableView *_tableView;
    CGFloat      _headerHeight;
}

@property (nonatomic,strong)PTHomePageHeaderView *headerView;

@end

@implementation PTHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerHeight = 290;
    
    [self searchView];

    [self createTabelView];
    
    if (@available(iOS 11.0,*)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 导航栏透明
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)createTabelView
{
    CGFloat tabbarHieght = [PTManager shareManager].tabbarHeight;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchView.bottom, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN - tabbarHieght - self.searchView.bottom) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"PTHomePageCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PTHomePageCell class])];
}

#pragma mark ----tableViewDataSource----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PTHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTHomePageCell class])];
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark ----tableViewDelegate----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    PTDetailViewController *vc = [[PTDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - getter and setter
- (PTHomePageHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[PTHomePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, _headerHeight)];
    }
    return _headerView;
}

@end
