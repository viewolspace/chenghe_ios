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
        //self.backgroundColor = [UIColor cyanColor];
        [self recommendLabel];
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



- (UILabel *)hotLabel
{
    if (!_hotLabel) {
        _hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, self.topView.bottom + 31, WIDTH_OF_SCREEN - 14 - 14, 18)];
        _hotLabel.text = @"热门";
        _hotLabel.textColor = [PTTool colorFromHexRGB:@"#282828"];
        _hotLabel.font = [UIFont systemFontOfSize:19.f];
        [self addSubview:_hotLabel];
    }
    
    return _hotLabel;
}


- (UIScrollView *)actionScrollView
{
    if (!_actionScrollView) {
        CGFloat height = 120;
        CGFloat page = 0;
        _actionScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(page, self.hotLabel.bottom + 24, WIDTH_OF_SCREEN - page, height)];
        _actionScrollView.delegate = self;
        [self addSubview:_actionScrollView];
 
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
    PartTimeAdModel *model = self.topThreeModelArr[sender.tag - 100];
    if (self.clickAdBlcok) {
        self.clickAdBlcok(model);
    }
}

- (void)bannerAction:(UIButton *)sender
{
    PartTimeAdModel *model = self.scrollModelArr[sender.tag - 300];
    if (self.clickAdBlcok) {
        self.clickAdBlcok(model);
    }
}

#pragma mark - data -
- (void)setBannerDataWithModel:(PartTimeAdModel *)model
{
    [self.actionScrollView removeAllSubVies];
    
    CGFloat height = 120;
    CGFloat scrollSizeWidth = 0;
    
    for (int i = 0; i < model.adModelArr.count; i ++) {
        
        PartTimeAdModel *adModel = model.adModelArr[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(14 + i * 207 + 8 * i, 0, 207, height)];
        btn.tag = 300 + i;
        [btn addTarget:self action:@selector(bannerAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.actionScrollView addSubview:btn];
        scrollSizeWidth = btn.right + 14.;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:btn.bounds];
        [imageView sd_setImageWithURL:[NSURL URLWithString:adModel.adImageUrl] placeholderImage:[UIImage imageNamed:@""]];
        //imageView.backgroundColor = COLOR_RANDOM;
        [btn addSubview:imageView];
        
        imageView.image = [self drawLineOfDashByImageView:imageView];
    }
    
    [self.actionScrollView setContentSize:CGSizeMake(scrollSizeWidth, 0)];
    
    self.scrollModelArr = model.adModelArr;
}

- (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView {
    // 开始划线 划线的frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    // 获取上下文
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    // 设置线条终点的形状
    CGContextSetLineCap(line, kCGLineCapRound);
    // 设置虚线的长度 和 间距
    CGFloat lengths[] = {5,5};
    
    CGContextSetStrokeColorWithColor(line, [UIColor greenColor].CGColor);
    // 开始绘制虚线
    CGContextSetLineDash(line, 0, lengths, 2);
    
    CGContextMoveToPoint(line, 0.0, 2.0);
    
    CGContextAddLineToPoint(line, 300, 2.0);
    
    CGContextStrokePath(line);
    
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
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
        //imageView.backgroundColor = COLOR_RANDOM;
        [btn addSubview:imageView];
    }
    
    self.topThreeModelArr = model.adModelArr;
   
}


@end
