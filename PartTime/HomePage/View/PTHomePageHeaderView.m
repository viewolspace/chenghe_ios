//
//  PTHomePageHeaderView.m
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTHomePageHeaderView.h"

@implementation PTHomePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        [self recommendLabel];
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
        NSArray *imagesNameArr = @[@"宅家赚钱",@"简单易做",@"高薪日结"];
        for (int i = 0; i < 3; i ++) {
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(14 + i * width + i * 7.0, 0, width, height)];
            [btn addTarget:self action:@selector(topThreeAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100 + i;
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
            btn.backgroundColor = COLOR_RANDOM;
            [_topView addSubview:btn];
            [btn setImage:[UIImage imageNamed:imagesNameArr[i]] forState:UIControlStateNormal];
        }
    }
    
    return _topView;
}



- (UILabel *)actionLabel
{
    if (!_actionLabel) {
        _actionLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, self.topView.bottom + 31, WIDTH_OF_SCREEN - 14 - 14, 18)];
        _actionLabel.text = @"热门";
        _actionLabel.textColor = [PTTool colorFromHexRGB:@"#282828"];
        _actionLabel.font = [UIFont systemFontOfSize:19.f];
        [self addSubview:_actionLabel];
    }
    
    return _actionLabel;
}


- (UIScrollView *)actionScrollView
{
    if (!_actionScrollView) {
        CGFloat height = 120;
        CGFloat page = 14;
        _actionScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(page, self.actionLabel.bottom + 24, WIDTH_OF_SCREEN - page, height)];
        _actionScrollView.delegate = self;
        [self addSubview:_actionScrollView];
        
        CGFloat scrollSizeWidth = 0;
        for (int i = 0; i < 10; i ++) {
            UIButton *bg = [[UIButton alloc] initWithFrame:CGRectMake(i * 207 + 8 * i, 0, 207, height)];
            bg.backgroundColor = COLOR_RANDOM;
            bg.tag = 300 + i;
            [bg addTarget:self action:@selector(hotAction:) forControlEvents:UIControlEventTouchUpInside];
            [_actionScrollView addSubview:bg];
            [bg setImage:[UIImage imageNamed:@"BANNER _ 长图.png"] forState:UIControlStateNormal];
            scrollSizeWidth = bg.right + 14.;
        }
        
        [_actionScrollView setContentSize:CGSizeMake(scrollSizeWidth, 0)];
    }
    
    return _actionScrollView;
}


- (UILabel *)recommendLabel
{
    if (!_recommendLabel) {
        CGFloat height = 18;
        _recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, self.actionScrollView.bottom + 32.f, WIDTH_OF_SCREEN - 14 -14, height)];
        _recommendLabel.text = @"推荐";
        _recommendLabel.textColor = [PTTool colorFromHexRGB:@"#282828"];
        _recommendLabel.font = [UIFont systemFontOfSize:19.f];
        [self addSubview:_recommendLabel];
    }
    
    return _recommendLabel;
}


#pragma mark - senderAction -
- (void)topThreeAction:(UIButton *)sender
{
    NSLog(@"top: %ld",sender.tag);
}

- (void)hotAction:(UIButton *)sender
{
    NSLog(@"热门：%ld",sender.tag);
}

@end
