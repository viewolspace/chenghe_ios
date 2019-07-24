//
//  BaseViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "BaseViewController.h"
#import "PTSearchViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setLeftItemBtnWithColor:[PTTool colorFromHexRGB:@"#282828"]];
}

- (void)setLeftItemBtnWithColor:(UIColor *)color
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction:)];
    [leftItem setTintColor:color];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)popAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter and setter
- (PTSearchView *)searchView
{
    if (!_searchView) {
        CGFloat statusBarHeight = [PTManager shareManager].statusBarHeight;
        if (statusBarHeight < 27) {
            statusBarHeight = 27;
        }
        _searchView = [[PTSearchView alloc] initWithFrame:CGRectMake(0, statusBarHeight, WIDTH_OF_SCREEN, 44.f)];
        _searchView.backgroundColor = [UIColor orangeColor];
        _searchView.delegate = self;
        [self.view addSubview:_searchView];
    }
    
    return _searchView;
}

- (void)searchBtnTapAction
{
    PTSearchViewController *vc = [[PTSearchViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
