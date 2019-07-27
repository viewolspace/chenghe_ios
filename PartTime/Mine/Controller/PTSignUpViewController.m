//
//  PTSignUpViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/24.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTSignUpViewController.h"
#import "PTChoiceCell.h"
#import "PTDetailViewController.h"

@interface PTSignUpViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation PTSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#282828"],NSFontAttributeName:[UIFont systemFontOfSize:19.f]}];
    [self createTabelView];
    
    [self requestMyPartTimeData];
   
    if (self.categoryId) {
        [self requestCategoryData];
    }else{
        self.title = @"我的报名";
        [self requestMyPartTimeData];
    }
    
    [self setMjFooterView:self.tableView];
    [self setMJHeaderView:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 导航栏透明
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.clipsToBounds = NO;
}


- (void)createTabelView
{
    CGFloat tabbarHieght = [PTManager shareManager].tabbarHeight;
    CGFloat statusBarHeight = [PTManager shareManager].statusBarHeight;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN - tabbarHieght - statusBarHeight) style:UITableViewStyleGrouped];
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
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count != 0) {
        PartTimeModel *model = self.dataArr[indexPath.row];
        self.hidesBottomBarWhenPushed = YES;
        PTDetailViewController *vc = [[PTDetailViewController alloc] init];
        vc.ptId = model.aId;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - setter and getter -

#pragma mark - data -
- (void)headerReoladAction
{
    self.pageIndex = 1;
    [self.dataArr removeAllObjects];
    if (self.categoryId) {
        [self requestCategoryData];
    }else{
        [self requestMyPartTimeData];
    }
}

- (void)footerReloadAction
{
    if (self.categoryId) {
        [self requestCategoryData];
    }else{
        [self requestMyPartTimeData];
    }
}

//我的报名
- (void)requestMyPartTimeData
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    __weak typeof(self)weakSelf = self;
    [PTMyPartTimeModel requestMyPartTimeWithUserId:[PTUserUtil getUserId] pageIndex:self.pageIndex pageSize:self.pageSize completeBlock:^(id obj) {
        
        [weakSelf setMyPartTimeData:(PTMyPartTimeModel *)obj];
        
    } faileBlock:^(id error) {
        
        [NewShowLabel setMessageContent:@"请求我的报名数据失败"];
    }];
    
}

//协议
- (void)requestCategoryData{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    __weak typeof(self)weakSelf = self;
    
    [PartTimeCategoryModel requestPartTimeWithCategoryId:self.categoryId pageIndex:self.pageIndex pageSize:self.pageSize completeBlock:^(id obj) {
        [weakSelf setCategoryPartTimeData:(PartTimeCategoryModel *)obj];

    } faileBlock:^(id error) {
        [NewShowLabel setMessageContent:@"请求报名数据失败"];
    }];
    
    [PTMyPartTimeModel requestMyPartTimeWithUserId:[PTUserUtil getUserId] pageIndex:self.pageIndex pageSize:self.pageSize completeBlock:^(id obj) {
        
        [weakSelf setMyPartTimeData:(PTMyPartTimeModel *)obj];
        
    } faileBlock:^(id error) {
        
        [NewShowLabel setMessageContent:@"请求我的报名数据失败"];
    }];
}


- (void)setCategoryPartTimeData:(PartTimeCategoryModel *)model
{
    if (model.modelArr.count == 0) {
        self.title = model.name;
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    self.title = model.name;
    self.pageIndex ++;
    [self.dataArr addObjectsFromArray:model.modelArr];
    [self.tableView reloadData];
    
}

- (void)setMyPartTimeData:(PTMyPartTimeModel *)model
{
    if (model.modelArr.count == 0) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    self.pageIndex ++;
    [self.dataArr addObjectsFromArray:model.modelArr];
    [self.tableView reloadData];
    
}

@end
