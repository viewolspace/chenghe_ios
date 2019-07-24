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
#import "PTResumeViewController.h"
#import "PTSignUpViewController.h"
#import "PTChangeNameView.h"

@interface PTMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UILabel  *loginLabel;
@property (nonatomic,strong)UIImageView *headerView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *titleArr;
@property (nonatomic,copy)NSArray *imageArr;
@property (nonatomic,assign)CGFloat headerHeight;
@property (nonatomic,strong)UIImageView *userHeaderView;
@property (nonatomic,strong)PTChangeNameView *changeNameView;
@end

@implementation PTMineViewController

#pragma mark - 通知方法 -
- (void)keyboardWillShow:(NSNotification *)notification
{
   
    NSValue *aValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height / 3.0;
    if (self.changeNameView) {
         self.changeNameView.topConstraint.constant = -height;
        [UIView animateWithDuration:0.3 animations:^{
            [self.changeNameView layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (self.changeNameView) {
        self.changeNameView.topConstraint.constant = 0;
        [UIView animateWithDuration:0.3 animations:^{
            [self.changeNameView layoutIfNeeded];
        }];
    }
   
}

#pragma makr - 生命周期 -
- (void)viewDidLoad {
    [super viewDidLoad];
   
    _headerHeight = 237.5 + 40.f;
   self.titleArr = @[@"我的简历",@"我的报名",@"修改昵称",@"关于我们"];
    self.imageArr = @[@"简历",@"报名",@"昵称",@"我们"];
    
    [self createTabelView];
    
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self addObserver];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)addObserver
{
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   
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
    cell.ptImageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    
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
    return _headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, _headerHeight)];
    [headerView addSubview:self.headerView];
    return headerView;
}

#pragma mark - tableView点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.titleArr[indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        PTResumeViewController *vc = [PTResumeViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(indexPath.row == 1){
        PTSignUpViewController *vc = [PTSignUpViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(indexPath.row == 2){
        [self showAlertView];
    }
    
}

#pragma mark - 修改昵称 -
- (void)showAlertView
{
    UIWindow *window = [PTManager shareManager].hightWindow;
    PTChangeNameView *view = [PTChangeNameView initWithXib];
    view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    view.frame = CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN);
    [window addSubview:view];
    window.hidden = NO;
    self.changeNameView = view;
    
    __weak typeof(self)weakSelf = self;
    [view setCancelBlock:^{
        weakSelf.changeNameView = nil;
        window.hidden = YES;
    }];
    
    [view setConfirmBlock:^(NSString * _Nonnull text) {
        if (![text isEqualToString:@""]) {
            weakSelf.loginLabel.text = text;
            [weakSelf.changeNameView removeFromSuperview];
            weakSelf.changeNameView = nil;
            window.hidden = YES;
        }else{
            [NewShowLabel setMessageContent:@"请输入昵称"];
        }
    }];
}



- (void)setNameWithText:(NSString *)text
{
    if (![text isEqualToString:@""]) {
        self.loginLabel.text = text;
        UIWindow *window = [PTManager shareManager].hightWindow;
        
    }
}


#pragma mark - getter and setter
- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        
        CGFloat width = 91.f;
        CGFloat top   = 79.f;
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_OF_SCREEN - width) / 2.0, top, width, width)];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius  = width / 2.0;
        _loginBtn.backgroundColor = [PTTool colorFromHexRGB:@"#f6f6f6"];
        
        [_loginBtn addSubview:self.userHeaderView];
    }
    
    return _loginBtn;
}

- (UIImageView *)userHeaderView
{
    if (!_userHeaderView) {
        _userHeaderView = [[UIImageView alloc] initWithFrame:self.loginBtn.bounds];
        [_userHeaderView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    }
    
    return _userHeaderView;
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
        //btn.backgroundColor = [UIColor orangeColor];
        [_loginLabel addSubview:btn];
        
        _loginLabel.userInteractionEnabled = YES;
    }
    
    return _loginLabel;
}

- (UIImageView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 237)];
        _headerView.image = [UIImage imageNamed:@"登录背景.png"];
        
        [_headerView addSubview:self.loginBtn];
        [_headerView addSubview:self.loginLabel];
        _headerView.userInteractionEnabled = YES;
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
