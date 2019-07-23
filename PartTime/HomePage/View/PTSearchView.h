//
//  PTSearchView.h
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PTSearchViewDelegate <NSObject>

/** 点击搜索方法 */
- (void)searchBtnTapAction;

@end

@interface PTSearchView : UIView

@property (nonatomic,weak)id<PTSearchViewDelegate>delegate;
@property (nonatomic,strong)UIButton *searchBtn;


@end

NS_ASSUME_NONNULL_END
