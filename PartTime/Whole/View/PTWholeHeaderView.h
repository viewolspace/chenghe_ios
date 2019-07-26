//
//  PTWholeHeaderView.h
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTWholeHeaderView : UIView
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIScrollView *bannerScrollView;
@property (nonatomic,copy)NSArray *topThreeModelArr;
@property (nonatomic,copy)NSArray *scrollModelArr;

@property (nonatomic,copy)void (^clickAdBlcok)(PartTimeAdModel *model);

- (void)setBannerDataWithModel:(PartTimeAdModel *)model;
- (void)setTopThreeDataWithModel:(PartTimeAdModel *)model;

@end


NS_ASSUME_NONNULL_END
