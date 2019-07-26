//
//  PTChoiceHeaderView.h
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTChoiceHeaderView : UIView

@property (nonatomic,strong)UIScrollView *bannerScrollView;
@property (nonatomic,strong)UILabel *choiceLabel;
@property (nonatomic,copy)NSArray *modelArr;
@property (nonatomic,copy)void (^selectDataBlock)(PartTimeAdModel *model);

- (void)setDataWithAdModel:(PartTimeAdModel *)model;
@end

NS_ASSUME_NONNULL_END
