//
//  PTSignUpViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/24.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTSignUpViewController.h"
#import "PTChoiceCell.h"
#import "PTMyPartTimeModel.h"

@interface PTSignUpViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation PTSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的报名";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#282828"],NSFontAttributeName:[UIFont systemFontOfSize:19.f]}];
    [self createTabelView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 导航栏透明
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.clipsToBounds = NO;
    [self requestMyPartTimeData];
}


- (void)createTabelView
{
    CGFloat tabbarHieght = [PTManager shareManager].tabbarHeight;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN - tabbarHieght) style:UITableViewStyleGrouped];
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
    return 250.f;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - setter and getter -
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr ;
}


#pragma mark - data -
- (void)requestMyPartTimeData
{
    
    __weak typeof(self)weakSelf = self;
    [PTMyPartTimeModel requestMyPartTimeWithUserId:1 pageIndex:1 pageSize:5 completeBlock:^(id obj) {
        
        [weakSelf setMyPartTimeData:(PTMyPartTimeModel *)obj];
        
    } faileBlock:^(id error) {
        
        [NewShowLabel setMessageContent:@"请求我的报名数据失败"];
        NSLog(@"请求我的报名数据失败");
    }];
    
}


- (void)setMyPartTimeData:(PTMyPartTimeModel *)model
{
    if (model.modelArr.count == 0) {
        
        return;
    }
    
    [_dataArr addObjectsFromArray:model.modelArr];
    [self.tableView reloadData];
    
}

@end
