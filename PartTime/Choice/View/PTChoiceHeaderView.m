//
//  PTChoiceHeaderView.m
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTChoiceHeaderView.h"

@implementation PTChoiceHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self choiceLabel];
    }
    return self;
}

#pragma mark - setter and getter
- (UIScrollView *)bannerScrollView
{
    if (!_bannerScrollView) {
        
        CGFloat height = 119;
        CGFloat width = WIDTH_OF_SCREEN;
        _bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
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

- (UILabel *)choiceLabel
{
    if (!_choiceLabel) {
        _choiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, self.bannerScrollView.bottom + 35, WIDTH_OF_SCREEN - 14 - 14, 18)];
        _choiceLabel.text = @"热门";
        _choiceLabel.textColor = [PTTool colorFromHexRGB:@"#282828"];
        _choiceLabel.font = [UIFont systemFontOfSize:19.f];
        [self addSubview:_choiceLabel];
    }
    
    return _choiceLabel;
}

@end
