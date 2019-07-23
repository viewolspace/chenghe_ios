//
//  PTSearchView.m
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTSearchView.h"

@implementation PTSearchView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self searchBtn];
    }
    return self;
}


#pragma mark - getter and setter
- (UIButton *)searchBtn
{
    if (!_searchBtn) {
        CGFloat width = 89;
        CGFloat height = 29;
        _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_OF_SCREEN - 14 - width , 0, width, height)];
        [_searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchBtn];
        
        _searchBtn.backgroundColor = [PTTool colorFromHexRGB:@"#e9e9e9"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 35, height)];
        label.text = @"搜索";
        label.textColor = [PTTool colorFromHexRGB:@"#939393"];
        label.font = [UIFont systemFontOfSize:15.f];
        label.textAlignment = NSTextAlignmentLeft;
        [_searchBtn addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width - 12 - 15, (height - 15) / 2.0, 15, 15)];
        imageView.image = [UIImage imageNamed:@"搜索图标.png"];
        [_searchBtn addSubview:imageView];
        
        _searchBtn.layer.masksToBounds = YES;
        _searchBtn.layer.cornerRadius  = _searchBtn.height / 2.0;
    }
    
    return _searchBtn;
}



#pragma mark - senderAction -
- (void)searchAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(searchBtnTapAction)]) {
        [self.delegate searchBtnTapAction];
    }
}

@end
