//
//  PTDetailViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTDetailViewController.h"
#import "PTDetailTitleCell.h"
#import "PTDetailContentCell.h"
#import "PTDetailCompanyCell.h"

@interface PTDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic,strong)UIButton *confirmBtn;
@property (nonatomic,strong) CAGradientLayer *confirmLayer;
@property (nonatomic,strong)UILabel *confirmLabel;
@end

@implementation PTDetailViewController

- (void)viewDidLoad {
     [super viewDidLoad];
    
    [self createTabelView];
    
    [self confirmBtn];
    
    [self setTitle:@"详情"];
       
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    
    
}

- (void)createTabelView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, self.view.bounds.size.height - 45) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    [self registerAction];
}

- (void)registerAction{
    [_tableView registerNib:[UINib nibWithNibName:@"PTDetailTitleCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PTDetailTitleCell class])];
     [_tableView registerNib:[UINib nibWithNibName:@"PTDetailContentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PTDetailContentCell class])];
     [_tableView registerNib:[UINib nibWithNibName:@"PTDetailCompanyCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PTDetailCompanyCell class])];
}

#pragma mark ----tableViewDataSource----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self titleCell:tableView indexPath:indexPath];
    }else if(indexPath.section == 1){
        return [self contentCell:tableView indexPath:indexPath];
    }else{
        return [self companyCell:tableView indexPath:indexPath];
    }
   
}


/**
 标题
 */
- (UITableViewCell *)titleCell:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath
{
    PTDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTDetailTitleCell class])];
    return cell;
}


/**
 工作内容
 */
- (UITableViewCell *)contentCell:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath
{
    PTDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTDetailContentCell class])];
    return cell;
}


/**
 公司
 */
- (UITableViewCell *)companyCell:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath
{
    PTDetailCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTDetailCompanyCell class])];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


#pragma mark ----tableViewDelegate----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 19)];
    view.backgroundColor = [PTTool colorFromHexRGB:@"#f1f3f4"];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter and setter
- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 45 - self.navigationController.navigationBar.height - statusRect.size.height, WIDTH_OF_SCREEN, 45)];
        [btn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _confirmBtn = btn;
        
        [_confirmBtn.layer addSublayer:self.confirmLayer];
        [self confirmLabel];
    }
    
    return _confirmBtn;
}

- (UILabel *)confirmLabel
{
    if (!_confirmLabel) {
        _confirmLabel = [[UILabel alloc] initWithFrame:self.confirmBtn.frame];
        _confirmLabel.text = @"报名参加";
        _confirmLabel.textColor = [PTTool colorFromHexRGB:@"#ffffff"];
        _confirmLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _confirmLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_confirmLabel];
    }
    
    return _confirmLabel;
}

- (CAGradientLayer *)confirmLayer
{
    if (!_confirmLayer) {
        _confirmLayer = [PTTool customLayer:self.confirmBtn haveCorner:NO];
    }
    
    return _confirmLayer;
}

#pragma mark - senderAction -
- (void)confirmAction:(UIButton *)sender
{
    NSLog(@"报名参加");
}

@end
