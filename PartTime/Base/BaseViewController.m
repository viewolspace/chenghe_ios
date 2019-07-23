//
//  BaseViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

@end
