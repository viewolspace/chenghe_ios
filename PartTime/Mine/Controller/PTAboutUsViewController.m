//
//  PTAboutUsViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/26.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTAboutUsViewController.h"

@interface PTAboutUsViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *bgScrollView;
@property (nonatomic,strong)UIView *whiteBgView;
@property (nonatomic,strong)UIImageView *logoImageView;
@property (nonatomic,strong)UILabel *logoLabel;
@property (nonatomic,strong)UIButton *bottomBtn;

@end

@implementation PTAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftItemBtnWithColor:[PTTool colorFromHexRGB:@"#ffffff"]];
    
    self.view.backgroundColor = [PTTool colorFromHexRGB:@"#f1f3f4"];
    self.title = @"关于我们";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#ffffff"],NSFontAttributeName:[UIFont systemFontOfSize:19.f]}];
    
    if (@available(iOS 11.0,*)) {
        self.bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self logoLabel];
    [self bottomBtn];

    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(14.f, self.whiteBgView.top , self.whiteBgView.width, self.whiteBgView.height)];
    shadowView.backgroundColor = [UIColor whiteColor];
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOpacity = 0.1;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2.f);
    shadowView.layer.cornerRadius = 10.f;
    [self.bgScrollView insertSubview:shadowView belowSubview:self.whiteBgView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 导航栏透明
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.clipsToBounds = YES;
}


#pragma mark - getter and setter
- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN , HEIGHT_OF_SCREEN)];
        _bgScrollView.delegate = self;
        _bgScrollView.backgroundColor = [PTTool colorFromHexRGB:@"#f6f6f6"];
        [self.view addSubview:_bgScrollView];
        
        //背景和返回按钮
        UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 237.0)];
        headerView.image = [UIImage imageNamed:@"登录背景.png"];
        [_bgScrollView addSubview:headerView];
        
    }
    
    return _bgScrollView;
}


- (UIView *)whiteBgView
{
    if (!_whiteBgView) {
        _whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(14.f, 126.f, WIDTH_OF_SCREEN - 14 * 2.0, HEIGHT_OF_SCREEN - 126.f - 31.f)];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
        _whiteBgView.layer.masksToBounds = YES;
        _whiteBgView.layer.cornerRadius  = 10.f;
        [self.bgScrollView insertSubview:_whiteBgView atIndex:1];
    }
    
    return _whiteBgView;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        //97
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_OF_SCREEN - 97) / 2.0, 175.f, 97, 97)];
        _logoImageView.image = [UIImage imageNamed:@"兼职圈logo"];
        [self.bgScrollView addSubview:_logoImageView];
    }
    
    return _logoImageView;
}

- (UILabel *)logoLabel
{
    if (!_logoLabel) {
        
        NSString *str = @"提供真实有效的兼职工作，全国各地海量兼职信息，闲暇之余一起努力兼职，赚高薪";
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 10;
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16.f],NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#0d0d0d"],NSParagraphStyleAttributeName:style};
        CGFloat width = WIDTH_OF_SCREEN - 54 * 2.0;
        CGFloat height = [str boundingRectWithSize:CGSizeMake(width, 0) options:1 attributes:dic context:nil].size.height;
        
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(54, self.logoImageView.bottom + 43, width, height)];
        label.attributedText = attStr;
        label.numberOfLines = 0;
        [self.bgScrollView addSubview:label];
        
        _logoLabel = label;
    }
    
    return _logoLabel;
}

- (UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        //44
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(44.f, self.whiteBgView.bottom - 27 - 44, WIDTH_OF_SCREEN - 44 * 2.0, 44)];
        [btn setTitle:@"客服QQ：9685719" forState:UIControlStateNormal];
        [btn setTitleColor:[PTTool colorFromHexRGB:@"#939393"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        btn.backgroundColor = [PTTool colorFromHexRGB:@"f6f6f6"];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius  = 44 / 2.0;
        [self.bgScrollView addSubview:btn];
        
        _bottomBtn = btn;
    }
    
    return _bottomBtn;
}

#pragma mark - senderAction -
- (void)bottomAction:(UIButton *)sender
{
    NSLog(@"复制客服QQ");
}

@end
