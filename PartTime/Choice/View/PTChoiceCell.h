//
//  PTChoiceCell.h
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTChoiceCell : UITableViewCell

/** haveImage ? 24 : 10 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noImageChangeTopConstraint;

/** haveImage ? 93 : 0 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *ptTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ptImageView;

@property (weak, nonatomic) IBOutlet UILabel *ptSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptPayLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;
@property (weak, nonatomic) IBOutlet UIImageView *verImageView;

- (void)setDataWithModel:(PartTimeModel *)model;

@end

NS_ASSUME_NONNULL_END
