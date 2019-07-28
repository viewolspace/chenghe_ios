//
//  PTResumeViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/24.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTResumeViewController.h"

@interface PTResumeViewController ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIScrollView *bgScrollView;
@property (nonatomic,strong)UIButton *manBtn;
@property (nonatomic,strong)UIButton *womanBtn;
@property (nonatomic,strong)UIImageView *userHeaderView;
@property (nonatomic,strong)UIButton *loginBtn; //用户头像点击
@property (nonatomic,strong)UITextField  *userNameTextField;
@property (nonatomic,assign)CGFloat barHeight;
@property (nonatomic,strong)UIView *whiteBgView;
@property (nonatomic,strong)UIView *bornView;
@property (nonatomic,strong)UIButton *bornBtn;
@property (nonatomic,strong)UILabel *exeLabel;
@property (nonatomic,strong)UITextView *exeTextField;
@property (nonatomic,strong)UILabel *introduceLabel;
@property (nonatomic,strong)UITextView *introduceTextField;
@property (nonatomic,strong)UIButton *confirmBtn;
@property (nonatomic,assign)CGFloat scrollViewSizeHeight;
@property (nonatomic,strong)UIView *statusBarView;

@property (nonatomic,assign)NSInteger exeTag; //编辑工作
@property (nonatomic,assign)NSInteger introduceTag; //编辑介绍
@property (nonatomic,assign)CGFloat keyBoardHeight;
@property (nonatomic,assign)BOOL isLight;

//需要上传的字段,必传
/** 头像字符串 */
@property (nonatomic,strong)NSString *pic64Str;
/** 名字 */
@property (nonatomic,copy)NSString *realName;
/** 性别 1男2女 */
@property (nonatomic,copy)NSString *sex;
/** 工作经验 */
@property (nonatomic,copy)NSString *exp;
/** 自我介绍 */
@property (nonatomic,copy)NSString *des;
/** 出生日期 */
@property (nonatomic,copy)NSString *birthday;

@end

@implementation PTResumeViewController

#pragma mark - 通知方法 -
- (void)keyboardWillShow:(NSNotification *)notification
{
    
    NSValue *aValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyBoardHeight = keyboardRect.size.height;
    
    [self.bgScrollView setContentSize:CGSizeMake(0, self.scrollViewSizeHeight + self.keyBoardHeight)];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self.bgScrollView setContentSize:CGSizeMake(0, self.scrollViewSizeHeight)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isLight = YES;
    
    self.statusBarView = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    
    [self setLeftItemBtnWithColor:[PTTool colorFromHexRGB:@"#ffffff"]];

    
    self.exeTag = 400;
    self.introduceTag = 500;
    self.barHeight = self.navigationController.navigationBar.height;
    
    self.view.backgroundColor = [PTTool colorFromHexRGB:@"#f1f3f4"];
    self.title = @"个人简历";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#ffffff"],NSFontAttributeName:[UIFont systemFontOfSize:19.f]}];
    
    if (@available(iOS 11.0,*)) {
        self.bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self womanBtn];
    
    [self confirmBtn];
    [self whiteBgView];

    
    self.whiteBgView.height = self.confirmBtn.bottom + 33.f - (self.loginBtn.bottom - self.loginBtn.height / 2.0);
    [self.bgScrollView setContentSize:CGSizeMake(0, self.whiteBgView.bottom + 27)];
    
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(14.f, self.whiteBgView.top , self.whiteBgView.width, self.whiteBgView.height)];
    shadowView.backgroundColor = [UIColor whiteColor];
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOpacity = 0.1;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2.f);
    shadowView.layer.cornerRadius = 10.f;
    [self.bgScrollView insertSubview:shadowView belowSubview:self.whiteBgView];
    
    self.scrollViewSizeHeight = self.whiteBgView.bottom + 27;
    
    [self addObserver];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.bgScrollView addGestureRecognizer:tap];

    [self.userNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self manSelect:self.manBtn];
    //初始化用户信息
    [self initUserInfo];
}

