//
//  PTWholeViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTWholeViewController.h"
#import "PTWholeHeaderView.h"
#import "PTDetailViewController.h"
#import "PTChoiceCell.h"

@interface PTWholeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    CGFloat      _headerHeight;
}

@property (nonatomic,strong)PTWholeHeaderView *headerView;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation PTWholeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerHeight = 200;
    
    [self searchView];
    
    [self createTabelView];
    
    if (@available(iOS 11.0,*)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self setMjFooterView:self.tableView];
    [self setMJHeaderView:self.tableView];
    
    [self requestAllData];
    [self requestBannerAction];
    [self requestTopThreeAdAction];
    
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
    
    [_tableView registerNib:[UINib nibWithNibName:@"PTChoiceCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PTChoiceCell class])];
}

#pragma mark ----tableViewDataSource----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PTChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTChoiceCell class])];
    [cell setDataWithModel:self.dataArr[indexPath.row]];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark ----tableViewDelegate----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PartTimeModel *model = self.dataArr[indexPath.row];
    return model.havePicCellHeight;
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
    PartTimeModel *model = self.dataArr[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    PTDetailViewController *vc = [[PTDetailViewController alloc] init];
    vc.ptId = model.aId;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - getter and setter
- (PTWholeHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[PTWholeHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, _headerHeight)];
        __weak typeof(self)weakSelf = self;
        [_headerView setClickAdBlcok:^(PartTimeAdModel * _Nonnull model) {
            [weakSelf clickAdAction:model];
        }];
    }
    return _headerView;
}

#pragma mark - senderAction -
- (void)clickAdAction:(PartTimeAdModel *)model
{
    [self.navigationController clickAdAction:model chileVC:self];
}

#pragma mark - data -
- (void)headerReoladAction
{
    self.pageIndex = 1;
    [self.dataArr removeAllObjects];
    [self requestAllData];
}

- (void)footerReloadAction
{
    [self requestAllData];
}


/** 顶部三个按钮 */
- (void)requestTopThreeAdAction
{
    __weak typeof(self)weakSelf = self;
    [PartTimeAdModel requestADWithCategoryId:PT_WHOLE_TOP_THREE completeBlock:^(id obj) {
        [weakSelf.headerView setTopThreeDataWithModel:(PartTimeAdModel *)obj];
    } faileBlock:^(id error) {
        
    }];
}

/** 请求滚动数据 */
- (void)requestBannerAction
{
    __weak typeof(self)weakSelf = self;
    [PartTimeAdModel requestADWithCategoryId:PT_WHOLE_SINGLE completeBlock:^(id obj) {
        [weakSelf.headerView setBannerDataWithModel:(PartTimeAdModel *)obj];
    } faileBlock:^(id error) {
        
    }];
}

/** 请求全部数据 */
- (void)requestAllData{
    
    __weak typeof(self)weakSelf = self;
    [PartTimeQueryModel requestPartTimeWithKeyWord:@"" pageIndex:self.pageIndex pageSize:self.pageSize completeBlock:^(id obj) {
        [weakSelf setDataWithModel:(PartTimeQueryModel *)obj];
    } faileBlock:^(id error) {
        
    }];
    
}

- (void)setDataWithModel:(PartTimeQueryModel *)model
{
    if (model.modelArr.count == 0) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    
    self.pageIndex ++;
    [self.dataArr addObjectsFromArray:model.modelArr];
    [self.tableView reloadData];
}

@end
