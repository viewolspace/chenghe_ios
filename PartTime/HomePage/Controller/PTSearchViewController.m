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
@interface PTSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    
}
@property (nonatomic,strong)UIImageView *noDataImageView;
@property (nonatomic,strong)UILabel *noDataLabel;
@property (nonatomic,strong)UITextField *searchTextField;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,assign)BOOL pop;
@property (nonatomic,assign)CGFloat keyBoardHeight;
@property (nonatomic,assign)CGFloat tableViewHeight;

@end

@implementation PTSearchViewController

#pragma mark - 通知方法 -
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSValue *aValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyBoardHeight = keyboardRect.size.height;
    
    self.tableView.height = self.tableViewHeight - self.keyBoardHeight;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.tableView.height = self.tableViewHeight;
}

#pragma mark - 生命周期 -
- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    [self noDataImageView];
    [self searchTextField];
    [self createTabelView];
    
    [self addObserver];
    
    [self setMJHeaderView:self.tableView];
    [self setMjFooterView:self.tableView];
    
    self.tableView.hidden = YES;
    
}

- (void)addObserver
{
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dealloc
{
    if (self.searchTextField) {
        [self.searchTextField removeFromSuperview];
    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@ 释放了！",[self class]);
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 导航栏透明
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    self.searchTextField.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.searchTextField.hidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController.view endEditing:YES];
}

- (void)createTabelView
{
    CGFloat tabbarHieght = [PTManager shareManager].tabbarHeight;
    CGFloat statusBarHeight = [PTManager shareManager].statusBarHeight;
    self.tableViewHeight = HEIGHT_OF_SCREEN - tabbarHieght - statusBarHeight;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, self.tableViewHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.hidden = YES;
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
    if (self.dataArr.count == 0) {
        return 0;
    }else{
        PartTimeModel *model = self.dataArr[indexPath.row];
        return model.havePicCellHeight;
    }
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
    PartTimeModel *model = self.dataArr[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    PTDetailViewController *vc = [[PTDetailViewController alloc] init];
    vc.ptId = model.aId;
    [self.navigationController.view endEditing:YES];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - textFieldDelegate -
- (void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        [self.dataArr removeAllObjects];
        self.tableView.hidden = YES;
        self.noDataImageView.hidden = NO;
        self.noDataLabel.hidden = NO;
        [self.tableView reloadData];
        return;
    }
    [self requestQueryWithText:textField.text];
}


#pragma mark - setter and getter
- (UIImageView *)noDataImageView
{
    if (!_noDataImageView) {
        
        CGFloat width = 263.f;
        _noDataImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_OF_SCREEN - width) / 2.0, (HEIGHT_OF_SCREEN - width) / 2.0 - [PTManager shareManager].statusBarHeight, width, width)];
        _noDataImageView.image = [UIImage imageNamed:@"搜索_默认无状态图"];
        [self.view addSubview:_noDataImageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, _noDataImageView.bottom - 70, WIDTH_OF_SCREEN, 20)];
        label.text = @"无搜索内容";
        label.textColor = [PTTool colorFromHexRGB:@"#1d1d1d"];
        label.font = [UIFont systemFontOfSize:16.f];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        self.noDataLabel = label;
    }
    
    return _noDataImageView;
}

- (UITextField *)searchTextField
{
    if (!_searchTextField) {
        
        CGFloat barHeight = [PTManager shareManager].navigationBarHeight;
        CGFloat statusBarHeight = [PTManager shareManager].statusBarHeight;
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(46, (barHeight - 29) / 2.0 + statusBarHeight - TOP_MARIN, WIDTH_OF_SCREEN - 46 -14, 29)];
        _searchTextField.backgroundColor = [PTTool colorFromHexRGB:@"#e9e9e9"];
        _searchTextField.layer.cornerRadius = 29 / 2.0;
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.placeholder = @"输入您想搜索的内容";
        _searchTextField.font = [UIFont systemFontOfSize:15.f];
        _searchTextField.delegate = self;
        [self.navigationController.navigationBar addSubview:_searchTextField];
        
        CGFloat leftViewWidth = 46;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftViewWidth, 29)];
        UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(19, (29 - 15) / 2.0, 15, 15)];
        searchImageView.image = [UIImage imageNamed:@"搜索图标"];
        [leftView addSubview:searchImageView];
        
        [_searchTextField setLeftViewMode:UITextFieldViewModeAlways];
        [_searchTextField setLeftView:leftView];
        
        [_searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }

    
    return _searchTextField;
}

#pragma mark - senderAction -
- (void)popAction:(UIButton *)sender
{
    [self.navigationController.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - data -
- (void)headerReoladAction
{
    NSLog(@"下拉刷新了");
    [self.tableView.mj_header endRefreshing];
}

- (void)footerReloadAction
{
    NSLog(@"上拉刷新了");
    [self.tableView.mj_footer endRefreshing];
}

- (void)requestQueryWithText:(NSString *)text
{
    __weak typeof(self)weakSelf = self;
    [PartTimeQueryModel requestPartTimeWithKeyWord:text pageIndex:self.pageIndex pageSize:self.pageSize completeBlock:^(id obj) {
        
        PartTimeQueryModel *model = (PartTimeQueryModel *)obj;
        [weakSelf setDataWithModel:model];
        
    } faileBlock:^(id error) {
        
    }];
}

- (void)setDataWithModel:(PartTimeQueryModel *)model
{
    if ([self.searchTextField isEditing]) {
        
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:model.modelArr];
        
    }else{
        [self.dataArr addObjectsFromArray:model.modelArr];
    }
    
    if (self.dataArr.count == 0) {
        self.tableView.hidden = YES;
        self.noDataImageView.hidden = NO;
        self.noDataLabel.hidden = NO;
    }else{
        self.tableView.hidden = NO;
        self.noDataImageView.hidden = YES;
        self.noDataLabel.hidden = YES;
    }
    
    [self.tableView reloadData];
    
}



@end