- (void)initUserInfo
{
    self.exp = @"";
    self.des = @"";
    self.birthday = @"";
    self.realName = @"";
    
    if ([PTUserUtil loginStatus]) {
        
        UserModel *model = [PTUserUtil getUserInfo];
        
        self.exp = model.exp;
        self.des = model.des;
        self.realName = model.realName;
        
        self.exeTextField.text = self.exp;
        self.introduceTextField.text = self.des;
        self.userNameTextField.text = self.realName;
        [self.userHeaderView sd_setImageWithURL:[NSURL URLWithString:model.headPic] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        if ([model.birthday isKindOfClass:[NSString class]]) {
            [self.bornBtn setTitle:model.birthday forState:UIControlStateNormal];
            self.birthday = model.birthday;
        }
        
        if (model.sex == 1) {
            [self manSelect:self.manBtn];
        }else{
            [self womanSelect:self.womanBtn];
        }
        
    }
}

- (void)addObserver
{
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)tapAction{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 导航栏透明
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.clipsToBounds = YES;
 
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.isLight) {
        return UIStatusBarStyleLightContent;
    }else{
        return UIStatusBarStyleDefault;
    }
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

#pragma mark - getter and setter
- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        CGFloat statusBar = [PTManager shareManager].statusBarHeight;
        CGFloat navHeight = self.navigationController.navigationBar.height;
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, - statusBar - navHeight, WIDTH_OF_SCREEN , HEIGHT_OF_SCREEN )];
        _bgScrollView.delegate = self;
        _bgScrollView.backgroundColor = [PTTool colorFromHexRGB:@"#f6f6f6"];
        [self.view addSubview:_bgScrollView];
        
        //背景和返回按钮
        UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 237.0)];
        headerView.image = [UIImage imageNamed:@"登录背景.png"];
        [_bgScrollView addSubview:headerView];
        
        [_bgScrollView setContentSize:CGSizeMake(0, HEIGHT_OF_SCREEN * 3.0)];
    }
    
    return _bgScrollView;
}

- (UIButton *)manBtn
{
    if (!_manBtn) {
        CGFloat width = 55.f;
        CGFloat bgWidth = self.bgScrollView.width;
        _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _manBtn.frame = CGRectMake(bgWidth / 2.0 - 50 - width, self.userNameTextField.bottom + 31.f, width, width);
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
        _womanBtn.frame = CGRectMake(bgWidth / 2.0 + 50, self.userNameTextField.bottom + 31.f, width, width);
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
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_OF_SCREEN - width) / 2.0, 81, width, width)];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius  = width / 2.0;
        _loginBtn.backgroundColor = [PTTool colorFromHexRGB:@"#f6f6f6"];
        
        [_loginBtn addSubview:self.userHeaderView];
        [self.bgScrollView addSubview:_loginBtn];
    }
    
    return _loginBtn;
}

- (UITextField *)userNameTextField
{
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, self.loginBtn.bottom + 19, WIDTH_OF_SCREEN - 40, 20)];
        _userNameTextField.placeholder = @"请输入姓名";
        _userNameTextField.textAlignment = NSTextAlignmentCenter;
        [self.bgScrollView addSubview:_userNameTextField];
    }
    
    return _userNameTextField;
}

- (UIImageView *)userHeaderView
{
    if (!_userHeaderView) {
        
        UserModel *model = [PTUserUtil getUserInfo];
        _userHeaderView = [[UIImageView alloc] initWithFrame:self.loginBtn.bounds];
        [_userHeaderView sd_setImageWithURL:[NSURL URLWithString:model.headPic] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    }
    
    return _userHeaderView;
}

- (UIView *)whiteBgView
{
    if (!_whiteBgView) {
        _whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(14.f, self.loginBtn.bottom - self.loginBtn.height / 2.0, WIDTH_OF_SCREEN - 14 * 2.0, HEIGHT_OF_SCREEN)];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
        _whiteBgView.layer.masksToBounds = YES;
        _whiteBgView.layer.cornerRadius  = 10.f;
        [self.bgScrollView insertSubview:_whiteBgView atIndex:1];
    }
    
    return _whiteBgView;
}

