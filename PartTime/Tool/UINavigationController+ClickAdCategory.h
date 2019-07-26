//
//  UINavigationController+ClickAdCategory.h
//  PartTime
//
//  Created by Mac on 2019/7/26.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (ClickAdCategory)

/** 点击广告的跳转 */
- (void)clickAdAction:(PartTimeAdModel *)model
              chileVC:(UIViewController *)chileVC;

@end

NS_ASSUME_NONNULL_END
