//
//  PTHomePageHeaderView.h
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTHomePageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTHomePageHeaderView : UIView<UIScrollViewDelegate>
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UILabel *hotLabel;
@property (nonatomic,strong)UIScrollView *actionScrollView;
@property (nonatomic,strong)UILabel *recommendLabel;

- (void)setHotDataWithModel:(PTHomePageModel *)model;

@end

NS_ASSUME_NONNULL_END