- (UIView *)bornView
{
    if (!_bornView) {
        
        _bornView = [[UIView alloc] initWithFrame:CGRectMake(31, self.manBtn.bottom + 33 + 30, WIDTH_OF_SCREEN - 31 * 2.0, 40)];
        [self.bgScrollView addSubview:_bornView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        label.text = @"出生日期";
        label.textColor = [PTTool colorFromHexRGB:@"#0d0d0d"];
        label.font = [UIFont systemFontOfSize:16.f];
        [_bornView addSubview:label];
        
        [_bornView addSubview:self.bornBtn];
    }
    
    return _bornView;
}

- (UIButton *)bornBtn
{
    if (!_bornBtn) {
        //13 24
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.bornView.width - 6.5, (self.bornView.height - 12) / 2.0, 6.5, 12)];
        arrow.image = [UIImage imageNamed:@"跳转小尖头"];
        [self.bornView addSubview:arrow];
        
        _bornBtn = [[UIButton alloc] initWithFrame:CGRectMake(arrow.left - 100, 0, 100, self.bornView.height)];
        [_bornBtn setTitle:@"请选择您的生日" forState:UIControlStateNormal];
        [_bornBtn setTitleColor:[PTTool colorFromHexRGB:@"#656565"] forState:UIControlStateNormal];
        [_bornBtn addTarget:self action:@selector(bornAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bornBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [self.bornView addSubview:_bornBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bornView.height - 1, self.bornView.width, 1)];
        lineView.backgroundColor = [PTTool colorFromHexRGB:@"#f1f3f4"];
        [self.bornView addSubview:lineView];
    }
    
    return _bornBtn;
}

- (UILabel *)exeLabel
{
    if (!_exeLabel) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.bornView.left, self.bornView.bottom + 24.f, 100, 16)];
        label.text = @"工作经验";
        label.textColor = [PTTool colorFromHexRGB:@"#0d0d0d"];
        label.font = [UIFont systemFontOfSize:16.f];
        [self.bgScrollView addSubview:label];
        
        _exeLabel = label;
    }
    
    return _exeLabel;
}

- (UITextView *)exeTextField
{
    if (!_exeTextField) {
        _exeTextField = [[UITextView alloc] initWithFrame:CGRectMake(self.exeLabel.left, self.exeLabel.bottom + 11, self.bornView.width, 120)];
        _exeTextField.backgroundColor = [PTTool colorFromHexRGB:@"#f6f6f6"];
        _exeTextField.delegate = self;
        _exeTextField.tag = self.exeTag;
        [self.bgScrollView addSubview:_exeTextField];
    }
    
    return _exeTextField;
}

- (UILabel *)introduceLabel
{
    if (!_introduceLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.exeTextField.left, self.exeTextField.bottom + 18.f, 100, 16)];
        label.text = @"自我介绍";
        label.textColor = [PTTool colorFromHexRGB:@"#0d0d0d"];
        label.font = [UIFont systemFontOfSize:16.f];
        [self.bgScrollView addSubview:label];
        
        _introduceLabel = label;
    }
    
    return _introduceLabel;
}

- (UITextView *)introduceTextField
{
    if (!_introduceTextField) {
        _introduceTextField = [[UITextView alloc] initWithFrame:CGRectMake(self.introduceLabel.left, self.introduceLabel.bottom + 11.f, self.bornView.width, 120)];
        _introduceTextField.backgroundColor = [PTTool colorFromHexRGB:@"#f6f6f6"];
        _introduceTextField.delegate = self;
        _introduceTextField.tag = self.introduceTag;
        [self.bgScrollView addSubview:_introduceTextField];
    }
    
    return _introduceTextField;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.introduceTextField.left, self.introduceTextField.bottom + 33, self.bornView.width, 44)];
        [btn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
        [self.bgScrollView addSubview:btn];
        
        [btn.layer addSublayer:[PTTool customLayer:btn haveCorner:YES]];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:btn.bounds];
        label.text = @"保存";
        label.textColor = [PTTool colorFromHexRGB:@"#ffffff"];
        label.font = [UIFont systemFontOfSize:18.f];
        label.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:label];
        
        _confirmBtn = btn;
    }
    
    return _confirmBtn;
}



