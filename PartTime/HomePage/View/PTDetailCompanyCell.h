//
//  PTDetailCompanyCell.h
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTDetailCompanyCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *stars;
@property (weak, nonatomic) IBOutlet UIView *companyBgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *companyHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *companyImageView;

- (void)setDataWithModel:(PartTimeModel *)model
                comModel:(PartTimeDetailModel *)detailModel;

@end

NS_ASSUME_NONNULL_END
