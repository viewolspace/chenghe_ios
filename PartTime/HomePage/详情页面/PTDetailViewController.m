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
@end

@implementation PTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createTabelView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    return 300.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, 19)];
    view.backgroundColor = [PTTool colorFromHexRGB:@"#f1f3f4"];
    return view;
}

@end
