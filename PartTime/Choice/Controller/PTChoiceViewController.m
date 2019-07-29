//
//  PTChoiceViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTChoiceViewController.h"
#import "PTChoiceHeaderView.h"
#import "PTChoiceCell.h"
#import "PTDetailViewController.h"
@interface PTChoiceViewController ()<UITableViewDelegate,UITableViewDataSource,PTSearchViewDelegate>
{
    UITableView *_tableView;
    CGFloat      _headerHeight;
}

@property (nonatomic,strong)PTChoiceHeaderView *headerView;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation PTChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _headerHeight = 170;
    
    [self searchView];
    [self createTabelView];
    
    if (@available(iOS 11.0,*)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction:)];
    [leftItem setTintColor:[PTTool colorFromHexRGB:@"#282828"]];
    self.navigationItem.leftBarButtonItem = leftItem;
   
    [self setMjFooterView:self.tableView];
    [self setMJHeaderView:self.tableView];
    
    [self requestChoiceAction];
    [self requestAD];
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
    self.hidesBottomBarWhenPushed = YES;
    PTDetailViewController *vc = [[PTDetailViewController alloc] init];
    PartTimeModel *model = self.dataArr[indexPath.row];
    vc.ptId = model.aId;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - getter and setter
- (PTChoiceHeaderView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[PTChoiceHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, _headerHeight)];
        __weak typeof(self)weakSelf = self;
        [_headerView setSelectDataBlock:^(PartTimeAdModel * _Nonnull model) {
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
    NSLog(@"上拉刷新");
    [self requestChoiceAction];
}
- (void)footerReloadAction
{
    NSLog(@"下拉刷新");
    [self requestChoiceAction];

}

- (void)requestAD
{
    __weak typeof(self)weakSelf = self;
    [PartTimeAdModel requestADWithCategoryId:PT_CHOICE_SCROLL completeBlock:^(id obj) {
        PartTimeAdModel *model = (PartTimeAdModel *)obj;
        [weakSelf.headerView setDataWithAdModel:model];
    } faileBlock:^(id error) {
        NSLog(@"精选广告请求失败");
    }];
}

- (void)requestChoiceAction
{
  

    __weak typeof(self)weakSelf = self;
    [PTHomePageModel requestHotOrChoiseWithId:2 pageIndex:self.pageIndex pageSize:self.pageSize completeBlock:^(id obj) {
        
        [weakSelf setDataWithModel:(PTHomePageModel *)obj];
        
    } faileBlock:^(id error) {
        NSLog(@"精选页面请求精选失败");
    }];
}

- (void)setDataWithModel:(PTHomePageModel *)model
{
    if (model.modelArr.count == 0) {
        //没有请求到数据，页面保持不变
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    if (self.isHeaderLoad) {
        self.isHeaderLoad = NO;
        [self.dataArr removeAllObjects];
    }
    
    self.pageIndex ++;
    [self.dataArr addObjectsFromArray:model.modelArr];
    [self.tableView reloadData];
}


@end