#pragma mark - textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == self.exeTag) {
        [self.bgScrollView setContentOffset:CGPointMake(0, 0 + self.keyBoardHeight)];
        self.exp = textView.text;
    }else{
        [self.bgScrollView setContentOffset:CGPointMake(0, 0 + self.keyBoardHeight + 120)];
        self.des = textView.text;

    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.tag == self.exeTag) {
        [self.bgScrollView setContentOffset:CGPointMake(0, 0 + self.keyBoardHeight)];
        self.exp = textView.text;
    }else{
        [self.bgScrollView setContentOffset:CGPointMake(0, 0 + self.keyBoardHeight + 120)];
        self.des = textView.text;
        
    }
}

#pragma mark - textFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    self.realName = textField.text;
}

#pragma mark - senderAction -
- (void)popAction:(UIButton *)sender
{
    [self.lineView removeFromSuperview];
    self.statusBarView.backgroundColor = [UIColor clearColor];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)manSelect:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (sender.selected) {
        return;
    }
    self.sex = @"1";
    _manBtn.selected = YES;
    _womanBtn.selected = NO;
    
}

- (void)womanSelect:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (sender.selected) {
        return;
    }
    self.sex = @"2";
    _manBtn.selected = NO;
    _womanBtn.selected = YES;
    
}

- (void)bornAction:(UIButton *)sender
{
    NSLog(@"设置年龄");
    __weak typeof(self)weakSelf = self;
    NSString *date = @"";
    if (![self.bornBtn.titleLabel.text isEqualToString:@"请选择您的生日"] && [PTUserUtil loginStatus]) {
       
        UserModel *model = [PTUserUtil getUserInfo];
        if ([model.birthday isKindOfClass:[NSString class]]) {
            NSArray *dateArr = [model.birthday componentsSeparatedByString:@"."];
            NSMutableString *str = [NSMutableString string];
            for (int i = 0; i < dateArr.count; i ++) {
                NSString *dateS = dateArr[i];
                [str appendString:[NSString stringWithFormat:@"%@-",dateS]];
            }
            
            date = [NSString stringWithFormat:@"%@",[str substringWithRange:NSMakeRange(0, str.length - 1)]];
        }
        
    }
    

    
    [CZHDatePickerView sharePickerViewWithCurrentDate:date DateBlock:^(NSString *dateString) {
        NSArray *dateArr = [dateString componentsSeparatedByString:@"-"];
        NSMutableString *birthday = [NSMutableString string];
        for (int i = 0; i < dateArr.count; i ++) {
            NSString *str = dateArr[i];
            [birthday appendString:[NSString stringWithFormat:@"%@.",str]];
        }
        weakSelf.birthday = [NSString stringWithFormat:@"%@",[birthday substringWithRange:NSMakeRange(0, birthday.length - 1)]];
        [weakSelf.bornBtn setTitle:weakSelf.birthday forState:UIControlStateNormal];
    }];
}

