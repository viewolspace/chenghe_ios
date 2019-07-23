//
//  PTMineViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTMineViewController.h"
#import "PTMineCell.h"
#import "PTLoginViewController.h"

@interface PTMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UILabel  *loginLabel;
@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *titleArr;
@end

@implementation PTMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   self.titleArr = @[@"我的简历",@"我的报名",@"修改昵称",@"关于我们"];
    
    [self createTabelView];
    
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
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

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - tableview -
- (void)createTabelView
{
    //获取状态栏的rect
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = [PTTool colorFromHexRGB:@"#ffffff"];
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"PTMineCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PTMineCell class])];
}

#pragma mark ----tableViewDataSource----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTMineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTMineCell class])];
    cell.ptTitleLabel.text = self.titleArr[indexPath.row];
    
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark ----tableViewDelegate----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 237.5 + 40;
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
    NSLog(@"%@",self.titleArr[indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - getter and setter
- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        
        CGFloat width = 91.f;
        CGFloat top   = 79.f;
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_OF_SCREEN - width) / 2.0, top, width, width)];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.backgroundColor = [UIColor orangeColor];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius  = width / 2.0;
    }
    
    return _loginBtn;
}

- (UILabel *)loginLabel
{
    if (!_loginLabel) {
        
        CGFloat height = 16.f;
        _loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.loginBtn.bottom + 19, WIDTH_OF_SCREEN,height)];
        _loginLabel.text = @"点击登录";
        _loginLabel.textColor = [PTTool colorFromHexRGB:@"#f6f6f6"];
        _loginLabel.font = [UIFont systemFontOfSize:13.f];
        _loginLabel.textAlignment = NSTextAlignmentCenter;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_OF_SCREEN - 200) / 2.0, 0, 200, height)];
        [btn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor orangeColor];
        [_loginLabel addSubview:btn];
        
        _loginLabel.userInteractionEnabled = YES;
    }
    
    return _loginLabel;
}

- (UIView *)headerView
{
    if (!_headerView) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0,0,375,237);
        view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,375,237);
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:93/255.0 green:104/255.0 blue:254/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:87/255.0 green:160/255.0 blue:254/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:95/255.0 green:195/255.0 blue:255/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0.0),@(0.5),@(1.0)];
        
        [view.layer addSublayer:gl];
        _headerView = view;
        
        [_headerView addSubview:self.loginBtn];
        [_headerView addSubview:self.loginLabel];
    }
    
    return _headerView;
}


#pragma mark - senderAction -
- (void)loginAction:(UIButton *)sender
{
    PTLoginViewController *loginVC = [[PTLoginViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
   
    self.hidesBottomBarWhenPushed = NO;
}

@end
