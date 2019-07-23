//
//  PTWholeHeaderView.m
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTWholeHeaderView.h"

@implementation PTWholeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        [self bannerScrollView];
    }
    return self;
}



#pragma mark - getter and setter
- (UIView *)topView
{
    if (!_topView) {
        
        CGFloat width = (WIDTH_OF_SCREEN - (14 * 2.0 + 7 * 2.0)) / 3.0;
        CGFloat height = 42.f;
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, height)];
        _topView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_topView];
        
        for (int i = 0; i < 3; i ++) {
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(14 + i * width + i * 7.0, 0, width, height)];
            [btn addTarget:self action:@selector(topThreeAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100 + i;
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
            btn.backgroundColor = COLOR_RANDOM;
            [_topView addSubview:btn];
        }
    }
    
    return _topView;
}

- (UIScrollView *)bannerScrollView
{
    if (!_bannerScrollView) {
        
        CGFloat height = 119;
        CGFloat width = WIDTH_OF_SCREEN;
        _bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topView.bottom + 27, width, height)];
        _bannerScrollView.pagingEnabled = YES;
        
        CGFloat sizeWidth = 0;
        CGFloat bannerWidth = width - 14 * 2.0;
        for (int i = 0; i < 3; i ++) {
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(14 + i * WIDTH_OF_SCREEN, 0, bannerWidth, height)];
            view.backgroundColor = COLOR_RANDOM;
            [_bannerScrollView addSubview:view];
            sizeWidth = view.right;
        }
        
        _bannerScrollView.contentSize = CGSizeMake(WIDTH_OF_SCREEN * 3.0, 0);
        [self addSubview:_bannerScrollView];
    }
    
    return _bannerScrollView;
}



#pragma mark - senderAction -
- (void)topThreeAction:(UIButton *)sender
{
    NSLog(@"top: %ld",sender.tag);
}

@end
