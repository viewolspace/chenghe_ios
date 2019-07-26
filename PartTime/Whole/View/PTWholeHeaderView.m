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
        
        CGFloat height = 42.f;
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, height)];
        [self addSubview:_topView];
       
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
      
        [self addSubview:_bannerScrollView];
    }
    
    return _bannerScrollView;
}



#pragma mark - senderAction -
- (void)topThreeAction:(UIButton *)sender
{
    NSLog(@"top: %ld",sender.tag);
    PartTimeAdModel *model = self.topThreeModelArr[sender.tag - 100];
    if (self.clickAdBlcok) {
        self.clickAdBlcok(model);
    }
}

- (void)bannerAction:(UIButton *)sender
{
    NSLog(@"banner: %ld",sender.tag);
    PartTimeAdModel *model = self.scrollModelArr[sender.tag - 300];
    if (self.clickAdBlcok) {
        self.clickAdBlcok(model);
    }
}

#pragma mark - data -
- (void)setBannerDataWithModel:(PartTimeAdModel *)model
{
    [self.bannerScrollView removeAllSubVies];
    
    CGFloat height = 120;
    CGFloat scrollSizeWidth = 0;
    CGFloat width = WIDTH_OF_SCREEN - 14 * 2.0;
   
    for (int i = 0; i < model.adModelArr.count; i ++) {
        
        PartTimeAdModel *adModel = model.adModelArr[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(14 + i * width, 0, width, height)];
        btn.tag = 300 + i;
        [btn addTarget:self action:@selector(bannerAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bannerScrollView addSubview:btn];
        scrollSizeWidth = btn.right + 14.;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:btn.bounds];
        [imageView sd_setImageWithURL:[NSURL URLWithString:adModel.adImageUrl] placeholderImage:[UIImage imageNamed:@""]];
        imageView.backgroundColor = COLOR_RANDOM;
        [btn addSubview:imageView];
    }
    
    self.bannerScrollView.contentSize = CGSizeMake(WIDTH_OF_SCREEN * model.adModelArr.count, 0);
    self.scrollModelArr = model.adModelArr;
   
}

- (void)setTopThreeDataWithModel:(PartTimeAdModel *)model
{
    
    [self.topView removeAllSubVies];
    
    CGFloat width = (WIDTH_OF_SCREEN - (14 * 2.0 + 7 * 2.0)) / 3.0;
    CGFloat height = 42.f;
    
    for (int i = 0; i < model.adModelArr.count && i < 3; i ++) {
        PartTimeAdModel *adModel = model.adModelArr[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(14 + i * width + i * 7.0, 0, width, height)];
        [btn addTarget:self action:@selector(topThreeAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        [_topView addSubview:btn];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:btn.bounds];
        [imageView sd_setImageWithURL:[NSURL URLWithString:adModel.adImageUrl] placeholderImage:[UIImage imageNamed:@""]];
        imageView.backgroundColor = COLOR_RANDOM;
        [btn addSubview:imageView];
    }
    
    self.topThreeModelArr = model.adModelArr;
    
}

@end
