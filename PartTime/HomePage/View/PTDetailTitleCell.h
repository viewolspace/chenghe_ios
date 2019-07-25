//
//  PTDetailTitleCell.h
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTDetailTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *ptCopyBtn;

@property (weak, nonatomic) IBOutlet UILabel *ptTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *ptUpDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *ptPayLabel;

@property (weak, nonatomic) IBOutlet UILabel *ptWorkTimelabel;
@property (weak, nonatomic) IBOutlet UILabel *ptWorkAddress;
@property (weak, nonatomic) IBOutlet UIView *subLabelView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subLabelViewHeightConstraint;
- (void)setDataWithModel:(PartTimeModel *)model;

@end

NS_ASSUME_NONNULL_END
