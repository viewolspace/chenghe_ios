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
#import "PTHomePageModel.h"

@interface PTHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,PTSearchViewDelegate>
{
    UITableView *_tableView;
    CGFloat      _headerHeight;
    CGFloat      _noDataHeaderHeight;
    BOOL         _haveHotData;
}

@property (nonatomic,strong)PTHomePageHeaderView *headerView;
@property (nonatomic,assign)BOOL haveHotData;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *choiceDataArr;
@property (nonatomic,assign)NSInteger hotPageIndex;
@property (nonatomic,assign)NSInteger hotPageSize;

@property (nonatomic,assign)NSInteger choicePageIndex;
@property (nonatomic,assign)NSInteger choicePageSize;
@end

@implementation PTHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hotPageIndex = 1;
    self.hotPageSize  = 10;
    
    self.choicePageIndex = 1;
    self.choicePageSize = 10;
    
    _haveHotData = YES;
    _headerHeight = 290;
    _noDataHeaderHeight = 91.f;
    [self searchView];

    [self createTabelView];
    
    if (@available(iOS 11.0,*)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self setMJHeaderView:self.tableView];
    [self setMjFooterView:self.tableView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 导航栏透明
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    [self requestHotDataAction];
    [self requestChoiceDataAction];
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
    [cell setDataWithModel:self.choiceDataArr[indexPath.row]];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.choiceDataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark ----tableViewDelegate----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.choiceDataArr.count == 0) {
        return 150;
    }else{
        PartTimeModel *model = self.choiceDataArr[indexPath.row];
        return model.homePageCellHeight;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_haveHotData) {
        return _headerHeight;
    }else{
        return _noDataHeaderHeight;
    }
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
    if (self.choiceDataArr.count != 0) {
        PartTimeModel *model = self.choiceDataArr[indexPath.row];
        self.hidesBottomBarWhenPushed = YES;
        PTDetailViewController *vc = [[PTDetailViewController alloc] init];
        vc.ptId = model.aId;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}



#pragma mark - getter and setter
- (PTHomePageHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[PTHomePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, _headerHeight)];
    }
    return _headerView;
}

- (NSMutableArray *)choiceDataArr
{
    if (!_choiceDataArr) {
        _choiceDataArr = [NSMutableArray array];
    }
    
    return _choiceDataArr;
}


#pragma mark - data -
- (void)footerReloadAction
{
   // [self requestHotDataAction];
    [self requestChoiceDataAction];
}

- (void)headerReoladAction
{
    [self.choiceDataArr removeAllObjects];
    
   // self.hotPageIndex = 1;
    self.choicePageIndex = 1;
    
   // [self requestHotDataAction];
    [self requestChoiceDataAction];
}

/** 请求热门数据 */
- (void)requestHotDataAction
{
    __weak typeof(self)weakSelf = self;
    [PTHomePageModel requestHotOrChoiseWithId:1 pageIndex:self.hotPageIndex pageSize:self.hotPageSize completeBlock:^(id obj) {
        
        PTHomePageModel *model = (PTHomePageModel *)obj;
        [weakSelf.headerView setHotDataWithModel:model];
        if (model.modelArr.count == 0) {
            weakSelf.haveHotData = NO;
        }else{
            weakSelf.haveHotData = YES;
        }
        
        [weakSelf.tableView reloadData];
        
    } faileBlock:^(id error) {
        
        [NewShowLabel setMessageContent:@"请求热门数据失败"];

    }];
}


/** 请求精选数据 */
- (void)requestChoiceDataAction
{
    __weak typeof(self)weakSelf = self;
    [PTHomePageModel requestHotOrChoiseWithId:2 pageIndex:self.choicePageIndex pageSize:self.choicePageSize completeBlock:^(id obj) {
        
        PTHomePageModel *model = (PTHomePageModel *)obj;
        [weakSelf reloadChoiceDataWithModel:model];

        
    } faileBlock:^(id error) {
        
        [NewShowLabel setMessageContent:@"请求精选数据失败"];
    }];
}


//设置精选数据
- (void)reloadChoiceDataWithModel:(PTHomePageModel *)model
{
    if (model.modelArr.count == 0) {
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
        return;
    }
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    
    [self.choiceDataArr addObjectsFromArray:model.modelArr];
    [self.tableView reloadData];
    
    self.choicePageIndex ++;
}


@end
