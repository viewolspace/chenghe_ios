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

#pragma mark - data -
- (void)setDataWithAdModel:(PartTimeAdModel *)model
{
    NSArray *views = self.bannerScrollView.subviews;
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    
    
    CGFloat height = 119;
    CGFloat width = WIDTH_OF_SCREEN;
    
    CGFloat sizeWidth = 0;
    CGFloat bannerWidth = width - 14 * 2.0;
    for (int i = 0; i < model.adModelArr.count; i ++) {
        
        PartTimeAdModel *adModel = model.adModelArr[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(14 + i * WIDTH_OF_SCREEN, 0, bannerWidth, height)];
        [btn addTarget:self action:@selector(selectAdAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [self.bannerScrollView addSubview:btn];
        sizeWidth = btn.right;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:btn.bounds];
        [imageView sd_setImageWithURL:[NSURL URLWithString:adModel.adImageUrl] placeholderImage:[UIImage imageNamed:@""]];
        imageView.backgroundColor = COLOR_RANDOM;
        [btn addSubview:imageView];
    }
    
    self.modelArr = model.adModelArr;
    self.bannerScrollView.contentSize = CGSizeMake(WIDTH_OF_SCREEN * model.adModelArr.count, 0);
}

#pragma mark - senderAction -
- (void)selectAdAction:(UIButton *)sender
{
    PartTimeAdModel *model = self.modelArr[sender.tag - 100];
    if (self.selectDataBlock) {
        self.selectDataBlock(model);
    }
}

@end
