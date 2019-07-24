//
//  PTResumeViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/24.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTResumeViewController.h"

@interface PTResumeViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *bgScrollView;
@property (nonatomic,strong)UIButton *manBtn;
@property (nonatomic,strong)UIButton *womanBtn;
@property (nonatomic,strong)UIImageView *userHeaderView;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UITextField  *userNameTextField;

@end

@implementation PTResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [PTTool colorFromHexRGB:@"#f1f3f4"];
    
    [self womanBtn];
    [self manBtn];
    [self userNameTextField];
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - getter and setter
- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        
        
        //背景和返回按钮
        UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 237.0)];
        headerView.image = [UIImage imageNamed:@"登录背景.png"];
        [self.view addSubview:headerView];
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(14, 132, WIDTH_OF_SCREEN - 14 * 2.0, HEIGHT_OF_SCREEN - 132 - 30)];
        shadowView.backgroundColor = [UIColor whiteColor];
        shadowView.layer.shadowOffset = CGSizeMake(0, 2.f);
        shadowView.layer.shadowOpacity = 0.1;
        shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        [self.view addSubview:shadowView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [PTManager shareManager].statusBarHeight + 15, WIDTH_OF_SCREEN, 18)];
        label.text = @"个人简历";
        label.textColor = [PTTool colorFromHexRGB:@"#ffffff"];
        label.font = [UIFont systemFontOfSize:19.f];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(14, 126, WIDTH_OF_SCREEN - 14 * 2.0, HEIGHT_OF_SCREEN - 126 - 26)];
        _bgScrollView.delegate = self;
        _bgScrollView.backgroundColor = [UIColor whiteColor];
        _bgScrollView.layer.masksToBounds = YES;
        _bgScrollView.layer.cornerRadius = 5.f;
        [self.view addSubview:_bgScrollView];
        
        

    }
    
    return _bgScrollView;
}

- (UIButton *)manBtn
{
    if (!_manBtn) {
        CGFloat width = 55.f;
        CGFloat bgWidth = self.bgScrollView.width;
        _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _manBtn.frame = CGRectMake(bgWidth / 2.0 - 50 - width, 116, width, width);
        [_manBtn setImage:[UIImage imageNamed:@"男_up.png"] forState:UIControlStateNormal];
         [_manBtn setImage:[UIImage imageNamed:@"男_down.png"] forState:UIControlStateSelected];
        [_manBtn addTarget:self action:@selector(manSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgScrollView addSubview:_manBtn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(bgWidth / 2.0 - 50 - width / 2.0 - 10, _manBtn.bottom + 20, 20, 20)];
        label.text = @"男";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [PTTool colorFromHexRGB:@"#0d0d0d"];
        [self.bgScrollView addSubview:label];
    }
    
    return _manBtn;
}

- (UIButton *)womanBtn
{
    if (!_womanBtn) {
        CGFloat width = 55.f;
        CGFloat bgWidth = self.bgScrollView.width;
        _womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _womanBtn.frame = CGRectMake(bgWidth / 2.0 + 50, 116, width, width);
        [_womanBtn setImage:[UIImage imageNamed:@"女-up.png"] forState:UIControlStateNormal];
        [_womanBtn setImage:[UIImage imageNamed:@"女_down.png"] forState:UIControlStateSelected];
        [_womanBtn addTarget:self action:@selector(womanSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgScrollView addSubview:_womanBtn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(bgWidth / 2.0 + 50 + width / 2.0 - 10, _womanBtn.bottom + 20, 20, 20)];
        label.text = @"女";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [PTTool colorFromHexRGB:@"#0d0d0d"];
        [self.bgScrollView addSubview:label];
        
        
    }
    
    return _womanBtn;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        
        CGFloat width = 91.f;
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_OF_SCREEN - width) / 2.0, self.bgScrollView.top - width / 2.0, width, width)];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius  = width / 2.0;
        _loginBtn.backgroundColor = [PTTool colorFromHexRGB:@"#f6f6f6"];
        
        [_loginBtn addSubview:self.userHeaderView];
        [self.view addSubview:_loginBtn];
    }
    
    return _loginBtn;
}

- (UITextField *)userNameTextField
{
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, self.loginBtn.bottom + 19, WIDTH_OF_SCREEN - 40, 20)];
        _userNameTextField.placeholder = @"请输入姓名";
        _userNameTextField.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_userNameTextField];
    }
    
    return _userNameTextField;
}

- (UIImageView *)userHeaderView
{
    if (!_userHeaderView) {
        _userHeaderView = [[UIImageView alloc] initWithFrame:self.loginBtn.bounds];
        [_userHeaderView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    }
    
    return _userHeaderView;
}

#pragma mark - senderAction -
- (void)popAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)manSelect:(UIButton *)sender
{
    if (sender.selected) {
        return;
    }
    
    _manBtn.selected = YES;
    _womanBtn.selected = NO;
    
}

- (void)womanSelect:(UIButton *)sender
{
    if (sender.selected) {
        return;
    }
    
    _manBtn.selected = NO;
    _womanBtn.selected = YES;
    
}

- (void)loginAction:(UIButton *)sender
{
    NSLog(@"点击头像了");
}

@end
