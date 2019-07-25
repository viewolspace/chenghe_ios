//
//  BaseViewController.h
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTSearchView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController<PTSearchViewDelegate>

@property (nonatomic,strong)PTSearchView *searchView;

/** 设置返回按钮颜色 默认:#282828 黑色 */
- (void)setLeftItemBtnWithColor:(UIColor *)color;


/** 返回方法 */
- (void)popAction:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
