//
//  PTSearchViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/24.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTSearchViewController.h"
#import "PTChoiceCell.h"
#import "PTDetailViewController.h"
@interface PTSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
}
@property (nonatomic,strong)UIImageView *noDataImageView;
@property (nonatomic,strong)UITextField *searchTextField;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation PTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    [self noDataImageView];
    [self searchTextField];
    [self createTabelView];
    
    [self setSearchData:@[@"1"]];
    
}

- (void)dealloc
{
    if (self.searchTextField) {
        [self.searchTextField removeFromSuperview];
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 导航栏透明
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    return 250.0;
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
    self.hidesBottomBarWhenPushed = YES;
    PTDetailViewController *vc = [[PTDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - setter and getter
- (UIImageView *)noDataImageView
{
    if (!_noDataImageView) {
        
        CGFloat width = 263.f;
        _noDataImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_OF_SCREEN - width) / 2.0, (HEIGHT_OF_SCREEN - width) / 2.0 - [PTManager shareManager].statusBarHeight, width, width)];
        _noDataImageView.image = [UIImage imageNamed:@"搜索_默认无状态图"];
        [self.view addSubview:_noDataImageView];
    }
    
    return _noDataImageView;
}

- (UITextField *)searchTextField
{
    if (!_searchTextField) {
        
        CGFloat barHeight = [PTManager shareManager].navigationBarHeight;
        CGFloat statusBarHeight = [PTManager shareManager].statusBarHeight;
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(46, (barHeight - 29) / 2.0 + statusBarHeight, WIDTH_OF_SCREEN - 46 -14, 29)];
        _searchTextField.backgroundColor = [PTTool colorFromHexRGB:@"#e9e9e9"];
        _searchTextField.layer.cornerRadius = 29 / 2.0;
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.placeholder = @"输入您想搜索的内容";
        _searchTextField.font = [UIFont systemFontOfSize:15.f];
        [self.navigationController.navigationBar addSubview:_searchTextField];
        
        CGFloat leftViewWidth = 46;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftViewWidth, 29)];
        UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(19, (29 - 15) / 2.0, 15, 15)];
        searchImageView.image = [UIImage imageNamed:@"搜索图标"];
        [leftView addSubview:searchImageView];
        
        [_searchTextField setLeftViewMode:UITextFieldViewModeAlways];
        [_searchTextField setLeftView:leftView];
    }

    
    return _searchTextField;
}

#pragma mark - senderAction -
- (void)popAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - data -
- (void)setSearchData:(NSArray *)dataArr
{
    if (dataArr.count == 0) {
        if (self.dataArr.count == 0) {
            self.tableView.hidden = YES;
            self.noDataImageView.hidden = NO;
        }else{
            self.tableView.hidden = NO;
            self.noDataImageView.hidden = YES;
        }
        return;
    }
    
    
    self.tableView.hidden = NO;
    self.noDataImageView.hidden = YES;
 
    
    
    self.dataArr = dataArr;
    
    [self.tableView reloadData];
}

@end