- (void)confirmAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    if ([self.exp isEqualToString:@""]) {
        [NewShowLabel setMessageContent:@"请输入您的工作经验"];
        return;
    }
    
    if ([self.des isEqualToString:@""]) {
        [NewShowLabel setMessageContent:@"请输入您的自我介绍"];
        return;
    }
    
    if ([self.realName isEqualToString:@""]) {
        [NewShowLabel setMessageContent:@"请输入您的昵称"];
        return;
    }
    
    if ([self.birthday isEqualToString:@""]) {
        [NewShowLabel setMessageContent:@"请选择您的出生日期"];
        return;
    }

    __weak typeof(self)weakSelf = self;
    [PartTimeUserUpDateInfoModel requestUserWithImageStr:self.pic64Str sex:[self.sex integerValue] birthday:self.birthday exp:self.exp des:self.des userId:[PTUserUtil getUserId] realName:self.realName completeBlock:^(id obj) {
        
        PartTimeUserUpDateInfoModel *model = (PartTimeUserUpDateInfoModel *)obj;
        if ([model.status isEqualToString:@"0000"]) {
            [PartTimeUserGetInfoModel requestUserWithUserId:[PTUserUtil getUserId] completeBlock:^(id obj) {
                
                PartTimeUserGetInfoModel *infoModel = (PartTimeUserGetInfoModel *)obj;
                if ([infoModel.status isEqualToString:@"0000"]) {
                    [NewShowLabel setMessageContent:@"保存成功"];
                    [weakSelf popAction:[UIButton new]];
                }
                
            } faileBlock:^(id error) {
                
            }];
        }
        
    } faileBlock:^(id error) {
        
    }];
    
 
}

- (void)loginAction:(UIButton *)sender
{
    [self pic];
    NSLog(@"点击头像了");
}



#pragma mark - nav头部方法 -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.bgScrollView) {
        [self refreshNavigationBar];
    }
}



- (void)refreshNavigationBar{
    
    // 示例中使用了webView
    CGPoint offset = self.bgScrollView.contentOffset;
    
    // 通过offset.y与固定值300的比例来决定透明度
    CGFloat alpha = MIN(1, fabs(offset.y/81.f));
    if (offset.y < 0) {
        alpha = 0;
    }
    
    if (offset.y >= 81.f) {
        [self setLeftItemBtnWithColor:[PTTool colorFromHexRGB:@"#282828"]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#282828"],NSFontAttributeName:[UIFont systemFontOfSize:19.f]}];
        self.isLight = NO;

        [self.navigationController.navigationBar addSubview:self.lineView];
        
    }else{
        [self setLeftItemBtnWithColor:[PTTool colorFromHexRGB:@"#ffffff"]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#ffffff"],NSFontAttributeName:[UIFont systemFontOfSize:19.f]}];
        
        self.isLight = YES;
        
        [self.lineView removeFromSuperview];
    }
    
    [self preferredStatusBarStyle];

    
    [self.navigationController.navigationBar setTranslucent:!(BOOL)(int)alpha];
    
    UIColor *realTimeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
    
    UIImage *realTimeImg = [self UINavigationBarImageWithColor:realTimeColor];
    [self.navigationController.navigationBar setBackgroundImage:realTimeImg forBarMetrics:UIBarMetricsDefault];
    // 消除阴影
    //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.statusBarView.backgroundColor = realTimeColor;
    
}
// 获取navigationBar和statusBar的总高度
- (UIImage *)UINavigationBarImageWithColor:(UIColor *)aColor{
    CGSize navigationBarSize = self.navigationController.navigationBar.frame.size;
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    return [self imageWithColor:aColor Size:CGSizeMake(navigationBarSize.width,navigationBarSize.height + statusBarSize.height)];
}
// 绘制纯色图
- (UIImage *)imageWithColor:(UIColor *)aColor Size:(CGSize)aSize{
    UIGraphicsBeginImageContextWithOptions(aSize, NO, 0);
    [aColor set];
    UIRectFill(CGRectMake(0, 0, aSize.width, aSize.height));
    UIImage *renderedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return renderedImg;
}

#pragma mark 访问相机
- (void)photo{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    NSUInteger sourceType = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.delegate = self; //设置代理
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType; //图片来源
        
        //拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.sourceType = sourceType;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:imagePickerController animated:YES completion:NULL];
        });
    }
}

#pragma mark 访问相册
- (void)pic{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    NSUInteger sourceType = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.delegate = self; //设置代理
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType; //图片来源
        
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    self.pic64Str = [imageData base64EncodedStringWithOptions:0];
    
    [self.userHeaderView setImage:image];
    NSLog(@"%@",image);
}

@end
